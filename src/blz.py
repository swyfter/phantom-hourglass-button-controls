import struct
def blz_dec(data):
    enc_end_hdr=struct.unpack_from('<I',data,len(data)-8)[0]
    inc=struct.unpack_from('<I',data,len(data)-4)[0]
    hdrlen=enc_end_hdr>>24; enclen=enc_end_hdr&0xffffff
    if inc==0 and enclen==0: return bytes(data)
    out=bytearray(data)+bytearray(inc)
    src=len(data)-hdrlen; dst=len(out); lim=len(data)-enclen
    while src>lim:
        src-=1; flags=out[src]
        for i in range(8):
            if src<=lim: break
            if flags&0x80:
                src-=2; v=out[src]|(out[src+1]<<8)
                ln=(v>>12)+3; disp=(v&0xfff)+3
                for _ in range(ln):
                    dst-=1; out[dst]=out[dst+disp]
            else:
                src-=1; dst-=1; out[dst]=out[src]
            flags<<=1
    return bytes(out[:len(data)-hdrlen+inc]) if False else bytes(out)
