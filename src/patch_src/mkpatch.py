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

KEY = 32  # source index: one entry per KEY-aligned block, so moved data of 2 * KEY bytes or more is found

def match_len(a, ai, b, bi, end):
    """Number of equal bytes a[ai + k] == b[bi + k] for bi + k < end (blocks first, then bisect)."""
    k, n = 0, min(end - bi, len(a) - ai)
    while k < n:
        e = min(k + BLOCK, n)
        if a[ai + k:ai + e] == b[bi + k:bi + e]:
            k = e; continue
        lo, hi = k, e
        while hi - lo > 1:
            mid = (lo + hi) >> 1
            if a[ai + lo:ai + mid] == b[bi + lo:bi + mid]: lo = mid
            else: hi = mid
        return lo
    return n

def ops(src, tgt):
    """Yield ('copy', tgt_off, len, src_off) / ('add', tgt_off, len, None) over the target.
    Same-offset copies first; in the other spans, copies of data that moved (a hash of each
    KEY-aligned source block finds them, then the match grows both ways)."""
    index = {}
    for p in range(0, len(src) - KEY + 1, KEY):
        index.setdefault(src[p:p + KEY], p)
    for kind, off, ln in regions(src, tgt):
        if kind == 'same':
            yield 'copy', off, ln, off; continue
        end = off + ln; lit = i = off
        while i + KEY <= end:
            p = index.get(tgt[i:i + KEY])
            if p is None: i += 1; continue
            b = 0                                      # grow the match backwards
            while i - b > lit and p - b > 0 and src[p - b - 1] == tgt[i - b - 1]: b += 1
            n = b + match_len(src, p, tgt, i, end)
            if n < MIN_COPY: i += 1; continue
            if i - b > lit: yield 'add', lit, i - b - lit, None
            yield 'copy', i - b, n, p - b
            lit = i = i - b + n
        if lit < end: yield 'add', lit, end - lit, None

# ---------------- BPS ----------------
def bps_num(n):
    out = bytearray()
    while True:
        x = n & 0x7f; n >>= 7
        if n == 0: out.append(0x80 | x); return bytes(out)
        out.append(x); n -= 1

def make_bps(src, tgt):
    p = bytearray(b'BPS1') + bps_num(len(src)) + bps_num(len(tgt)) + bps_num(0)
    srel = 0
    for kind, off, ln, so in ops(src, tgt):
        if kind == 'add':
            p += bps_num(((ln - 1) << 2) | 1) + tgt[off:off + ln]  # TargetRead
        elif so == off:
            p += bps_num(((ln - 1) << 2) | 0)              # SourceRead
        else:
            d = so - srel; srel = so + ln
            p += bps_num(((ln - 1) << 2) | 2) + bps_num((abs(d) << 1) | (d < 0))  # SourceCopy
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

WIN = 0x800000  # target window size (8 MiB)
SEG = 0x1000000  # largest source segment of a window (16 MiB)

def make_vcdiff(src, tgt):
    out = bytearray(b'\xd6\xc3\xc4\x00') + bytes([0])   # magic, version 0, no header extras
    def window(w0, w1, items):
        cp = [(so, ln) for kind, ln, so in items if kind == 'copy']
        s0 = min((so for so, ln in cp), default=0); s1 = max((so + ln for so, ln in cp), default=0)
        data = bytearray(); inst = bytearray(); addr = bytearray(); t = w0
        for kind, ln, so in items:
            if kind == 'copy':
                inst += bytes([19]) + vint(ln)       # COPY, size follows, mode 0 (VCD_SELF)
                addr += vint(so - s0)                # address within the source segment
            else:
                inst += bytes([1]) + vint(ln)        # ADD, size follows
                data += tgt[t:t + ln]
            t += ln
        delta = vint(w1 - w0) + bytes([0]) + vint(len(data)) + vint(len(inst)) + vint(len(addr)) + data + inst + addr
        if cp: out.extend(bytes([1]) + vint(s1 - s0) + vint(s0))      # VCD_SOURCE
        else: out.append(0)
        out.extend(vint(len(delta)) + delta)
    w0 = 0; items = []; lo = hi = None
    for kind, off, ln, so in ops(src, tgt):
        while ln:
            if off == w0 + WIN:                      # window full
                window(w0, off, items); w0 = off; items = []; lo = hi = None
            if kind == 'copy' and lo is not None and max(hi, so + ln) - min(lo, so) > SEG:
                window(w0, off, items); w0 = off; items = []; lo = hi = None   # source too far
            k = min(ln, w0 + WIN - off)
            items.append((kind, k, so))
            if kind == 'copy':
                lo = so if lo is None else min(lo, so); hi = so + k if hi is None else max(hi, so + k)
                so += k
            off += k; ln -= k
    if items: window(w0, len(tgt), items)
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
