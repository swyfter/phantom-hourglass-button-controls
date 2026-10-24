"""Read main RAM from a RetroArch melonDS DS save state (RZIP v2 = zstd chunks).
usage: python stateram.py STATE...   (needs Python 3.14 for compression.zstd)
Prints the touch controller (0x021BAB68) grab/target fields of each state."""
import sys, struct
from compression import zstd

CTL = 0x021BAB68

def unpack(path):
    d = open(path, 'rb').read()
    if not d.startswith(b'#RZIPv'):
        return d
    pos, out = 20, []
    while pos < len(d):
        n = struct.unpack_from('<I', d, pos)[0]
        out.append(zstd.decompress(d[pos + 4:pos + 4 + n]))
        pos += 4 + n
    return b''.join(out)

def main_ram(path):
    s = unpack(path)
    i = s.find(b'NDSG')
    return s[i + 0x14:i + 0x14 + 0x400000]

def rd(ram, addr, n):
    o = addr - 0x02000000
    return ram[o:o + n]

if __name__ == '__main__':
    for p in sys.argv[1:]:
        ram = main_ram(p)
        c = rd(ram, CTL, 0xA0)
        w = struct.unpack_from('<10i', c, 0x78)
        print(f'{p.rsplit(chr(92), 1)[-1]:60} touch={c[0xc]} 6a={struct.unpack_from("<H", c, 0x6a)[0]:04x} '
              f'81={c[0x81]:02x} 82={c[0x82]:02x} 84={w[3] & 0xffffffff:x} 94={w[7] & 0xffffffff:x} 98={w[8] & 0xffffffff:x} '
              + ' '.join(f'+{0x78 + 4 * i:02x}={v & 0xffffffff:x}' for i, v in enumerate(w)))
