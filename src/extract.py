"""Dump decompressed ARM9 and overlays from a ROM for disassembly.
usage: python extract.py rom.nds outdir      -> arm9.bin (@0x02000000), ov_NN.bin (+ ov_list.txt)"""
import sys, os, struct
from blz import blz_dec
def u32(b, o): return struct.unpack_from('<I', b, o)[0]
rom = open(sys.argv[1], 'rb').read(); out = sys.argv[2]; os.makedirs(out, exist_ok=True)
a9off, a9size = u32(rom, 0x20), u32(rom, 0x2C)
a9 = rom[a9off:a9off + a9size]
comp_end = u32(a9, 0xB64 + 0x14)
arm9 = a9[:0x4000] + blz_dec(a9[0x4000:comp_end - 0x02000000]) + a9[comp_end - 0x02000000:]
open(os.path.join(out, 'arm9.bin'), 'wb').write(arm9)
ovt_off, ovt_size, fat = u32(rom, 0x50), u32(rom, 0x54), u32(rom, 0x48)
lst = []
for i in range(ovt_size // 32):
    e = struct.unpack_from('<8I', rom, ovt_off + i * 32)
    s, t = u32(rom, fat + e[6] * 8), u32(rom, fat + e[6] * 8 + 4)
    raw = rom[s:t]
    dec = blz_dec(raw[:e[7] & 0xFFFFFF]) if (e[7] >> 24) & 1 else raw
    open(os.path.join(out, f'ov_{i:02d}.bin'), 'wb').write(dec)
    lst.append(f'{i:2d} {e[1]:#010x} {len(dec):#x}')
open(os.path.join(out, 'ov_list.txt'), 'w').write('\n'.join(lst) + '\n')
print('\n'.join(lst))
