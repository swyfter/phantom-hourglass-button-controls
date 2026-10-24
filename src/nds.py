import struct
def u32(d,o): return struct.unpack_from('<I',d,o)[0]
def u16(d,o): return struct.unpack_from('<H',d,o)[0]
class ROM:
    def __init__(s,path):
        d=s.d=open(path,'rb').read()
        s.arm9=d[u32(d,0x20):u32(d,0x20)+u32(d,0x2c)]
        s.arm9_ram=u32(d,0x28); s.arm9_entry=u32(d,0x24)
        s.arm7=d[u32(d,0x30):u32(d,0x30)+u32(d,0x3c)]
        fnt=d[u32(d,0x40):u32(d,0x40)+u32(d,0x44)]
        fat=d[u32(d,0x48):u32(d,0x48)+u32(d,0x4c)]
        s.files=[d[u32(fat,i*8):u32(fat,i*8+4)] for i in range(len(fat)//8)]
        s.ovt9=d[u32(d,0x50):u32(d,0x50)+u32(d,0x54)]
        s.ovt7=d[u32(d,0x58):u32(d,0x58)+u32(d,0x5c)]
        s.names={}
        def walk(did,path):
            off=u32(fnt,(did&0xfff)*8); fid=u16(fnt,(did&0xfff)*8+4)
            while True:
                l=fnt[off]; off+=1
                if l==0: break
                n=fnt[off:off+(l&0x7f)].decode('latin1'); off+=l&0x7f
                if l&0x80:
                    sub=u16(fnt,off); off+=2; walk(sub,path+n+'/')
                else: s.names[fid]=path+n; fid+=1
        walk(0xf000,'')
    def overlays9(s):
        r=[]
        for i in range(0,len(s.ovt9),32):
            e=struct.unpack_from('<8I',s.ovt9,i); r.append(e)
        return r
