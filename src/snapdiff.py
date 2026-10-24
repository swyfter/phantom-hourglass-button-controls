"""Compare rapause snapshots. usage: python snapdiff.py region off len p0 p1 ...   (dump words)
                                  python snapdiff.py diff region p0 p1 ...          (changed bytes)"""
import sys, json, os, struct
HERE = os.path.dirname(os.path.abspath(__file__))
def load(n, k):
    a, h = json.load(open(os.path.join(HERE, 'snaps', n + '.json')))[k]
    return a, bytes.fromhex(h)
a = sys.argv[1:]
if a[0] == 'diff':
    k, names = a[1], a[2:]
    ss = [load(n, k) for n in names]
    base = ss[0][0]; bs = [s[1] for s in ss]
    d = [i for i in range(len(bs[0])) if len({b[i] for b in bs}) > 1]
    print(len(d), 'bytes differ')
    for i in d[:int(os.environ.get('LIM', 300))]:
        print(f'{base+i:#010x} +{i:#06x}: ' + ' '.join(f'{b[i]:02x}' for b in bs))
else:
    k, off, ln, names = a[0], int(a[1], 16), int(a[2], 16), a[3:]
    for n in names:
        base, b = load(n, k)
        o = off - base if off >= base else off
        print(n, b[o:o + ln].hex(' '))
