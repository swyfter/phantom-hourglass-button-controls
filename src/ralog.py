"""Log the diagnostic build's A-button taps while the game runs in RetroArch (melonDS DS).
Needs patch_src/dpad_debug.bin + .nm from a DPAD_DEBUG=1 build. If RAM holds another known build
(a save state made with an older ROM), the debug code is hot-loaded over it automatically.
usage: python ralog.py [--hotload] [logfile]      (Ctrl+C to stop)"""
import os, sys, time, struct, glob
from ra import read
from rahotload import hotload, matches, syms

HERE = os.path.dirname(os.path.abspath(__file__))
P = os.path.join(HERE, 'patch_src')
DBG = (os.path.join(P, 'dpad_debug.bin'), os.path.join(P, 'dpad_debug.nm'))
# other builds a save state may hold: patch_src/known/*.bin with matching .nm
OLDS = [(b, b[:-4] + '.nm') for b in sorted(glob.glob(os.path.join(P, 'known', '*.bin')))]
out = open(next((a for a in sys.argv[1:] if a != '--hotload'), None) or os.path.join(HERE, 'ralog.txt'), 'a', buffering=1)

def log(s):
    line = time.strftime('%H:%M:%S ') + s
    print(line); out.write(line + '\n')

# Hot-loading hangs the game when melonDS DS runs with its JIT on (JIT blocks aren't invalidated
# by frontend memory writes). Only use --hotload with the core's JIT disabled.
HOTLOAD = '--hotload' in sys.argv
if HOTLOAD: sys.argv.remove('--hotload')

def ensure_debug():
    """True when the debug code is running (hot-loading it if allowed and needed)."""
    try:
        if matches(*DBG): return True
        if not HOTLOAD: return False
        r = hotload(*DBG, OLDS)
        if r: log(f'--- hot-loaded debug code over {os.path.basename(r)}')
        return bool(r)
    except (IOError, OSError, AssertionError) as e:
        return False

sym = syms(DBG[1])
SEQ, LOG, CTL = sym['dbg_seq'], sym['dbg_log'], sym['dbg_ctl']
log('--- waiting for the game')
was_ok = False
last, changed_at, checked = None, None, 0
while True:
    if time.time() - checked > 1.0:                        # catch save-state loads
        checked = time.time()
        ok = ensure_debug()
        if ok != was_ok:
            log('--- debug code running, logging A presses' if ok else '--- debug code not running (unknown build?)')
            was_ok, last = ok, None
    if not was_ok:
        time.sleep(0.2); continue
    try:
        seq = struct.unpack('<I', read(SEQ, 4))[0]
    except (IOError, OSError):
        was_ok = False; continue
    if last is None or seq < last:
        last = seq
    if seq != last and changed_at is None:
        changed_at = time.time()
    if changed_at and time.time() - changed_at > 0.7:      # let the probe run finish
        seq = struct.unpack('<I', read(SEQ, 4))[0]
        ring = read(LOG, 128)
        log(f'A press: {seq - last} tap(s)')
        for i in range(max(last, seq - 16), seq):
            st, f81, f82, f84, x, y = struct.unpack_from('<4B2h', ring, (i % 16) * 8)
            kind = 'textbox' if st == 0xEE else 'throw' if st == 0 else f'probe {st // 2 - 1}'
            flags = 'not checked' if f81 == 0xFF else f'+81={f81:02x} +82={f82:02x} +84={f84:02x}'
            log(f'  {kind:8} at ({x:4},{y:4})  {flags}')
        ctl = struct.unpack('<I', read(CTL, 4))[0]
        if 0x02000000 <= ctl < 0x02400000:
            log(f'  ctl {ctl:08x} +80: ' + read(ctl + 0x80, 16).hex(' '))
        last, changed_at = seq, None
    time.sleep(0.02)
