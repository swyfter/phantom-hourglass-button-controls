#!/bin/bash
# usage: step.sh ROM instate outstate "cmds; cmds" [shotname]
ROM="$1"; IN="$2"; OUT="$3"; CMDS="$4"; SHOT="${5:-last}"
f=$(mktemp); echo -e "${CMDS//;/\\n}" > $f; echo "shot shots/$SHOT.png" >> $f; echo "savestate states/$OUT.mst" >> $f
[ "$IN" != "-" ] && [ -f saves/$IN.sav ] && cp -f saves/$IN.sav saves/$OUT.sav
INS=$([ "$IN" = "-" ] && echo - || echo states/$IN.mst)
./headless "$ROM" $f $INS saves/$OUT.sav 2>&1 | grep -v "^frames"
cp -f saves/$OUT.sav saves/next.sav 2>/dev/null; rm -f $f
