import sys, struct, zlib
d=open(sys.argv[1],'rb').read()
p=0
def b():
    global p; v=d[p]; p+=1; return v
def vi(buf=None):
    global p
    v=0
    while True:
        c=b(); v=(v<<7)|(c&0x7f)
        if not c&0x80: return v
print("magic",d[:4].hex()); p=4
hi=b(); print("hdr_ind",hi)
if hi&1: print("secondary comp id",b())
if hi&2: n=vi(); print("custom code table len",n); p+=n
if hi&4:
    n=vi(); app=d[p:p+n]; p+=n; print("appheader",app)
# default code table
tbl=[]
tbl.append((0,0,0,1,0,0)) # RUN
tbl.append((1,0,0)) 
def build():
    T=[]
    T.append(((3,0,0),(0,0,0)))  # RUN size0
    for s in range(0,18): T.append(((1,s,0),(0,0,0)))
    for m in range(9):
        T.append(((2,0,m),(0,0,0)))
        for s in range(4,19): T.append(((2,s,m),(0,0,0)))
    for m in range(6):
        for a in range(1,5):
            for c in range(4,7): T.append(((1,a,0),(2,c,m)))
    for m in range(6,9):
        for a in range(1,5): T.append(((1,a,0),(2,4,m)))
    for m in range(9): T.append(((2,4,m),(1,1,0)))
    return T
T=build(); assert len(T)==256,len(T)
win=0; tot_t=0; stats={'add':0,'run':0,'copy_src_same':0,'copy_src_moved':0,'copy_tgt':0}
changed=[]
while p<len(d):
    wi=b(); srclen=srcpos=None
    if wi&3:
        srclen=vi(); srcpos=vi()
    dlen=vi(); start=p
    tlen=vi(); di=b(); ld=vi(); li=vi(); la=vi()
    if wi&4: ck=struct.unpack('>I',d[p:p+4])[0]; p+=4
    data=d[p:p+ld]; p+=ld; inst=d[p:p+li]; p+=li; addr=d[p:p+la]; p+=la
    # decode
    ip=0; ap=0; near=[0]*4; ni=0; same=[0]*(3*256); here=0
    def rv(buf,i):
        v=0
        while True:
            c=buf[i]; i+=1; v=(v<<7)|(c&0x7f)
            if not c&0x80: return v,i
    while ip<len(inst):
        code=inst[ip]; ip+=1
        for (t,s,m) in T[code]:
            if t==0: continue
            if s==0: s,ip=rv(inst,ip)
            if t==1:
                stats['add']+=s; changed.append((tot_t+here,s,'ADD'))
            elif t==3:
                stats['run']+=s; changed.append((tot_t+here,s,'RUN'))
            else:
                if m==0: a,ap=rv(addr,ap)
                elif m==1: x,ap=rv(addr,ap); a=here+(srclen or 0)-x
                elif m<6: x,ap=rv(addr,ap); a=near[m-2]+x
                else: x=addr[ap]; ap+=1; a=same[(m-6)*256+x]
                near[ni]=a; ni=(ni+1)%4; same[a%768]=a
                sl=srclen or 0
                if a<sl:
                    src=srcpos+a
                    if src==tot_t+here: stats['copy_src_same']+=s
                    else: stats['copy_src_moved']+=s; changed.append((tot_t+here,s,'MOVE from %#x'%src))
                else: stats['copy_tgt']+=s; changed.append((tot_t+here,s,'TCOPY'))
            here+=s
    assert here==tlen
    tot_t+=tlen; win+=1
print("windows",win,"target size",tot_t, hex(tot_t))
print(stats)
# merge changed regions
changed.sort(); merged=[]
for o,s,k in changed:
    if merged and o<=merged[-1][1]+16: merged[-1][1]=max(merged[-1][1],o+s); merged[-1][2].add(k.split()[0])
    else: merged.append([o,o+s,{k.split()[0]}])
print("changed regions",len(merged))
for o,e,k in merged[:80]: print(hex(o),hex(e),e-o,sorted(k))
print("---- moves by delta")
from collections import Counter
deltas=Counter(); first={}
for o,s,k in changed:
    if k.startswith('MOVE'):
        src=int(k.split()[-1],16); dl=o-src; deltas[dl]+=s; first.setdefault(dl,(o,src))
for dl,n in deltas.most_common(15): print("delta",hex(dl) if dl>=0 else '-'+hex(-dl),"bytes",n,"first tgt/src",[hex(x) for x in first[dl]])
print("---- non-move changes")
nm=[(o,s,k) for o,s,k in changed if not k.startswith('MOVE')]
m2=[]
for o,s,k in nm:
    if m2 and o<=m2[-1][1]+64: m2[-1][1]=max(m2[-1][1],o+s); m2[-1][2]+=s
    else: m2.append([o,o+s,s])
print(len(m2))
for o,e,n in m2: 
    if n>8: print(hex(o),hex(e),n)
