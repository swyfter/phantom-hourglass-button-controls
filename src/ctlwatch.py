"""Log changes in the touch controller (0x021BAB68) +0x80..+0xA0 and PAD-independent fields, live.
usage: python ctlwatch.py [logfile]"""
import sys, time, struct
from ra import read
CTL = 0x021BAB68
out = open(sys.argv[1] if len(sys.argv) > 1 else 'ctlwatch.txt', 'a', buffering=1)
last = None
while True:
    try:
        b = read(CTL, 0xA0)
    except OSError:
        time.sleep(0.5); continue
    w = struct.unpack_from('<10i', b, 0x78)
    key = (b[0x0c], w, struct.unpack_from('<H', b, 0x6a)[0])
    if key != last:
        line = (time.strftime('%H:%M:%S') + f'.{int(time.time()*10)%10} touch={b[0x0c]} 6a={key[2]:04x} '
                + ' '.join(f'+{0x78+4*i:02x}={v & 0xffffffff:x}' for i, v in enumerate(w)))
        print(line, flush=True); out.write(line + '\n')
        last = key
    time.sleep(0.03)
