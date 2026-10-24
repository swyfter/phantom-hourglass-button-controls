# emit headless commands that hot-swap the current v2 code + hook branches into a running state
import sys, struct
sys.path.insert(0,'..'); sys.path.insert(0,'../v2')
sym={l.split()[2]:int(l.split()[0],16) for l in open('../v2/dpad.sym')}
def bl(src,dst): return 0xEB000000 | (((dst-(src+8))>>2)&0xFFFFFF)
hooks=[(0x0203A474,'dialog_advance'),(0x020B79B0,'dpad_move'),(0x020B7938,'tap_front'),(0x020AEC04,'roll_check'),(0x020B0D74,'slash_check'),(0x020A9480,'spin_check')]
print("loadbin 219b120 ../v2/dpad.bin")
for a,f in hooks: print("poke %x %x"%(a,bl(a,sym[f])))
