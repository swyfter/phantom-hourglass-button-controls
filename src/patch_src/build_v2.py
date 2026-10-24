"""Build Zelda: Phantom Hourglass (US) D-pad v2 from a clean ROM.

usage: python3 build_v2.py clean.nds out.nds

Edits are made in place: no filesystem rebuild, every other file keeps its
original offset, so the resulting patch is small and easy to audit.
"""
import sys, os, struct, subprocess, hashlib, zlib
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))
from blz import blz_dec
from blzenc import recompress
from nds import ROM
import text_fix

CLEAN_SHA1 = '4c8f52dd719918bbcd46e73a8bae8628139c1b85'
DEBUG = os.environ.get('DPAD_DEBUG') == '1'   # diagnostic build with the RAM tap log (see ralog.py)
OUT = 'dpad_debug' if DEBUG else 'dpad'        # link.py output names (OUT.bin, OUT.sym, ...)
CODE_ADDR = 0x0219B120          # link address = old main-arena start (end of the largest overlay)
CODE_RESERVE = 0x4700     # 17.75 KB reserved (history: src/DEVLOG.md, "Build scripts")
if DEBUG:
    CODE_RESERVE += 0x200       # diagnostic build only: logs don't fit

def u32(b, o): return struct.unpack_from('<I', b, o)[0]
def p32(b, o, v): struct.pack_into('<I', b, o, v)

def bl(src, dst):
    off = (dst - (src + 8)) >> 2
    assert -(1 << 23) <= off < (1 << 23)
    return 0xEB000000 | (off & 0xFFFFFF)

def patch_word(buf, base, addr, old, new):
    o = addr - base
    cur = u32(buf, o)
    assert cur == old, f'{addr:#x}: expected {old:#010x}, found {cur:#010x}'
    p32(buf, o, new)

def crc16(data):
    c = 0xFFFF
    for x in data:
        c ^= x
        for _ in range(8):
            c = (c >> 1) ^ 0xA001 if c & 1 else c >> 1
    return c

def main(src, dst):
    rom = bytearray(open(src, 'rb').read())
    sha = hashlib.sha1(rom).hexdigest()
    if sha != CLEAN_SHA1:
        sys.exit(f'Not the clean US ROM (sha1 {sha}); expected {CLEAN_SHA1}')

    subprocess.run([sys.executable, os.path.join(HERE, 'link.py')], check=True)
    code = open(os.path.join(HERE, OUT + '.bin'), 'rb').read()
    sym = {l.split()[2]: int(l.split()[0], 16) for l in open(os.path.join(HERE, OUT + '.sym'))}
    print(f'{OUT}.bin {len(code)} bytes, CODE_RESERVE {CODE_RESERVE:#x}, {CODE_RESERVE - len(code)} bytes free')
    code += b'\0' * (-len(code) % 32)
    assert len(code) <= CODE_RESERVE, 'code does not fit in CODE_RESERVE'

    # ---------------- ARM9 ----------------
    a9off, a9size = u32(rom, 0x20), u32(rom, 0x2C)
    a9 = bytes(rom[a9off:a9off + a9size])
    MP = 0xB64                                   # module params
    mp = struct.unpack_from('<6I', a9, MP)
    al, ale, ast, bss0, bss1, comp_end = mp
    assert comp_end == 0x02041A18
    arm9 = bytearray(a9[:0x4000] + blz_dec(a9[0x4000:comp_end - 0x02000000]) + a9[comp_end - 0x02000000:])
    B = 0x02000000

    # H1: let the pad routine always read buttons (as v1); the D-pad/A tap logic needs it.
    o = 0x0202ADEC - B
    assert arm9[o + 3] == 0x0A; arm9[o + 3] = 0xEA
    # H3: the game's PadUpdate call (r0 = PAD) goes to pad_update, which reads the keys and changes
    # the PAD bits for the menus and screens before the game uses them (see dpad.s).
    patch_word(arm9, B, 0x0202AE3C, bl(0x0202AE3C, 0x02037414), bl(0x0202AE3C, sym['pad_update']))
    # H2: A/B advance dialogue.
    patch_word(arm9, B, 0x0203A474, 0xE1D013B4, bl(0x0203A474, sym['dialog_advance']))
    # Reserve RAM for our code: move the main arena start up by CODE_RESERVE.
    for lit in (0x0200E580, 0x0202F744):
        patch_word(arm9, B, lit, CODE_ADDR, CODE_ADDR + CODE_RESERVE)

    # New autoload block: append code after existing block data, move the table after it.
    table = bytes(arm9[al - B:ale - B])
    assert ale - B == len(arm9) and len(table) == 24
    arm9 = arm9[:al - B] + code + table + struct.pack('<3I', CODE_ADDR, len(code), 0)
    new_al = al + len(code)
    struct.pack_into('<2I', arm9, MP, new_al, new_al + 36)
    assert B + len(arm9) < bss1, 'ARM9 image would overlap overlay region'

    # Reuse the original token stream: only the tokens near an edit and at the high end (our
    # code, the new autoload table) change, so the patch holds almost none of the original code.
    comp = recompress(a9[0x4000:comp_end - B], bytes(arm9[0x4000:]))
    assert blz_dec(comp) == bytes(arm9[0x4000:])
    new_a9 = bytearray(arm9[:0x4000] + comp)
    p32(new_a9, MP + 0x14, B + len(new_a9))      # compressed_static_end
    # ARM9 slot ends where the ARM9 overlay table begins; move that table to the end if needed.
    ovt_off, ovt_size = u32(rom, 0x50), u32(rom, 0x54)
    slot_end = ovt_off
    used = u32(rom, 0x80)
    def append(blob):
        nonlocal used
        pos = (used + 0x1FF) & ~0x1FF
        rom[pos:pos + len(blob)] = blob
        used = pos + len(blob)
        return pos
    if a9off + len(new_a9) > slot_end:
        newpos = append(bytes(rom[ovt_off:ovt_off + ovt_size]))
        rom[ovt_off:ovt_off + ovt_size] = b'\xff' * ovt_size
        p32(rom, 0x50, newpos); ovt_off = newpos
        slot_end = 0x46400
    # Still too big (v2.1.19, 7.5 KB of code): move the files that follow to the end of the ROM.
    fat, nfat = u32(rom, 0x48), u32(rom, 0x4C) // 8     # FAT offset, file count
    while a9off + len(new_a9) > slot_end:
        starts = sorted(u32(rom, fat + i * 8) for i in range(nfat) if u32(rom, fat + i * 8 + 4) > u32(rom, fat + i * 8))
        fid = next(i for i in range(nfat) if u32(rom, fat + i * 8) == slot_end)
        fs, ft = u32(rom, fat + fid * 8), u32(rom, fat + fid * 8 + 4)
        pos = append(bytes(rom[fs:ft]))
        rom[fs:ft] = b'\xff' * (ft - fs)
        struct.pack_into('<2I', rom, fat + fid * 8, pos, pos + ft - fs)
        slot_end = next(s for s in starts if s > fs)
    assert a9off + len(new_a9) <= slot_end
    rom[a9off:a9off + a9size] = b'\xff' * a9size
    rom[a9off:a9off + len(new_a9)] = new_a9
    p32(rom, 0x2C, len(new_a9))

    # ---------------- overlays ----------------
    def ovl(i):
        e = list(struct.unpack_from('<8I', rom, ovt_off + i * 32))
        fid = e[6]
        s, t = u32(rom, fat + fid * 8), u32(rom, fat + fid * 8 + 4)
        raw = bytes(rom[s:t])
        dec = bytearray(blz_dec(raw[:e[7] & 0xFFFFFF]) if (e[7] >> 24) & 1 else raw)
        return e, fid, s, t, dec
    def store(i, e, fid, s, t, dec):
        c = recompress(bytes(rom[s:t])[:e[7] & 0xFFFFFF], bytes(dec)); assert blz_dec(c) == bytes(dec)
        # in place if it fits before the next file's 0x200 boundary, else append
        limit = (t + 0x1FF) & ~0x1FF
        if s + len(c) <= limit:
            rom[s:limit] = b'\xff' * (limit - s); pos = s
            rom[pos:pos + len(c)] = c
        else:
            rom[s:t] = b'\xff' * (t - s); pos = append(c)
        struct.pack_into('<2I', rom, fat + fid * 8, pos, pos + len(c))
        e[7] = (e[7] & 0xFF000000) | len(c)
        struct.pack_into('<8I', rom, ovt_off + i * 32, *e)

    # overlay 0: player / field controls
    e, fid, s, t, d = ovl(0); base = e[1]
    for addr, old, fn in ((0x020B79B0, 0xEBFFFFB4, 'dpad_move'),
                          (0x020B7938, 0xE1C416B2, 'tap_front'),
                          (0x020AEC04, 0xEB000999, 'roll_check'),
                          (0x020B0D74, 0xE3A00000, 'slash_check'),
                          (0x020A9480, 0xE5C01004, 'spin_check'),
                          (0x0207AF30, bl(0x0207AF30, 0x0207AD30), 'menu_touch')):
        patch_word(d, base, addr, old, bl(addr, sym[fn]))
    # touch-button class (vtable 0x020E893C) update: fs_btn records the file select buttons
    patch_word(d, base, 0x020E893C, 0x020D0610, sym['fs_btn'])
    store(0, e, fid, s, t, d)

    # overlay 3: save menu (Continue / Save and Quit) button updates, seen by smenu_btn.
    e, fid, s, t, d = ovl(3); base = e[1]
    for addr in (0x020F16D8, 0x020F1780):
        patch_word(d, base, addr, 0xE12FFF3C, bl(addr, sym['smenu_btn']))   # blx r12
    store(3, e, fid, s, t, d)

    # overlay 9: field HUD shortcuts.  Original: B/Down = map toggle, Y/Left = menu bar,
    # Select = items; while the map is open (modes 4/8/44) A/X/Y/Up/Left/Right also close it.
    # B/Y/D-pad now control Link, so: Select = menu bar (Save, Collection, Sea Chart, Map; v2.1.31,
    # as in v2.1-v2.1.18), L = nothing (map until v2.1.30, items until v2.1.18), Select no longer
    # opens the items directly (it did in v2.1.19-v2.1.30); R uses the equipped item, see item_ctl;
    # with the map open, A/B/X/Y/D-pad/L/R close it (Link can't move then anyway).
    e, fid, s, t, d = ovl(9); base = e[1]
    patch_word(d, base, 0x0211B134, 0xE3120082, 0xE3120000)   # tst r2,#0x82  -> tst r2,#0 (none; L until v2.1.30)
    patch_word(d, base, 0x0211B300, 0x00000C71, 0x00000FF3)   # map-open close mask: +B,Down,R,L
    patch_word(d, base, 0x0211B214, 0xE3120E82, 0xE3120004)   # menu bar: tst r2,#0x820 -> tst r2,#4 (Select)
    patch_word(d, base, 0x0211B2B4, 0xE3100004, 0xE3100000)   # items: tst r0,#4 -> tst r0,#0 (none)
    store(9, e, fid, s, t, d)

    # overlay 14: item bar button (the Items list). Original: A/Right. Now: X.
    e, fid, s, t, d = ovl(14); base = e[1]
    patch_word(d, base, 0x0214414C, 0xE3100011, 0xE3100B01)   # tst r0,#0x11 -> tst r0,#0x400 (X)
    store(14, e, fid, s, t, d)

    # ---------------- English text fixes (typos, see text_fix.py) ----------------
    text_fix.apply(rom, fat, ROM(src).names, append)

    # ---------------- header ----------------
    p32(rom, 0x80, used)
    struct.pack_into('<H', rom, 0x15E, crc16(rom[:0x15E]))
    open(dst, 'wb').write(rom)
    print('wrote', dst, 'sha1', hashlib.sha1(rom).hexdigest(), 'crc32 %08x' % zlib.crc32(rom))

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
