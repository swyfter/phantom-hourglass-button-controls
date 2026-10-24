import sys
from vcdtab import T
src=open(sys.argv[1],'rb').read(); d=open(sys.argv[2],'rb').read(); out=bytearray()
p=0
def rv(buf,i):
    v=0
    while True:
        c=buf[i]; i+=1; v=(v<<7)|(c&0x7f)
        if not c&0x80: return v,i
p=5; hi=d[4]
if hi&4: n,p=rv(d,p); p+=n
while p<len(d):
    wi=d[p]; p+=1; sl=sp=0
    if wi&3: sl,p=rv(d,p); sp,p=rv(d,p)
    srcseg=src[sp:sp+sl] if wi&1 else bytes(out[sp:sp+sl])
    dl,p=rv(d,p); tl,p=rv(d,p); p+=1
    ld,p=rv(d,p); li,p=rv(d,p); la,p=rv(d,p)
    if wi&4: p+=4
    data=d[p:p+ld]; p+=ld; inst=d[p:p+li]; p+=li; addr=d[p:p+la]; p+=la
    t=bytearray(); ip=dp=ap=0; near=[0]*4; ni=0; same=[0]*768
    while ip<len(inst):
        code=inst[ip]; ip+=1
        for (ty,s,m) in T[code]:
            if ty==0: continue
            if s==0: s,ip=rv(inst,ip)
            if ty==1: t+=data[dp:dp+s]; dp+=s
            elif ty==3: t+=data[dp:dp+1]*s; dp+=1
            else:
                here=len(t)
                if m==0: a,ap=rv(addr,ap)
                elif m==1: x,ap=rv(addr,ap); a=here+sl-x
                elif m<6: x,ap=rv(addr,ap); a=near[m-2]+x
                else: a=same[(m-6)*256+addr[ap]]; ap+=1
                near[ni]=a; ni=(ni+1)%4; same[a%768]=a
                for k in range(s):
                    q=a+k
                    t.append(srcseg[q] if q<sl else t[q-sl])
    assert len(t)==tl
    out+=t
open(sys.argv[3],'wb').write(out); print("wrote",len(out))
