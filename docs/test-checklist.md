# User test checklist

Pending RetroArch tests. Remove a section when its checks pass (and note the result in src\DEVLOG.md).

All sections up to v2.1.82 passed in RetroArch (user reports, 2026-10-23 and 2026-10-24), including the v2.1.81 merchant grid and the v2.1.69 bomb set-down.

## v2.1.84 (= v2.1.100-wip): hold A wins the final boss sword clash
1. Load the playthrough ROM "Legend of Zelda, The - Phantom Hourglass.nds" (v2.1.84; fresh boot, not state 944: that state holds the v2.1.82 code).
2. Go to the final boss fight. Wait until Bellum's sword locks with Link's sword and the "RUB!" bubble shows.
3. Hold A. Do not touch the D-pad or the stylus.
4. Confirm: in about 1 second Link pushes Bellum back, and the "RUB!" bubble goes away. Link takes no damage.
5. Let the next clash come and do not press A. Confirm: Link loses the clash, the same as before.

## v2.1.83 (= v2.1.99-wip): L = Phantom Hourglass button (final boss fight)
1. Load the playthrough ROM "Legend of Zelda, The - Phantom Hourglass.nds" (v2.1.83; fresh boot, not an old state).
2. Go to the final boss fight. Wait until the hourglass button shows at the bottom centre.
3. Press L. Confirm: yellow corners show, the same as a stylus tap on the hourglass.
4. Press L again. Confirm: the yellow corners go away.
5. Press L, then draw a figure eight with the stylus (no line shows; this is normal). Confirm: time stops.
6. Press L on the field outside the fight. Confirm: nothing happens.
