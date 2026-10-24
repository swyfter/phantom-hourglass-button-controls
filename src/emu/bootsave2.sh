#!/bin/bash
# bootsave.sh ROM outstate -> boots ROM with mercay save into gameplay
ROM="$1"; OUT="$2"; SAVE="${3:-mercay.sav}"
cp saves/$SAVE saves/$OUT.sav
cat > /tmp/bs.txt <<EOS
run 600
touch 128 100 5
run 200
touch 128 100 5
run 500
shot shots/${OUT}_a.png
touch 128 56 4
run 120
touch 205 168 4
run 300
shot shots/${OUT}_b.png
touch 128 80 4
run 600
shot shots/${OUT}.png
savestate states/$OUT.mst
EOS
./headless "$ROM" /tmp/bs.txt - saves/$OUT.sav 2>&1 | grep -v "^frames"
