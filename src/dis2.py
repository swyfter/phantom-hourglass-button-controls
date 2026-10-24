import subprocess,struct,re,sys
def mc(words):
    txt="\n".join(" ".join("0x%02x"%x for x in w.to_bytes(4,'little')) for w in words)
    r=subprocess.run(["llvm-mc","--disassemble","-triple=armv5te","--show-encoding"],input=txt,capture_output=True,text=True)
    res={}
    for l in r.stdout.splitlines():
        m=re.match(r'\s+(.*?)\s+@ encoding: \[(.*)\]',l)
        if m:
            enc=int("".join(x[2:] for x in reversed(m.group(2).split(','))),16); res[enc]=m.group(1)
    return res
def dis(buf,base,s,e):
    words=[struct.unpack_from('<I',buf,o)[0] for o in range(s-base,e-base,4)]
    tab=mc(set(words)); out=[]
    for k,v in enumerate(words):
        a=s+4*k; l=tab.get(v,'.word')
        m=re.match(r'(b\w*)\s+#(-?\d+)$',l)
        if m: l+=f"  -> {a+8+int(m.group(2)):#x}"
        m2=re.search(r'\[pc, #(-?\d+)\]',l)
        if m2:
            o=a+8+int(m2.group(1))-base
            if 0<=o<=len(buf)-4: l+=f"  ; ={struct.unpack_from('<I',buf,o)[0]:#x}"
        out.append(f"{a:#010x}: {v:08x}  {l}")
    return "\n".join(out)
if __name__=="__main__":
    b=open(sys.argv[1],'rb').read(); print(dis(b,int(sys.argv[2],16),int(sys.argv[3],16),int(sys.argv[4],16)))
