"""Headless libretro frontend for the melonDS DS core (RetroArch's DLL), for testing builds.
usage: py -3.14 lr.py ROM [STATE] < script      (or lr.py ROM STATE script.txt)
STATE = a RetroArch .stateN (RZIP) made with the same ROM. Script lines:
  run N               run N frames (60 Hz) with no input
  hold KEYS N         hold keys (a b x y l r start select up down left right, '+'-joined) for N frames
  press KEYS          hold 2 frames, then release 4
  touch X Y N         stylus on the bottom screen at (X, Y) for N frames
  shot FILE.png       save both screens (256x384)
  peek ADDR N         hex dump of main RAM (0x02xxxxxx) or DTCM (0x027e0000-0x027e3fff)
  poke ADDR HEX       write bytes into main RAM
  save FILE           write a raw core state (load it again as STATE)
Core options: software renderer, JIT off (see OPTS).
Core DLL: MELONDS_CORE, else RETROARCH_DIR/cores/melondsds_libretro.dll (default dir C:/RetroArch-Win64)."""
import ctypes as C, os, struct, sys, zlib

CORE = os.environ.get('MELONDS_CORE') or os.path.join(
    os.environ.get('RETROARCH_DIR', r'C:\RetroArch-Win64'), 'cores', 'melondsds_libretro.dll')
SYSDIR = os.path.join(os.environ.get('TEMP', '.'), 'lr_system')
OPTS = {'melonds_render_mode': 'software', 'melonds_jit_enable': 'disabled', 'melonds_threaded_renderer': 'disabled',
        'melonds_boot_mode': 'direct', 'melonds_sysfile_mode': 'builtin', 'melonds_screen_layout1': 'top-bottom',
        'melonds_number_of_screen_layouts': '1', 'melonds_screen_gap': '0', 'melonds_touch_mode': 'touch',
        'melonds_show_cursor': 'disabled', 'melonds_console_mode': 'ds', 'melonds_mic_input': 'silence'}
KEYS = dict(b=0, y=1, select=2, start=3, up=4, down=5, left=6, right=7, a=8, x=9, l=10, r=11)

ENV_CB = C.CFUNCTYPE(C.c_bool, C.c_uint, C.c_void_p)
VIDEO_CB = C.CFUNCTYPE(None, C.c_void_p, C.c_uint, C.c_uint, C.c_size_t)
AUDIO_CB = C.CFUNCTYPE(None, C.c_int16, C.c_int16)
AUDIOB_CB = C.CFUNCTYPE(C.c_size_t, C.c_void_p, C.c_size_t)
POLL_CB = C.CFUNCTYPE(None)
INPUT_CB = C.CFUNCTYPE(C.c_int16, C.c_uint, C.c_uint, C.c_uint, C.c_uint)

class GameInfo(C.Structure):
    _fields_ = [('path', C.c_char_p), ('data', C.c_void_p), ('size', C.c_size_t), ('meta', C.c_char_p)]

class Variable(C.Structure):
    _fields_ = [('key', C.c_char_p), ('value', C.c_char_p)]

class Rig:
    def __init__(self, rom):
        os.makedirs(SYSDIR, exist_ok=True)
        self.lib = C.CDLL(CORE)
        self.keys, self.touch, self.frame = set(), None, None
        self.fmt = 0
        self._keep = []
        self._sysdir = C.c_char_p(SYSDIR.encode())
        self._vals = {k.encode(): C.c_char_p(v.encode()) for k, v in OPTS.items()}
        cbs = [ENV_CB(self.env), VIDEO_CB(self.video), AUDIO_CB(lambda l, r: None),
               AUDIOB_CB(lambda d, n: n), POLL_CB(lambda: None), INPUT_CB(self.input)]
        self._keep += cbs
        L = self.lib
        L.retro_set_environment(cbs[0])
        L.retro_init()
        L.retro_set_video_refresh(cbs[1]); L.retro_set_audio_sample(cbs[2])
        L.retro_set_audio_sample_batch(cbs[3]); L.retro_set_input_poll(cbs[4]); L.retro_set_input_state(cbs[5])
        L.retro_load_game.argtypes = [C.POINTER(GameInfo)]; L.retro_load_game.restype = C.c_bool
        self._rom = open(rom, 'rb').read()
        self._rombuf = C.create_string_buffer(self._rom, len(self._rom))
        info = GameInfo(os.path.abspath(rom).encode(), C.cast(self._rombuf, C.c_void_p), len(self._rom), None)
        if not L.retro_load_game(C.byref(info)):
            raise SystemExit('retro_load_game failed')
        L.retro_get_memory_data.restype = C.c_void_p; L.retro_get_memory_size.restype = C.c_size_t
        if os.environ.get('LR_SAVE'):          # battery save (.srm) to start with
            sav = open(os.environ['LR_SAVE'], 'rb').read()
            p, n = L.retro_get_memory_data(0), L.retro_get_memory_size(0)
            if p and n:
                C.memmove(p, sav, min(n, len(sav)))
            else:
                print('no SAVE_RAM interface', file=sys.stderr)
        L.retro_serialize_size.restype = C.c_size_t
        L.retro_unserialize.argtypes = [C.c_void_p, C.c_size_t]; L.retro_unserialize.restype = C.c_bool
        L.retro_serialize.argtypes = [C.c_void_p, C.c_size_t]; L.retro_serialize.restype = C.c_bool
        L.retro_get_memory_data.restype = C.c_void_p; L.retro_get_memory_size.restype = C.c_size_t

    def env(self, cmd, data):
        cmd &= 0xffff
        if cmd in (9, 31):                     # GET_SYSTEM_DIRECTORY, GET_SAVE_DIRECTORY
            C.cast(data, C.POINTER(C.c_char_p))[0] = self._sysdir.value
            return True
        if cmd == 10:                          # SET_PIXEL_FORMAT
            self.fmt = C.cast(data, C.POINTER(C.c_int))[0]
            return True
        if cmd == 15:                          # GET_VARIABLE
            v = C.cast(data, C.POINTER(Variable))[0]
            val = self._vals.get(v.key)
            C.cast(data, C.POINTER(Variable))[0].value = val.value if val else None
            return val is not None
        if cmd == 17:                          # GET_VARIABLE_UPDATE
            C.cast(data, C.POINTER(C.c_bool))[0] = False
            return True
        if cmd in (3, 16, 33, 35, 36, 39, 53):  # misc "set" calls: accept
            return True
        return False

    def video(self, data, w, h, pitch):
        if data:
            self.frame = (C.string_at(data, pitch * h), w, h, pitch)

    def input(self, port, device, index, id_):
        if port != 0:
            return 0
        if device == 1:                        # joypad
            return 1 if id_ in self.keys else 0
        if device == 6 and self.touch:         # pointer: -0x7fff..0x7fff over the 256x384 layout
            x, y = self.touch
            if id_ == 0: return int((x + 0.5) / 256 * 0xfffe) - 0x7fff
            if id_ == 1: return int((y + 192 + 0.5) / 384 * 0xfffe) - 0x7fff
            if id_ == 2: return 1
        return 0

    def run(self, n=1):
        for _ in range(n):
            self.lib.retro_run()

    def load_state(self, path):
        d = open(path, 'rb').read()
        if d.startswith(b'#RZIPv'):
            from compression import zstd
            pos, out = 20, []
            while pos < len(d):
                n = struct.unpack_from('<I', d, pos)[0]
                out.append(zstd.decompress(d[pos + 4:pos + 4 + n])); pos += 4 + n
            d = b''.join(out)
        if d.startswith(b'RASTATE'):           # RetroArch container: find the MEM block
            pos = 8
            while pos < len(d):
                tag, n = d[pos:pos + 4], struct.unpack_from('<I', d, pos + 4)[0]
                if tag == b'MEM ':
                    d = d[pos + 8:pos + 8 + n]; break
                pos += 8 + n + (-n % 8)
        buf = C.create_string_buffer(d, len(d))
        if not self.lib.retro_unserialize(buf, len(d)):
            raise SystemExit('retro_unserialize failed')

    def save_state(self, path):
        n = self.lib.retro_serialize_size()
        buf = C.create_string_buffer(n)
        self.lib.retro_serialize(buf, n)
        open(path, 'wb').write(buf.raw)

    def ram(self):
        p, n = self.lib.retro_get_memory_data(2), self.lib.retro_get_memory_size(2)
        return p, n

    def peek(self, addr, n):
        p, size = self.ram()
        o = (addr - 0x02000000) % size
        return C.string_at(p + o, n)

    def poke(self, addr, b):
        p, size = self.ram()
        C.memmove(p + (addr - 0x02000000) % size, b, len(b))

    def dtcm(self, addr, n):                   # DTCM (0x027e0000) from a serialized state
        size = self.lib.retro_serialize_size()
        buf = C.create_string_buffer(size)
        self.lib.retro_serialize(buf, size)
        j = buf.raw.find(b'CP15', 0x400100)
        o = j + 0x801c + (addr - 0x027e0000)
        return buf.raw[o:o + n]

    def shot(self, path):
        data, w, h, pitch = self.frame
        rows = []
        for y in range(h):
            row = bytearray(b'\0')
            line = data[y * pitch:y * pitch + w * (4 if self.fmt == 1 else 2)]
            if self.fmt == 1:
                for x in range(w):
                    b, g, r = line[4 * x], line[4 * x + 1], line[4 * x + 2]
                    row += bytes((r, g, b))
            else:
                for x in range(w):
                    v = line[2 * x] | line[2 * x + 1] << 8
                    row += bytes(((v >> 11) * 255 // 31, (v >> 5 & 63) * 255 // 63, (v & 31) * 255 // 31))
            rows.append(bytes(row))
        def chunk(t, d): return struct.pack('>I', len(d)) + t + d + struct.pack('>I', zlib.crc32(t + d))
        png = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 2, 0, 0, 0)) \
            + chunk(b'IDAT', zlib.compress(b''.join(rows))) + chunk(b'IEND', b'')
        open(path, 'wb').write(png)

def keyset(s):
    return {KEYS[k] for k in s.lower().split('+') if k}

def main():
    a = sys.argv[1:]
    rig = Rig(a[0])
    if len(a) > 1 and a[1] != '-':
        rig.run(1)
        rig.load_state(a[1])
    lines = open(a[2]).read().splitlines() if len(a) > 2 else sys.stdin.read().splitlines()
    for line in lines:
        w = line.split()
        if not w or w[0].startswith('#'): continue
        c = w[0]
        if c == 'run': rig.run(int(w[1]))
        elif c == 'hold':
            rig.keys = keyset(w[1]); rig.run(int(w[2])); rig.keys = set()
        elif c == 'press':
            rig.keys = keyset(w[1]); rig.run(2); rig.keys = set(); rig.run(4)
        elif c == 'touch':
            rig.touch = (int(w[1]), int(w[2])); rig.run(int(w[3])); rig.touch = None
        elif c == 'shot': rig.shot(w[1]); print('shot', w[1])
        elif c == 'peek':
            a, n = int(w[1], 16), int(w[2])
            d = rig.dtcm(a, n) if 0x027e0000 <= a < 0x027e4000 else rig.peek(a, n)
            print(w[1], d.hex(' '))
        elif c == 'poke': rig.poke(int(w[1], 16), bytes.fromhex(w[2]))
        elif c == 'save': rig.save_state(w[1])
        else: print('?', line)
        sys.stdout.flush()

if __name__ == '__main__':
    main()
