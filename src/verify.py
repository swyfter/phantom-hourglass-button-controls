import struct, sys
from nds import *
from blz import blz_dec
a=ROM(sys.argv[1]); b=ROM(sys.argv[2])
def arm9(r):
    d=r.arm9; ce=u32(d,0xb64+0x14)
    return d[:0x4000]+blz_dec(d[0x4000:ce-0x2000000])+d[ce-0x2000000:]
def ovl(r,i):
    e=r.overlays9()[i]; f=r.files[e[6]]
    return (blz_dec(f[:e[7]&0xffffff]) if e[7]>>24&1 else f)
def words(x,y,base,n=None):
    out=[]
    for o in range(0,min(len(x),len(y)),4):
        if x[o:o+4]!=y[o:o+4]: out.append((base+o,u32(x,o),u32(y,o)))
    return out
A,B=arm9(a),arm9(b)
print("ARM9 len",hex(len(A)),hex(len(B)))
for w in words(A,B,0x2000000): print("  arm9 %#x: %08x -> %08x"%w)
print("  appended %d bytes (code+table)"%(len(B)-len(A)))
for i in range(len(a.overlays9())):
    x,y=ovl(a,i),ovl(b,i)
    if x!=y:
        print("ovl",i); [print("  %#x: %08x -> %08x"%w) for w in words(x,y,a.overlays9()[i][1])]
# every other file identical?
others=[i for i in range(len(a.files)) if a.files[i]!=b.files[i] and i not in (a.overlays9()[0][6],a.overlays9()[9][6],a.overlays9()[14][6])]
print("other changed files:",others, " arm7 same:",a.arm7==b.arm7)
# autoload table
mp=struct.unpack_from('<7I',B,0xb64); print("modparams", [hex(x) for x in mp])
for e in range(mp[0],mp[1],12): print("  autoload", [hex(x) for x in struct.unpack_from('<3I',B,e-0x2000000)])
