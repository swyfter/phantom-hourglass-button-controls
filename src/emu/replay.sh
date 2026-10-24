#!/bin/bash
# deterministic replay: boot from mercay save -> Oshus conversation finished
set -e
./bootsave2.sh v2.nds g2 mercay.sav >/dev/null 2>&1 || true
./step.sh v2.nds g2 r1 "hold UP 40;hold RIGHT 75;hold UP 90;hold UP 100;run 30;hold UP+RIGHT 10;hold UP 14;run 10;hold A 3;run 60;hold A 3;run 52;hold UP 25;run 20;hold UP 60;hold UP+RIGHT 40;hold LEFT 60;hold UP 60" r1
./step.sh v2.nds r1 r2s "hold LEFT 4;run 10;hold A 3;run 60;hold A 3;run 40;hold A 3;run 40" r2s
C="hold DOWN 15;hold A+DOWN 3;hold DOWN 6;hold DOWN 20;hold LEFT 90;hold LEFT 60;hold A 3;run 60"; for i in $(seq 1 13); do C="$C;hold A 3;run 40"; done
C="$C;run 30;shot shots/r3b.png;hold DOWN+LEFT 30;hold LEFT 80;hold UP 50;run 120;run 150"
./step.sh v2.nds r2s r3 "$C" r3
C="hold RIGHT 5;hold UP 8;run 10;hold A 3;run 60"; for i in $(seq 1 38); do C="$C;hold A 3;run 37"; done
./step.sh v2.nds r3 r5 "$C;run 100" r5
