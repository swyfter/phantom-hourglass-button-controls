"""Print the debug build's per-mode input-gate table while the game runs in RetroArch.
Needs patch_src/dpad_debug.bin + .nm from a DPAD_DEBUG=1 build (v2.1.3+).
For each game mode seen: open = buttons read, gated = the game ignores buttons (cutscenes...),
ctl = player control (tap_front) ran while gated.
usage: python ragate.py [--watch]"""
import os, sys, time
from ra import read
from rahotload import syms

HERE = os.path.dirname(os.path.abspath(__file__))
S = syms(os.path.join(HERE, 'patch_src', 'dpad_debug.nm'))

def show():
    t = read(S['dbg_modes'], 96)
    g = read(S['dbg_gated'], 1)[0]
    rows = [f'  mode {m:#04x}: ' + ' '.join(n for b, n in ((1, 'open'), (2, 'gated'), (4, 'ctl')) if v & b)
            for m, v in enumerate(t) if v]
    return f'gated now: {g}\n' + '\n'.join(rows)

if __name__ == '__main__':
    if '--watch' in sys.argv:
        last = None
        while True:
            s = show()
            if s != last: print(time.strftime('%H:%M:%S'), s, sep='\n'); last = s
            time.sleep(0.5)
    else:
        print(show())
