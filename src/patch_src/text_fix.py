"""English text fixes (typos and small wording mistakes) for build_v2.py.

Each edit is (file, entry, old, new): old must occur once in that entry of English/Message/<file>.
Text uses the docs/dialogue-en.txt notation: '\n' = line break, {hex} = control code ({fe0000} = Link's
name). Keep the line count and keep each line about as wide as the lines around it (max about 200 px in
zeldaDS_15). List: docs/dialogue-typos.md.
"""
import re, struct

EDITS = [
    # typos
    ('sea.bmg', 0, 'sceen will drop', 'screen will drop'),
    ('field.bmg', 12, 'mermaid constume.', 'mermaid costume.'),
    ('frost.bmg', 171, 'How embarassing', 'How embarrassing'),
    ('frost.bmg', 105, 'evil force..\n', 'evil force...\n'),
    ('main_isl.bmg', 274, ' I Wonder', ' I wonder'),
    ('hidari.bmg', 159, 'Te-hee!', 'Tee-hee!'),
    ('kaitei_F.bmg', 11, 'be fine.\n{fe0000}.', 'be fine,\n{fe0000}.'),
    # wording
    ('demo.bmg', 4, 'to Hyrulian princesses.', 'to Hylian princesses.'),
    ('demo.bmg', 5, 'He slayed evil', 'He slew evil'),
    ('demo.bmg', 61, 'and show him who he is.', 'and show him Linebeck.'),
    ('field.bmg', 12, 'Dear, {fe0000}!', 'Dear {fe0000},'),
    ('field.bmg', 22, 'Oh scatterbrained', 'O scatterbrained'),
    ('torii.bmg', 68, 'chairman of the Big\nFriends', 'chairman of the\nFriends'),
    ('torii.bmg', 72, 'from the Big\nFriends', 'from the\nFriends'),
    ('battle.bmg', 15, 'points, wins!', 'points wins!'),
    ('battle.bmg', 68, 'of the starting count.', 'of the countdown.'),
    ('collect.bmg', 12, 'fresh baked!', 'fresh-baked!'),
    ('brave.bmg', 35, 'to the north\nsea. Tried', 'to the Northern\nSea. Tried'),
    ('brave.bmg', 36, 'fog to the north sea, where\nI first', 'fog to the Northern Sea,\nwhere I first'),
    ('frost.bmg', 69, 'has sneaked over', 'has snuck over'),
    ('frost.bmg', 169, '\nwho a liar.', '\nwhom a liar.'),
    ('ghost.bmg', 7, 'Please bring my older', 'Will you bring my older'),
    ('ghost.bmg', 75, 'damsel saving?', 'damsel-saving?'),
    ('hidari.bmg', 20, "old wayfarer's tales", "old wayfarers' tales"),
    ('hidari.bmg', 124, 'As consolation prize', 'As a consolation prize'),
    ('kaitei_F.bmg', 56, '5th Floor', '5th floor'),
    ('kaitei_F.bmg', 58, '11th Floor', '11th floor'),
    ('kaitei_F.bmg', 58, '12th Floor', '12th floor'),
    ('kojima2.bmg', 8, 'per game.', 'per try.'),
    ('main_isl.bmg', 1, 'Make way to', 'Make your way to'),
    ('main_isl.bmg', 109, "gracing\nour presence! It's old man\nOshus!",
                          "gracing\nus with his presence! It's\nold man Oshus!"),
    ('main_isl.bmg', 148, 'You ready as I am?', 'You as ready as I am?'),
    ('main_isl.bmg', 275, '\nSo sad, the', '\n♪So sad, the'),
    ('system.bmg', 130, 'View it from', 'View them from'),
    ('torii.bmg', 57, 'that master wants', 'that Master wants'),
    ('wisdom.bmg', 10, 'map of he who', 'map of him who'),
    ('demo.bmg', 105, 'OoooOh....', 'OoooOh...'),
    ('ghost.bmg', 25, 'Ahhh....', 'Ahhh...'),
]

def enc(s):
    """Text notation -> BMG UTF-16LE bytes ({hex} -> 0x1A code)."""
    out = b''
    for part in re.split(r'(\{[0-9a-f]*\})', s):
        if part.startswith('{'):
            h = bytes.fromhex(part[1:-1]); out += b'\x1a\x00' + bytes([3 + len(h)]) + h
        else:
            out += part.encode('utf-16-le')
    return out

def strlen(dat, p):
    """Length in bytes of the string at p, terminator included."""
    o = p
    while struct.unpack_from('<H', dat, o)[0]:
        o += dat[o + 2] if dat[o:o + 2] == b'\x1a\x00' else 2
    return o + 2 - p

def patch_bmg(d, edits):
    d = bytearray(d); secs = []; o = 0x20
    while o + 8 <= len(d):
        tag, sz = bytes(d[o:o + 4]), struct.unpack_from('<I', d, o + 4)[0]
        if sz == 0: break
        secs.append((tag, o, sz)); o += sz
    tags = [s[0] for s in secs]
    _, io, _ = secs[tags.index(b'INF1')]
    k = tags.index(b'DAT1'); _, do, dsz = secs[k]
    cnt, esz = struct.unpack_from('<HH', d, io + 8)
    offs = [struct.unpack_from('<I', d, io + 16 + i * esz)[0] for i in range(cnt)]
    dat = bytearray(d[do + 8:do + dsz])
    end = max(p + strlen(dat, p) for p in offs)
    for idx, old, new in edits:
        p = offs[idx]; s = bytes(dat[p:p + strlen(dat, p)])
        a, b = enc(old), enc(new)
        hits = [i for i in range(0, len(s), 2) if s.startswith(a, i)]
        assert len(hits) == 1, f'entry {idx}: {old!r} found {len(hits)} times'
        pos = p + hits[0]; delta = len(b) - len(a)
        dat[pos:pos + len(a)] = b
        offs = [q + delta if q > p else q for q in offs]
        end += delta
    dat = dat[:end]
    new_dsz = max(dsz, (8 + end + 31) & ~31)
    dat += b'\0' * (new_dsz - 8 - end)
    for i, q in enumerate(offs): struct.pack_into('<I', d, io + 16 + i * esz, q)
    grow = new_dsz - dsz
    out = d[:do + 4] + struct.pack('<I', new_dsz) + dat + d[do + dsz:]
    struct.pack_into('<I', out, 8, struct.unpack_from('<I', out, 8)[0] + grow)   # header size = end of DAT1
    return bytes(out)

def apply(rom, fat, names, append):
    """names: {file id: path}. Writes each patched file in place if it fits before the next 0x200
    boundary, else appends it with append(blob) -> offset."""
    byname = {n: f for f, n in names.items()}
    files = {}
    for f, i, old, new in EDITS: files.setdefault(f, []).append((i, old, new))
    for f, edits in files.items():
        fid = byname['English/Message/' + f]
        s, t = struct.unpack_from('<2I', rom, fat + fid * 8)
        blob = patch_bmg(bytes(rom[s:t]), edits)
        limit = (t + 0x1FF) & ~0x1FF
        if s + len(blob) <= limit:
            rom[s:limit] = b'\xff' * (limit - s); pos = s
            rom[pos:pos + len(blob)] = blob
        else:
            rom[s:t] = b'\xff' * (t - s); pos = append(blob)
        struct.pack_into('<2I', rom, fat + fid * 8, pos, pos + len(blob))
