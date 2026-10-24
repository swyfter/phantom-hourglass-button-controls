"""Take a RAM snapshot (snaps/pN.json, same format as rasnap.py) each time RetroArch is paused.
Works with any build: uses the touch controller at 0x021BAB68 (stable in this game).
usage: python rapause.py [first_index]      (Ctrl+C to stop)"""
import os, sys, time, json
from ra import cmd, read

HERE = os.path.dirname(os.path.abspath(__file__))
D = os.path.join(HERE, 'snaps'); os.makedirs(D, exist_ok=True)
# keep this small: each 1 KB read is one UDP round trip, and a capture must finish before the
# user unpauses (a 1 MB heap read took ~20 s and smeared over gameplay)
REGIONS = {'ctl': (0x021BAB68, 0x200), 'obj': (0x021CE300, 0x400), 'ui': (0x021E3800, 0x800)}

def grab(a, n): return b''.join(read(a + o, min(1024, n - o)) for o in range(0, n, 1024))

n = int(sys.argv[1]) if len(sys.argv) > 1 else 0
was = False
while True:
    try:
        paused = 'PAUSED' in cmd('GET_STATUS')
    except OSError:
        paused = False
    if paused and not was:
        snap = {k: (a, grab(a, sz).hex()) for k, (a, sz) in REGIONS.items()}
        json.dump(snap, open(os.path.join(D, f'p{n}.json'), 'w'))
        print(time.strftime('%H:%M:%S'), 'saved', f'p{n}', flush=True)
        n += 1
    was = paused
    time.sleep(0.3)
