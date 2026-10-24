"""Disassemble a range of a dumped binary with llvm-objdump (Windows LLVM has no llvm-mc).
usage: python dis.py file.bin BASE START END [thumb]"""
import sys, os, subprocess, tempfile, re, struct
LLVM = os.environ.get('LLVM_DIR', r'C:\Program Files\LLVM\bin')
f, base, s, e = sys.argv[1], int(sys.argv[2], 16), int(sys.argv[3], 16), int(sys.argv[4], 16)
thumb = len(sys.argv) > 5
data = open(f, 'rb').read()
chunk = data[s - base:e - base]
with tempfile.TemporaryDirectory() as d:
    raw, elf = os.path.join(d, 'c.bin'), os.path.join(d, 'c.elf')
    open(raw, 'wb').write(chunk)
    subprocess.run([os.path.join(LLVM, 'llvm-objcopy'), '-I', 'binary', '-O', 'elf32-littlearm',
                    '--rename-section', '.data=.text,alloc,code,load,contents',
 raw, elf], check=True)
    out = subprocess.run([os.path.join(LLVM, 'llvm-objdump'), '-d', '--no-show-raw-insn', f'--adjust-vma={s:#x}',
                          '--triple=' + ('thumbv5te' if thumb else 'armv5te'), elf],
                         capture_output=True, text=True).stdout
for l in out.splitlines():
    m = re.match(r'\s*([0-9a-f]+):\s+(.*)', l)
    if not m: continue
    a, ins = int(m.group(1), 16), m.group(2)
    ins = re.sub(r'\s*<_binary[^>]*>', '', ins)
    ins = re.sub(r'\s*@ (imm|0x)[^;]*$', '', ins)
    # resolve pc-relative literal loads
    p = re.search(r'\[pc, #(-?(?:0x)?[0-9a-f]+)\]', ins)
    if p and not thumb:
        o = a + 8 + int(p.group(1), 0) - base
        if 0 <= o <= len(data) - 4: ins += f'   ; ={struct.unpack_from("<I", data, o)[0]:#x}'
    print(f'{a:08x}: {ins}')
