#!/bin/bash
# Thin wrapper: link.py holds the one copy of the link settings (address from build_v2.py, defsyms).
# Needs python3 and LLVM (clang, ld.lld, llvm-objcopy, llvm-nm). DPAD_DEBUG=1 is passed through.
set -e
cd "$(dirname "$0")"
exec python3 link.py "$@"
