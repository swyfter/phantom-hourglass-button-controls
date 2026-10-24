"""Assemble + link dpad.s -> dpad.bin, dpad.sym (link.sh only runs this file).
Uses clang's integrated assembler (same as llvm-mc; the Windows LLVM package has no llvm-mc).
The link address and the output names come from build_v2.py (CODE_ADDR, OUT).
DPAD_DEBUG=1 builds the diagnostic version with the RAM tap log (see ralog.py) as dpad_debug.*,
plus dpad_debug.nm (all symbols) for ralog.py / ragate.py / rasnap.py."""
import os, shutil, subprocess
from build_v2 import CODE_ADDR, DEBUG, OUT

HERE = os.path.dirname(os.path.abspath(__file__))
LLVM_DIRS = [d for d in (os.environ.get('LLVM_DIR'), r'C:\Program Files\LLVM\bin') if d]

DEFSYMS = {
    'GetCamera': 0x0208B120, 'TouchCtl_Stop': 0x020B7888, 'ScreenFromWorld': 0x01FFE468,
    'TouchCtl_Begin': 0x0207AC18, 'RollGesture': 0x020B1270, 'PadUpdate': 0x02037414,
    'InputGate': 0x02036130, 'TouchSample': 0x0207AD30, 'CellPos': 0x0203476C,
    'BtnUpdate': 0x020D0610, 'ActorFromHandle': 0x020C3614,
}

def tool(name):
    p = shutil.which(name)
    if p: return p
    for d in LLVM_DIRS:
        for ext in ('.exe', ''):
            c = os.path.join(d, name + ext)
            if os.path.exists(c): return c
    raise SystemExit(f'{name} not found (install LLVM)')

def run(*a): subprocess.run(a, check=True, cwd=HERE)

def main():
    dbg = ['-Wa,-defsym,DEBUGLOG=1'] if DEBUG else []
    o, elf, bin_ = OUT + '.o', OUT + '.elf', OUT + '.bin'
    run(tool('clang'), '--target=armv5te-none-eabi', '-c', '-x', 'assembler', *dbg, 'dpad.s', '-o', o)
    run(tool('ld.lld'), '-m', 'armelf', f'--section-start=.text={CODE_ADDR:#010x}', '-e', '0', '--no-dynamic-linker',
        *[f'--defsym={k}={v:#010x}' for k, v in DEFSYMS.items()], '-o', elf, o)
    run(tool('llvm-objcopy'), '-O', 'binary', '-j', '.text', elf, bin_)
    nm = subprocess.run([tool('llvm-nm'), elf], check=True, cwd=HERE, capture_output=True, text=True).stdout
    lines = sorted(l for l in nm.splitlines() if ' T ' in l)
    with open(os.path.join(HERE, OUT + '.sym'), 'w') as f:
        f.write('\n'.join(lines) + '\n')
    if DEBUG:
        with open(os.path.join(HERE, OUT + '.nm'), 'w') as f:
            f.write(nm)

if __name__ == '__main__':
    main()
