# Dump all English message text: one line per entry, "file#index<TAB>text".
# Control codes print as {hex}; line breaks print as \n.
# Usage: py src/tools/dump_text.py <rom.nds> <out.txt>
import struct, sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
from nds import *
def entries(d):
    secs={}; o=0x20
    while o+8<=len(d):
        sz=u32(d,o+4)
        if sz==0: break
        secs[d[o:o+4]]=o; o+=sz
    io,do=secs[b'INF1'],secs[b'DAT1']
    cnt,esz=struct.unpack_from('<HH',d,io+8); dat=d[do+8:]
    for i in range(cnt):
        p=u32(d,io+16+i*esz); s=[]
        while p+1<len(dat):
            c=u16(dat,p)
            if c==0: break
            if c==0x1a: n=dat[p+2]; s.append('{'+dat[p+3:p+n].hex()+'}'); p+=n; continue
            s.append('\\n' if c==10 else chr(c)); p+=2
        yield i,''.join(s)
r=ROM(sys.argv[1]); out=open(sys.argv[2],'w',encoding='utf-8')
for fid,n in sorted(r.names.items()):
    if n.startswith('English/Message/'):
        for i,s in entries(r.files[fid]): out.write('%s#%d\t%s\n'%(n.split('/')[-1],i,s))
