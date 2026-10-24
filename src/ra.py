"""Read/write DS memory through RetroArch network commands (Settings > Network > Network Commands).
usage: python ra.py status | read ADDR LEN | write ADDR HEXBYTES"""
import socket, sys

HOST, PORT = '127.0.0.1', 55355

def cmd(s, timeout=1.0):
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as so:
        so.settimeout(timeout)
        so.sendto(s.encode(), (HOST, PORT))
        return so.recvfrom(65536)[0].decode(errors='replace').strip()

def read(addr, n):
    r = cmd(f'READ_CORE_MEMORY {addr:x} {n}').split()
    # reply: READ_CORE_MEMORY <addr> <hex bytes...>  or  READ_CORE_MEMORY <addr> -1 <error>
    if len(r) < 3 or r[2] == '-1':
        raise IOError(' '.join(r))
    return bytes(int(x, 16) for x in r[2:])

def write(addr, data):
    return cmd(f'WRITE_CORE_MEMORY {addr:x} ' + ' '.join(f'{b:02x}' for b in data))

if __name__ == '__main__':
    a = sys.argv[1:]
    if a[0] == 'status':
        print(cmd('VERSION')); print(cmd('GET_STATUS'))
    elif a[0] == 'read':
        print(read(int(a[1], 16), int(a[2])).hex(' '))
    elif a[0] == 'write':
        print(write(int(a[1], 16), bytes.fromhex(a[2])))
