"""Hot-swap patch code into a running game (e.g. a save state holding older code) via RetroArch.
usage: python rahotload.py NEW.bin NEW.nm [OLD.bin OLD.nm ...]
WARNING: with melonDS DS's JIT enabled this hangs the game (stale JIT blocks); disable the JIT first.
Otherwise safe while the game runs: hooks are first put back to the game's original instructions,
then the code is written, then the hooks are pointed at the new code."""
import sys
from ra import read, write

CODE = 0x0219B120
# hook address: (patch function, original instruction) - see build_v2.py
HOOKS = {0x0203A474: ('dialog_advance', 0xE1D013B4), 0x020B79B0: ('dpad_move', 0xEBFFFFB4),
         0x020B7938: ('tap_front', 0xE1C416B2), 0x020AEC04: ('roll_check', 0xEB000999),
         0x020B0D74: ('slash_check', 0xE3A00000), 0x020A9480: ('spin_check', 0xE5C01004)}

def syms(p):
    d = {}
    for l in open(p):
        a = l.split()
        if len(a) == 3: d[a[2]] = int(a[0], 16)
    return d

def bl(src, dst): return (0xEB000000 | (((dst - src - 8) >> 2) & 0xFFFFFF)).to_bytes(4, 'little')

def read_code(n): return b''.join(read(CODE + o, min(256, n - o)) for o in range(0, n, 256))

def matches(binp, nmp):
    """RAM holds this build's code (up to its variables) and its hooks."""
    code, s = open(binp, 'rb').read(), syms(nmp)
    lim = s['msg_guard'] - CODE
    if read_code(lim) != code[:lim]: return False
    return all(read(a, 4) == bl(a, s[f]) for a, (f, _) in HOOKS.items())

def hotload(newbin, newnm, olds):
    """olds: [(bin, nm)] builds RAM may hold. Returns name of the replaced build, or None."""
    for ob, on in olds:
        if matches(ob, on): break
    else:
        return None
    new, s = open(newbin, 'rb').read(), syms(newnm)
    assert len(new) <= 0x800
    for a, (_, orig) in HOOKS.items(): write(a, orig.to_bytes(4, 'little'))
    for o in range(0, len(new), 128): write(CODE + o, new[o:o + 128])
    assert read_code(len(new)) == new, 'code verify failed'
    for a, (f, _) in HOOKS.items(): write(a, bl(a, s[f]))
    assert matches(newbin, newnm), 'hook verify failed'
    return ob

if __name__ == '__main__':
    a = sys.argv[1:]
    r = hotload(a[0], a[1], list(zip(a[2::2], a[3::2])))
    print('replaced', r) if r else sys.exit('RAM holds none of the given builds')
