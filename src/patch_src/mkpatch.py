"""Create BPS and xdelta3-compatible VCDIFF patches (clean -> v2), and verify both.
usage: python3 mkpatch.py clean.nds v2.nds out_basename
"""
import sys, os, zlib, struct
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

MIN_COPY = 16
BLOCK = 4096

def mismatch(src, tgt, i, end):
    """First k in [i, end) with src[k] != tgt[k], or end. Skips equal blocks, then bisects."""
    while i < end:
        e = min(i + BLOCK, end)
        if src[i:e] == tgt[i:e]:
            i = e; continue
        lo, hi = i, e                                  # first mismatch is in [lo, hi)
        while hi - lo > 1:
            mid = (lo + hi) >> 1
            if src[lo:mid] == tgt[lo:mid]: lo = mid
            else: hi = mid
        return lo
    return end

def regions(src, tgt):
    """Yield ('same', off, len) / ('diff', off, len) over the target."""
    n = len(tgt); m = min(n, len(src)); i = 0
    while i < n:
        if i < m and src[i] == tgt[i]:
            j = mismatch(src, tgt, i, m)               # 'same' stops at a mismatch or the end of the source
            yield 'same', i, j - i
        else:
            # extend diff until we see MIN_COPY identical bytes (inside the source and the target)
            j = i
            while True:
                while j < m and src[j] != tgt[j]: j += 1
                if j + MIN_COPY > m: j = n; break      # no room for MIN_COPY equal bytes: diff to the end
                k = mismatch(src, tgt, j, j + MIN_COPY)
                if k == j + MIN_COPY: break
                j = k
            yield 'diff', i, j - i
        i = j

# ---------------- BPS ----------------
def bps_num(n):
    out = bytearray()
    while True:
        x = n & 0x7f; n >>= 7
        if n == 0: out.append(0x80 | x); return bytes(out)
        out.append(x); n -= 1

def make_bps(src, tgt):
    p = bytearray(b'BPS1') + bps_num(len(src)) + bps_num(len(tgt)) + bps_num(0)
    for kind, off, ln in regions(src, tgt):
        if kind == 'same':
            p += bps_num(((ln - 1) << 2) | 0)              # SourceRead
        else:
            p += bps_num(((ln - 1) << 2) | 1) + tgt[off:off + ln]  # TargetRead
    p += struct.pack('<II', zlib.crc32(src), zlib.crc32(tgt))
    p += struct.pack('<I', zlib.crc32(p))
    return bytes(p)

def apply_bps(p, src):
    assert p[:4] == b'BPS1'; i = 4
    def num():
        nonlocal i
        data, shift = 0, 1
        while True:
            x = p[i]; i += 1
            data += (x & 0x7f) * shift
            if x & 0x80: return data
            shift <<= 7; data += shift
    ss, ts, ms = num(), num(), num(); i += ms
    assert zlib.crc32(src) == struct.unpack_from('<I', p, len(p) - 12)[0], 'source CRC mismatch'
    out = bytearray(); srel = trel = 0
    while i < len(p) - 12:
        d = num(); cmd, ln = d & 3, (d >> 2) + 1
        if cmd == 0: out += src[len(out):len(out) + ln]
        elif cmd == 1: out += p[i:i + ln]; i += ln
        elif cmd == 2:
            d = num(); srel += (-1 if d & 1 else 1) * (d >> 1); out += src[srel:srel + ln]; srel += ln
        else:
            d = num(); trel += (-1 if d & 1 else 1) * (d >> 1)
            for _ in range(ln): out.append(out[trel]); trel += 1
    assert len(out) == ts and zlib.crc32(out) == struct.unpack_from('<I', p, len(p) - 8)[0], 'target CRC mismatch'
    return bytes(out)

# ---------------- VCDIFF (RFC 3284, default code table, as xdelta3 reads it) ----------------
def vint(n):
    out = [n & 0x7f]; n >>= 7
    while n: out.append(0x80 | (n & 0x7f)); n >>= 7
    return bytes(reversed(out))

WIN = 0x800000  # 8 MiB target windows, each paired with the same source range

def make_vcdiff(src, tgt):
    out = bytearray(b'\xd6\xc3\xc4\x00') + bytes([0])   # magic, version 0, no header extras
    for w0 in range(0, len(tgt), WIN):
        w1 = min(w0 + WIN, len(tgt))
        s0, s1 = w0, min(w1, len(src))
        data = bytearray(); inst = bytearray(); addr = bytearray()
        for kind, off, ln in regions(src[s0:s1], tgt[w0:w1]):
            if kind == 'same':
                inst += bytes([19]) + vint(ln)       # COPY, size follows, mode 0 (VCD_SELF)
                addr += vint(off)                    # address within the source segment
            else:
                inst += bytes([1]) + vint(ln)        # ADD, size follows
                data += tgt[w0 + off:w0 + off + ln]
        delta = vint(w1 - w0) + bytes([0]) + vint(len(data)) + vint(len(inst)) + vint(len(addr)) + data + inst + addr
        out += bytes([1]) + vint(s1 - s0) + vint(s0) + vint(len(delta)) + delta   # VCD_SOURCE
    return bytes(out)

def main(srcp, tgtp, base):
    src = open(srcp, 'rb').read(); tgt = open(tgtp, 'rb').read()
    bps = make_bps(src, tgt); open(base + '.bps', 'wb').write(bps)
    assert apply_bps(bps, src) == tgt
    vc = make_vcdiff(src, tgt); open(base + '.xdelta', 'wb').write(vc)
    import subprocess
    tmp = base + '.check.nds'
    # apply.py: next to this file in the release source zip (flat src/), one folder up (src\) in the project
    here = os.path.dirname(os.path.abspath(__file__))
    ap = os.path.join(here, 'apply.py') if os.path.exists(os.path.join(here, 'apply.py')) else os.path.join(os.path.dirname(here), 'apply.py')
    subprocess.run([sys.executable, ap, srcp, base + '.xdelta', tmp], check=True, capture_output=True)
    assert open(tmp, 'rb').read() == tgt; os.remove(tmp)
    print('bps', len(bps), 'bytes; xdelta', len(vc), 'bytes; both verified')

if __name__ == '__main__':
    main(*sys.argv[1:4])
