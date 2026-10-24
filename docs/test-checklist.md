# User test checklist

Pending RetroArch tests. Remove a section when its checks pass (and note the result in src\DEVLOG.md).

All sections up to v2.1.74 passed in RetroArch (user report, 2026-10-23).

Not in a section: the v2.1.69 bomb set-down test (standing A with a bomb held sets it down the way Link faces).

## v2.1.91-wip: hammer facing, boulder let-go
ROM: "Phantom Hourglass US - Button Controls v2.1.91-wip.nds". Start it fresh (old save states keep the old code).
1. Equip the hammer. Face down with the D-pad, then press X. Confirm Link takes it out and still faces down.
2. With the hammer out, press Left, Up and Right. Confirm Link turns each way.
3. Press A. Confirm the hammer hits the way Link faces. Press X. Confirm the hammer goes away.
4. At a round boulder, press A to grab it. Press the D-pad sideways. Confirm Link lets go and walks at once.
5. Grab it again. Hold the D-pad away from it. Confirm Link lets go after about half a second.
6. Grab it again and press A. Confirm it rolls one tile. Then press Left and Right. Confirm Link walks.
7. At a square push block: confirm D-pad toward + A pushes and D-pad away + A pulls (as before).
