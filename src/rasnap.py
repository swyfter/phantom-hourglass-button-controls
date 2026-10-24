"""Snapshot / diff RAM regions through RetroArch, to find game state flags.
usage: python rasnap.py save NAME        (touch controller +0..0x200 and the player region)
       python rasnap.py diff NAME1 NAME2"""
import os, sys, struct, json
from ra import read

HERE = os.path.dirname(os.path.abspath(__file__))
D = os.path.join(HERE, 'snaps'); os.makedirs(D, exist_ok=True)
sym = {l.split()[2]: int(l.split()[0], 16) for l in open(os.path.join(HERE, 'patch_src', 'dpad_debug.nm')) if len(l.split()) == 3}

def regions():
    ctl = struct.unpack('<I', read(sym['dbg_ctl'], 4))[0]
    return {'ctl': (ctl, 0x200), 'heap': (0x021A0000, 0x40000)}   # heap around the controller

def grab(a, n): return b''.join(read(a + o, min(1024, n - o)) for o in range(0, n, 1024))

if sys.argv[1] == 'save':
    snap = {k: (a, grab(a, n).hex()) for k, (a, n) in regions().items()}
    json.dump(snap, open(os.path.join(D, sys.argv[2] + '.json'), 'w'))
    print('saved', sys.argv[2], {k: hex(a) for k, (a, _) in snap.items()})
else:
    s = [json.load(open(os.path.join(D, n + '.json'))) for n in sys.argv[2:]]
    for k in s[0]:
        bs = [(r[k][0], bytes.fromhex(r[k][1])) for r in s]
        base = bs[0][0]
        if any(b[0] != base for b in bs): print(k, 'moved'); continue
        diffs = [i for i in range(len(bs[0][1])) if len({b[1][i] for b in bs}) > 1]
        print(f'{k} @ {base:#x}: {len(diffs)} differing bytes')
        for i in diffs[:200]:
            print(f'  {base + i:#010x} +{i:#06x}: ' + ' '.join(f'{b[1][i]:02x}' for b in bs))
