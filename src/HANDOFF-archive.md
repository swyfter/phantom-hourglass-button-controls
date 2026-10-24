# Phantom Hourglass Button Controls patch - handoff archive

Moved out of src\HANDOFF.md on 2026-10-21. Nothing here was changed. "See above" / "see below" in an
entry can point to a part that is now in src\HANDOFF.md.

## Old State section (to 2026-10-21; replaced by the release table in HANDOFF.md)

# Phantom Hourglass D-pad patch - handoff (2026-10-16)
- Latest release: v2.1.42 (builds\v2.1.42\, = root playthrough ROM, 2026-10-19; = v2.1.45-wip, SHA-1
  409fb4d8baddaf7971f8d32b29ba76c6d539de30: treasure merchant on buttons, Sell held, collection keys on Mercay
  fixed; user tested in RetroArch). Before: v2.1.41 (D-pad picks a sea on the Sun Crest's Sea Chart; user test of
  the crest still due), v2.1.40 (shipyard menu, Customize and View Ship on
  buttons), v2.1.39 (B / A attack in 30 Hz field rooms such as the Cyclok fight, gate_carry). Named "Button Controls" since v2.1.36 (files zelda_phantom_hourglass_buttons_*,
  buttons_vX.Y.Z_source.zip). History below. Newest release: v2.1.45 (builds\v2.1.45\, = root playthrough ROM, = v2.1.50-wip, SHA-1
  dc7390b66698d8f926dc5877ae809342aa2c8a45: Sea Chart screen D-pad over seas and islands, Y = map Memo / Erase,
  game over screen on buttons; user tested). Before: v2.1.44 (= v2.1.47-wip, collection Items page, L / R pages),
  v2.1.43 (= v2.1.46-wip, Salvage Arm). Newest release since: v2.1.46 (builds\v2.1.46\, = root playthrough ROM, = v2.1.52-wip, SHA-1
  2cee9d4fd29630919fec7bf017a7365557d88ae5: statue turn screen, Left / Right full turns; user tested). Newest release since: v2.1.47
  (builds\v2.1.47\, = root playthrough ROM, = v2.1.54-wip, SHA-1 1776672c102711b91905c8ee524126a8d1978c32: dungeon map
  floors on Up / Down, A no longer turns a statue; released before a user test). Newest release since: v2.1.48
  (builds\v2.1.48\, = root playthrough ROM, = v2.1.57-wip, SHA-1 7fa1bd2ee32ae9c611d9b47136333b889f2a5426: bow D-pad
  no longer shoots, sword clash rub, magic box on buttons; released before a user test, 2026-10-20). Newest release
  since: v2.1.49 (builds\v2.1.49\, = root playthrough ROM, = v2.1.58-wip, SHA-1 8795da73ede5e5ef2fe333b3e9ba2303336ea348:
  dungeon map floors fixed for the Temple of the Ocean King; released before a user test, 2026-10-20). No wip in root
  from this work (v2.1.42-58-wip in builds\). Newest release since: v2.1.50 (builds\v2.1.50\, = root playthrough ROM,
  = v2.1.59-wip, SHA-1 9ec94c8f9ce7fe9a2d62a71bc8300e9315ccf595: Ghost Ship fog steering on buttons; released before a
  user test, 2026-10-20). v2.1.49 and v2.1.50 FREEZE on Up / Down in the field (data abort in fl_shown). Newest
  release since: v2.1.51 (builds\v2.1.51\, = root playthrough ROM, = v2.1.60-wip, SHA-1
  51687e898257c53cb124ae41a4bc0c8837c6fe01: that freeze fixed; user tested in RetroArch, 2026-10-20). No wip in root
  (v2.1.42-60-wip in builds\). Newest release since: v2.1.52 (builds\v2.1.52\, = root
  playthrough ROM, = v2.1.62-wip, SHA-1 a8849e859f7ba04df8ca7041b0a23d2c25b9d050: bow hold A aim (v2.1.61-wip) and
  dungeon map floors fixed for user state 385; released before a user test on the user's request, 2026-10-20).
  Newest release since: v2.1.53 (builds\v2.1.53\, = root playthrough ROM, = v2.1.63-wip, SHA-1
  663c9aeec7beae076d1a13c07a32b24c848d88d8: Force Gem D-pad lock fixed; released before a user test on the user's
  request, 2026-10-20). Newest release since: v2.1.54 (builds\v2.1.54\, = root playthrough ROM, = v2.1.64-wip, SHA-1
  20aa1f1739252e958097b042233ce371a52c3586: bow hold A Left / Right aim straight; user tested in RetroArch,
  2026-10-20). Newest release since: v2.1.55 (builds\v2.1.55\, = root playthrough ROM, = v2.1.65-wip, SHA-1
  445f869a535258d137a1ce53f6db2d9a7ba57ba8: English text typo fixes; released before a user test on the user's
  request, 2026-10-20). Newest release since: v2.1.56 (builds\v2.1.56\, = root playthrough ROM, = v2.1.66-wip, SHA-1
  3f1b7ae7dfb9db48cd532671b8a56e5228340f3d: Start on the save menu no longer talks to the NPC under it; released
  before a user test on the user's request, 2026-10-20). Newest release since: v2.1.57 (builds\v2.1.57\, = root
  playthrough ROM, = v2.1.67-wip, SHA-1 9badc41668863a8308c8341c585f03fd68b86ebf: a second Start skips a cutscene;
  released before a user test on the user's request, 2026-10-21). No wip in root (v2.1.42-67-wip in builds\).
  Next wip: v2.1.68-wip.
  Code space: CODE_RESERVE 0x4000 since v2.1.61-wip, 87 bytes free (v2.1.67-wip). v2.1.35 was released before the user tested wip4: fishing bugs go in v2.1.36.
- Released v2 (in builds\v2\): built from patch_src/dpad_v2_0.s. ROM SHA-1 2710d54b022231784a1f14f5baebc4029d133928.
- WORK IN PROGRESS: patch_src/dpad.s = v2 + "A-button reliability" rework (user approved options 1 and 2):
  1. Aim from the last D-pad direction (last_oct, fresh for 45 logic frames), not Link's body heading.
  2. Multi-spot probing: up to 5 taps (30/18/42 px ahead, +/-14 sideways, lifted 10 px), one per 2 logic
     frames with release frames between, stopping when the game reports a hit.
     Hit test = player-touch object (0x021BAB68 here) bytes +0x81/+0x82 nonzero or word +0x84 != -1.
- WIP results in the emulator:
  - Talking: fixed (Oshus straight on, villager from further away).
  - Barrels: still unreliable. In the cave-barrel case the probe hits (flags set) and Link walks to the barrel,
    but doesn't lift it. A REAL stylus tap at the same spot (71,98) does the same thing, so this may be
    game behaviour from that position/angle. Next: compare with a successful lift, try tapping the barrel
    centre / holding the touch longer, and test Ciela-targeted objects (user reports A fails on those too).
- The user also reported: can't enter the cave east of Oshus's house (also fails with the stylus in the
  emulator; walkthrough says pick up the barrels, then the sign puzzle answer is 7).


## Old wip entries (v2.1-wip to v2.1.57-wip, and the sailing research)

WIP build: "Phantom Hourglass US - Dpad v2.1-wip.nds", SHA-1 1a4a3f4cb4ffc34edc749af6dff39ab65e8f862c.
  User test: talking OK (incl. further away), sword B / B+D-pad / Y+B all OK, objects OK from above/sides,
  but barrels and Ciela targets mostly fail when Link stands directly BELOW them (facing up).
wip2: octant-4 probes changed to 40, 22, 30, 16, 52 px up (were 40, 28, 52 and 40 +/- 14), since the lift
  pushes facing-up probes too far for short objects. SHA-1 262ee326328d490974fb0ae16cdf598fcaa92102.
  User test of wip2: NO improvement from below. Talking from below still OK. Pots are fine from below; only
  barrels, rocks and Ciela targets fail. On failure Link just stands there, or, if something else is near
  (cave entrance), runs to that and goes in. So the probes aren't registering the barrel/rock at all from
  below, rather than overshooting. Distance theory looks wrong; needs the emulator or a stylus comparison.
  Stylus test: tapping a barrel from directly below ALWAYS lifts it, even tapping on Link's head.
  So the near probes would work but aren't reached: probe 0 (40 up) lands on the ground behind the object,
  the game takes it as a walk (Link blocked / runs to the cave), and a flag set by that walk (+0x81?) ends probing.
wip3: octant-4 order 18 (Link's head), 40, 28, 52, 24. Risk: talking from below if the 18px tap sets a flag.
  User test of wip3: stones from below FIXED; barrels and Ciela targets still fail; NPCs still fine.
wip4: octant-4 order 18, 26, 40, 52, 32 (second head tap before 40 for taller barrels).
  User: barrels from below DO work, but only when Link is lined up exactly below them.
wip5: NPROBES 7 (rows padded with PROBE_END=-128, checked in do_probe). Octant 4: (0,-18) (0,-26) (-8,-22)
  (8,-22) (0,-40) (0,-52) (0,-32); other octants unchanged (5 probes). SHA-1 175d3703b294bf7ac30bfa273bc6feea37a8a45a.
  User screenshot (Ciela over a sign, Link directly below, facing up, Mercay Island): the sign spans
  ~23-40px above Link's feet, x -20..+10, lower half hidden by Link's head (to ~-31). wip5's -40 tap only clips
  the sign's top edge / hits the wall and ends probing; -32 came last.
wip6: octant 4 = (0,-18) (0,-26) (-8,-22) (8,-22) (0,-34) (0,-42) (0,-52).
Feature (user request): L and Select swapped. Select = menu bar (Save/Collection/Map), L = items screen.
  ov9 0x211B214 tst r2,#4 (menu bar); 0x211B2B4 tst r0,#0x200 (items; original tst r0,#4).
Fix (v2.1.1-wip, untested): L opened the collection screen but only Select closed it. The screen is a set of
  game modes (MODE 0x27E077C = 0x13-0x17 from land, 0x1d-0x21 from sea; opened by ov3 thumb 0x20FAE14, closed
  via ov9 vtable 0x211E6B4). New hook H3 at ARM9 0x202AE3C (bl PadUpdate 0x2037414, r0 = PAD): pad_update
  ORs Select into PAD+2 when L is newly pressed in those modes. SHA-1 2ebf0d6396a46156f3a8b6b9172ed754cc30e6de.
Diagnostics: RetroArch (%RETROARCH_DIR%, melonDS DS 1.4.0) network commands on UDP 55355; src/ra.py reads
  main RAM (DTCM 0x027E.... is NOT mapped at those addresses there). DPAD_DEBUG=1 builds a tap log
  (dbg_ctl/dbg_seq/dbg_log ring, 16 x 8 bytes); src/ralog.py prints it to src/ralog.txt. Needs
  patch_src/dpad_debug.bin + dpad_debug.nm, which the debug build now writes itself (see "Build scripts").
wip7-debug log (src/ralog.txt, user booted fresh + in-game save): user says ~19/20 from-below lifts work now.
  - Successful lifts are almost always probe 0 (head tap) with +82=01, one tap.
  - The same probe-0 spot sometimes gets nothing on the first press(es) and +82=01 on a later one
    (e.g. (148,71)): maybe taps are ignored while Link is still settling/turning after the D-pad.
  - THROW: the A press that throws gets no flags, so probing continues and sends probes 1-6 AFTER the
    throw (7 taps). The later off-axis probes likely set the throw direction -> diagonal throws. Need a
    "holding something" flag to skip probing (or stop after probe 0) when throwing.
  - +81=01 shows up on probe 1/2 when slightly off-centre; per the old note +81 = object targeted, Link walks
    to it but doesn't lift (same as a stylus tap). Matches the user's "clicked just above the object".
RAM diff (src/rasnap.py, holding barrel vs after throw): touch controller +0x82 = 01 while carrying, 00 after.
wip8: A while +0x82 != 0 = one throw tap from throw_table (straight, no lift; up = 48px), no follow-up probes.
  Untested. Caveat: if +0x82 also lingers after reading a sign, the next A sends a single tap instead of probing.
wip8 test: left/right throws still diagonal. Log: those throw presses ran FULL probing because +0x82 was
  already 0 (it's "last tap lifted something", cleared when Link turns: dpad_move calls TouchCtl_Stop).
  Real held-object handle found in heap (4 snapshots): word 0x021CB884 = 7 holding / -1 free (0x021CB880 =
  object id, -1 free), but no static pointer reaches that heap block (ov0 0x020EE3EC -> 0x021CB4B0 is the
  previous block). Not used.
wip9: own latch `carrying`, set when a probe's hit test sees +0x82 (lift), cleared on the next A press and when
  a text box opens. A press with carrying or +0x82 -> single throw tap.
  User test of wip9: all left/right throws straight; log shows every post-lift A press was a single throw tap.
  Status: wip9 = release candidate (from-below lifts ~19/20, signs, NPCs, sword, throws, L/Select swap).
FUTURE FIX (user): after lifting an object from the side, A throws it diagonally instead of the way Link
  picked it up. Likely the 10px lift: side probe 0 is (+/-30, -10), so the throw aim tilts north.
  Probably needs a "holding something" check to throw with an unlifted point (find the carry-state field).

v2.1.2-wip (2026-10-17, untested): push blocks. User report on v2.1.1: A tapped only the pull arrow (probes
  reach ~52px; push arrow is ~57-71px away), and after a move A swung at the air instead of regrabbing.
  Found with rapause.py snapshots (snaps/p11-p18 = free/grab for right, left, up, down):
  - grabbing a block: touch ctl +0x98 = 4 and +0x94 = 0x0f (else -1/-1); +0x6a = heading of the grab tap.
  - heap obj 0x021CE428 (vtable 0x020E6468, size 0x12c): +0x20 pos, +0xa0 Link facing, +0x5e grab heading;
    no static pointer found yet (0x027E0F90 is a different manager object), so it isn't used.
  tap_front: while grabbing, latch grab_h = +0x6a snapped to 90 deg; A = one tap on the arrow, projected with
  ScreenFromWorld from Link pos + 2 tiles (push, D-pad toward the block or no D-pad) or -1 tile (pull), +0x600 up.
  On let-go, last_oct = block direction and stops aging (aim_hold) until the D-pad is used, so A regrabs.
  Screen offsets measured from screenshots: horizontal push +/-63, pull 31-34, y -14; up push -71 pull +26;
  down push +57 pull -41. Debug build: "Phantom Hourglass US - Dpad v2.1.2-wip-debug.nds" (arrow taps log as "throw").
  Tools: extract.py (dump arm9/overlays), dis.py (llvm-objdump range), rapause.py, snapdiff.py, ctlwatch.py.
  wip test: no push at all. ctlwatch showed the grab marker is +0x94 = block object id (0x1a this time;
  +0x98 = 0xf, earlier 4), and pressing the D-pad RELEASES the grab (dpad_move's +0x58/+0x6a writes).
  wip2: grab = +0x94 != -1 and not carrying; dpad_move skips steering for D-pad along the grab axis
  (only sets last_oct); roll_check doesn't roll while grab_on.
  User test of wip2 (2026-10-17): push, pull and regrab work from all four sides; throws still work.
  Released as v2.1.2 (builds\v2.1.2\: bps, xdelta, README, source zip), ROM SHA-1 bd5201b5c81ba3ce4f4f33427178452defbc8543.

v2.1.3-wip (2026-10-17, untested):
  - Input gate: H1 (0x202ADEC beq->b) skips the game's "ignore buttons" test. Caller 0x202CA28 passes
    r2 = InputGate(0x027E0C54) (ARM 0x02036130: obj byte 0 && (mode table 0x2056BA0[mode] bit0 XOR
    !(word 0x027E070C bit0))). pad_update now calls it after PadUpdate and, when nonzero, zeroes PAD +0/+2/+4
    (keeps A/B in +2 while msg_guard != 0, so text still advances). The real held keys live in held_real and
    are put back in PAD+0 before PadUpdate so press edges stay correct. Unknown yet: whether the gate is ever
    set during normal play (if so, add exceptions per mode). Debug build logs dbg_modes[mode] (bit0 open,
    bit1 gated, bit2 tap_front ran while gated); read with src/ragate.py [--watch].
  - Side-lift throw: do_probe stores the probe octant (probe_oct); on a lift, last_oct = probe_oct, aim_hold = 1,
    so the throw no longer falls back to +0x6a (heading of the lifted tap, tilted north -> diagonal).
  - Debug builds reserve 0xA00 (logs no longer fit 2 KB); release stays 0x800 (dpad.bin 1800 bytes).
  Debug ROM: "Phantom Hourglass US - Dpad v2.1.3-wip-debug.nds", SHA-1 45bd14102b4b5b8138babfb8d1e9097ce03786ad.
  Released untested as v2.1.3 at the user's request (builds\v2.1.3\), ROM SHA-1 18448ca02e5f328828d30aa63a42867692811e5a,
  now the root playthrough ROM. The user is testing it in a full playthrough; reports due at sailing and at secondary items.
  If buttons stop responding somewhere, load the debug ROM there and run src/ragate.py to see the gated mode.

v2.1.4-wip (2026-10-17, user tested and verified OK): collection screen page switch on D-pad (user request: Right = 2nd page, Left = 1st).
  Field collection UI is not ov2 (ov2's menu state machine, idle states 7/13 with buttons at obj+0x98/+0x30, is
  not loaded on land). Instead a fake stylus tap: new hook H4 ov0 0x207AF30 (bl TouchSample 0x207AD30 inside the
  touch update 0x207AED8; r1 = raw sample u16 x,y,touch,valid) -> menu_touch overwrites the sample for 3 updates.
  pad_update arms it on a new Right/Left press in the collection modes: ">" at (243,84), "<" at (12,84)
  (measured from RetroArch screenshots; touch manager 0x27E0D78: +0xc touching, +0x10/+0x14 xy, +0x34 edges).
  Right on page 2 / Left on page 1 taps the empty screen edge. dpad.bin 1914 bytes.
  ROM: "Phantom Hourglass US - Dpad v2.1.4-wip.nds", SHA-1 1ea11e92190077b4984b7d57c3f19ff9865fd2d8.
  Released as v2.1.4 (builds\v2.1.4\: bps, xdelta, README, source zip), same SHA-1 / CRC32 89467d89;
  now the root playthrough ROM. link.sh brought up to date (InputGate, TouchSample defsyms were missing).

v2.1.5-wip (2026-10-17, user tested and verified OK): dialogue choices on buttons (user request; test case = Temple, NPC with sprained
  ankle, "Sure / No way", user's RetroArch state 10, made with v2.1.4 so it can't run this code: the heap starts right
  after the old 0x800 reserve). Found by decompressing the state (RZIP v2 = zstd chunks, main RAM at file +0x34).
  - Text box = class vtable 0x2057E14 (tap handler 0x203A3B8, r6 = this at the H2 hook). +0x164 = choice panel
    (vtable 0x2057F48): +0x16e = choice count (0 = none), +0x15c > 0 shown, +0x174 = touched index, +0x178/+0x17c =
    panel offset; 4 touch buttons at +0x180 (16 bytes, vtable ov0 0x20E8958: +8 layout cell, +0xc element, +0xd state
    1 idle / 2 pressed / 4 held over / 0x20 dragged off / 8 fired on release over it). Update loop 0x203CC24.
  - Hit test = layout rect (0x2035A4C) of (cell, element) at touch - panel offset; CellPos 0x203476C(cell, elem, &x, &y,
    4, 4) gives its centre in the same space.
  - choice_ctl (from pad_update): Up/Down = fake stylus held on a bubble (first press = top), moving = drag to the new
    one, lift, press; A = lift (chooses). A/B/Up/Down hidden from the game while choices are up. Stylus sequencing in
    menu_touch via ch_tap. CODE_RESERVE now 0xA00 (dpad.bin 2397 bytes), debug 0xC00.
  ROM: "Phantom Hourglass US - Dpad v2.1.5-wip.nds", SHA-1 091085588a7f913900f6d61f504ae8449fb2aab9 (save copied from
  the playthrough .srm).
  Released as v2.1.5 (builds\v2.1.5\: bps, xdelta, README, source zip), same SHA-1 / CRC32 0a2294a3;
  now the root playthrough ROM. Playthrough save states made before this (incl. state 10) carry v2.1.4 code.

v2.1.6-wip (2026-10-17, untested): save menu on buttons (user request: "Continue / Save and Quit", shown after
  Select > Save; user's RetroArch states 18/19, made with v2.1.5). Found by decompressing the states (RZIP v2; melonDS
  state: main RAM at NDSG +0x14, DTCM at CP15 section +0x801c) and diffing against state 16 (same spot, no menu).
  - Controller = ov3 object (heap; reached as [[0x27E103C]] -> mgr, mgr+0x18), state word +4: 0 idle, 1 opening,
    2 menu up, 3 closing. Update ov3 0x20F13A0 (called from ov9 0x211AEE0): in state 2, B/Start = Continue.
    Buttons 0x20F160C: two sets of 3 touch buttons (20-byte class vtable 0x20E893C, stride 24): ctrl+0x8c (cells
    0xe1/0xe2) if mode table bit0 and gate byte 0, else ctrl+0x44 (cells 0x14/0x15). Index 0 = id 0x50 Continue,
    1 = 0x51 Save and Quit (shown when 0x20F3F34(0x211F534) == 0), 2 = 0x52 alternative (otherwise). Update call
    = vfunc [0](btn, 0, yoff, 0), yoff = 30 or 0; fired (state 8) -> 0x20F17E0 acts on the id.
  - Hook H5 ov3 0x20F16D8 / 0x20F1780 (blx r12 -> bl smenu_btn): records the buttons + yoff each pass.
    smenu_ctl (pad_update, when choice_ctl reports no choices) reuses the ch_tap stylus: Up/Down press on a
    button (CellPos centre + yoff), A lifts = press. choice_ctl no longer clears ch_tap itself (smenu_ctl does
    when neither is up). CODE_RESERVE 0xC00 (debug 0xE00), dpad.bin 2748 bytes.
  ROM: "Phantom Hourglass US - Dpad v2.1.6-wip.nds", SHA-1 1946f13ea336c19d9d04b3f5c779e9470db70077, save
  copied from the playthrough .srm. User test: Continue / Save and Quit selection works (CellPos centre + yoff OK).
  Released as v2.1.6 (builds\v2.1.6\: bps, xdelta, README, source zip), same SHA-1 / CRC32 b5c56c2f; now the root
  playthrough ROM, docs\README.txt updated. Known limitations added to the README: "Save complete." box and the
  post-talk NPC lock (see Future below).

v2.1.7-wip (2026-10-17, user tested and verified fixed): post-talk NPC lock (bug below). No state shows it (src/stateram.py reads the
  touch ctl from RetroArch states, needs Python 3.14; all states have +0x94 = -1 or the ctl elsewhere). ctlwatch.txt
  shows +0x84/+0x8c/+0x94 are (handle, serial) pairs, not type codes, so a block can't be told from an NPC that way.
  Fix: tap_front stores +0x94 in talk_id every frame msg_guard is nonzero (text box up / just closed); the grab
  check skips +0x94 == talk_id (and resets talk_id when +0x94 = -1), so grab_on is never latched for an NPC/sign.
  If it still locks, +0x94 may only be set after the box closes: run ctlwatch.py through a talk.
  ROM: "Phantom Hourglass US - Dpad v2.1.7-wip.nds", SHA-1 ffb4ab76906f4a744231e5dd8243014053bb0b59, dpad.bin 2788
  bytes, save copied from the playthrough .srm.
  Released as v2.1.7 (builds\v2.1.7\: bps, xdelta, README, source zip), same SHA-1 / CRC32 009b2dae; now the root
  playthrough ROM, docs\README.txt updated (NPC-lock limitation replaced by the title-screen stylus tap).

v2.1.8-wip (2026-10-17, user tested OK: Start on the title, A on "Save complete."): "Save complete." box and title screen on buttons. Found from the user's states
  (v2.1.6-wip state1 = Save complete, v2.1.7-wip state1 = title; DTCM = 2nd "CP15" tag in the state + 0x801c, the
  first one is inside main RAM).
  - Text box advance (tap handler 0x203A3B8): a touch PRESS edge (bit0 of touch mgr +0x34, what dialog_advance ORs
    in) only sets box +0x57f; the box advances on the RELEASE edge (bit1, path 0x203a628 -> 0x203b078 reads +0x57f).
    On the field tap_front's injected tap supplies the rest; during "Save complete." tap_front doesn't run (state:
    msg_guard stuck at 12, box +0x15c = 1, +0x151 = 1, +0x57f = 1, gate open, save ctrl state still 2).
    Fix in pad_update: A/B new press with ch_seen != 0 (box seen recently) and msg_guard == MAX (tap_front didn't
    count it down) -> menu_tap stylus tap at the text box (128,168). menu_tap's y is now set per tap.
  - Title: ov40 (slot word OVL_SLOT 0x27E091C = 40; ov30-40 share 0x217bce0, so check the slot, not code bytes,
    which stay in RAM after unload). Its input vtable (0x2189800) has a pad handler 0x2186f64 that already takes
    Start (title states 0/1/4) next to the touch one; but InputGate is on at the title (gate obj byte 1, mode table
    [1] bit0 = 0, 0x27E070C bit0 = 0), so the game (and pad_update) clear the presses. pad_update's gated branch now
    passes Start, and A as Start, while slot == 40. If ov40 also runs the intro, Start/A may skip it there.
  ROM: "Phantom Hourglass US - Dpad v2.1.8-wip.nds", SHA-1 8eda4f1e4dde58becd1ef98d54cae5d0f095f915, dpad.bin 2896
  bytes, save copied from the playthrough .srm. (Moved to builds\ when v2.1.9-wip was made.)

v2.1.9-wip (2026-10-17, user tested: title A/Start OK; file list Up/Down/A OK; Copy/Erase/Start and their
  dialogue choices OK; mode select Up/Down/A OK; OPTIONS SCREEN: only B works in RetroArch, no Up/Down/Left/Right,
  although the rig showed Left/Right changing values. Tabled by the user for a later build; see Future list):
  file select menus on buttons + input gate fix.
  User request (v2.1.8 states 1-4): file list, Back/Copy/Erase/Start, Adventure/Battle/Options, Options screen.
  - The menus are overlays 1/6/10 (slot word 0x27E090C = 10; 9 on the field/title). B is already the game's Back
    on all of them. Their buttons are touch buttons of class vtable ov0 0x20E893C (+8 cell, +0xa id, +0xc element,
    +0xd state 1 idle / 2 pressed / 4 held over / 0x20 dragged off / 8 fired; update = vfunc [0] 0x20D0610(btn,
    xoff, yoff, ?); vfunc [4] 0x20CFF2C copies ids into [[0x27E103C]] +0x1c pressed / +0x1e hover / +0x20 fired).
    Ids: file screen WFC 0x55 (file panels are not buttons: tap (128,70) / (128,130); a held press highlights,
    the release picks); Start 0x56, Copy 0x57, Erase 0x58, Back 0x59; Adventure 0x5a, Battle 0x5b, Options 0x5c,
    Back 0x5d; Options arrows 0x7f/0x80, 0x81/0x82, 0x83/0x84, Back 0x85, Mic Test 0x86.
  - fs_btn: the vtable entry now points at fs_btn, which (overlay 10 only) stores each id's CellPos centre +
    offset and the pad-read stamp (fs_frame) in fs_tab, then jumps to 0x20D0610. fs_ctl (pad_update, after
    choice_ctl / smenu_ctl, which now returns 1 while the save menu is up) picks the screen from fs_specs
    (first id seen within 2 pad reads) and drives ch_tap: lists = D-pad holds/slides (first press = default:
    file 1 / Start / Adventure), A lifts (A with nothing held taps the default); B slides a held stylus off to
    (128,2) first (CH_DRAGOFF) so nothing fires, the game does the Back. Options rows: Up/Down = row (no
    highlight), Left/Right tap that row's arrow; Mic Test row: A only.
  - menu_touch now steps ch_tap phases from a table (ch_next, CH_TOUCHING mask); new phases TAP, DRAGX,
    RELEASEX, DRAGOFF.
  - INPUT GATE FIX: InputGate is the 30 Hz off-frame (gate obj byte 1 at the title / cutscenes, then it flips
    with counter 0x27E070C every frame; byte 0 on the field). Since v2.1.3 pad_update dropped presses that began
    on a gated frame (v2.1.8's title Start worked only when it hit the right frame). Now a gated read keeps
    held_real as last read for all but the deliver mask (A/B/Up/Down while msg_guard), so the press shows on the
    next read, like the game. The title gets no early delivery (a press handed over on a gated frame is not seen
    there); A = Start on the title on any read. 1-frame presses on a gated frame are lost (as in the clean game).
  - CODE_RESERVE 0x1000 (debug 0x1200); dpad.bin 4000 bytes, nearly full.
  Rig-tested (src/lr.py, fresh boot with the playthrough .srm): title A/Start at both frame parities; file
  list Down x3 (file 1, file 2, WFC held), A = file 1; Left/Right on Copy/Erase/Start, A on Start; Down x3 to
  Options, A; Options Right / Down+Left change values, Up into Mic Test row, Right ignored, A opens it; B with a
  held entry backs out without firing it; default A path loads the game (field OK). Not tested: Copy/Erase
  confirmation screens, New Game, WFC Setup, the field after the gate change in cutscenes.
  ROM: "Phantom Hourglass US - Dpad v2.1.9-wip.nds", SHA-1 c15ad893cb36abcfff335dfe202dba4dc32dedb3, save copied
  from the playthrough .srm.
  Released as v2.1.9 (builds\v2.1.9\: bps, xdelta, README, source zip), same SHA-1 / CRC32 c5f7949a; xdelta
  re-applied with src/apply.py to the same SHA-1. Now the root playthrough ROM (wip moved to builds\),
  docs\README.txt updated (v2.1.8 changes folded in; Options screen listed as a known limitation).

## Sailing research (2026-10-17, from RetroArch state 24 in the lr.py rig; nothing built yet)
Agreed mapping (user): D-pad Up = Go, Down = Stop, A = Jump, B = cannon straight ahead (later; needs the ship
  object / heading). Left/Right left free. R/Select/L unchanged.
- At sea: mode 0x27E077C = 1 (same as land!), overlay slot word 0x27E0910 = 15 (ov15 = sea; ov14 on land).
  Route screen = mode 0x11, R map = 4, L = 0x13. Select / the Menu button keep mode 1 (menu bar over the HUD).
- Sea controller singleton: ptr [0x218EE9C] (ov15 bss; getter ov15 0x213CDCC, made by 0x213CEB0, 72 bytes,
  freed by 0x213CEF8 which zeroes the ptr). Check slot 15 first: other overlays share that bss range.
  +0x1c speed request, +0x20 current: 0 = Stop, 2 = Go (init 2/2). +0x41 = lever locked (set by 0x213D134
  which also forces a speed). +0x34 = HUD-cover fade, 0 while the sail HUD is up, 0x30 with menu bar / route /
  map open (fades back to 0 after closing). Lever logic ov15 0x213D8A0: a short tap anywhere on the lever
  TOGGLES 0 <-> 2 on release (either half), a drag across the threshold also switches.
- Go/Stop/Jump are NOT touch-button objects (no vtable 0x20E893C/0x20E8958 entry changes when touched); the
  Route (id 0x8e) and Menu (id 3) buttons are. Tap points (bottom screen): lever (238,110) (Go ~99, Stop ~122,
  both toggle); Jump (127,181). With the menu bar open, (127,181) is the "Collection" button, so gate on +0x34.
- Plan: in pad_update, if slot(0x27E0910) == 15 && ctl = [0x218EE9C] && mode == 1 && ctl+0x34 == 0 &&
  ctl+0x41 == 0: Up new press && +0x1c == 0 -> menu_tap (238,110); Down && +0x1c == 2 -> same tap;
  A new press -> menu_tap (127,181), and hide A from tap_front.
- Current v2.1.9 at sea: D-pad/B/X/Y inject no touches; A injects one stray touch at x=0xFEC8 (offscreen,
  harmless as far as seen). Cannon: tapping open sea in state 24 fired nothing visible (cannon not owned?).
- Code space: dpad.bin was 4000 of CODE_RESERVE 0x1000; grown to 0x1200 in v2.1.10-wip.

v2.1.10-wip (2026-10-17, rig tested; user tested: all checks passed): sailing controls, as planned above. pad_update block
  after the text-box tap: slot 0x27E0910 == 15, mode 1, msg_guard 0, menu_tap idle, [0x218EE9C] != 0 -> A/Up/Down
  new presses hidden from the game; then if +0x34 == 0 (sail HUD up): A = menu_tap at Jump (127,181), else if
  +0x41 == 0: Up with speed 0 / Down with speed 2 = menu_tap on the lever (238,110).
  CODE_RESERVE 0x1200 (debug 0x1400); dpad.bin 4192 bytes (debug 4700).
  Rig test (src/lr.py, state 24; code linked rig-only at 0x023B3000, a RAM range that stays zero there, with all
  hooks repointed: hot-swapping at 0x219B120 would overrun v2.1.9's 0x1000 reserve into the heap): Up while going /
  Down while stopped do nothing; Down stops, Up goes, Down+Up quickly ends going; A jumps (3 in a row OK);
  menu bar open: A/Down inject nothing (v2.1.9's tap_front tapped the sea at (99,63) on A there), Down works
  again after it closes; B/X/Y/Left/Right inject nothing. Land (fresh boot, playthrough .srm): slot = 14, Up walks.
  Not tested: text boxes at sea, the cannon (not owned in state 24), lever-locked scenes, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.10-wip.nds", SHA-1 ec063e592d7b32b60574cf5d49b17d0a11dea1b4, CRC32
  7bd10451; save copied from the playthrough .srm.
  Released as v2.1.10 (builds\v2.1.10\: bps, xdelta, README, source zip; patches made with mkpatch.py, xdelta
  re-applied with src/apply.py to the same SHA-1). Now the root playthrough ROM (wip moved to builds\),
  docs\README.txt updated (sailing controls; shop A-quit and stylus-only sailing listed as known limitations).

v2.1.11-wip (2026-10-17, rig tested; user tested: all checks passed, incl. an NPC choice): dialogue choices faster, wrapping, top one held by default.
  - choice_ctl: when the bubbles first show (ch_auto = 0, msgwin+5), the stylus presses the top one at once; A is
    ignored for CH_AUTO_LOCK = 9 pad reads (~0.3 s; pad reads are 30 Hz there) so an A mashed through the text
    doesn't pick it. Down on the bottom bubble wraps to the top, Up on the top wraps to the bottom. A key pressed
    while the stylus moves (CH_DRAG / CH_RELEASE) or while a new press settles is kept in ch_queue (msgwin+6,
    latest key wins) and done once it is held. ch_off clears both.
  - Speed: per-phase counts in ch_step (menu_touch and choice_ctl): CH_DRAG / CH_RELEASE = CH_MOVE_STEP 2 (was 4
    each), so a move takes ~7 frames instead of ~16. CH_HOLD now counts CH_SETTLE = 2 touch updates (no next
    phase): without it a queued move right after a new press made the game FIRE the bubble the stylus slid to
    (rig: Down, Down quickly on Yes/No started "Saving..."). smenu_ctl / fs_ctl share the shorter CH_RELEASE.
  - dpad.bin 4392 bytes (CODE_RESERVE 0x1200).
  Rig test (src/lr.py, fresh boot with the playthrough .srm, Select > Save = "Save your progress?" Yes/No; script
  in the session scratchpad, chtest.py): Yes held ~1.5 s after the tap with no key; early A ignored, later A
  picks it; Down/Up move and wrap both ways; 3 Downs with short gaps end on No with nothing fired; Down + A picks
  No (back to the field, no save). 2-frame presses are sometimes lost at 30 Hz reads: test with 4-frame presses.
  Not tested: the save menu (Continue / Save and Quit, didn't come up after Yes here), file select lists,
  3-4 bubble choices, NPC choices, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.11-wip.nds", SHA-1 0e3687d8c3e3279a0b3cf7ef6c955b9557dda090, CRC32
  69dcfc2b.

v2.1.12-wip (2026-10-17, rig tested; user tested: all checks passed; released as v2.1.12, see end of entry): save menu (Continue / Save and Quit) gets the v2.1.11 choice handling.
  - smenu_ctl: Continue pressed by default when the menu first takes input (sm_auto = smenu+16, set on the first
    press, A locked CH_AUTO_LOCK reads); two buttons, so Up/Down both switch to the other one (wrap); keys during a
    move / settle wait in sm_queue (smenu+17); ch_step counts (CH_DRAG / CH_RELEASE 2, CH_HOLD settle 2).
  - B FIX: with the stylus held, the game's B (= Continue) closed the menu under it and the later lift became a
    field tap (rig: Linebeck's "Make your way with caution, Link!" started). Now B with the stylus down is hidden,
    sm_queue = KEY_B, the stylus slides off to (FS_OFF_X, FS_OFF_Y) and lifts (CH_DRAGOFF -> CH_CONFIRM), then B
    goes to the game as a new press. B after A (CH_CONFIRM) is dropped.
  - .ltorg after ch_step: the end literal pool was out of reach of dialog_advance. CODE_RESERVE 0x1400 (debug
    0x1600); dpad.bin 4624 bytes. States made by older builds can't take this code: boot fresh.
  Rig test (smtest.py in the session scratchpad: links dpad.o at 0x023B3000 and repoints every hook in RAM,
  incl. ov3, in the user's v2.1.5 state 18 with the menu up): Continue held at once; Down/Up switch and wrap; 3
  quick Downs end on Save and Quit with nothing fired; A on Continue closes the menu with no field tap; B closes
  it with no field tap; early A ignored. The held button shows dim (the game's pressed look). Select > Save on
  land and in state 16 (at sea) gives the Yes/No choice, with Yes held.
  Not tested: Save and Quit itself, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.12-wip.nds", SHA-1 e366372c59939dddc640bc2be08e98048884c535, CRC32
  38baf166; save copied from the playthrough .srm. v2.1.11-wip moved to builds\.
  Released as v2.1.12 (builds\v2.1.12\: bps, xdelta, README, source zip; patches made with mkpatch.py, xdelta
  re-applied with src/apply.py to the same SHA-1; source rebuilt to the same SHA-1 first). Now the root
  playthrough ROM (wip moved to builds\), docs\README.txt updated (v2.1.11 + v2.1.12 changes).

v2.1.13-wip (2026-10-17, rig tested; user tested: all checks passed; released as v2.1.13, see end of entry): shop window A no longer quits.
  - Found with the user's v2.1.10-wip state 2 (merchant's table, "Just tap your selection!"): the shop is game
    mode 0x1a. A started tap_front's probes (7 taps at x 125-141, y 150-184), and in the main view those land on
    the Quit button (~x 89-166, y 166-193). The shop's text boxes don't go through dialog_advance (msg_guard
    stays 0), so the text-box tap was not involved. Item view: Buy ~(70,178), Quit ~(185,178).
  - Fix: pad_update hides A (PAD+2) in mode SHOP_MODE 0x1a while msg_guard == 0. dpad.bin 4664 bytes.
  - B is NOT the game's way out: in the rig B, Start and Select do nothing in the shop (old v2.1.10 code too).
    Only a stylus tap on Quit leaves. Possible follow-up: B = tap Quit, A / D-pad pick items.
  Rig test (shoptest.py in the session scratchpad: links dpad.o at 0x023B3000 and repoints the hooks in state 2):
  A x3, Up/Down/Left/Right, X, Y, Up+A inject no touches and the shop stays open; tapping the potion, then A x2:
  no touches, item view stays. Fresh boot with the playthrough .srm: field mode 1, A still probes.
  Not tested: other merchants, a text box with a choice inside the shop, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.13-wip.nds", SHA-1 d729dcfd48fe6ad6dfc1ce83281111aad97e926b, CRC32
  94a0ce15; save copied from the playthrough .srm.
  Released as v2.1.13 (builds\v2.1.13\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (shop limitation: items and Quit by stylus only).

v2.1.14-wip (2026-10-17, rig tested; user tested: all checks passed; moved to builds\): shop window on buttons (user request).
  - Found (user's v2.1.10-wip state 2, merchant with 5 slots): the shop is overlay 31 (OVL_SLOT 0x27E091C = 31,
    mode 0x1a). ov31 bss word 0x2183DE0 = shop object (made by 0x217BD28): +0x14 = item shown (-1 = table view),
    +0x18 its price, +0x70 = 8 actor handles (handle, serial), resolved by ov0 0x20C3614(mgr [0x27E0FE4], &pair)
    (= ActorFromHandle defsym). Slots 0-4 = items (3D actors; +0x48 position, +0x164 item id, -1 = nothing for
    sale: slot 0 here, the crossed-out map, takes no taps); 5 = Quit under the table, 6 = item-view Quit, 7 = Buy.
    Item tap test 0x21800CC: sphere at +0x48 (radius 0x4cd) vs the touch point; it fires on release over the same
    item (a drag off cancels), and shows no highlight while held. Button tap test: cell 0x5c element 2/1/0, active
    while +0x160 == 0 and byte +0x164 != 0. Handlers: 0x217C674 (items, table view), 0x217C840 (table Quit = leave),
    0x217C8E0 (item Quit), 0x217C970 (Buy). Buy -> mode 1 "You got ..." text (normal text box), then back to the
    table. Not enough Rupees -> item view with only the centre Quit (slot 5) active; the speech box needs no tap.
  - shop_ctl (pad_update chain: choice_ctl, smenu_ctl, shop_ctl, fs_ctl; only with ov31, mode 0x1a, shop object,
    msg_guard 0): hides A/B/D-pad from the game. Table view (slot 5 active): Right/Down = next item for sale,
    Left/Up = previous (wrap; first press = first item), A = the item seen last (or the first), B = tap Quit
    (leaves the shop). Items are tapped (CH_TAP) at ScreenFromWorld(GetCamera, actor +0x48): the table has no
    highlight, so the D-pad opens the item view at once. Item view (Buy active): the stylus is held on Buy when the
    view first takes input (A locked CH_AUTO_LOCK pad reads; pad reads are 60 Hz here, ~0.15 s), Left/Right hold
    Buy / Quit (held button shows dim), A lifts = press, B = slide to Quit and press it, Up/Down = previous / next
    item (sh_next: Quit, then the table opens it). Keys during a move or a busy view wait in sh_queue (cleared when
    the table takes input). Item view with only slot 5 active: A/B tap it. The v2.1.13 "hide A in mode 0x1a" block
    stays as a fallback for a shop that isn't ov31.
  - CODE_RESERVE 0x1600 (debug 0x1800); dpad.bin 5584 bytes. States made by older builds can't take this code.
  Rig test (shoptest.py in the session scratchpad, links dpad.o at 0x023B3000 and repoints the hooks in state 2):
  Right on the table opens item 1 (slot 0 skipped), Buy held ~2 s later when the view takes input; A just after
  is ignored; Right/Left move the hold to Quit / Buy; Down = Quit, then item 2 opens; B with Buy held slides to Quit
  and quits; Left on the table from item 2 opens item 1; Up from item 1 wraps to item 4; Right + A = Quit; A on
  the table reopens item 4; X/Y/Start do nothing; A on Buy for item 1 (too dear) -> "not enough Rupees", A taps
  Quit -> table; B on the table leaves the shop (mode 1). Fresh boot with the playthrough .srm: field A still
  probes (it took the temple stairs out), D-pad walks.
  Not tested: other merchants (other item counts / overlays), a real purchase with buttons (the rig's earlier
  stylus buy of the Zora Scale went to the "You got" text in mode 1), real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.14-wip.nds", SHA-1 76c2248af5b1b94130ef3085bf8b48086e98e59d, CRC32
  4e984544; save copied from the playthrough .srm.

v2.1.15-wip (2026-10-17, rig tested; user tested: all checks passed, but a bought item stays selectable; moved to builds\): shop table highlight (user request: move through the items
  without opening the Buy view each time).
  - Item update ov31 0x217EDD4: when not shown (+0x174 != 1) an item moves down toward its home (+0x14/+0x18/+0x1c)
    by 1024 a logic frame and snaps to it when at or below home y; so a home above the item snaps it up and the
    game keeps it there (a plain +0x4c poke is undone the next logic frame).
  - sh_lift: the highlighted item's home y +SH_LIFT (0x400; ~15 px up on screen), the one lifted before is lowered.
    sh_lslot / sh_ly remember the slot and the lifted home y; an item whose home isn't sh_ly (new shop, new actor)
    is never lowered. Not reset on leaving the shop.
  - Table view: the highlighted item (sh_last, else the next for sale, else the first) is lifted every pad read;
    D-pad moves it (wrap), A sets sh_next = it, and an sh_next item is tapped once it sits at its home
    (+0x4c == +0x18). B, item view and Up/Down in the item view unchanged; the item view's item stays lifted on
    return. The v2.1.14 "D-pad opens the item view" is gone.
  - CODE_RESERVE 0x1800 (debug 0x1A00); dpad.bin 5748 bytes.
  Rig test (shoptest.py, state 2): item 1 lifted on entry (slot 0 skipped); Right x4 = 2, 3, 4, wrap to 1; Left wraps
  to 4; only one item lifted at a time; A opens item 4 (tap at its lifted place); early A ignored; B back, item 4
  still lifted; Right = 1, A opens it; Down/Up in the item view open item 2 / item 1 with the lift following;
  X/Start nothing; B on the table leaves (mode 1). Fresh boot with the playthrough .srm: field A probes, D-pad walks.
  ROM: "Phantom Hourglass US - Dpad v2.1.15-wip.nds", SHA-1 89ea27406dc7fe7bf4b4664cfb5038684c5e28aa, CRC32
  394ec80d; save copied from the playthrough .srm. v2.1.14-wip moved to builds\.

v2.1.16-wip (2026-10-17, rig tested; user tested: all checks passed; released as v2.1.16, see end of entry): the shop highlight skips bought items.
  - User (v2.1.15): after a purchase the D-pad still selects the empty place, and a tap says it is sold out.
  - Found by buying the Zora Scale (slot 3) in the rig and diffing the item actors: the bought item gets +0x158 = 1
    (was 10) and +0x175 = 1; the empty slot 0 (crossed-out map, item id -1) also has +0x158 = 1. The items' tap
    handler 0x217C674 shows the sold-out message for +0x158 == 1. sh_search now skips +0x158 == 1 (was +0x164 == -1).
  Rig test (shoptest.py with SHOP_STATE = shop_sold.raw, the state after the purchase): Right x5 = 1, 2, 4, 1, 2, 4
  and Left x4 = 2, 1, 4, 2 (slots 0 and 3 skipped). Fresh boot with the playthrough .srm: field A probes, D-pad walks.
  ROM: "Phantom Hourglass US - Dpad v2.1.16-wip.nds", SHA-1 34326f38d1fd9dd01b17b180391dbe09eab50f82, CRC32
  5af7d174; save copied from the playthrough .srm. v2.1.15-wip moved to builds\. dpad.bin 5748 bytes.
  Released as v2.1.16 (builds\v2.1.16\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (shop controls; shop limitation removed).

v2.1.17-wip (2026-10-17, rig tested; user tested: all checks passed): collection Treasure / Ship Parts chain (user request, see Future).
  - The collection has two pages: Items (page 1) and a Treasure / Ship Parts page with two tabs. All three stay
    in the same game mode (0x15 here), so the screen comes from ov9 bss word COLL_PAGE 0x0211F520 (struct
    0x211F51C +4, getter 0x211BE64 / setter 0x211BE70): 2 = Items, 4 = Treasure, 3 = Ship Parts. Found with a RAM
    diff over 10 screen changes (cdiff.py in the session scratchpad). The page 2 tab shown first is the last one used.
  - Bottom-screen tap points: tabs Treasure (62,15), Ship Parts (192,15); "<" (12,84) on page 2 = back to Items;
    ">" (243,84) on Items. The red back arrow at (12,178) was not used.
  - pad_update collection block: Items: Right = ">", Left = "<" (empty edge, as before); Treasure: Right = Ship
    Parts tab, Left = "<"; Ship Parts: Left = Treasure tab, Right = nothing; other values: the old arrow taps.
  - dpad.bin 5820 bytes (CODE_RESERVE 0x1800).
  Rig test: state 25 (Treasure tab; code linked rig-only at 0x023B3000, colltest.py): T->S->T->Items->T->S chain,
  Right on Ship Parts and Up/A/X do nothing. Fresh boot with the playthrough .srm (collboot.py): L opens Items,
  Right opens page 2 on the Ship Parts tab (last used), Left = Treasure, Left = Items, Right = Treasure, Right = Ship
  Parts; L and Select close (mode 1). In state 25 any close (L or Select, old code too) gives a black screen in
  the rig: a rig/state problem, not this change.
  Known: a second Right/Left within ~1/4 s of a page change is lost (the game ignores taps while the page slides).
  ROM: "Phantom Hourglass US - Dpad v2.1.17-wip.nds", SHA-1 f4c53f4859ac2ad70ac6e4b9e6d5f33cf40b10d8, CRC32
  142c7ef4; save copied from the playthrough .srm.
  Released as v2.1.17 (builds\v2.1.17\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (collection chain; entries and swap-screens button listed
  as a known limitation).

v2.1.18-wip (2026-10-17, rig tested; user test due): collection Treasure / Ship Parts entries on buttons (user request, see Future).
  - Found (state 25 at sea = ov2 in the 0x20eece0 slot, and a fresh land boot = ov3; same addresses in both): the
    slots are NOT touch-button objects. A held press lights a slot, the lift on it opens the entry; a drag to
    another slot cancels (nothing lit, nothing opens). Slot centres x 61/108/155/202, y 81/129 (CL_X0 + 47 * col,
    CL_Y0 + 48 * row). Each tab's panel state is a handler word: Treasure 0x20fc400 (grid 0x21185c5, entry shown
    0x21187dd), Ship Parts 0x20faf18 (grid 0x2116fc9, parts list 0x21173fd, Explanation 0x2117915; other values
    while it animates). 0x20fc40c / 0x20faf20 = slot opened last (stays after Back, so not a view flag).
    Entry views: back arrow (16,153) (Explanation -> list -> grid); parts list "Explanation" button (213,176).
    The grid's red arrow (12,178) closes the collection. B does nothing in the clean game here.
  - coll_ctl (pad_update chain after shop_ctl, before fs_ctl; page 2 only): grid: Up/Down/A press the tab's last
    slot (cl_sel, first time top left); held: D-pad moves it (CH_DRAG), Up/Down switch rows, A lifts = opens,
    B slides off (CH_DRAGOFF). Left on column 0 / Right on column 3 slide off, then the key goes on to the old
    tab chain (cl_pass). Other keys (L, Select, ...) with the stylus down wait in cl_pass until it lifted (no lift
    after a screen change). Nothing held: Left/Right/B pass as before. Entry shown: B = back arrow, A = back
    arrow (parts list: A = Explanation); A/B/D-pad hidden. Keys during a move wait in cl_key (latest wins).
  - CODE_RESERVE 0x1A00 (debug 0x1C00); dpad.bin 6436 bytes. States made by older builds can't take this code.
  Rig test (cltest.py in the session scratchpad: links dpad.o at 0x023B3000 and repoints the hooks; treas.raw /
  parts.raw from state 25, L_treas.raw from a land boot): Treasure Down/Right/Left/Down moves, A opens the Ruto
  Crown, B back, Up re-holds the last slot, Left x2 from column 1 = let go + "<" to Items; Ship Parts A = list,
  A = Explanation, B = list, B = grid, Right on column 3 lets go and stays; A on an empty slot opens nothing;
  land: L with a slot held lets go, then closes to the field. Fresh boot of the wip ROM with the playthrough
  .srm: L, Right to page 2, slot moves, list open/back, tab chain both ways with a slot held, L closes, field A
  probes after.
  Not tested: Up/Down in a parts list with several parts (not owned in these saves; no control there yet),
  real RetroArch. A move pressed while the stylus still slides keeps only the latest key.
  ROM: "Phantom Hourglass US - Dpad v2.1.18-wip.nds", SHA-1 0e69e660d5933ebf23d92873766984fdf7324bfa, CRC32
  872b4b8f; save copied from the playthrough .srm. Moved to builds\ when wip2 was made.
  User test of wip (RetroArch, 2026-10-17): grid moves, open, back, Explanation, tab chain, L close all pass.
  Two problems: (1) an empty slot shows no light, so on Treasure (only the Ruto Crown owned) the user never saw
  where the selection was; (2) back from an entry nothing was held until the next D-pad press.
wip2: both fixed.
  - Slot objects (the panel's 8 buttons, 0x60 bytes, row by row): Treasure 0x20fc4d0, Ship Parts 0x20faff8
    (= panel +0xe0, Ship Parts panel +0xf0); +0x44 = entry index, -1 = empty (Treasure: all but slot 5 here;
    Ship Parts: slot 3). The grid handler (Treasure 0x21185c4) runs the tap test 0x2114090 on each, sets
    panel +0x1c = the slot opened.
  - coll_ctl uses only slots with an entry (cl_has): first press = last slot if it has one, else the first one;
    Left/Right = next one that way in the row, none = let go + tab chain; Up/Down = other row, same column or the
    nearest (cl_near), none = stay. cl_back (cl_sel + 3) is set while an entry shows; on the grid with the stylus
    off it holds the slot again with no key.
  - dpad.bin 6604 bytes (CODE_RESERVE 0x1A00).
  Rig test (cltest.py): Treasure Down holds the crown at once; Right from it lets go -> Ship Parts tab; Ship
  Parts Right x3 from slot 0 = 1, 2, then let go at empty slot 3; back from the list holds the slot again by
  itself and A reopens it. Fresh boot of wip2 with the playthrough .srm: same, plus Left from column 0 lets go
  -> Treasure, B lets go, L closes, field A probes after.
  ROM: "Phantom Hourglass US - Dpad v2.1.18-wip2.nds", SHA-1 7537cbf83a3370050dc426d8f15ef03aade8794d, CRC32
  0bc052b7; save copied from the playthrough .srm.
  User test of wip2 (RetroArch, 2026-10-17): all checks passed.
  Released as v2.1.18 (builds\v2.1.18\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip2 moved to builds\), docs\README.txt updated (collection entries; limitation now only the swap-screens
  button and multi-part Ship Parts lists).

v2.1.19-wip (2026-10-17, rig tested; user test due): L uses the equipped item; Select = collection again; B closes
  the collection (user requests, see Future "Equipped-item button"; design approved by the user: one L press).
  - ov9: the v2.1 swap is undone. 0x211B2B4 keeps the clean "tst r0,#4" (Select = collection/items screen);
    0x211B214 (menu bar, clean Y/Left) is now "tst r2,#0" = no button (its touch button stays; Save = Start
    pause menu, Collection = Select, Map = R). pad_update's collection block: B (not L) counts as Select;
    coll_ctl: B with a slot held lets go, then Select (via cl_pass). An entry's B = back arrow as before.
  - X (ov14 0x214414C, clean A/Right) is the Items BAR (the list to equip from), not "use item": comment fixed.
  - Found: gItemManager [0x27E0FB4] (+0 equipped ItemFlag: 2 boomerang, 3 shovel, 4 bombs, 5 bow, 6 hook,
    7 bombchu, 8 hammer; +0xac EquipItem* by id, +0xb0 ammo u16 by id, +0x128 owned flags bit per id);
    gPlayerPos 0x27E0F94, gPlayerAngle 0x27E0FAC (u16, 0 = +z), gPlayer 0x27E0F90 (+0xa health);
    gLinkState 0x27E0FD0 (current state), gLinkStates 0x27E0FDC (array; [1] = LinkStateItem, +0x14 = item out).
    Item out <=> gLinkState == gLinkStates[1]. (EquipItem +8 "in use" only for some items; [0x27E0FF8] +0 is a
    frame-parity toggle, not a flag.) Names/offsets from the zeldaret/ph decompilation, checked in the rig.
  - The clean game takes the item out while L is HELD and puts it away on release (this undid our icon tap).
  - item_ctl (pad_update, every read; mode 1, no text box, not at sea): hides L from the game (PAD +0/+2).
    L, item not out: menu_tap on the icon (241,15), then once it is out IT_SETTLE (4) reads, the use tap; bombs and
    bombchu only come out. L, item out: the use tap. Use tap = menu_tap at ScreenFromWorld(Link pos + it_dist
    along the aim), aim = last_oct if fresh (DIR_FRESH) else gPlayerAngle, snapped to 8 directions; shortened
    to 3/4 up to 6 times until inside the screen (8 px margin). it_dist (1/16 tiles): boomerang 96, shovel 16,
    bombs 48, bow 128, hook 96, bombchu 0 (no tap: its screen swaps to the map and it is steered by a path drawn
    there), hammer 24.
  - build_v2.py: CODE_RESERVE 0x1E00 (debug 0x2000); dpad.bin 7276 bytes. The bigger ARM9 no longer fits before
    0x46400: the build now moves the file(s) after the ARM9 slot to the ROM end (FAT updated).
  Rig test (fresh boot with the playthrough .srm; items given by poking +0x128 bits 3-8 and ammo 10, equipped
  from the X bar; scripts final3.py / items4.py in the session scratchpad): boomerang L = thrown the way Link
  faces, Right then L = thrown right, icon tap then L = thrown; bombs L = out, L = thrown (ammo 9); bow L =
  arrow right, L again = second arrow, bow stays out (game behaviour); hook L = out, Link turns to the tap like a
  stylus tap (no hook target here); bombchu L = out (screens swap), second L puts it away (L reaches the game
  there: mode is not 1). Select = collection (mode 0x15), L does nothing there, Select / B close; page 2 with
  nothing held B closes; slot held B lets go and closes; entry B = back, slot held again, B closes. Up walks, A
  probes, X opens the item bar.
  Not tested: hammer and shovel (their icon stays crossed out with poked flags, even outdoors), a hook target,
  bombchu path (stylus), L at sea (L reaches the game there), real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.19-wip.nds", SHA-1 c15d6a89409769d192b71ef5050004e7dd6dd9d0, CRC32
  55c873c8; save copied from the playthrough .srm. Moved to builds\ when wip2 was made.
  User test of wip (RetroArch): boomerang with L (facing, after Right, icon then L), Select / B collection all
  pass; bow / bombs not owned yet; hook / hammer later. L is awkward for the user, and the controller's left
  TRIGGER opens the RetroArch Quick Menu, so it must not be needed.
wip2: R = item, L = map (user request; Sea Chart button to be brainstormed later).
  - Native: ov0 0x20AF10C / 0x20AF138 etc. test PAD+0 (HELD) & 0x300: L or R held = item out (put away on release).
    ov9's map check 0x211B134 reads PAD+2 (new presses), so item_ctl now hides R (+0 and +2) and held L (+0
    only); a new L press still reaches ov9. ov9 0x211B134: tst r2,#0x200 (L, was R); map-open close mask
    0x211B300 = 0xFF3 (+L). At sea item_ctl stops before the hiding (L/R there as in wip: L = map).
  Rig test (fresh boot with the current playthrough .srm, final_w2.py): R held 60 frames = boomerang out and
  thrown once, not held out; Right then R = thrown right; L held = map (mode 4), no item; L again / B / R close
  it; Select = collection, B closes; Up walks, A probes, X opens the item bar.
  ROM: "Phantom Hourglass US - Dpad v2.1.19-wip2.nds", SHA-1 df8502ee96901de8c9ce89a66bcffb59238a0de6, CRC32
  112645b0; save copied from the playthrough .srm. dpad.bin 7276 bytes. Moved to builds\ when wip3 was made
  (wip3 has all of wip2, so test wip2's R / L / Select / B checks on wip3).
wip3: item bar on buttons (user request; design approved by the user, potions included).
  - Found (rig, fresh boot + poked items): the bar (X) is not a game mode (mode stays 1). UI root [0x27E103C]
    (= 0x21bc4a0 here; [[0x27E103C]] is the touch-button manager) byte +0xd = 1 while the bar is open (0 on the
    field, collection, map; +0xc = 0xf0 for one frame while it opens). Places, all y 178: potions x 14, 40, then
    items in a FIXED order x 70 boomerang (2), 98 bombs (4), 123 bow (5), 149 bombchu (7), 175 hook (6), 200
    hammer (8), 226 shovel (3); a missing item leaves its place empty. Potions = gItemManager +0xbc/+0xbd (u8,
    0 = empty bottle, which takes no taps). A held press frames the icon (the game's equipped frame moves to
    it), the lift on it equips (2-frame tap is enough), and the bar closes by itself ~40 frames later. A slide
    to another icon or off the bar cancels. A potion tap = "Drink the potion?" Yes/No (choice_ctl handles it).
    X closes the bar; B is the sword there; a walk closes it; the ">" tab (248,178) closes it.
  - ib_ctl (pad_update chain after coll_ctl, before fs_ctl; mode 1, msg_guard 0, not at sea, bar open):
    held Left/Right always hidden (no walk). Stylus off: Left/Right hold the next place with something in it,
    counted from the equipped item's place (none: from place 1), wrapping; B = X (closes), A hidden. Stylus held
    (ch_tap CH_HOLD): Left/Right = CH_DRAG to the next place, A = CH_CONFIRM (lift = equip / drink), B / X =
    CH_DRAGOFF then X (ib_pass), Up/Down = CH_DRAGOFF (then Link walks, which closes the bar); other keys wait
    in ib_pass until it let go; keys during a move wait in ib_key (latest wins).
  - CODE_RESERVE 0x2000 (debug 0x2200); dpad.bin 7916 bytes.
  Rig test (t3.py / t3b.py in the session scratchpad; fresh boot of wip3 with the playthrough .srm, items poked
  as before): Right x2 / Left x6 = 98, 123, 98, 70, 40, 14, wrap 226, 200 (hammer framed); A there = hammer
  equipped, bar closes ~60 frames later; Right + A = bombs; held B / X = no equip, bar closed; nothing held B =
  closed, no sword, no walk; held + Up = let go, Link walks, bar closed; A with nothing held = nothing; Left from
  the boomerang = potion 2, A = "Drink the potion?" (Down + A = No, potion kept; A = Yes, Link drinks); own
  items only (boomerang + 2 potions): Right from the boomerang wraps to potion 1, then 40, 70; two quick Rights =
  123; field Left walks with the bar closed and after X closes it.
  Not tested: real RetroArch, the hammer / shovel icons in play (crossed out with poked flags), the bar at sea
  (ib_ctl is off there).
  ROM: "Phantom Hourglass US - Dpad v2.1.19-wip3.nds", SHA-1 2ac54a4d95e91ff0c7db0f153a070e905c324a60, CRC32
  8791f978; save copied from the playthrough .srm.
  User test of wip3 (RetroArch, 2026-10-17): all checks passed (item bar moves / equip / B close / potion
  prompt; field D-pad, A, R item, L map after the bar).
  Released as v2.1.19 (builds\v2.1.19\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip3 moved to builds\), docs\README.txt updated (R item, L map, Select / B collection, X item bar;
  stale "X = use item" / "R = map" control lines fixed).

v2.1.20-wip (2026-10-17, rig tested; user test due): Y = collection "switch screens" icon (user request, see Future).
  - Found (rig, fresh boot of v2.1.19 with the playthrough .srm): the icon (243,178) is on the Items page only
    (page 2 has none there). A tap toggles the Items layout: mode 0x15 <-> 0x1f (0x1f is in pad_update's
    0x1d-0x21 range), COLL_PAGE stays 2. Swapped, the ">" arrow is gone, so Right does nothing there. Closing
    while swapped is fine; the collection opens unswapped next time. X/Y/L/R/Start do nothing in the clean
    collection (screens unchanged), so Y was free.
  - pad_update collection block: Y on Items (or unknown page) = menu_tap at SWAP_X/SWAP_Y; Treasure / Ship Parts:
    nothing. (KEY_B|RIGHT|LEFT|Y = 0x832 is no ARM immediate: a second tsteq.)
  - dpad.bin 7932 bytes (CODE_RESERVE 0x2000).
  Rig test (fresh boot of the wip with the playthrough .srm): Select = 0x15, Y = 0x1f (layout swapped), Y = 0x15;
  Right = Ship Parts, Y = nothing; Left = Treasure, Y = nothing; B closes (mode 1), Up walks. Swapped + B closes,
  Select reopens unswapped (0x15); swapped + Select closes. Two Y presses 8 frames apart = one swap (the game
  ignores the tap while the screens slide, as for page changes).
  Not tested: real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.20-wip.nds", SHA-1 281fa3097a29b3efb3234e1dce1a54b67532c314, CRC32
  d266308b; save copied from the playthrough .srm.
  User test of wip (RetroArch, 2026-10-17): all checks passed.
  Released as v2.1.20 (builds\v2.1.20\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (Y = switch screens; limitation now only multi-part Ship
  Parts lists).

v2.1.21-wip (2026-10-17, rig tested; user test due): collection grid edges (user request, see Future).
  - coll_ctl, slot held: Left / Right with no filled slot left that way in the row now stay on the slot (no
    wrap; the old label 3 "let go, then the tab chain" path is gone). Up and Down are split: Up on the top row
    lets go (cl_up -> cl_off, CH_DRAGOFF) = tab level, where Left / Right switch tabs through pad_update's
    collection block as with nothing held; Up on the bottom row = top row (cl_row), and if no top slot has an
    entry it lets go too (Treasure with only bottom-row entries could not reach the tabs otherwise). Down on
    the top row = bottom row, none = stay; Down on the bottom row = stay. B, A, entry views and the nothing-held
    chain unchanged.
  - dpad.bin 7964 bytes (CODE_RESERVE 0x2000). cl_sel = 0x219cf64, ch_tap = 0x219cf2f in this build.
  Rig test (fresh boot of the wip with the playthrough .srm; Treasure slots 2, 3, 5 filled, Ship Parts all but 3):
  Ship Parts Down = slot 0, Right x4 = 1, 2, stay 2 (page 3 kept); Down = 6, Right x2 = 7, stay; Down = stay;
  Up = 2; Left x2 = 1, 0; Up = let go (stylus off, page 3); Up = slot 0 again; Left = stay; Up from the bottom
  row = top row, Up = let go, Right = nothing (last tab), Down = slot 2 held. Left = Treasure (4); Down = slot 2,
  Right x3 = 3, stay, stay (page 4 kept = the user's case); Down = 5, Down = stay, Up = 2, Up = let go, Left =
  Items (2), Right = Treasure, Down = slot 2, B = let go + closed (mode 1), field Up after.
  Not tested: real RetroArch; A / entry views (code unchanged).
  ROM: "Phantom Hourglass US - Dpad v2.1.21-wip.nds", SHA-1 81e6093091c9aca619f5a9c756cf75d6e2a7c784, CRC32
  642daf1f; save copied from the playthrough .srm.
  User test of wip (RetroArch, 2026-10-17): all checks passed.
  Released as v2.1.21 (builds\v2.1.21\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (grid edges; Up from the top row lets go).

v2.1.22-wip (2026-10-17, rig tested; user tested: all checks passed; released as v2.1.22, see end of entry): Ship Parts list Up/Down (user request, see Future).
  - Found (user's v2.1.19-wip3 state1, Hull list, in the rig with that ROM): a parts list is 9 FIXED rows (one per
    part of that kind; not owned = blank row that takes no taps), 3 on screen, scrolled by arrows (232,52) /
    (232,147), one row per tap with a slide. A row tap (fires on the release, ov9 0x21173fc: row buttons panel
    +0x7b0, stride 0x60) shows that part. Ship Parts panel = 0x20faf08 (COLL_SFN - 0x10): +0x18 list type (=
    slot), +0x1c row shown, +0x20..+0x28 part of each row on screen (-1 blank), +0x1130 slide position (rests at
    top * row height), +0x1418 row height 0xb800, +0x141c top row, +0x1420 max top (6). Owned = s8 count at
    [ITEM_MGR] +0x48 + kind * 9 + row >= 0 (0x20ad890), kind = word table 0x211dacc[list type]. Row centres
    x 130, y 87 + 26 * place.
  - coll_ctl, entry shown, panel = SFN_LIST, stylus off: Up/Down set cl_tgt (cl_sel + 6, 0xff = none) = the
    previous / next owned row from cl_tgt or the row shown; none that way = stay (no wrap, as the v2.1.21 grid
    edges). Then on each pad read with the list at rest: target above the screen = tap the up arrow, below =
    down arrow, on screen = CH_TAP its row; cleared when shown, on A/B, on the grid and off page 2. Up/Down
    pressed during a tap wait in cl_key. A (Explanation) and B (back) unchanged.
  - .balign 2 after cl_tgt (it_wait is written with strh). CODE_RESERVE 0x2200 (debug 0x2400); dpad.bin 8252
    bytes.
  Rig test (fresh boot of the wip with the playthrough .srm; t1-t6.py in the session scratchpad; this save owns
  Hull rows 0 Standard + 6 Tropical, Handrail rows 0 + 4, one part in the others): Select, Right = Ship Parts,
  Down, Right x2, A = Hull list. Down = 4 scrolls + tap = Tropical Ship shown (~77 frames); Down again = stay;
  Up = back to Standard Hull (top 0); Up again = stay; Down then Down 10 frames later = Tropical; Up then Down 12
  frames later = Tropical; Up then B mid-slide = grid, slot held again, B closes (mode 1), Up walks. A after Down
  = Explanation of the Tropical Ship, B = list, B = grid. Handrail: Down = Worn Handrail (2 scrolls), Down stays,
  Up x2 = Standard, Down = Worn. One-part list: Down/Up stay, A / B as before. Treasure: entry open, Down/Up do
  nothing, B back, B closes.
  Not tested: real RetroArch; a list with 3+ owned parts (Down past a part on screen).
  ROM: "Phantom Hourglass US - Dpad v2.1.22-wip.nds", SHA-1 4767c2f3c71f9016a05c38f17e8423a3796c610e, CRC32
  d7c08a57; save copied from the playthrough .srm.
  User test of wip (RetroArch, 2026-10-17): all checks passed.
  Released as v2.1.22 (builds\v2.1.22\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (Ship Parts list Up/Down; its known limitation removed).

v2.1.23-wip (2026-10-17, rig tested; user test due): Options screen Left/Right (Future item, user on v2.1.9-wip).
  - Found (rig, fresh boot of v2.1.22 with the playthrough .srm; JIT off and on, the user's .opt has JIT on and no
    native BIOS files, so the same emulation): NOT reproduced. Down x3 + A or a stylus tap into Options, then 4-frame
    holds, 25/60-frame holds, 1-frame presses at both parities, quick repeats, and Copy (Yes) / Erase (No) choices
    first: Left/Right always change the row's value, ch_tap OFF, arrow ids 0x7f-0x84 live in fs_tab (age 0, the
    buttons update every frame). Forcing ch_tap = CH_HOLD (poke) on Options gives exactly the user's report: Left /
    Right do nothing, ch_tap stays HOLD, B still goes back. FS_ROWS never sets HOLD and had no way out of it (the
    B / A release is in the list modes only), so any held stylus left by another ch_tap user (choice_ctl's auto
    press etc.) while fs_cur already pointed at Options locked the arrows. Which path left it in RetroArch is not
    known. Also: fs_live compared 8-bit stamps, so a gone button looked live again for 3 reads every 255 reads
    (e.g. the Options ids on the mode select: fs_ctl took it as a new Options screen, slid a held entry off).
  - fs_rows: ch_tap CH_HOLD = fs_slideoff (DRAGOFF, lift, OFF) first, then the arrows work. fs_live: a stamp older
    than 2 reads is cleared (0 = never), so it can't come back on the wrap.
  - Row highlight: not added (the game draws none; a held stylus on an arrow would fire it on the lift, so no
    simple highlight). Up/Down still pick the row without a visible change; Up from the top row = Mic Test row.
  - dpad.bin 8272 bytes (CODE_RESERVE 0x2200). ch_tap = 0x219d05f, fs_cur = 0x219d080, fs_tab = 0x219d0a8.
  Rig test (fresh boot of the wip with the playthrough .srm): file list Down = file 1 held, A = Start screen, A =
  mode select, Down x3, A = Options; Right = Message Speed Fast; Down, Left = Sound Mono; Down, Right = Hand
  Left-handed; forced CH_HOLD + Right = slid off (that press used up), Left = Right-handed; B = "save your
  changes?" (Yes held), A = mode select; B = Start screen, B = file list (Down x2 = file 2 held, Up = file 1); A,
  A, A = game loaded (mode 1), Up/Right walk into the shipyard, Down walks out.
  Not tested: real RetroArch (the original fault was never seen in the rig); field A after the load.
  ROM: "Phantom Hourglass US - Dpad v2.1.23-wip.nds", SHA-1 ce958d08dac14cc6db59d7d30dac85013b17a177, CRC32
  e1d6b925; save copied from the playthrough .srm. (v2.1.22-wip was already in builds\.)
  User test of wip (RetroArch, 2026-10-17): all checks passed (Options Left/Right, B back, file select, field;
  also the v2.1.22 Ship Parts Hull list Up/Down).
  Released as v2.1.23 (builds\v2.1.23\: bps, xdelta, README, source zip). src already held the v2.1.24-wip throw
  change, so the release source is the v2.1.22 source zip + the two v2.1.23 edits (fs_rows, fs_live); it rebuilds
  to the same SHA-1. Patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1. Now the
  root playthrough ROM (v2.1.23-wip in builds\), docs\README.txt updated (Options Left/Right control line, the
  Options known limitation removed).

v2.1.24-wip (2026-10-17, rig tested; user test due): throw while running (Future item, user bug report).
  - Found (rig, fresh boot of v2.1.23-wip with the playthrough .srm, barrel by the start house): lift with A,
    run Left, A = nothing, the barrel stays held (carrying = 1). tap_front's label 35 sent stop_probe for any
    held D-pad, so A with the D-pad never tapped. A + D-pad = roll_check's roll, but the game doesn't roll while
    carrying, so nothing happened. A bomb out with R (Link in the item state, LinkStateId_Item, carrying = 0) has
    the same gap: A throws it standing (probe taps), not running. R itself already threw while running (menu_tap).
  - Fix (tap_front, label 35): D-pad held + A new press: carrying or +0x82 -> start_probe (its single
    throw_table tap, aimed by last_oct = the D-pad way); else bombs equipped (ITEM_MGR +0 == IT_BOMBS) and
    gLinkState == gLinkStates[1] -> the same throw tap; else stop_probe as before (roll unchanged).
  - dpad.bin 8400 bytes (CODE_RESERVE 0x2200). carrying = 0x219d0d3 in this build.
  Rig test (fresh boot of the wip with the playthrough .srm; exp.py / bomb3-5.py in the session scratchpad; bombs
  given by poking owned bit 4 and ammo [ItemMgr +0xb0] +8 = 10, equipped from the X bar): barrel lifted with A,
  run Left + A = thrown left (carrying 0), run Down + A = thrown down, standing A = thrown; A + Left with nothing
  held = roll; Up walks after; A at Oshus = "Link!" text. Bomb out (R): run Left + A = thrown (ammo 9), standing
  A = thrown, run Left + R = thrown.
  Not tested: push blocks (none near the start; grab code is before label 35 and unchanged), pots (same lift
  as the barrel), a bomb picked up off the ground, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.24-wip.nds", SHA-1 5e80cedecafced620ce24b4bdc598ff499a48adf, CRC32
  fe43b8e4; save copied from the playthrough .srm. v2.1.23-wip moved to builds\ (its release is a separate
  session: the current src no longer rebuilds v2.1.23's SHA-1). Moved to builds\ when wip2 was made.
  User test of wip (RetroArch): bomb throws while moving up / down OK; left / right: Link stops and sets the
  bomb down at his feet.
wip2: bomb throws left / right.
  - Found (rig): the throw tap 40 px to the side is read as a tap near Link = "set down" (bomb at his feet, short
    state 2, then 0). 48 px throws. Up 48 / down 40 were far enough (vertical px = more ground). Standing A with a
    bomb out also failed to the sides: it probed (30 px taps set it down, later probes swung the sword).
  - held_obj (new subroutine; +0x82, carrying, or bomb out = ITEM_MGR +0 == IT_BOMBS and gLinkState ==
    gLinkStates[1]) is used by both the moving branch and start_probe, so a bomb out always gets the single
    throw tap (standing too), never the probes. throw_table: down (0,44), down-right (40,32), right (60,0),
    up-right (40,-44), up (0,-48), and mirrored to the left.
  - dpad.bin 8400 bytes. carrying = 0x219d0d3, throw_table = 0x219cf3c in this build.
  Rig test (fresh boot of wip2; bdir3.py / bdir5.py in the session scratchpad, bombs poked and equipped from the
  X bar): all 8 directions x (run + A, stand + A, run + R) = throw (long state 2). Control: the old 40 px table
  poked back in = run Left + A sets the bomb down again. Barrel (boot with the earlier playthrough .srm copy,
  v2.1.24-wip.srm, at the start house): run Left + A, run Down + A, standing A all throw; A + Left with nothing
  held = roll; Up walks; A at Oshus = "Link!". Seen: a throw while running left right under the house door
  breaks the barrel on the wall at once, and Link then turns up into the door (Left still held); on open lawn
  Link keeps running left. Not looked into.
  Not tested: push blocks, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.24-wip2.nds", SHA-1 d3aca00adb36a5adb32c27d68b46a4312badf3a7, CRC32
  4252d420; save copied from the playthrough .srm.
  User test of wip2 (RetroArch, 2026-10-18): all checks passed.
  Released as v2.1.24 (builds\v2.1.24\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip2 moved to builds\), docs\README.txt updated (throw while running, bomb throws).
v2.1.25-wip (2026-10-18): bomb-flower bomb: run + A throws; standing A sets a bomb down (user's choice).
  - Found: see the BUG entry under "Future feature requests" (gPlayer +0x3c = held actor id, -1 = none).
  - held_obj: gPlayer +0x3c != -1, or a bag bomb out (ITEM_MGR +0 == IT_BOMBS and the item state). The carrying
    latch and +0x82 are no longer read there (the latch stays for its other uses).
  - start_probe: held and no D-pad held -> DROP_IDX: one tap at drop_xy (0, -8) = on Link. With the D-pad held
    the throw_table tap as before.
  - Found (rig): the game has no set-down for barrels: every raw tap (on Link, +/-8, -20, +20 sideways, 2 or 8
    frames) throws the barrel (it breaks). So standing A throws barrels / pots the way Link faces, as before.
  Rig test (fresh boot with the v2.1.24-wip.srm copy, start house; fb4/fb5/fb6/fb8/fb9.py in the session
  scratchpad): barrel lifted with A: run L / R / D / U / DL + A and standing A all let go (+0x3c -> -1), run D
  flies off the ledge, standing A (facing the door) breaks it on the wall. Bag bombs (poked, equipped, R out):
  standing A and stop + A = short state 2 (set down), run L / R / U / D / UR + A = long state 2 (throw). Run DL
  there went off a ledge (Link in the air, no throw; location, not the patch).
  Not tested: a bomb-flower bomb on the new build (state 58 holds v2.1.24 code; a rig hot-swap of the patch
  blob broke all A handling, because the blob's runtime variables are reset), push blocks, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.25-wip.nds", SHA-1 e631550c5497c7b6dbc06fb2848e0e1ea75103df, CRC32
  a9e4c75f. Moved to builds\ when v2.1.26-wip was made (its user test is still due; v2.1.26 has all of it).
v2.1.26-wip (2026-10-18, rig tested; user test due): B puts the item away (user bug, see Future).
  - Found (rig, fresh boot of v2.1.25-wip with the playthrough .srm, shovel equipped): the clean game puts the
    item away on the L/R release (item_ctl hides held L/R since v2.1.19-wip2, so that never happens) or with the
    "Put Away" button, which is the item icon itself while the item is out (the label shows under it, ~(232,50)).
    A tap on (241,15), (232,25) or (232,50) with the shovel out = gLinkState back to normal. B with the item out
    did nothing (no slash in the item state).
  - item_ctl: B new press with the item out (gLinkState == gLinkStates[1]) and no menu_tap running = menu_tap on
    the icon (ITEM_ICON_X/Y, IT_ICON_FRAMES), B hidden from the game (PAD+2, so no slash), it_wait / it_ok cleared
    (no use tap after it). Same for every item (the game decides; the icon tap is the same for all).
    held_obj / start_probe / drop_xy (v2.1.25-wip) not touched.
  - Rebuilt after the bomb session's v2.1.25-wip2 drop_table edit (do_probe DROP_IDX), so this wip has both.
    dpad.bin 8532 bytes (CODE_RESERVE 0x2200). The rig test below was re-run on the rebuild (same results).
  Rig test (fresh boot of the wip with the playthrough .srm; boot.py / ex.py / t1-t3.py in the session scratchpad):
  shovel R = out + dig, B = put away; R again, R = dig again, B = away; B held 40 frames = away, no move; B with
  nothing out = nothing changes; stylus icon tap = out, B = away; R then B 30 frames later (before the dig tap) =
  away, no dig; Left walks after. Boomerang (equipped from the X bar): R then B 10 frames later = away, no throw;
  icon tap = out, B = away. Bag bombs (poked owned bit 4, ammo 10, equipped from the bar): R = bomb out, B = away,
  ammo still 10, icon back; Up walks after.
  Not tested: bow / hook / hammer (not owned), bombchu (item_ctl is off there: mode is not 1), real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.26-wip.nds", SHA-1 2f7d4342577f72b03cc559b7300910b9b6c8f48c, CRC32
  723b7b3b; save copied from the playthrough .srm.
  drop_table (bomb session, in this build): user test of v2.1.25-wip (RetroArch, 2026-10-18) = run + A throws in
  all four directions, but standing A with a bomb-flower bomb always turned Link up first (the (0, -8) tap is
  above his feet). The set-down tap now goes 20 px the way Link faces (octant from last_oct or heading, as the
  throw): down (0,20), diagonals (+/-14,+/-14), sides (+/-20,0), up (0,-20). Rig test (fresh boot with the
  v2.1.24-wip.srm copy, bag bombs poked and equipped; fb10.py in the bomb session's scratchpad): face down /
  right / left / up / down-right, R out, A = short state 2 (set down) each time; gPlayerAngle after = 0xf960,
  0x5464, 0xaeaa, 0x8051, 0x2aa5 (Link keeps facing that way). Not tested: a bomb-flower bomb, real RetroArch.
v2.1.27-wip (2026-10-18, rig tested; user test due): B = a screen's lower-left Back button (user request: B swung
  the sword under the wall-map screen instead of closing it). Built on v2.1.26-wip (has all of it).
  - Found (user's RetroArch state 59 = map on the wall of a Mercay house, in the rig): the screen is game mode 0x37
    (54 while it opens). Its Back arrow (14,178) is a touch button of class vtable 0x20E893C with id 0x45 (cell
    64, element 0; state 1 -> 4 held -> 8 fired). The game's B does nothing there, so the sword slash ran. A
    second id-0x45 button (cell 6) exists in the HUD block but is not updated on the field. Id 0x45 is not live
    on the field, L map (mode 4), collection (0x15), item bar, menu bar, Sea Chart (0x2c) or the file select.
    Opening the wall map with A first shows a text box ("~To my son~ ..."); the Back button is updated only
    after the text is closed.
  - fs_btn (the vtable hook) now also records the id-0x45 button of any screen in bk_tab (CellPos centre +
    offset, fs_frame stamp). back_ctl (pad_update, after fs_ctl, only when no other menu took the keys): Back
    updated within 2 pad reads, new B, no text box seen (ch_seen 0), not the file select, not a collection mode
    -> B hidden from the game (PAD +0 / +2, no slash) and menu_tap on the button. A stale stamp is cleared.
  - CODE_RESERVE 0x2400 (debug 0x2600); dpad.bin 8764 bytes. bk_tab = 0x219d290, fs_frame = 0x219d26d,
    menu_tap = 0x219d244 in this build. States made by older builds can't take this code.
  Rig test: wall map (state 59, the build's blob hot-swapped and every hook repointed; hot.py in the session
  scratchpad): B closes the map (mode 1), no slash; field B after = slash (gLinkState changes); A at the map
  reopens it, B x3 = text typed out, text closed, map closed. 2-frame presses are sometimes lost there (30 Hz
  reads, as elsewhere); 4-frame presses always worked. Fresh boot of the wip with the playthrough .srm: file
  select B goes back; field B = slash; L map + B closes; Select + B closes the collection; X + B closes the item
  bar; Menu > Sea Chart + B closes it; Up walks into the house. Not tested: a wall map on a fresh boot (the
  house is not near the save point), other Back-button screens (none found yet), real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.27-wip.nds", SHA-1 caa4ada3d9c5823dc062e3f162c1c2ba9b6da9a8, CRC32
  5c6c6c2f; save copied from the playthrough .srm. Put in the root next to v2.1.26-wip (both user tests due).
  (The v2.1.28-wip session built over this file by mistake; it rebuilt the same SHA-1 from dpad.s without its own
  edit and put it in builds\. Its .srm was replaced by a fresh copy of the playthrough .srm. v2.1.28-wip has all
  of v2.1.27, so test both on v2.1.28-wip.)
  Wall-map re-test on v2.1.28-wip (state 59, hot.py, same steps): B closes the map, field B = slash, A reopens,
  B x3 = text typed out, text closed, map closed. Same results as v2.1.27-wip.
  User test of the v2.1.27 checklist on v2.1.28-wip (RetroArch, 2026-10-18): all checks passed.
v2.1.28-wip (2026-10-18, rig tested; user test due): A with the item out = R; no Put Away tap during a sword swing.
  - User test of v2.1.26-wip (RetroArch, 2026-10-18): B puts the shovel away. New bug: after one R dig, A with
    Link facing left / right digs diagonally.
  - Found (rig, fresh boot of v2.1.27-wip, shovel, facing left): A with the item out ran tap_front's probes; the
    side probe 0 is (+/-30, -10), so the dig went up-left ((103,72) vs R's (101,91)). Also, the R dig turns Link
    toward its tap with an error: gPlayerAngle 0xc000 -> 0xac1a (~28 deg), so a heading-aimed tap goes diagonal too.
  - Found: gLinkStates[1] is ALSO the sword state (B slash, and A probes that land near Link slash): state object
    +0x14 = item held out (3 shovel; 0 in a swing, 0 after Put Away). So v2.1.26's B (and the old "item out"
    test) fired during a swing: rig, shovel out, B B B 8 frames apart = put away, slash, then the 3rd B (in the
    swing) tapped the icon and took the shovel out again.
  - item_ctl: item out = gLinkState == gLinkStates[1] and its +0x14 == the equipped item. A new press with the item
    out (not bombs: held_obj's throw / set-down stays) is hidden from the game and counts as R (the use tap).
    it_oct (it_wait + 2): world octant of the last use tap, 0xff while the item is not out; a use tap with no fresh
    D-pad goes that way, else gPlayerAngle. held_obj's bomb test still uses the state-only check (bomb session code).
  - dpad.bin 8828 bytes (CODE_RESERVE 0x2400). menu_tap = 0x219d284, it_wait = 0x219d2c4 in this build.
  Rig test (fresh boot of the wip with the playthrough .srm; boot.py / ex.py / t1, t4, t7.py in the session
  scratchpad): shovel facing left / right / down / up / left: R tap (101,91) / (161,92) / (130,112) / (130,73) /
  (103,95), then A, A = the same point each time (digs), B = away. B B B from shovel out = away + slashes, shovel
  stays away (+0x14 0); B B B from idle = slashes only. t1 again: R out, B away, R + R dig, B, B held, icon tap + B,
  R + B before the dig, boomerang icon tap + B, walking after: all as in v2.1.26. Bombs out (R) + A = set down via
  held_obj (no use tap). Not tested: bow / hook / hammer, real RetroArch.
  Known, not changed: A with nothing near Link can make a probe tap that slashes (game: a tap near Link = slash).
  ROM: "Phantom Hourglass US - Dpad v2.1.28-wip.nds", SHA-1 c022b715a6fab69015ee168512bb07efcc325b36, CRC32
  517380c6; save copied from the playthrough .srm. v2.1.26-wip and v2.1.27-wip are in builds\. Moved to builds\
  when v2.1.29-wip was made.
  User test of v2.1.28-wip (RetroArch, 2026-10-18): checks 1-4 (A digs straight left / right, B away) pass. Check 5
  (B x3 quickly after B put the shovel away): "the shovel briefly re-equips before Link swings his sword again".
v2.1.29-wip (2026-10-18, rig tested; the user's check 5 problem NOT reproduced in the rig): Put Away latch.
  - Rig (v2.1.28-wip, fresh boot): B x3 from shovel out and from shovel away, presses 2 / 4 frames, gaps 3-20
    frames: no frame with the shovel out again (state 1 with +0x14 = 3), no extra touch, the screenshots show only
    the sword. Found: Put Away acts on the touch RELEASE; Link stays in state 1 with +0x14 = 3 until then, so in
    v2.1.28 a B read in that window (after menu_tap's 3 updates, before the game handled the release) tapped the
    icon again. In the rig that second tap joined the first press (no release frame between), so it did nothing;
    with another frame timing (RetroArch, 30 Hz reads) it could land after the release = take the shovel out again.
    That is the likely cause, not proven.
  - item_ctl: it_put (it_wait + 3) = IT_PUT (30) pad reads, set by the Put Away tap; while the item is still out
    and it_put > 0: A / B hidden (R always is), no taps, it_put counts down. Cleared when the item is not out.
  - dpad.bin 8884 bytes (CODE_RESERVE 0x2400). menu_tap = 0x219d2bc, it_wait = 0x219d2fc in this build.
  Rig test (fresh boot of the wip with the playthrough .srm; t1, t4, t7, t9.py in the session scratchpad): B x3
  timing sweep (as above) = no re-out, ends away; A digs = R's point in 4 directions; B B B from out / idle =
  away + slashes; t1 (R, B, R + R dig, B held, icon tap + B, R + B before the dig, boomerang + B, walking) all as
  v2.1.28; bombs out + A = set down. If check 5 still fails: a RetroArch save state just before the B presses.
  ROM: "Phantom Hourglass US - Dpad v2.1.29-wip.nds", SHA-1 26e80217f203c9ff4ceeb7bb7b3e678abc0812d9, CRC32
  1f4b3ebb; save copied from the playthrough .srm.
  User test of wip (RetroArch, 2026-10-18): all checks passed (R out + B away, B x3 from away = sword only,
  R + B x3 = away and stays away; no shovel flash).
  Released as v2.1.29 (builds\v2.1.29\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (v2.1.25-v2.1.29 changes: bomb-flower bombs / standing
  set-down, B = Put Away, A with an item out = R, B = lower-left Back arrow; shovel removed from the untested list).
  Release notes say the standing set-down and B with the boomerang / bombs were rig-tested only.
v2.1.30-wip (2026-10-18, rig tested; user test due): B no longer slashes under the wall map or its text box (user
  bug, see Future). Built on v2.1.29 (source rebuilt to its SHA-1 first).
  - Found (state 59, v2.1.30 code hot-swapped; tr.py / tr2.py in the session scratchpad): after A at the map, the
    screen is mode 54 then 55 for ~43 frames with no text box; then the "~To my son~" box types out. Link's update
    keeps running under this screen, so B reached slash_check every time: before the text (msg_guard 0) AND with
    the text up (msg_guard 12, ch_seen 3); the same B also typed the text out (dialog_advance). So the cause was
    not a late msg_guard: slash_check never looked at it.
  - Game flags: touch ctl [0x27E0FB8] (r7 in the gesture function ov0 0x20B0AAC, which ends in our slash_check
    hook) +0x7c = player takes stylus input, +0x7d = second enable; both set each frame by ov0 0x20AF4D8 and forced
    to 0 by its tests (0x20AF444: text/UI checks, [0x27E0C68 +4] = 1 under the map, ...; +0x7d also 0 in modes
    55/59 via 0x20AEE98). Field: 01 01. Wall map opening / with text: 00 00. Map up, no text: 01 00 (3 frames while
    it opens, and after the text closes).
  - slash_check: no slash unless touch ctl +0x7c and +0x7d are both nonzero (no own latch; B is not hidden from the
    game, so dialog_advance, back_ctl and item_ctl see it as before). dpad.bin 8896 bytes (CODE_RESERVE 0x2400).
  Rig test (state 59, hot-swapped): B 10 / 30 frames after the A release (tr.py) and 24 / 26 / 28 (the +0x7c = 1
  frame) / 30 / 32 / 40 frames after A starts (tr2.py), map opening, no text = no slash (v2.1.29 code: 10 and 30
  slashed); B 44 / 47 frames after the A release (text typing) = text typed out, no slash (v2.1.29: typed out AND
  slashed); B closes the text, B closes the map (back_ctl), field B
  slashes, B again slashes. Fresh boot of the wip with the playthrough .srm: B, Right + B, B x3 quickly slash;
  R = shovel out, B = put away (no slash), B after = slash; walk. Same states as v2.1.29 with the same script.
  Not tested: Y + B spin under the map (spin_check unchanged), other no-NPC text boxes, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.30-wip.nds", SHA-1 22deedc2f5c1a160dcb41d6b9eb04f23db74a374, CRC32
  0491f99c; save copied from the playthrough .srm. Moved to builds\ when wip2 was made.
  User test of wip (RetroArch, 2026-10-18): Y + B with the wall-map text up = Link spin-attacks.
wip2: spin_check gets the same test: the Y+B spin flag is set only while touch ctl ([TOUCH_CTL] 0x27E0FB8, new
  equ) +0x7c and +0x7d are both nonzero (and the pointer is not 0). Flags and r1-r3 still kept (conditional chain).
  dpad.bin 8924 bytes (CODE_RESERVE 0x2400).
  Rig test (state 59, hot-swapped; tr2.py): Y+B held 30 frames with the text up = no state change; Y+B held while
  the map opens = nothing; then B closes the text, B closes the map, field B = slash, field Y+B = spin (screenshots
  show the circle trail at 12 and 22 frames held).
  ROM: "Phantom Hourglass US - Dpad v2.1.30-wip2.nds", SHA-1 c1a743a6de1641fe41ed191225dad3bbc1dac7e0, CRC32
  41792fb6; save copied from the playthrough .srm.
  User test of wip2 (RetroArch, 2026-10-18): all checks passed (no slash or spin under the wall-map text; field B
  and Y+B work).
  Released as v2.1.30 (builds\v2.1.30\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip2 moved to builds\), docs\README.txt updated (v2.1.30 change and testing lines).

v2.1.31-wip (2026-10-18, rig tested on land; user test due): Select = menu bar on buttons, L free (user request:
  Select opens Save / Collection / Sea Chart / Map, D-pad moves, Collection first, A confirms, Select / B close,
  a screen from the bar returns to the field with the bar closed, no bar with an item out, a visible selection).
  - ov9 (build_v2.py): 0x211B214 tst r2,#4 (Select = menu bar; was none since v2.1.19), 0x211B2B4 tst r0,#0
    (Select no longer opens the collection; it still closes it, that is the collection's own check), 0x211B134
    tst r2,#0 (L = nothing; map from the bar). 0x211B300 map close mask unchanged. item_ctl still hides held L.
  - Found (rig, fresh boot with the playthrough .srm): the bar slides in over ~6 frames. HUD buttons object
    [[0x27E103C] + 0x1c] word +4 = 8 while the bar shows (6 while it slides, 0 hidden). The [+0x14] object's +8
    is NOT usable: it stays 8 for ~3 s after a screen opened from the bar closes (bar hidden); a Select then
    shows the bar again. Bar buttons (vtable 0x20E893C, ids 3 Menu, 4, 5, 6, 7 Collection, 0xb on land; 8 at
    sea) are updated through none of the hooked vfuncs ([0] fs_btn, also tried [1] 0x20cfebc): fs_btn never
    sees them. So mb_ctl uses fixed places (y 176): land Save 43, Collection 120, Sea Chart 164, Map 207; at sea
    (SEA_OVL_SLOT 15, from state 24's screenshot) Save 43, Collection 84, Sea Chart 122. A held press drops the
    icon ~3 px (game's pressed look; Save shows none): user chose this as the marker (no custom sprite).
    Clean behaviour checked: the game refuses the bar with an item out; B with the bar open closes it.
  - mb_ctl (pad_update chain after ib_ctl; mode 1, msg_guard 0, flag = 8; pointers checked to be in main RAM,
    since an unchecked chain hung the boot with a white screen): new presses and held D-pad hidden; stylus
    holds Collection (ch_tap CH_HOLD); Left/Right = CH_DRAG one place, ends stay; A = CH_CONFIRM and a latch
    (mb_sel+1) until the flag drops; B / Select = CH_DRAGOFF, then Select (game closes the bar).
  - CODE_RESERVE 0x2600 (debug 0x2800); dpad.bin 9480 bytes. mb_sel = 0x219d558, ch_tap = 0x219d50f.
  Rig test (fresh boot of the wip with the playthrough .srm; t15.py / t16.py in the session scratchpad):
  Select = bar, Collection pressed; Right x3 = Sea Chart, Map, stays; Left x4 = Sea Chart, Collection, Save,
  stays; A on Collection = mode 21, B = field, bar hidden, Left walks; Sea Chart = mode 44, B closes; Map =
  mode 4, B = field, walks; Save = "Save your progress?", Down + A = No; Select + B = closed, no slash; Select
  + Select = closed; Up / Down with the bar open = no walk; icon tap (item out) + Select = no bar; L = nothing;
  Select right after closing Collection = bar shown with Collection held, Select closes it.
  Not tested: the bar at sea (state 24 holds old code with a smaller reserve; no fresh-boot save at sea),
  dungeons (bar layout assumed as on land), real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.31-wip.nds", SHA-1 a24229c7ed6f1a69874b6259f4b849b71f3cb07f, CRC32
  08b51cef; save copied from the playthrough .srm. docs\README.txt to be updated on release (Select / L lines).
  Moved to builds\ when wip2 was made.
  User test of wip (RetroArch, 2026-10-18): all checks passed. Tweak asked: Left on Save wraps to Map, Right on
  Map wraps to Save.
wip2: mb_ctl Left/Right wrap (place 0 -> last, past the last -> 1; at sea Save <-> Sea Chart). dpad.bin 9480 bytes.
  Rig test (fresh boot of wip2 with the playthrough .srm; t19.py): Collection, Left = Save, Left = Map, Right =
  Save, Right = Collection; Left x2 + A = map (mode 4), B = field.
  ROM: "Phantom Hourglass US - Dpad v2.1.31-wip2.nds", SHA-1 1aff42e6d368b6b07a30815afb8966ab67fab4bb, CRC32
  b9f49112; save copied from the playthrough .srm.
  User test of wip2 (RetroArch, 2026-10-18): wrap works (all v2.1.31 checks passed on wip).
  Released as v2.1.31 (builds\v2.1.31\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip2 moved to builds\), docs\README.txt updated (Select menu bar / L control lines, v2.1.31 change and
  testing lines).

v2.1.32-wip (2026-10-18, rig tested; user test due): code-size cleanup, no intended behaviour change.
  - dpad.s: shared helpers after ch_step: ch_go / ch_go_at / ch_go_off (ch_tap phase + ch_step count), menu_tap_at
    (replaces it_tap and the inline menu_tap writes in pad_update / back_ctl), in_coll (collection modes), on_field /
    on_land (mode 1, no text box, [not at sea]), hd_oct (heading -> octant). coll_ctl / ib_ctl / mb_ctl share the
    tail ctl_at / ctl_set / ctl_off / ctl_wait / ctl_done (in mb_ctl); cl_wait stays (cl_key is a byte).
    IT_ICON_FRAMES removed. dpad.bin 9480 -> 9144 bytes (CODE_RESERVE 0x2600 unchanged, 584 bytes free).
  Rig test (fresh boot with the playthrough .srm; scripts boot/files/opts/field.txt in the session scratchpad):
  file list Down/Down/Up hold, A = Copy/Erase/Start row, A = Start, mode select Up wraps to Options, Options Right
  = Fast, B back, A = Adventure -> field; menu bar Collection held, Right/Left, Left wraps to Map, B closes; Collection
  -> Right = page 2, Down holds slot 0, A opens Passable Prow, B back re-holds, Up lets go, B closes; item bar
  X/Right/Right/B; R takes the shovel out and digs; Select > Save: Yes held, Down = No, A = field; D-pad walks, A probes.
  Not tested: shop, sailing, save menu (Continue / Save and Quit), Put Away screenshot not checked, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.32-wip.nds", SHA-1 8db640a51ea7b0f27e43d85ea072e6c68b44ee00, CRC32
  98538a87; save copied from the playthrough .srm.
  User test (RetroArch, 2026-10-18): all checks passed (incl. shop, sailing, save menu Continue / Save and Quit + B).
  Released as v2.1.32 (builds\v2.1.32\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (v2.1.32 change and testing lines).

v2.1.33-wip (2026-10-18, rig tested; user test due): review group B, maintenance cleanup, no intended behaviour change.
  - dpad.s: named data-block field offsets (MT_*, CT_*, MW_*, SM_*, FS_SEL, SH_*, CL_*, IT_OK/OCT/PUT, IB_*, MB_*,
    DIR_AGE) instead of raw [rN, #n]. They are numbers in the .equ block at the top (ldrh / strh / ldrsb / ldrsh can't
    take a label difference defined later); the chk_off macro at each data group stops the build if one no longer
    matches its label difference. Old IT_PUT (30 reads) renamed IT_PUT_WAIT; mb_sel + 1 got its own label mb_screen;
    the sh_ly .balign became 2 pad bytes (chk_off can't read across a .balign). This step alone gave the same
    dpad.bin SHA-1 as v2.1.32 (e67a1b06...).
  - Dead stylus phases CH_DRAGX / CH_RELEASEX removed (nothing set them): CH_DRAGOFF 8 -> 6, ch_next / ch_step 7
    entries (checked by .if), CH_TOUCHING = 0x66 (HOLD, DRAG, TAP, DRAGOFF) built from the phase names, now a mov
    (no literal). ch_tap phase numbers 0-5 unchanged.
  - fs_phase: comment only. It stores CHOICE_STEP for every phase (a CH_HOLD settles 4 updates, not CH_SETTLE 2);
    known and kept until a change is tested.
  - Stale comments: L -> R (IT_FIRST, IT_WAIT, IT_SETTLE, it_dist, it_wait), ch_tap = menu stylus of all touch
    menus, header "v2.1.x". msg_guard is now .byte + .balign 4, 0 (zero fill keeps the bytes; code reads it as a byte).
  - dpad.bin 9144 -> 9136 bytes (CODE_RESERVE 0x2600 unchanged, 592 bytes free). Instruction diff against v2.1.32:
    only the ch_step offset, mov #0x66, CH_DRAGOFF #6 and the adr to ch_step; data block bytes the same (8 bytes
    lower: data labels are v2.1.32 address - 8, e.g. ch_tap 0x0219d3b7, mb_sel 0x0219d400). DEBUGLOG build assembles.
  Rig test (fresh boot with the playthrough .srm; scripts boot/files/opts/field.txt in the session scratchpad; the
  title took the 2nd A, near frame 1400, not one at 1300 or 1800 - v2.1.32-wip the same): file list Down/Down/Up
  hold, A = Copy/Erase/Start row, A = Start, mode select Down holds Adventure, Up wraps to Options, Options Right =
  Fast, Left = Normal, B back, A = Adventure -> field; menu bar Collection held, Right/Left, Left wraps to Map, B
  closes; Collection -> Right = page 2, Down holds slot 0, A opens Passable Prow, B back re-holds, Up lets go, B
  closes; item bar X/Right/Right/B; R takes the shovel out and digs, B = Put Away; Select > Save: Yes held, Down =
  No, A = field; D-pad walks right, A probes.
  Not tested: shop, sailing, save menu (Continue / Save and Quit), dialogue choices, parts list, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.33-wip.nds", SHA-1 28674097786fb58cbd63aafd03ef662ba9d53665, CRC32
  1855693c; save copied from the playthrough .srm.
  User test (RetroArch, 2026-10-18): all checks passed (incl. shop, sailing, dialogue choices, save menu Continue /
  Save and Quit).
  Released as v2.1.33 (builds\v2.1.33\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip moved to builds\), docs\README.txt updated (v2.1.33 change and testing lines).

Build scripts (2026-10-18, review group C; no new ROM, dpad.s unchanged; the build still gives the v2.1.33 SHA-1
  28674097..., and mkpatch.py on the v2.1.33 ROM gives the released .bps byte for byte and verifies both patches).
  - link.py is the one link script. It takes the link address (CODE_ADDR) and the output names from build_v2.py.
    link.sh is now a thin wrapper that runs "python3 link.py" (kept: the release source zip lists it).
  - build_v2.py: DEBUG / OUT constants; debug reserve = CODE_RESERVE + 0x200; prints "dpad.bin N bytes,
    CODE_RESERVE 0x..., N bytes free" (unpadded size); H3 comment fixed (pad_update, not "L closes the
    collection"); the FAT offset (0x48) is read once (fat0 removed).
  - DPAD_DEBUG=1 now writes dpad_debug.o/.elf/.bin/.sym plus dpad_debug.nm (full llvm-nm output, read by ralog.py,
    ragate.py, rasnap.py), and leaves dpad.* alone. Checked: debug build links, dbg_seq/dbg_log/dbg_ctl found in
    the .nm. The old dpad_debug.bin/.nm (2308 bytes, an early debug build) were put back after the test.
  - src\tools\: the byte-identical copies (apply, blz, blzenc, dis2, nds, vcd, vcdtab .py) deleted; the same files
    are in src\. Only extract.py used src\tools (sys.path line, for blz); that line is removed (src\blz.py is used).
    src\tools\verify.py kept: it differs from src\verify.py only in line 4: it reads the clean ROM from
    PH_CLEAN_ROM (default .backup\) and takes only the patched ROM as argv[1]; src\verify.py takes both.
  - mkpatch.py: the apply.py fallback stays (same folder in the flat release zip, src\ in the project); comment added.
  - CODE_RESERVE history (moved from build_v2.py): 2 KB until v2.1.4, 2.5 KB v2.1.5, 3 KB until v2.1.8, 4 KB until
    v2.1.9, 4.5 KB until v2.1.11, 5 KB until v2.1.13, 5.5 KB v2.1.14, 6 KB until v2.1.17, 6.5 KB v2.1.18, 7.5 KB
    v2.1.19-wip/wip2, 8 KB v2.1.19-wip3 to v2.1.21, 8.5 KB v2.1.22 to v2.1.26, 9 KB v2.1.27 to v2.1.30, 9.5 KB
    (0x2600) v2.1.31 to v2.1.35-wip2, 10 KB (0x2800) v2.1.35-wip3 to v2.1.36, 10.5 KB (0x2A00) since v2.1.37-wip.

mkpatch.py speed-up (2026-10-18, review group D, the last review item; no new ROM, dpad.s unchanged).
  - regions() no longer walks the ROM one byte at a time. New helper mismatch() compares 4 KB blocks and bisects
    the first mismatching block. A 'diff' run jumps to the next equal byte, then checks the MIN_COPY (16) bytes there.
    Edge rules unchanged: 'diff' ends at the first 16 equal bytes inside the source and the target; a longer
    target is 'diff' to the end; 'same' stops at the end of the source. make_bps/make_vcdiff/apply_bps/main unchanged.
  - Checked: list(new) == list(old) on v2.1.33 vs clean (31 regions; regions() 4.36 s -> 0.06 s) and on synthetic
    cases (equal, longer/shorter/empty target, diff at start/end, short runs with 15/16-byte gaps, 4 KB block edges,
    300 random small-alphabet cases). mkpatch.py on the v2.1.33 ROM: .bps and .xdelta byte-identical to
    builds\v2.1.33\, both verified. Full run 15.9 s -> 7.1 s (the rest is apply_bps and the apply.py check).

v2.1.34-wip (2026-10-18, rig tested; user test due): sailing X = Route, B = cannon, B backs out of the route screen
  (user request, see Future list). Found from user states 62 (sail HUD) / 63 (route screen), v2.1.33:
  - Route button tap (238,176) -> mode 0x10 (opening, ~40-65 frames) -> 0x11. Back arrow (14,176) closes it. B did
    nothing there before. Leaving port opens the route screen by itself.
  - Cannon: a tap on open sea at (128,70) fires straight ahead (camera looks along the heading; in a turn it lags a
    little). Owned in the playthrough save.
  - After a route is drawn, a GO! (95,128) / CANCEL (163,128) panel covers the screen (back arrow hidden). Not a
    0x20e893c / 0x20e8958 touch button. Route screen object = [0x027e07c0] (DTCM global, vtable 0x02189484 at sea):
    byte +0x1e = 1 while drawing / panel shown, 0 after GO! or CANCEL; +0x114 = 8 once a route is drawn (stays 8).
    CANCEL erases the route and brings back the back arrow.
  - dpad.s, pad_update sailing block: now also takes B / X. Gate as before (slot 15, msg_guard 0, menu_tap idle,
    SEA_CTL != 0), then by mode: 0x11 = B hidden, menu_tap on CANCEL if [ROUTE_OBJ] is in main RAM, has ROUTE_VT
    and +ROUTE_PANEL != 0, else on the back arrow; 1 = A/B/X/Up/Down hidden, and with the HUD up (+0x34 == 0) A =
    Jump, B = cannon tap, X = Route tap, Up/Down = lever as before. A B press during the opening (mode 0x10) passes
    to the game (it does nothing there).
  - dpad.bin 9276 bytes (CODE_RESERVE 0x2600, 452 bytes free).
  Rig test (fresh boot of the wip with the playthrough .srm, Linebeck at Mercay -> set sail; scratchpad chk.py):
  route screen on departure: B = sail HUD; X = route screen; drawn route + B = CANCEL (route erased, still mode
  0x11), B again = HUD; GO! (stylus) sails; Down = Stop, Up = Go; B fires the cannon ahead; A jumps; Select + B
  closes the bar; after sailing X opens the route screen (route shown), B closes it; B at sea before a route
  (no lever shown) fires too.
  Not tested: X under the menu bar (hidden, as A), text boxes at sea, cannon not owned, other seas, real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.34-wip.nds", SHA-1 aa9e58072408d2fc1c1b000d81a710407fd23876, CRC32
  d5a0433e; save copied from the playthrough .srm. Moved to builds\ when wip2 was made.
  User test (RetroArch, 2026-10-18): all checks passed. Change asked: A confirms GO! on the panel.
wip2: route screen A = menu_tap on GO! (95,128) while +ROUTE_PANEL != 0; A with no panel is left to the game
  (does nothing). B unchanged. dpad.bin 9316 bytes (412 bytes free).
  Rig test (fresh boot of wip2 with the v2.1.34-wip .srm, since the playthrough save now starts in a cave on
  another island; Linebeck at Mercay -> set sail; scratchpad chk2.py): A with no route = nothing (mode 0x11); route
  drawn + A = mode 1, sailing the route (+0x114 = 8, speed 2); X = route screen; route + B = CANCEL; B = HUD; B =
  cannon.
  ROM: "Phantom Hourglass US - Dpad v2.1.34-wip2.nds", SHA-1 3d3e36303f473e8ff031e24b743b62d43ddff582, CRC32
  7f433e12. Its .srm already existed in RetroArch's saves folder (13:25), so it was not overwritten.
  User test of wip2 (RetroArch, 2026-10-18): all checks passed.
  Released as v2.1.34 (builds\v2.1.34\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough
  ROM (wip2 moved to builds\), docs\README.txt updated (sailing B / X, Routes screen A / B control lines, v2.1.34
  change and testing lines, sailing limitation reworded).

v2.1.35-wip (2026-10-18, rig tested; user test due): sea menu bar reaches Fish; the real stylus works on the bar.
  User report: fishing unlocked; Fish is on the sea menu bar but the D-pad can't reach it and the stylus can't tap
  it. Fish lights up only while the ship is over a school of fish (user).
  - Found (RetroArch states 81 / 82, v2.1.34 code): the sea bar has a second panel right of Sea Chart with three
    slots: "?" (161), "?" (200), Fish (235), y 176 (from the state 81 screenshot; "?" = not owned yet). mb_sea held
    only Save / Collection / Sea Chart. Poking a 6-slot table into state 82 (Fish lit): Right x4 + A = the
    fishing view. A on an unlit Fish or a "?" = nothing.
  - Found: with the bar open, mb_ctl keeps our stylus held on a button (ch_tap CH_HOLD), so menu_touch replaces
    every real sample: no real stylus tap worked on the bar (also Collection) since v2.1.31.
  - mb_sea = 6 slots (43, 84, 122, 161, 200, 235); the "?" slots are kept so later sea items need no change.
    menu_touch: a real stylus press (sample +4 != 0) while mb_sel holds a button sets ch_tap CH_OFF and
    mb_screen (the bar is the stylus's until it closes, as after A); the sample passes. Ownership of the "?"
    items is not checked (dead stops). dpad.bin 9364 bytes (364 bytes free). mb_sel = 0x219d4e4, ch_tap =
    0x219d49b, mb_sea = 0x219c651.
  Rig test (fresh boot of the wip with the playthrough .srm: Adventure starts on the route screen at sea, B =
  HUD): Select = Collection held; Left = Save, Left = Fish (wrap), Right = Save; stylus tap on Collection = mode
  0x15 in one tap; B = HUD; Select = Collection held again, Right = Sea Chart, Select = closed.
  Not tested on this build: A on a lit Fish (no school near the fresh-boot spot; tested by the table poke on
  state 82), the land bar with the stylus, fishing itself (stylus only: cast / reel not mapped).
  ROM: "Phantom Hourglass US - Dpad v2.1.35-wip.nds", SHA-1 e83591d26f9c26dd9e89ea2443085bda75368e7b, CRC32
  8a1aeffb; save copied from the playthrough .srm. Moved to builds\ when wip2 was made.
  User test of wip (RetroArch, 2026-10-18): all checks passed. New report: the fishing tutorial text needs
  several A presses per page.
wip2: fishing tutorial text, A / B on every press.
  - Found (wip state 1 = tutorial text, mode 1 at sea; per-frame rig watch): dialog_advance runs on even frames
    (guard = MAX), tap_front on odd frames (guard MAX - 1), so the guard is 12 / 11 by turns. A / B count
    only via pad_update's fallback text-box tap (tap_front's tap does not advance this box), which needed
    guard == MAX at the pad read: only a press whose first read came on an odd frame worked (8 of 8 missed in
    the rig, about half in RetroArch). A stylus tap at (128,168) advances every time.
  - pad_update fallback: at sea (SEA_OVL_SLOT 15) guard >= MAX - 1 counts too; on land unchanged (there
    tap_front gives the tap). dpad.bin 9388 bytes (340 bytes free).
  Rig test (wip state 1 with wip2 hot-swapped in: scratchpad hot.py loads dpad.bin and re-aims the 11 hook
  branches / vtable pointers from the old global addresses): A every 41 and 42 frames = each press finishes
  the typing or turns the page, no page skipped, as with the stylus. Not tested: text boxes at sea outside
  fishing (e.g. Linebeck), on land (code path unchanged).
  ROM: "Phantom Hourglass US - Dpad v2.1.35-wip2.nds", SHA-1 69f61c604e161cf27174d4f92c84f7f8082877f4, CRC32
  11d7a007; save copied from the v2.1.35-wip .srm.
  Fishing research (wip states 1 / 2, no build): Fish (lit over a school) -> fishing view, the line casts by
  itself. Bite = "PULL!" on the top screen; the tutorial says: flick up on the rod to set the hook (timing),
  slide the stylus down to pull up on the rod, make small circles with the stylus to reel in. No input on
  "PULL!" = "MISS!", back to sailing. Fight screen: distance in yds (top), tension meter with "Danger!" (left
  edge, bottom screen). Bottom-left red arrow (~(16,180)) = quit fishing. In state 2 (tutorial fish) a slide
  down, a slide up and a tap all hooked it (circles followed), so the tutorial fish shows no difference.
  Next: a state on "PULL!" with a normal fish; find the game's rod / reel inputs (touch deltas).
  Moved to builds\ when wip3 was made.
wip3: fishing on buttons (user approved the design); fishing text A fixed for both frame parities.
  - Found (rig, 180 RAM snapshots of a fishing run from state 82 + RetroArch wip states 1 / 2, checked over 9
    states): fishing = SEA_OVL_SLOT 15 and byte 0x020eaab4 (ov0) = 1 and byte 0x0218f54f (ov15) = 0 (sailing:
    0 / 2). While fishing, SEA_CTL points to a fishing object (0x021f6f10 in both sessions): +0x14ae = scene
    (1-5 intro, 6 tutorial text, 7 waiting for a bite, 8 bite, 9 fish on the line, 10 catch, 0/2-5 after it),
    +0x12c8 = event (5 "PULL!", 4 hooked, 0 fight, 6 "LET GO!" (fish jumps: stylus off), 7 miss / lost).
    The fight gauge falls with no input; a slide down raises it; circles reel in (distance drops). The red
    arrow (quit) is not a touch button seen by fs_btn (bk_tab stays empty).
  - Found: the wip2 change only fixed half the presses. The fishing text box needs BOTH dialog_advance seeing
    the press (it runs on odd frames there) AND the fallback stylus tap. A press read on an odd frame:
    dialog_advance sees it, the tap needs guard >= MAX - 1 (wip2 change). On an even frame: dialog_advance
    never saw it. New ab_pend byte: an A / B press with ch_seen != 0 stays pending 2 pad reads;
    dialog_advance ORs the press flag for a pending one and clears it.
  - fish_ctl (pad_update, before the sailing keys; fishing and no text box): hides A B X Y Select D-pad from
    the game; held keys from held_real (PAD+0 is cleared on gated reads: with PAD+0 held B dropped every
    other read and the circle restarted, no reeling). A = one slide (x 128, y 60 + 6 per read, 20 reads, 2 up),
    held Down = slide after slide, held B in scene 9 = circles (16 points, r 20, centre (128,120), one per
    read), B outside scene 9 or Select = menu_tap on the red arrow (16,178). fg_x / fg_y = the point (x 0 =
    up); menu_touch presses there when ch_tap is off.
  - CODE_RESERVE 0x2800 (10 KB; debug 0x2a00). dpad.bin 9956 bytes (284 bytes free).
  Rig tests:
  - Fishing (earlier wip3 build without ab_pend, hot-swapped into wip state 2 = "PULL!"): A = hooked (event
    5 -> 4, scene 9); B 90 reads / Down 45 reads by turns, keys let go on "LET GO!", A on "PULL!": 5 "LET GO!"
    survived, distance 32 -> 1 yds, catch screen (scene 10, "These fish are common..."), back to sailing.
  - Text (test-only build without fish_ctl, scratchpad nofish.py, so it fits the old 0x2600 reserve for a
    hot-swap): fishing tutorial, A starting on even and on odd frames = one page per press, none skipped.
    Land (state 66, fisherman's house, talk + A x14) against the v2.1.34 code in the same state: same pages;
    the old code skipped "Haha! I finally met the mermaid of my dreams!", the new one shows it.
  - Hot-swap note: wip3's data (it_wait .. fg_mode, 0x219d720+) lies past the old 0x2600 end = the heap of
    states made with a 0x2600 build, so the full wip3 cannot be hot-swapped into them. Not tested on the
    final build: fishing (no rig state; the rig could not sail onto a school, the ship sank on the way) and
    the B quit. Not tested anywhere: Select quit, a normal (non-tutorial) fish.
  ROM: "Phantom Hourglass US - Dpad v2.1.35-wip3.nds", SHA-1 a678349b9172c5e26eae594ec8046c34eb8792cc, CRC32
  0b806788; save copied from the v2.1.35-wip .srm. Moved to builds\ when wip4 was made.
  User test of wip3 (RetroArch, 2026-10-18): the whole fishing tutorial without the stylus. Then a normal
  fish: user state "Phantom Hourglass US - Dpad v2.1.35-wip3.state4" (cast of a normal fish; state3 = sailing).
wip4: fishing detection fixed for normal fish.
  - Found (rig, wip3 state 4): 0x020eaab4 (FISH_ON) stays 0 through a normal fish (it was 1 in the tutorial
    sessions only), so fish_ctl never ran: A on "PULL!" did nothing, miss. 0x0218f54f (FISH_SEA) = 0 there
    too. FISH_SEA over 13 sea states (sail HUD, menu bar, route screen, text at sea, both seas' sessions) = 2;
    0 only while fishing; 0 also in 4 land states (overlay 14 / none), which the SEA_OVL check excludes.
  - fish_ctl: fishing = SEA_OVL and FISH_SEA = 0 (FISH_ON removed). dpad.bin 9936 bytes (304 bytes free).
  Rig tests (wip4 hot-swapped into wip3 state 4, same 0x2800 reserve; scratchpad swap.py reads the old
  addresses from the state's own hook branches, fishplay.py plays with keys only):
  - Buttons only: cast intro (scenes 1-4), wait (7), "PULL!" + A = hooked (event 5 -> 4, scene 9); B 90 reads /
    Down 45 reads by turns, keys let go on "LET GO!" (7 of them), A on "PULL!": distance 20 -> 1 yds, "You
    caught a skippyjack! It measures 2 ft. 2 in.", back to sailing.
  - B 30 reads into the wait = quit (scene 0 / 1, fishing object gone, sail HUD with Menu / Route).
  Not tested: Select = quit, sailing keys after this change (fish_ctl is off with FISH_SEA = 2, path
  unchanged), real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.35-wip4.nds", SHA-1 b14976bc5455a2cd45d34d7a79673c11b36b676a, CRC32
  9664ded0; save copied from the v2.1.35-wip3 .srm.
  Released as v2.1.35 on the user's request (2026-10-18, "build it so I can get through the tutorial; fix
  bugs in the next version"), before a user test of wip4: builds\v2.1.35\ (bps, xdelta, README, source
  zip; source rebuilt to the same SHA-1 first, patches made with mkpatch.py, xdelta re-applied with
  src/apply.py to the same SHA-1). Now the root playthrough ROM (wip4 moved to builds\). docs\README.txt
  updated (menu bar at sea, fishing control lines, v2.1.35 change, testing and limitation lines).
  Save: the playthrough .srm (13:56) was kept as "...Phantom Hourglass.srm.before-v2.1.35.bak" in RetroArch's
  saves folder and replaced by the newer v2.1.35-wip4 .srm (15:14), so the release opens with the newest
  progress.
  User test of v2.1.35 (RetroArch, 2026-10-18): caught a real (non-tutorial) fish without the stylus.

v2.1.36-wip (2026-10-18, rig tested; user test due): diagonal fishing slides (user request).
  - User: Down + Left = draw a line down-left (SW), Down + Right = down-right (SE), Down = straight down (S).
  - fish_ctl: at the start of each slide (A or held Down), Left / Right held -> new byte fg_dx (fg_mode + 4) =
    -FG_DX / +FG_DX (FG_DX 6), else 0; slide x = FG_SX + fg_dx * step. Over 20 reads: SW x 128 -> 14, SE
    128 -> 242, y 60 -> 174 as before. Direction is fixed for one slide; held Down repeats with the current
    Left / Right. Left / Right alone do nothing. Not checked: whether the game uses the slide's x at all.
  - dpad.bin 9973 bytes (267 bytes free).
  Rig test (wip3 state4, normal fish, wip hot-swapped with the old session's swap.py; scratchpad diag.py, run
  with Python 3.14 since lr.load_state needs `compression`): A hooked; B 90 reads then Down+Left / Down /
  Down+Right 135 reads by turns: fg_x / fg_y per read as above for each direction, "LET GO!" survived, fish
  to 1 yd, scene 0 (end of the fight). No visible rod tilt in the screenshots.
  ROM: "Phantom Hourglass US - Dpad v2.1.36-wip.nds", SHA-1 be8722135ab42464703957bc7342172db05192d6, CRC32
  319580b0; save copied from the playthrough .srm. docs\README.txt not updated yet (do on release).
  Moved to builds\ when wip2 was made (wip2 has all of it; its user test is still due).
wip2 (2026-10-18, rig tested; user test due): R only takes the item out / puts it away; A uses it (user request:
  "R selects the equipped item but does not use it, so I can draw by hand; R again puts it away like B").
  - item_ctl: item not out + R = icon tap only (all items; no use tap), then R is ignored while it_wait (IT_WAIT
    45 reads) runs and the item is not out yet; cleared as soon as it is out. Item out + R = Put Away (the B
    path: icon tap, B hidden, it_put latch). Item out + A (not bombs) = the use tap as before (r8 now holds
    KEY_R / KEY_A; R + A on one read = Put Away). IT_SETTLE removed; it_ok byte kept, unused (data layout same).
  - dpad.bin 9945 bytes (295 bytes free).
  Rig test (fresh boot with the v2.1.29-wip .srm, land, shovel equipped; scratchpad rt.py): R = shovel out, no
  dig (screenshot: "Put Away" label, no hole); R = away; R, R 10 frames later = out then away; R, R 7 frames
  later = out (2nd ignored); B with nothing out = no item; R out + A = dig (A again digs); Left + R + A = dig
  left; shovel out + stylus tap (180,150) = dig there (screenshot), shovel stays out; B = away.
  Not tested: boomerang / bombs / bow / hook / hammer with this build (code path is the same icon tap; bombs A
  = held_obj set-down, unchanged), bombchu (item_ctl off: mode not 1, R reaches the game), real RetroArch.
  ROM: "Phantom Hourglass US - Dpad v2.1.36-wip2.nds", SHA-1 d0cecc6612919eeaea9ba80782b7baf36df511e7, CRC32
  faf6e079; save copied from the playthrough .srm. Moved to builds\ on release.
  User test of wip2 (RetroArch, 2026-10-18): all checks passed (R out without use, stylus path, A use, R / B
  away; the wip diagonal fishing slides were in the same checklist note, not a separate check list).
  Released as v2.1.36 (builds\v2.1.36\: bps, xdelta, README, source zip; source rebuilt to the same SHA-1 first,
  patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). First release under the
  "Button Controls" name: release ROM builds\"Phantom Hourglass US - Button Controls v2.1.36.nds", patches
  zelda_phantom_hourglass_buttons_v2.1.36.*, README title "Button Controls Patch" (D-pad kept in the
  description, griegamaster credit kept). Now the root playthrough ROM. docs\README.txt updated (R / A / R-or-B
  control lines, Down + Left / Right fishing line, v2.1.36 change, testing and limitation lines).
  Save: the playthrough .srm was kept (backup "...Phantom Hourglass.srm.before-v2.1.36.bak"); the v2.1.36-wip2
  .srm (written 8 s later, different content) was not copied over it.

v2.1.37-wip (2026-10-18, rig tested on land; user test due): Sea Chart screen on buttons (user request; user state 127
  = the four-seas screen at sea, made with v2.1.35: "B goes back, no way to select a sea chart"). User design rule:
  B in an opened sea chart goes back to the four-seas screen (as the stylus Back arrow does), not to the field.
  - Found (rig, state 127 with v2.1.35-wip4 and a fresh land boot of v2.1.36 with the v2.1.33-wip .srm): the
    four-seas screen = mode 0x2c (land and sea). Seas are touch buttons (vtable 0x20E893C, cell 0xda): ids 0x21 NW
    (el 0), 0x22 NE (1), 0x1f SW (2), 0x20 SE (3); only OWNED seas get the update vfunc (clouded ones: no press, no
    light), so fs_btn stamps tell ownership. Back arrow there = id 0x1e (el 4). A held press lights the sea; the
    lift on it opens its chart (mode 0x2d, then 4); a slide to another sea or off cancels. B there closes (0x29 /
    0x6, then mode 1). An opened chart = mode 4 with Memo 0x18, Erase 0x19, Back arrow 0x17 (13,178): the arrow
    returns to 0x2c. The land Map (menu bar Map, mode 4) uses the same three ids; its arrow closes to the field.
    Since v2.1.19 B in mode 4 closed the whole map (our ov9 0x211B300 close mask), hence the user's report.
    FS_OFF (128,2) is INSIDE the NW sea: a slide-off there and a lift opens NW.
  - fs_btn: id MAP_BACK_ID 0x17 goes to bk_tab while mode == 4 (so back_ctl's B taps it: chart -> four seas, land
    Map -> field as before); ids 0x1f-0x22 go to sc_tab by place (NW, NE, SW, SE). fs_live's stamp test is now
    also entry point tab_live.
  - sc_ctl (pad_update chain after mb_ctl, before fs_ctl; mode 0x2c): stylus up = hold sc_last if owned, else the
    first owned sea (A / B / D-pad hidden from the game); Left/Right = other column, Up/Down = other row (wrap by
    toggle; clouded = stay), CH_DRAG then re-press; A = CH_CONFIRM (sc_screen latch until the mode changes); B =
    slide to the opposite sea's centre (SC_LEFT_X/RIGHT_X 64/192, TOP/LOW_Y 48/144) with CH_DRAGOFF, then B to the
    game. No sea on screen yet (opening): keys to the game. Back from a chart: the last sea is held again.
  - menu_touch: a real stylus press while the bar OR the four-seas screen holds ours: that update the real sample
    passes (slide = cancel ours), the next is forced up (new phase CH_LIFT 7: ch_next / ch_step entries, path 7:
    zeroes the sample's touch word), then the real press is a new press. Touch updates run at 30 Hz there. Rig:
    a real tap on another sea needs >= 10 frames (8: half; 6: nothing, the tap is used up); on the held sea or
    the bar >= 6 frames (bar Map over held Collection now works; a 1-update lift was missed with a 2+2 variant
    tested and dropped: it ate 6-frame taps whole).
  - CODE_RESERVE 0x2A00 (debug 0x2C00); dpad.bin 10529 bytes (223 bytes free). sc_sel = 0x0219d960, ch_tap =
    0x0219d907, mb_sel = 0x0219d950 in this build.
  Rig test (fresh boot of the wip with the playthrough .srm = land, Linebeck's island; scratchpad t2-t8.py): Select,
  Right, A = mode 0x2c with NW lit at once; Down = SW lit; Right (SE clouded) / Left (NE clouded) stay; Up = NW; A =
  NW chart (mode 4); B = back to 0x2c with NW lit; Down, A = SW chart; B = back, SW lit; B = closed to the field
  (mode 1), Right walks; B, B quick = closed; Down + quick A = toggles row and opens; B on held NW closes (no NW
  open: the opposite-sea slide); land Map + B = field, no slash; real stylus taps as above; Collection, page 2,
  B close, walk, sword B, Select > Save Yes/No unchanged.
  Not tested: the four-seas screen at sea (state 127 holds v2.1.35 code, no fresh-boot save at sea; same mode and
  ids expected), NE / SE owned, dungeon maps (mode 4 or 8?) with id 0x17, real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.37-wip.nds", SHA-1 dd103105678e068da51227811d5a8db8652ee06e,
  CRC32 daef182e; save copied from the playthrough .srm. On release: README control lines (Sea Chart screen: D-pad
  picks a sea, A opens, B back / close). Moved to builds\ when wip2 was made (wip2 has all of it).
wip2 (2026-10-18, rig tested at sea; user test due): Cyclone Slate on buttons (user request; user state 126 = the
  slate at sea, made with v2.1.35: "no way to use the back button or the Sea Chart button").
  - Found (rig, state 126): slate = mode SLATE_MODE 0x3b (slot 15, SEA_CTL set). Back arrow (15,177) -> mode 1;
    "Sea Chart" (233,175) -> 0x28, 0x2, then the four-seas screen 0x2c (~92 frames until sc_ctl holds a sea).
    B there (game) returns to 0x3b. B / X did nothing on the slate before.
  - pad_update sailing block: mode 0x3b: B / X hidden from the game, B = menu_tap on the back arrow, X = menu_tap on
    Sea Chart. dpad.bin 10585 bytes (167 bytes free, CODE_RESERVE 0x2A00).
  Rig test (state 126 with the code linked rig-only at 0x023B3000 and all hook branches / pointers repointed;
  scratchpad slate.py, keys 150 frames apart): X = four seas, NW held; Down = SW; A = SW chart (mode 4, Memo /
  Erase); B = four seas; B = slate; X again = four seas, NW held; B, B = sailing (mode 1). Mode 1: X = Routes
  screen, B = HUD as before. Stylus taps on both slate buttons still work.
  Seen once: a Down pressed in the frame the four-seas screen first took input (from the slate) closed it back
  to 0x3b; with the screen settled, all keys work. Not chased (sc_ctl's opening, v2.1.37-wip code).
  Not tested: drawing / warping with the slate, real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.37-wip2.nds", SHA-1 cdfc533e54d2075c39868602ef91af11c17b62b1,
  CRC32 e8a5a7d4; save copied from the playthrough .srm. On release also: README lines (Cyclone Slate: B back,
  X Sea Chart). Moved to builds\ when wip3 was made (wip3 has all of it).
wip3 (2026-10-18, rig tested; user test due): map note X = Sea Chart (user request; user state 160 = a sea note
  on land with a back arrow and a "Sea Chart" button, made with v2.1.36; B back was already there via bk_tab).
  - Found (rig, state 160): note screen = mode NOTE_MODE 0x37 (land, SEA_OVL_SLOT 14). A tap on Sea Chart
    (233,176) -> 0x28, 0x2, then the four-seas screen 0x2c; B there (game) returns to 0x37.
  - pad_update, after the sailing block (label 4): X in mode 0x37 with no menu_tap running is hidden from the
    game and menu_tap taps (NOTE_CHART_X, NOTE_CHART_Y). dpad.bin 10649 bytes (103 bytes free, CODE_RESERVE 0x2A00).
  Rig test (state 160, code linked rig-only at 0x023B3000 as in wip2; keys 150 frames apart): X = four seas; B =
  note; X = four seas; Down, A = a chart (mode 4); B = four seas; B = note; B = field (mode 1).
  Also covers user state 165 (island map note, made with v2.1.36): same mode 0x37, but its lower-right
  button is "Map" at the same place. Rig: X = map (mode 4, Memo / Erase); B = note; X = map; B = note;
  B = field. No code change for it (comments in dpad.s only; ROM unchanged).
  Not tested: other mode-0x37 screens without a Sea Chart button (X taps empty space there), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.37-wip3.nds", SHA-1 0c3b013eb43242213aa5302d07382b8153dae01f,
  CRC32 7294da63; save copied from the playthrough .srm. On release also: README line (map note: B back, X Sea
  Chart). Moved to builds\ when wip4 was made (wip4 has all of it).
wip4 (2026-10-18, rig tested; user test due): early D-pad no longer closes the four-seas screen (the wip2 note).
  - Found (rig, state 126, X B X Down 90 frames apart): mode 0x2c is set ~10 frames before the seas' first button
    update; sc_ctl passed keys to the game then, and the game's D-pad closes the screen (0x6, 0x29, back to 0x3b).
  - sc_ctl, no sea on screen yet: A / D-pad hidden from the game (dropped); B still passes (the game's close).
    dpad.bin 10665 bytes (87 bytes free).
  Rig test (scratchpad slate.py, wip4 code linked at 0x023B3000): state 126, Down 40-94 frames after X = screen
  stays (NW held; at +94 the Down moves to SW); B at +84 = slate; A at +84 = stays; X, Down, A, B, B, X, B, B =
  four seas, SW, chart, four seas, slate, four seas, slate, sailing. State 160 (land note): Down at X+80/86/92 =
  stays; B, B = note, field.
  ROM: "Phantom Hourglass US - Button Controls v2.1.37-wip4.nds", SHA-1 c5c3d62ea9d8e12a686566bea5cf24ca180e40e8,
  CRC32 3d123e60; save copied from the playthrough .srm.
  User test of wip4 (RetroArch, 2026-10-18): all checks passed (slate X / B, early D-pad while the four seas open).
  Released as v2.1.37 on the user's request (builds\v2.1.37\: bps, xdelta, README, source zip; source rebuilt to
  the same SHA-1 first, patches made with mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1).
  Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.37.nds"; now the root playthrough ROM (wip4
  moved to builds\). docs\README.txt updated (Sea Chart screen, map note X, Cyclone Slate B / X control lines,
  v2.1.37 change and testing lines). Save: the playthrough .srm (19:36:56) was kept; the v2.1.37-wip4 .srm
  (19:37:11, different content) was not copied over it. wip and wip3 had no separate user test.
  User test of v2.1.37 (RetroArch, 2026-10-18): map note X works on both notes (Sea Chart and Map), as designed.
  (A first "X does nothing" report was the DS X / Y layout on the user's pad; the live code was checked to match
  the release before that was clear.)

v2.1.38-wip (2026-10-18, rig tested; user test due): hold A = stylus rub while an enemy holds Link (Future item
  "Shake-off attack"; user state 172 = a sand monster has swallowed Link, "RUB!" bubble, made with an older build).
  - Found (rig, state 172): Link's state (LINK_STATE 0x027e0fd0) is gLinkStates[4] (vtable 0x020e6060), sub-state
    word +4 = 6, while held; then state 5 (thrown out), then 0. State 4 handles sub-states 0-9 (other uses unknown),
    so the code checks sub-state 6 too. The game tracks stylus x deltas in a ring at heap 0x021bcb60 (+0x118..).
    In state 172 the grab ends by itself ~125 frames after load, with or without a rub (tried jumps and smooth
    drags, 5-80 px, 1-8 frames per side, on Link, on the monster, far away): the state is too late to show what a
    rub changes. The user has no earlier state; a state near the monster with Link free is planned (let it grab
    Link in the rig, then check how the rub frees him and tune RUB_DX / the speed).
  - fish_ctl fg_off (not fishing): Link state LS_HELD 4 + sub-state LS_HELD_SUB 6, msg_guard 0, A held (held_real)
    -> A hidden from the game (PAD +0 / +2), fg_x / fg_y = ScreenFromWorld(GetCamera, PLAYER_POS) x +/- RUB_DX 24
    (side swaps every 2 pad reads, fg_step counter), kept RUB_EDGE 8 inside the screen; menu_touch presses there
    (the fishing stylus path). A let go or the state over -> fg_x 0 = stylus up.
  - CODE_RESERVE 0x2C00 (debug 0x2E00); dpad.bin 10909 bytes (355 bytes free).
  Rig test (scratchpad rubtest.py: links dpad.o at 0x023B3000 into state 172 and repoints the hooks): A held 140
  frames = stylus at (141,91) / (189,91) by turns (Link at ~165,91), a new side every 4-5 frames; state 4/6 ends at
  frame 123 (as without A), stylus up 2 frames later. Fresh boot of the wip with the playthrough .srm (boot38.py):
  field A = one probe tap as before, A held 90 frames = one tap, no rub; D-pad walks.
  Not tested: whether the rub frees Link sooner (see above), other grabbing enemies (Like Like etc.: other
  sub-state?), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.38-wip.nds", SHA-1 73949b976ece4f72e6084fe5ce09fb4c446b7b65,
  CRC32 d7438136; save copied from the playthrough .srm.
  User state "...v2.1.38-wip.state1" (2026-10-18, wip code, Link free, sand mound next to him): grab at frame 18
  (state 4/6), "RUB!" bubble, Link-face bubble at ~240, thrown out at 291 (state 5/0), back to 0 at 424; Link
  loses about half a heart. Rig: no input, hold A (wip), real-stylus zig-zags (+/-24..60 px, 3-6 frames a side,
  on Link at ~111,108), repeated taps (3 / 6 frames) and circles: ALL free Link at frame 291, same hearts. A
  whole-RAM + DTCM diff at frames 60 / 120 / 200 (none vs rub) differs only in touch data (TOUCH 0x27e0d78..,
  the player touch controller and its sub-object, 0x0205aa2c.., 0x027e3f18): nothing in the game logic reacts to
  the rub in the rig. (Link-state code 0x213f014 clears touch ctl +0x78 at some point; maybe player touch input
  is off while held.) User (RetroArch, 2026-10-18): a mouse rub DOES free Link sooner than waiting. So the rig
  misses something: rubs started late (frame 60 / 90 / 120, fresh press, smooth +/-40..60 px at 8-15 px/frame,
  on the monster at ~120,90) also free Link at 290. Callers of the state-4 counter helper 0x020aedf8 (+0x12 count,
  >= 7 -> sub-state 1) are sword-combo code (0x2105de0..), not the rub. Monster actor (state1) 0x021cdc44, vtable
  0x02158fe4. User test of wip (RetroArch): hold A = same time as no input (fails).
wip2 (2026-10-18, rig tested; user test due): diagonal rub strokes.
  - Found by recording the user's live mouse rub over UDP (scratchpad rarec.py: ra.py reads of the touch manager
    copy 0x021bcf68 and the state-4 object 0x0224e8b8 in state1's layout, 5 grabs): state object +0x10 (s16) is
    the hold timer: set to 180 at the grab, -1 about every 2 frames, -0x20 per counted rub stroke; below 0 ->
    set to 32 (the escape phase), at 0 Link is thrown out. User's rubs: free ~160 frames after the grab.
  - Replaying the recorded path in the rig (replay.py) gives the same drops, so the rig is fine; pattern tests
    (pat2.py): strokes along x only or y only never count; any diagonal zig-zag counts (dy +/-2 is enough, 2-4
    frames a side, anywhere on the screen, from early in the grab). So the wip's flat x +/- 24 never counted.
  - fg_off rub: y = Link +/- RUB_DY 4 with each x side, side swaps every pad read (was every 2).
  - dpad.bin 10917 bytes (347 bytes free).
  Rig test (rubtest.py, wip2 code linked at 0x023B3000 into state1): A held from the grab = strokes (137,123) /
  (89,115) every ~2 frames; Link free (state 5) 158 frames after the grab (no input: 273). Fresh boot of wip2 with
  the playthrough .srm (boot38.py): field A = one probe tap, A held 90 frames = one tap, D-pad walks.
  ROM: "Phantom Hourglass US - Button Controls v2.1.38-wip2.nds", SHA-1 2d412bf1554968751130bde8f46c6fa72f9a4984,
  CRC32 fa35c349; save copied from the playthrough .srm. wip moved to builds\. Note: the user's state1 holds the
  wip code and is keyed to the wip ROM name, so the RetroArch test needs a new grab from the in-game save.
  User test of wip2 (RetroArch, 2026-10-18): passed ("that got it!").
  Released as v2.1.38 on the user's request (builds\v2.1.38\: bps, xdelta, README, source zip; source rebuilt to
  the same SHA-1 first, patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the
  same SHA-1). Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.38.nds"; now the root playthrough
  ROM (wip2 moved to builds\). docs\README.txt updated (hold A "RUB!" control line, v2.1.38 change and testing
  lines). Save: the playthrough .srm (20:21:49) was kept; the v2.1.38-wip2 .srm (20:46:08, newer) was not copied
  over it.

v2.1.39-wip (2026-10-18, rig tested; user test due): B / A attack again in the Cyclok fight (user bug, state 186
  on v2.1.38: B and A did nothing, Y+B spin worked).
  - Found (rig, state 186; a logger at slash_check writing to DTCM 0x027e1a00, since main-RAM writes stay in the
    emulated data cache and 0x023E0000+ is PU no-access): GATE_OBJ byte = 1 in this room (30 Hz scene), and
    slash_check runs only on the gated reads (counter 0x027e070c even). pad_update's gated branch zeroes PAD +0 / +2
    there (no deliver mask with msg_guard 0), so held_real had B but PAD never did. Removing the gated branch in the
    rig made B slash. The clean game skips the read on a gated frame, so PAD keeps the last read.
  - gate_carry (end of pad_update, after item_ctl): with Link free on land (on_land), an ungated read stores PAD
    +0 / +2 in gate_pad (after our controllers took their keys); a gated read gets that word back. Not free on land:
    gate_pad = 0, no change. Field rooms with the gate off: InputGate is 0, nothing changes.
  - dpad.bin 10993 bytes (271 bytes free).
  Rig test (scratchpad hs.py: links dpad.s at 0x023B3000 into state 186 and repoints the hooks): B = slash (one per
  press, 3-frame strip), B + Right = long slash, Y+B = spin, D-pad walks, A = a probe tap near Link (one slash).
  Fresh boot of the wip with the playthrough .srm (21:02, Temple of Wind): file select, dream-scene text on A, field
  (gate 0): B slash, Y+B spin, walk, A, B again.
  Not tested: other 30 Hz field rooms, A on a target in the Cyclok room, real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.39-wip.nds", SHA-1 f07e71f039a156b4548e5d91f883152e1d4374eb,
  CRC32 36ce534f; save copied from the playthrough .srm. User state 186 holds v2.1.38 code: test from the in-game
  save.
  User test of wip (RetroArch, 2026-10-18): all checks passed (Cyclok fight B, B + Right, A, Y+B, walking).
  Released as v2.1.39 on the user's request (builds\v2.1.39\: bps, xdelta, README, source zip; source rebuilt to
  the same SHA-1 first, patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the
  same SHA-1). Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.39.nds"; now the root playthrough
  ROM (wip moved to builds\). docs\README.txt updated (v2.1.39 change and testing lines). Save: the playthrough
  .srm was kept; the wip .srm was not copied over it.

v2.1.40-wip (2026-10-18, rig tested; user test due): shipyard on buttons (user request, state 195 = shipyard main
  menu, made with v2.1.39).
  - Found (rig, state 195): shipyard overlay OVL_SLOT 0x27E091C = 33. Main menu = mode 0x1a (same as the shop; the
    v2.1.13 hide-A fallback applied), buttons Customize (128,89) / View Ship (128,144) = touch buttons ids 0x87 /
    0x88 (heap), back arrow (12,178) id 0x89 -> field; a held press shows the button pressed, the lift fires. The game
    takes no buttons on any shipyard screen. Customize = mode 0x15, COLL_PAGE 5; View Ship = mode 0x1f, COLL_PAGE 6
    (both collection modes: v2.1.39's collection keys ran there, e.g. Y tapped View Ship's zoom -). Customize is the
    Ship Parts panel class at 0x20fa32c (state word 0x20fa33c = SFN_GRID / SFN_LIST / SFN_INFO; slots +0xf0, all 8
    filled; list fields as the collection: +0x18 type, +0x1c row, rows y 87 + 26n, arrows (232,52/147)). Held slot
    lights (and the part on the top-screen ship). Parts list: Attach (72,176), Explanation (178,176), back (16,153);
    Attach shows the part, then the grid returns. View Ship: taps left (70,100) / right (180,100) of the ship turn
    it, zoom + (241,37), - (241,173), back (12,178) -> main menu.
  - coll_ctl: tab 2 = Customize (COLL_PAGE 5 with OVL 33; cl_state / cl_panel / cl_grid / cl_slots tables per tab).
    Differences: Up on the top row stays, Left/Right with nothing held hold a slot, B (after the let-go) taps the
    red back arrow, the game sees no A/B/D-pad; parts list A = Attach, X = Explanation. cl_sel grew a byte (CL_KEY 4,
    CL_BACK 5, CL_PASS 6, CL_TGT 8).
  - sy_ctl (chain after coll_ctl; OVL 33, msg_guard 0): main menu Up = hold Customize, Down = hold View Ship, A =
    lift (nothing held: tap the button held last, first Customize), B = let go + back arrow (leaves). View Ship:
    menu_tap per press: Left/Right turn, Up/Down zoom +/-, B back. pad_update's collection keys skip OVL 33.
  - CODE_RESERVE 0x3000 (debug 0x3200); dpad.bin 11661 bytes (627 free).
  Rig test (scratchpad hs.py into state 195): menu Down/Up move the pressed look, A opens; Customize Down = slot 0,
  Right x2 = Hull slot, A = Hull list, Down = scrolls to Tropical Ship (top-screen preview), X = Explanation, B =
  list, B = grid with Hull held again, B = main menu, B = field; Right with nothing held = slot 0, Up on top row
  stays; Tropical Ship + A = attached, grid back; View Ship Left/Right turn, Up/Down zoom, B = menu; menu Up + B =
  field. Fresh boot of the wip with the playthrough .srm (on another island, not Mercay): collection Select, A,
  Right = Ship Parts, Down, A = list, B, B = closed (mode 1).
  Not tested: real RetroArch; the shipyard from a fresh boot (the save is far from Mercay); Up/Down in a list with
  3+ owned parts.
  ROM: "Phantom Hourglass US - Button Controls v2.1.40-wip.nds", SHA-1 bb21c9380e0aa3df443d3bcc758dc24c9d8fbb60,
  CRC32 a8af3c49; save copied from the playthrough .srm. User state 195 holds v2.1.39 code: test from the in-game save.
  User test of wip (RetroArch, 2026-10-18): all checks passed; wanted Customize highlighted by default. Moved to builds\.
wip2: main menu auto highlight.
  - fs_btn records the Customize button (id SY_ID_CUST 0x87, OVL 33) in sy_tab (centre 128,83 + stamp). sy_ctl's menu
    waits until it is live; a new menu (sy_auto = 0) gets the stylus held on the button used last (first Customize),
    A locked CH_AUTO_LOCK pad reads. sy_auto is cleared off the menu (Customize: coll_ctl; View Ship; sy_no) and
    while the button is not live, so a return from Customize / View Ship holds that button again.
  - dpad.bin 11825 bytes (463 free).
  Rig test (hs.py, state 195): Customize held at once; A after the lock opens Customize; A 4 frames in is ignored;
  B from Customize = menu with Customize held; View Ship and back = View Ship held, A reopens it; leave, talk to the
  shipwright again: Customize held as soon as the menu shows (text still typing), next A opens it.
  ROM: "Phantom Hourglass US - Button Controls v2.1.40-wip2.nds", SHA-1 d1b6ea487d55e1dda5edfb5fc9f87bad84d912ab,
  CRC32 a641fcf6; save copied from the v2.1.40-wip .srm (newer than the playthrough .srm, 22:34 vs 22:31).
  User test of wip2 (RetroArch, 2026-10-18): all checks passed.
  Released as v2.1.40 on the user's request (builds\v2.1.40\: bps, xdelta, README, source zip; source rebuilt to
  the same SHA-1 first, patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the
  same SHA-1). Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.40.nds"; now the root playthrough
  ROM (wip2 moved to builds\). docs\README.txt updated (shipyard controls, change and testing lines). Save: the
  playthrough .srm was kept; the wip .srm files were not copied over it.

v2.1.41-wip (2026-10-18, rig tested; user test due): D-pad picks a sea on the four-seas screen from the Sun Crest
  note (Temple of the Ocean King; user state 232 = Link at the crest, made with v2.1.39: "cannot pick a sea").
  - Found (rig, state 232): Up + A on the crest = mode 0x37 with the text "Press the sacred crest against the sea
    chart..."; after the text, X (map note X) = the normal four-seas screen, mode 0x2c, sea ids as before (NW / SW
    owned). sc_ctl holds NW at once, but then the game stops updating the sea buttons while one is held: the stamps
    go stale, tab_live forgets them, and the D-pad target test (sc_live) failed for every sea, so Down stayed on NW.
    After a slide + new press the game updates the seas again. The menu bar / slate / note screens keep updating.
  - sc_ctl, D-pad target: owned = its sc_tab x != 0 (set once the sea was ever on screen; tab_live clears only the
    stamp), not sc_live. Clouded seas never get an entry, so they still stay. dpad.bin 11837 bytes (451 free).
  - Rig note: 0x023B3000 is in use in state 232; the code was linked rig-only at 0x023C3000 (zero there, also in
    states 126 / 160), hooks repointed (scratchpad rt.py = slate.py with STATE / RES 0x3000 / NEW changed).
  Rig test (state 232): crest, A x4, X = four seas, NW held; Down = SW held; A = SW chart (mode 4, Mercay sea); B =
  four seas, SW held; Up = NW; Right (NE clouded) = stays; Down = SW; Left (SE clouded) = stays; B = closed (0x29,
  then 0x37); B = field (mode 1). State 126 (slate): X, Down, A = chart, B, B = slate, X, B, B = sailing. State 160
  (land note): X, B, X, Down, A = chart, B, B, B = field. Fresh boot of the wip with the playthrough .srm: Select,
  Right, A = 0x2c, Down, A = SW chart, B = four seas, B = field.
  Not tested: real RetroArch; the crest puzzle itself (SW chart + lid close: L2 + Y in the melonDS DS core).
  ROM: "Phantom Hourglass US - Button Controls v2.1.41-wip.nds", SHA-1 6298721bf21d83f91478788fa5060e5e370aa694,
  CRC32 08cde6b0; save copied from the playthrough .srm. User state 232 holds v2.1.39 code: test from the in-game save.
  On release: README testing / change line (Sun Crest Sea Chart: D-pad picks a sea).
  User test of the crest deferred (2026-10-18): no quick way back to the crest; the user tests at the next Sun Crest
  or a similar crest / Sea Chart transfer spot.
  Released as v2.1.41 on the user's request, before that user test (builds\v2.1.41\: bps, xdelta, README, source
  zip; source rebuilt to the same SHA-1 first, patches made with mkpatch.py (both verified), xdelta re-applied with
  src/apply.py to the same SHA-1). Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.41.nds"; now the
  root playthrough ROM (wip moved to builds\). docs\README.txt updated (change and testing lines; the testing line
  says rig only). Save: the playthrough .srm was kept; the wip .srm was not copied over it.

v2.1.42-wip (2026-10-18, rig tested; user test due): treasure merchant on buttons (user request, state 235 = Mercay
  treasure merchant "What should I look at: ship parts or treasures?", made with v2.1.41).
  - Found (rig, state 235): mode 0x1a (SHOP_MODE), overlay 45 in the ov41-45 slot (word 0x027e0920 = MC_OVL_SLOT;
    0x027e091c = -1 inside, 33 outside on Mercay). ov45 bss 0x0218ed24 = merchant object; +0x148 / +0x14c = its
    Ship Parts / Treasure panels: the collection's panel classes (vtables 0x0218ea6c / 0x0218eb78), in the heap.
    COLL_PAGE follows the tab (3 / 4). Same grid (slots +0xf0 / +0xe0, entry +0x44, CL_X0.. geometry), same Ship
    Parts list (rows y 87 + 26n, arrows 232,52/147, +0x1c row shown). A held press on a list row draws it pressed; a
    slide to another row and lift cancels. Tabs Treasure (62,15) / Ship Parts (192,15) always on screen; Quit
    (128,178): grid = leave (mode 1, goodbye text), list = back to the grid. Opening an entry: intro text state
    (Ship Parts 0x0218ced8, Treasure 0x0218d8ac; taps ignored), then the Sell view (Ship Parts 0x0218d020, Treasure
    TFN_ITEM) with Sell (70,178) / Quit (185,178), the shop's Buy / Quit places. Sell sells one at once (no
    confirm): treasure -> grid, ship part -> list (the row stays, "x 0"; a 0-count entry still opens, Sell then
    gives nothing). Quit: treasure -> grid, ship part -> list. The equipped part says "That's basic..." and
    returns to the list by itself. No text box takes a press (msg_guard stays 0).
  - coll_ctl: tabs 3 / 4 = merchant Ship Parts / Treasure (cl_merch: mode, overlay, object and panel pointers in
    main RAM, panel vtable). Panel per tab now in r9 (cl_base for the fixed tabs, cl_soff slot offset); tables
    cl_slots / cl_state / cl_panel gone; cl_row uses r8. cl_sel: 5 slot bytes, CL_LOCK 5, CL_KEY 6, CL_BACK 7,
    CL_PASS 8, CL_TGT 10. Grid: as the collection, the game sees no A/B/D-pad; nothing held: Left / Right tap the
    Treasure / Ship Parts tab, B taps Quit (held slot: lets go, then Quit). List: a row is always held (first the
    row shown); Up/Down = previous / next part owned (CH_DRAG on screen; off screen: let go, arrow taps, then
    hold); A lifts = Sell view; B = Quit (held row: let go first). A / B / Up / Down during a move wait in cl_key.
    Sell view: A taps Sell (once per view: CL_LOCK, cleared on the grid / list), B taps Quit.
  - dpad.bin 12277 bytes (11 free of 0x3000): the next feature needs CODE_RESERVE raised.
  Rig test (scratchpad tm\mt.py: links dpad.o at 0x023C3000 into state 235 and repoints the hooks; fb.py: fresh boot):
  Ship Parts: Down = slot 0 lit, Right = slot 1, A = Anchor list (Normal Anchor held), Down stays, B = grid; Prow
  list Down = Drill Prow, A = Sell view, B = list (Drill Prow held), A, A = sold (+800, back to the list); Hull list
  Down = 2 arrow taps then Tropical Ship held, A, B, Up = 2 arrow taps, Standard Hull held. Treasure: Left = tab,
  Down = Pink Coral, Right = Dark Pearl Loop (empty slot skipped), A, A = sold (+150), grid with it held, Up = let go,
  Right = Ship Parts tab, Left = Treasure tab; A x3 fast in a Sell view = one sale (5 -> 4); Sell view B = grid;
  held slot B = leave; nothing held B = leave. State 195 (shipyard): Customize grid, Hull list, Down = Tropical
  Ship, A = Attach, B, B = field. Fresh boot of the wip with the playthrough .srm (Mercay, merchant's door): Up into
  the shop, A x3 = merchant screen; Down x2, A = Handrail list, B, A, A = equipped part message, Down = Worn
  Handrail (scrolls); B, B = field, A = goodbye text closes.
  Known: the game ignores taps on the tabs for ~1.5 s after the merchant screen opens (a stylus tap too), so a
  Left / Right that early is lost; press again.
  Found while testing (not fixed here, v2.1.40 regression): on Mercay's field OVL_SLOT 0x027e091c = 33 (the shipyard
  overlay), so pad_update's collection keys (Right / Left / B / Y page and tab chain) and coll_ctl's Treasure /
  Ship Parts slots are skipped there (v2.1.39 works). Fix idea: test COLL_PAGE >= SY_CUST instead of OVL_SLOT.
  ROM: "Phantom Hourglass US - Button Controls v2.1.42-wip.nds", SHA-1 6639df8ec35b044cad36be2f2ce9003d8d463c02,
  CRC32 8ccc7644; save copied from the playthrough .srm. User state 235 holds v2.1.41 code: test from the in-game save
  (it starts at the merchant's door).
  On release: README controls (treasure merchant) and change / testing lines.

v2.1.43-wip (2026-10-19, rig tested; user test due): v2.1.42-wip (treasure merchant) + fix of the v2.1.40
  regression above (collection keys and Treasure / Ship Parts slots dead on Mercay's field, where OVL_SLOT keeps 33).
  - dpad.s: shipyard screens are told apart by COLL_PAGE (SY_CUST 5 / SY_VIEW 6; the collection uses 2-4), not by
    OVL_SLOT. pad_update's collection-keys block: skip when COLL_PAGE >= SY_CUST. coll_ctl: tab 2 (page 5) =
    Customize (clears sy_sel SY_AUTO), tabs 0/1 = collection, else cl_no; no overlay test.
  - sy_ctl's OVL_SLOT test kept: rig peeks show OVL_SLOT 33 on Mercay's field and in the shipyard, -1 at the treasure
    merchant (state 235); shops load ov31 (SHOP_OVL). Mode 0x1a with OVL_SLOT 33 is only the shipyard menu (known).
  - dpad.bin 12241 bytes (47 free of 0x3000).
  Rig test: fresh boot of the wip with the playthrough .srm (Mercay, merchant's door; OVL_SLOT 33): Select, A =
  Items (page 2), Right = Ship Parts (3), Down, A = Prow list, B, Up, Right stays, Down, A = list, B, B = field.
  Second boot: Right = 3, Left = Treasure (4), Down, A = entry, B, Up, Left = Items (2), Y = swap (mode 0x1f).
  State 195 (mt.py, shipyard): wait, A = Customize (5), Right, Down, A = Handrail list, B, B = menu, Down, A = View
  Ship (6), Right turns, Up zooms (screen diffs), B = menu. State 235 (merchant): Down, A = Prow list, B; Left =
  Treasure tab, Down, A = Pink Coral sell text. (An A in the first pad reads of the shipyard menu is locked: design.)
  Not tested: real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.43-wip.nds", SHA-1 5ca76775c5477fd778a8d8f14ac0240aa4685c76,
  CRC32 ff7f8fb0; save copied from the playthrough .srm.
  On release: README change line (collection keys on Mercay fixed) plus the v2.1.42-wip lines.
  User test (RetroArch, 2026-10-19): Mercay collection keys and shipyard all pass; merchant all pass except A x3
  fast in a Sell view: A then did nothing (B, A and waiting for Sell / Quit worked). User request: Sell highlighted by
  default in the Sell view. Both done in v2.1.44-wip.

v2.1.44-wip (2026-10-19, rig tested; user test due): treasure merchant Sell view.
  - Cause of the A lock: the Sell view state (MC_SSELL / TFN_ITEM) starts with Sell / Quit sliding in (a count
    3 -> 0 in about 7 frames: Ship Parts panel +0x64, Treasure panel +0x54). A tap then is lost, but CL_LOCK was set,
    so no later A tapped Sell.
  - Found (rig): a held press on Sell draws it highlighted (lighter); the lift on it sells.
  - coll_ctl Sell view: wait while the count is not 0; then hold Sell (CH_HOLD, once per view: CL_LOCK set when the
    hold is placed). Held: A = CH_CONFIRM (lift = sell). B: Quit (a held Sell lets go first; shared tail cl_mquit
    with the list's B). Merchant A / B / Up / Down pressed while the stylus moves now wait in CL_KEY in the Sell view
    too (the SFN_LIST test there is gone). adr cl_grid -> ldr =cl_grid (out of adr range).
  - dpad.bin 12273 bytes (15 free of 0x3000).
  Rig test (state 235, mt.py): Treasure: Left, Down, A, wait = Sell held (ch_tap 01 at 70,178); A = sold (+1500,
  grid). Ship Parts: Prow list, Down = Drill Prow, A, wait = Sell held; B = list; A, wait = Sell held again; A = sold
  (x 0, list). A every 10 frames from the grid through a treasure sale: one sale (1449 -> 2949), then the 0-count entry
  opens again with Sell held, no second sale. Regression: fresh boot (collection Ship Parts list, Treasure entry, B, B
  closes) and state 195 (Customize list, View Ship) pass.
  ROM: "Phantom Hourglass US - Button Controls v2.1.44-wip.nds", SHA-1 30f3e68078f7f823a4d6d238e78ff87ba6d74584,
  CRC32 dd33660a; save copied from the playthrough .srm.
  On release: README merchant line (Sell held: A sells) plus the v2.1.42 / v2.1.43 lines.
  User report (RetroArch, 2026-10-19): in the merchant, A on the equipped part (the row shown when a list opens)
  only drew it selected: no text, no entry; B went back. Fixed in v2.1.45-wip.

v2.1.45-wip (2026-10-19, rig tested; user test due): first A on a just-opened parts list.
  - Cause (rig, state 235): the list opens on the equipped part (the row shown), and coll_ctl held that row at once.
    After the state turns SFN_LIST, the rows slide in for ~24 frames (5 row objects at panel +0x780 + n*0x180, each
    with counts; the last, panel +0x8a4, is 0 when they stop). A press placed then is not taken as a press: the lift
    (A) did nothing (the game only marked the row selected) and the code held the row again; the second A worked.
    (A one-read wait was tried first: not enough.)
  - coll_ctl parts list: ctl_done while [panel +0x8a4] != 0 (the row counter stays 0 while the list scrolls). Sell
    view lock test is now "CL_LOCK != SH_BTN_Y" (same meaning).
  - dpad.bin 12285 bytes (3 free of 0x3000).
  Rig test (state 235): Handrail list, one A = the equipped part's entry ("Gah! What's this?!"), back to the list by
  itself, Down = Worn Handrail (scrolls), A = Sell view with Sell held, B = list, A = Sell held, A = sold (+50, x 0).
  B, B from a list = leave. Known (v2.1.42): right after a list closes, the grid ignores keys while the merchant's
  text types again (a B then is lost: press again). Fresh boot (collection Ship Parts list, B, B) and state 195
  (Customize list, Attach, View Ship back, leave) pass.
  ROM: "Phantom Hourglass US - Button Controls v2.1.45-wip.nds", SHA-1 409fb4d8baddaf7971f8d32b29ba76c6d539de30,
  CRC32 09d74ece; save copied from the playthrough .srm.
  User test (RetroArch, 2026-10-19): all 6 checks pass (equipped part entry on one A, Sell held, B, sell, A x3 =
  one sale, B leaves). Earlier wips' user checks (Mercay collection keys, shipyard, merchant) also passed.
  On release: README merchant line plus the v2.1.42-44 lines.
  Released as v2.1.42 on the user's request (2026-10-19; builds\v2.1.42\: bps, xdelta, README, source zip). Source
  rebuilt to the same SHA-1 first; patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py
  to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.42.nds"; now the root
  playthrough ROM (wip moved to builds\). docs\README.txt: merchant controls, change lines (merchant, Mercay
  collection fix), testing line, known limitation (merchant ignores buttons ~1.5 s). Save: the playthrough .srm was
  kept; no wip .srm was copied over it. Note: release v2.1.42 = wip v2.1.45-wip (the wip numbers ran ahead).

v2.1.46-wip (2026-10-19, rig tested; user test due): Salvage Arm on buttons (user approved the design; research in
  the Future list entry).
  - Found (rig, state 241): salvage = MODE 0x22 (SALV_MODE) at sea; FISH_SEA is 0 there too, so fish_ctl already
    took the keys (B / Select tapped its quit arrow (16,178) = the salvage back arrow: why B "already worked").
    [SEA_CTL] (0x021f7340 here) + 0x13a4 = s16 handle x - 128, -50..50; +0x13ac knob 3 centre / 4 up / 5 down
    (+0x13a8 stylus y offset, clamped +/-10). A press on the bar away from the handle does not grab it.
  - sv_ctl (fish_ctl branch after the keys are hidden, MODE == SALV_MODE): held D-pad = stylus via fg_x / fg_y; the
    first read presses on the handle (128 + [+0x13a4], 174), then x = handle -/+ SV_STEP 3 per pad read for Left /
    Right, y 144 (Up) / 189 (Down) / 174. A = slide back to the centre (fg_dx = 1; Left / Right cancel). B / Select
    = back arrow. Nothing held = stylus up (the handle stays). A text box ends it through msg_guard as for fishing,
    but Linebeck's salvage comments never set msg_guard (rig), so the keys work under them.
  - CODE_RESERVE 0x3200 (was 0x3000; debug 0x3400). dpad.bin 12537 bytes (263 free).
  Rig test (scratchpad sv.py = mt.py on state 241, code linked at 0x023C3000, hooks repointed): Left 20 frames ->
  handle -27, held -> -50; Right 30 -> -5; Down = knob 5, Up = knob 4, let go = knob 3, handle kept; A = 0 within
  10 frames; Down+Left = -50 and knob 5; B = mode 1 (sailing); a full fast dive under the comments: keys work to
  the end (the arm broke, back to sailing, stylus up). Not seen: a full climb with the treasure (Up / Down = knob
  only, whatever the game does with it). Fresh boot with the playthrough .srm copy: boots to sea, runs.
  ROM: "Phantom Hourglass US - Button Controls v2.1.46-wip.nds", SHA-1 bc27edc7e1d664ad8d4300ba643bd903e0419f0d,
  CRC32 bbdf5433; save copied from the playthrough .srm. On release: README salvage control line.
  User test (RetroArch, 2026-10-19): down to the treasure, all buttons worked.
  Released as v2.1.43 on the user's request (2026-10-19; builds\v2.1.43\: bps, xdelta, README, source zip). Source
  rebuilt to the same SHA-1 first; patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py
  to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.43.nds"; now the root
  playthrough ROM (wip moved to builds\). docs\README.txt: salvage control lines, change line, testing line. Save:
  the playthrough .srm was kept; no wip .srm was copied over it. Release v2.1.43 = wip v2.1.46-wip.

v2.1.47-wip (2026-10-19, rig tested; user test due): collection Items page on the D-pad, L / R turn pages (user request,
  states 236 = Items normal layout, 237 = swapped; plan approved by the user).
  - Found (rig): COLL_PAGE 1 = Fishing Journal ("<" from Items). The Items page shows an item's name only while the
    stylus is held on it (label widget 0x020fae20, byte +0x5c = 1 while shown); a short tap shows nothing.
    Item list (ov3 data, the same at sea): IP_LIST 0x020fa1f0 (vtable 0x020f6a0c), +8 = next, 27 nodes: 17 spirits
    half, then 10 hourglass half. Node +0x10 = layout, +0x44 = element (-1 = empty), +0x5b = 1 while its half is on
    the top screen. The game's touch test ov9 thumb 0x02113ff8 = rect test 0x02034b4c(layout, element, touch - offset);
    "can be touched" = 0x02113fa0 (owned, half on the bottom, not sliding). Centre = CellPos(+0x10, +0x44) + (+0x1c,
    +0x20) fx, plus (with +0x5e clear) the page offset 0x0211f4a0 +4 / +8 (y -20 px while swapped at our pad read; it
    flips -20 / +20 per frame there). 0x0211f4a0 +0xc = 1 while the screens slide; a tap is still ignored ~12 frames
    after it clears (rig, delay.py).
  - ip_ctl (pad_update chain after coll_ctl; Items page only): D-pad = stylus held on an item (CH_HOLD, moves
    CH_DRAG): first press = last item on this half, else the first touchable; move = nearest touchable item that way
    (along >= IP_MIN 4 px, score along + 2 x across; none = stay). D-pad hidden from the game and the collection block.
    Other keys while held: let go (ctl_off), then passed (ip_pass): B closes, Select closes, Y swaps; A does nothing.
    A D-pad press while nothing can be touched (screens sliding) waits in ip_key. Swapped layout (no arrows): L / R
    = Y, then the arrow once the spirits half is down, +0xc clear, y offset 0, plus IP_SETTLE_READS 8 (ip_pend /
    ip_pwait, flag 0x80; dropped after IP_PEND_READS 40).
  - pad_update collection block: L / R count as Left / Right on every collection page (Fish: R = ">"; Items: L "<" /
    R ">"; Treasure: L "<" / R Ship Parts tab; Ship Parts: L Treasure tab). D-pad Left / Right on Fish / page 2 unchanged.
  - CODE_RESERVE 0x3600 (was 0x3200); dpad.bin 13429 bytes (395 free).
  Rig test (fresh boot of the wip with the playthrough .srm copy; boots at sea, collection = mode 0x15; scratchpad
  ip1.py): Select, A, Down = Spirit of Power held (name shown), Right = Wisdom spirit, Right = Power Gem, Down = Treasure
  Map, Left = Power Gem, Up = Courage Gem, Up = stays; Right x4 reaches the right column item. Y with an item held =
  let go + swapped (0x1f); Down 40 frames later = hourglass held, Right = shield. Swapped: R = back + page 2 (Ship
  Parts), L = Fish. L (Items) = Fish, R = Items, R = page 2, L / R tabs, L on Treasure = Items, Down on Treasure = slot
  held (coll_ctl). A held = nothing; B held = closed (mode 1); Select held = closed.
  Not tested: on land (same addresses expected: state 236 was on land, its nodes match), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.47-wip.nds", SHA-1 311d5a529a7aa19db777a453e6575f10c2eb4c6d,
  CRC32 f86c423f; save copied from the playthrough .srm.
  User test (RetroArch, 2026-10-19): all checks passed (Items D-pad and names, both halves, Y, L / R chain, swapped
  L / R, B; land and sea).
  Released as v2.1.44 on the user's request (2026-10-19; builds\v2.1.44\: bps, xdelta, README, source zip). Source
  rebuilt to the same SHA-1 first; patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py
  to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.44.nds"; now the root
  playthrough ROM (wip moved to builds\). docs\README.txt: L line, collection L / R and Items D-pad control lines,
  change line, testing line. Save: the playthrough .srm was kept; no wip .srm was copied over it. Release v2.1.44 =
  wip v2.1.47-wip.

v2.1.48-wip (2026-10-19, rig tested; user test due): Y = Memo / Erase toggle on a map (user request after the Memo /
  Erase research in the Future list).
  - Found (rig, state 126 sea chart; RAM diff pen / eraser): the map's Memo button object (touch button, vtable
    0x020e893c, id MEMO_ID 0x18; Erase 0x19 is the next object, +0x18) has byte MM_SEL +0x60 = the tool in use
    (0x18 pen / 0x19 eraser; heap 0x021fddc8 there, halfword pair). Same layout on the land Map (rig).
  - fs_btn: ids 0x18 / 0x19 in MAP_MODE go to mm_tab (x, y, stamp; Memo's entry byte 3 = MM_SEL). mm_ctl (pad_update,
    after back_ctl): new Y with the target button live (tab_live) = Y hidden from the game, menu_tap on Erase when the
    pen is in use, else on Memo. Drawing stays stylus only. dpad.bin 13621 bytes (203 free of 0x3600).
  Rig test (fresh boot of the wip with the playthrough .srm copy; land, Mercay dock): Select, Right, Right, A = Map
  (mode 4); Y = Erase lit; drag = nothing drawn; Y = Memo lit; drag = line; Y = Erase lit, drag over it = erased;
  stylus Erase, then Y = Memo lit; B = field (mode 1); Y in the field = no change.
  Not tested: a sea chart with this build (state 126 holds old code; MM_SEL was found there), dungeon maps, real
  RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.48-wip.nds", SHA-1 38164b0ec9f833d499e1b120795c0e88ffc6e4f3,
  CRC32 7fdb8fac; save copied from the playthrough .srm. Moved to builds\ when v2.1.49-wip was made (it has all of it).

v2.1.49-wip (2026-10-19, rig tested; user test due): game over screen on buttons (user approved the save-menu
  design; research in the Future list).
  - fs_btn: ids GO_ID0 0x53 (Continue) / 0x54 (Save and Quit) go into smenu's slots 0 / 1 (button pointer, y offset
    SM_OFFY, SM_SEEN), as smenu_btn does for the save menu, so smenu_ctl drives them: Continue held at once, Up / Down
    switch (wrap), A lifts = fires; B lets go (no fire). Slots 1 / 2 are not cleared (no alternative button here).
    dpad.bin 13661 bytes (163 free of 0x3600).
  Rig test (fresh boot of the wip with the playthrough .srm copy, Mercay dock; potions poked 0, health 1, bomb set
  down = game over; scratchpad go49.py / go49b.py): Continue lit at once; Down = Save and Quit; Up = Continue; Down,
  Down = Continue (wrap); A on Continue = Mercay respawn, walks; Down, A = "Save your progress?" (choice_ctl), Down,
  A = No -> "End the game?"; B = nothing held, then Down = Continue held, A = respawn. Select > Save (Left, A): Yes
  = "Save complete.", field after; no regression seen.
  Not tested: Yes / End the game to the title, game over at sea or in a dungeon (same screen expected), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.49-wip.nds", SHA-1 6cdf9997701affb7b16e641b1ec650b8c22e27a4,
  CRC32 1eb7d8c9; save copied from the playthrough .srm. Moved to builds\ when v2.1.50-wip was made (it has all of it).

v2.1.50-wip (2026-10-19, rig tested; user test due): Sea Chart screen D-pad moves over seas AND islands (user state
  266, at sea, v2.1.44: "Down selects SW; Up selects the Isle of Gust and I can't select anything else").
  - Cause (rig, state 266): the NW hold point (sea centre 64,48) lies on the Isle of Gust's touch rect, so the game
    showed the island's name and A opened the island map; Up / Down only flipped the row (NE / SE clouded).
  - Found (rig + disassembly): the four-seas screen (mode 0x2c) update is 0x020f8de8 (object = heap block of 0x250;
    hover word +0x248 = island index, -1 = none). Islands: 16 slots, island = 0x0209d878([0x027e0f7c], i); a slot is
    pickable if +0x14 and 0x020a3f60(island) and its sea is owned (0x020ada18); centre = sea origin (table 0x020e508c,
    x / y per sea 0 SW, 1 NW, 2 SE, 3 NE) + island +8 / +0xc halved. Each pickable island has a touch button (vtable
    0x020e893c, ids 0x23 + slot, cell 0xdb, element 0xff); vtable [1] (0x020cfebc) subtracts the cell anchor
    (0x02034654(cell, signed +0x10)) from the centre and calls [0] = fs_btn. Rects 33 x 33 (small isles 17 / 13).
    The loop stops after a held island (the later islands and the seas are not updated while one is held).
    A press-slide-lift between seas / islands cancels (no chart / map opens).
  - fs_btn: ids IS_ID0 0x23.. (IS_COUNT 16) in SC_MODE -> is_tab (right after sc_tab: objects 0-3 seas, 4-19
    islands), centre = CELL_ANCHOR result + offset. sc_shut clears the is_tab x bytes (x = 0: not seen).
  - sc_ctl: D-pad = nearest seen object that way (along + 2 x across from the held one's centre, along >= SC_MIN 4;
    none = stay), slide / lift / press (CH_DRAG). sc_pt: an island is held at its centre; a sea at its centre, else the
    first sc_alt point clear of every seen island (SC_ISLE_R 18). sc_last = object index. B slides to the opposite
    sea's centre (from the held object's centre). CODE_RESERVE 0x3800 (was 0x3600); dpad.bin 14113 bytes (223 free).
  Rig test (fresh boot of the wip with the playthrough .srm copy, Mercay dock; scratchpad sc50.py): Select, Right, A =
  four seas, NW lit at (64,84), no label. Up = Zauz's Island; Up = stays; Down = NW; Down = Isle of Gust; Down = SW
  lit; Down = Cannon Island; Right = Isle of Ember; Left = Cannon. A on Gust = island map (mode 4); B = four seas,
  Gust held; B = field. A on NW = NW chart; B = back, NW held. A on SW = SW chart. Up from SW = island; B = field.
  Not tested: at sea (same screen expected), Sun Crest note / Cyclone Slate / land note X entries (states hold old
  code), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.50-wip.nds", SHA-1 dc7390b66698d8f926dc5877ae809342aa2c8a45,
  CRC32 765d9309; save copied from the playthrough .srm. Built from dpad.s with v2.1.48 + v2.1.49 in it (checked:
  build_v2.py differs from v2.1.44 only by CODE_RESERVE). docs\test-checklist.md now names this ROM for all
  three pending sections (v2.1.48, v2.1.49, v2.1.50).
  User test (RetroArch, 2026-10-19): all checklist sections passed (v2.1.48 Y toggle, v2.1.49 game over,
  v2.1.50 Sea Chart seas and islands).
  Released as v2.1.45 on the user's request (2026-10-19; builds\v2.1.45\: bps, xdelta, README, source zip).
  Source rebuilt to the same SHA-1 first, and again from the extracted source zip; patches made with mkpatch.py
  (both verified), xdelta re-applied with src/apply.py to the same SHA-1. Release ROM builds\"Phantom Hourglass US
  - Button Controls v2.1.45.nds"; now the root playthrough ROM (wip moved to builds\). docs\README.txt: Sea Chart
  D-pad / A lines, Y map line, game over line, L line (Y no longer closes the map), change section, testing line.
  docs\test-checklist.md emptied. Save: the playthrough .srm was kept; no wip .srm was copied over it. Release
  v2.1.45 = wip v2.1.50-wip (includes v2.1.48-wip and v2.1.49-wip).

v2.1.51-wip (2026-10-19, rig tested; user test due): statue turn screen, Left / Right turn the statue (user state 292
  = a stone statue close-up, two yellow turn arrows, Back lower left; made with the root playthrough ROM).
  - Found (rig, state 292): mode 0x37 (NOTE_MODE, as the map notes). B already worked (Back = id 0x45, bk_tab). The
    arrows are not touch buttons: a stylus tap at (104,135) turns the statue left, (151,135) right; one tap = one
    30-degree step (~36 frames); a held touch does not repeat. Statue object (ov32 vtable 0x02185ba4, heap 0x0225e584
    there): +8 state 12 idle / 13 turning, +0xc u16 angle. The D-pad did nothing there. Taps at both points on the map
    note states 59 / 160 / 165 change only the touch-input block (mode stays 0x37), so no screen test is needed.
  - pad_update map note block (label 4): in NOTE_MODE with no menu_tap running, a new X, Left or Right is hidden from
    the game (PAD +2) and menu_tap_at taps: X = (NOTE_CHART_X, NOTE_CHART_Y) as before, Left = (STATUE_L_X 104,
    STATUE_Y 135), Right = (STATUE_R_X 151, STATUE_Y). A press while a tap runs is passed on (the game ignores it):
    press again after the turn. dpad.bin 14141 bytes (195 free of 0x3800).
  Rig test (scratchpad st51.py: links dpad.o at 0x023B3000 into the old states, repoints all hooks + the fs_btn
  vtable word): state 292 Left = 0xeaab, Right = 0, Right = 0x1555, B = field (mode 1). States 160 / 59: Left / Right
  = mode stays 0x37, X = four seas (0x2c); state 165: X = map (4). Fresh boot of the wip with the playthrough .srm
  copy: field (mode 1).
  Known, not changed (old build the same): A on the statue screen turns the statue left (the A probe taps land on
  the left arrow).
  Not tested: other statues (same screen expected), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.51-wip.nds", SHA-1 c1eda57f57bc8ed7fcb1b7c414c06703d645a118,
  CRC32 8e222fb4; save copied from the playthrough .srm. Moved to builds\ when v2.1.52-wip was made.
  User test (RetroArch, wip state 1): Left once, then Right twice, then nothing more; a full 360 (12 steps either
  way) is needed. Fixed in v2.1.52-wip.

v2.1.52-wip (2026-10-19, rig tested; user test due): statue turns a full 360 with Left / Right (replaces v2.1.51's
  fixed tap points).
  - Cause (rig, v2.1.51-wip state 1, statue at 0x9555): the arrows turn with the statue, and the game turns it toward
    the side of a tap measured from the line through its face (tap sweep at radius 20 / 41 / 60 from (128,101): one
    half-plane +0x1555, the other -0x1555, on the line nothing). Fixed points change sides as the statue turns.
  - Found: object manager [0x027e0f68] (OBJ_MGR): +0xc = pool of object pointers, +0x10 = count (0x89 there). The
    examined statue = vtable STATUE_VT 0x02185ba4 (ov32, OVL_SLOT 32) with +8 = 12 (ST_IDLE) or 13 (turning); other
    objects of that class there have 0 / 3; after B it is 5. +0xc = u16 facing, 0 = face down the screen, direction
    (sin a, cos a). The game ignores a tap in the first read(s) after a turn ends (rig trace: tap 1 read after idle
    = nothing, ~4 reads after = turn).
  - st_ctl (pad_update, after the map note X): in NOTE_MODE, st_find walks the pool (OVL_SLOT 32 only, pointers
    0x02000000-0x023bffff). No statue: nothing (map notes keep the keys). Statue: Left / Right hidden from the game; a
    new press waits in st_pend; turning sets st_wait = ST_SETTLE 4 reads; idle, st_wait 0, menu_tap free and a key
    waiting or held = menu_tap_at 90 deg off the face from the step index round(a * 12 / 0x10000) and the st_cos table
    (R 40): Left = (128 - cos, 101 + sin) = facing -0x1555 (clockwise on the screen, the left arrow at the start),
    Right = the opposite point. Held key = one step per turn (~41 frames).
  - CODE_RESERVE 0x3A00 (was 0x3800); dpad.bin 14493 bytes (355 free).
  Rig test (scratchpad s3.py: links dpad.o at 0x023B3000 into the old states, repoints all hooks + the fs_btn vtable
  word): state 1 Left x12 = every step back to 0x9555 (60 frames apart); Right x12 the same the other way; 3 Lefts 8
  frames apart = 2 steps (the last two share st_pend); Left held 250 frames = 6 steps; Right, Left = start; B = field.
  State 292: Left x2 = 2 steps. States 160 / 165 / 59: no statue found, Left / Right = no change, X = four seas / map.
  Fresh boot of the wip with the playthrough .srm copy: field.
  Not tested: other statues / islands (other overlays would need STATUE_OVL / STATUE_VT), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.52-wip.nds", SHA-1 2cee9d4fd29630919fec7bf017a7365557d88ae5,
  CRC32 186a7970; save copied from the playthrough .srm.
  User test (RetroArch, 2026-10-19): "everything works" (full turns both ways).
  Released as v2.1.46 on the user's request (2026-10-19; builds\v2.1.46\: bps, xdelta, README, source zip). Source
  rebuilt to the same SHA-1, and again from the extracted source zip; patches made with mkpatch.py (both verified),
  xdelta re-applied with src/apply.py to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls
  v2.1.46.nds"; now the root playthrough ROM (wip moved to builds\). docs\README.txt: statue Left / Right control
  line, change section, testing line. Save: the playthrough .srm was kept; no wip .srm was copied over it. Release
  v2.1.46 = wip v2.1.52-wip.

v2.1.53-wip (2026-10-19, rig tested; user test due): dungeon map floors on Up / Down (user state 297 = dungeon map,
  "1F" floor button lower left, two floors 1F / B1; made with the root playthrough ROM v2.1.46).
  - Found (rig, state 297): the floor button = touch button id FLOOR_ID 0x1b (cell 0xbf el 2, (15,129)); a tap opens
    the floor list (mode 8, or 10 while it slides in; Memo / Erase hidden). The list = ids 0x37..0x3c (cell 0xc1 el
    1..6, x 15, y 36 + 17 per place; 1F = 0x3a (15,87), B1 = 0x3b (15,104)); only floors shown are updated. Ids 0x35 /
    0x36 (el 7 / 8, (15,18) / (15,139)) are always updated: list arrows (scroll?), not used. A floor tap shows that
    floor, the list stays open; a tap on the map closes it (mode 4); B closes the map. Map screen object = [0x027e07c0]
    (MAP_OBJ, vtable 0x021006e8 here; same word as ROUTE_OBJ): u16 +0x560 = 2 (floor count?), +0x562 (FL_SEL) = floor
    shown, 0x1a 1F / 0x1b B1 = list id - 0x20. The clean game closes the map on Up / Down (any key).
  - fs_btn: ids 0x1b and 0x37..0x3c in modes 4 / 8 / 10 -> fl_tab (entry 0 = button, 1.. = places). fl_ctl (pad_update,
    after mm_ctl): Up / Down with the shown floor's place live (list open) or the button live (closed) = hidden from
    the game; open: menu_tap on the next place that way if live; closed: tap the button, the target waits in fl_pend
    (FL_WAIT 20 reads) until its place is live. CODE_RESERVE 0x3C00 (was 0x3A00); dpad.bin 14933 bytes (427 free).
  Rig test (scratchpad fl6.py: links dpad.o at 0x023B3000 into state 297, repoints the hooks + fs_btn vtable word):
  Down = list + B1; Down = no change; Up = 1F; Up = no change; Down = B1; map tap = list closed (mode 4); Up from closed
  = list + 1F; B = map closed (to the note, mode 0x37); Up at the top floor = list opens, no change; Down twice 8
  frames apart = B1. Fresh boot of the wip with the playthrough .srm copy (saved in the dungeon, only 1F known):
  Up walks; Select, Right, Right, A = map; Down = list with only 1F, no change; Up = map stays; B = field.
  Not tested: a dungeon with more than 6 floors (Temple of the Ocean King: the list may scroll, and fl_ctl assumes
  place = FL_SEL + 0x20), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.53-wip.nds", SHA-1 5e52d5bc03b1948c8afc7f675a335f8c81ff6b6d,
  CRC32 eb84a23d; save copied from the playthrough .srm. Moved to builds\ when v2.1.54-wip was made (it has all of it).

v2.1.54-wip (2026-10-19, rig tested; user test due when a statue comes up): A no longer turns the statue (user OK'd
  the fix; "it will be a while before I see more statues"). Built on v2.1.53-wip's dpad.s (has the dungeon map floors).
  - Cause (v2.1.51 rig notes): on the statue turn screen the field A taps land on the bottom screen, on the left-turn
    side; old builds did the same.
  - st_ctl: with the statue found and no text box (ch_seen 0, msg_guard 0), A is hidden from the game too (PAD +0 and
    +2; a text box keeps A so it still advances). Left / Right: as v2.1.52 (only new presses hidden; held ones stay in
    PAD +0 for the repeat).
  - dpad.bin 14985 bytes (375 free of 0x3C00).
  Rig test (scratchpad s3.py, code linked at 0x023B3000 into the old states): v2.1.51 state 1: A, A held 30 frames =
  no turn, then Left = 1 step; state 292 A = no turn; all v2.1.52 checks again (12 Lefts / 12 Rights = full turns, 3
  fast Lefts = 2 steps, held 250 frames = 6 steps, B = field, map notes 160 / 165 / 59: Left / Right no change, X
  works). Fresh boot with the playthrough .srm copy: boots at sea now (mode 0x11, sailing; v2.1.46 and v2.1.53 the
  same, the save moved on).
  Not tested: a text box on the statue screen, real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.54-wip.nds", SHA-1 1776672c102711b91905c8ee524126a8d1978c32,
  CRC32 64a5eae1; save copied from the playthrough .srm.
  Released as v2.1.47 on the user's request (2026-10-19; builds\v2.1.47\: bps, xdelta, README, source zip) before a
  user test of v2.1.53 / v2.1.54 (the user confirmed the release has the dungeon floor keys). Source rebuilt to the
  same SHA-1 first, and again from the extracted source zip; patches made with mkpatch.py (both verified), xdelta
  re-applied with src/apply.py to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls
  v2.1.47.nds"; now the root playthrough ROM (wip moved to builds\). docs\README.txt: Up / Down dungeon floor line,
  statue line (A does nothing), change section, testing line (test setup only; > 6 floors untested). Save: the
  playthrough .srm was kept; no wip .srm was copied over it. Release v2.1.47 = wip v2.1.54-wip (includes v2.1.53-wip).

v2.1.55-wip (2026-10-19, rig tested; user test due): with the bow out the D-pad no longer shoots (user state 361 =
  field, bow out, 50 arrows; user: "all button presses cause it to fire instead of just A").
  - Found (rig, state 361): Up / Right press = 1 arrow each; Down held 46 frames = 2 arrows, Link stands still. X, Y,
    Select: none (B = Put Away, item_ctl). So only the D-pad.
  - Cause (ov056 = the bow, disassembled from the state's RAM): LinkStateItem bow update 0x0219907c asks PlayerControl
    0x020b0df4 for an aim point; with touch ctl +0x58 > 0x18000 (dpad_move's fake far stylus, 0x5f0000) it aims along
    +0x6a and draws (EquipBow 0x02198e48); 5+ frames later with no real touch (0x020af3cc = 0) it shoots (0x02198ea8).
    The bow state has no walk: a stylus touch there aims too.
  - dpad_move: Link's state = the item state with +0x14 = IT_BOW (5) -> only last_oct / DIR_AGE and it_oct (world
    octant of the D-pad way) are set; nothing goes to the touch ctl. A (it_use) shoots that way, also after DIR_FRESH.
  - dpad.bin 15057 bytes (303 free of 0x3C00).
  Rig test (scratchpad hot.py: links dpad.o at a zero range found by a scan, 0x023B4000, into state 361 and repoints
  the hooks + fs_btn vtable word): Up, Right, Down held 46 frames = still 50 arrows; Right, A = 49, arrow goes right;
  Left, 90 frames, A = 49, Link shoots left; B = bow put away, then Down walks. Fresh boot of the wip with the
  playthrough .srm copy: file select, Start = at sea (sailing), no crash.
  Not tested: other items with the D-pad (unchanged code path), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.55-wip.nds", SHA-1 d173e7ddc6542c318b760c611254275102e74537,
  CRC32 6a64e829; save copied from the playthrough .srm.

v2.1.56-wip (2026-10-19, rig tested; user test due): hold A rub also in a sword clash (user state 360 = Jolene on
  Linebeck's ship, swords locked, "RUB!" bubble with a left-right arrow; made with the root playthrough ROM).
  - Found (rig, state 360): LINK_STATE -> 0x02261158 = the held state 4 (vtable 0x020e6060) with sub-state +4 = 8
    (the sand monster grab is 6), so the v2.1.38 rub never started. The +0x10 timer stays 0 here. No input: the
    clash ends at frame ~190 with Link pushed back (state 0x2260fa4, then 0x2260d54). Stylus tests from load: flat
    x strokes (+/-40, +/-80, 2-6 frames a side, smooth sweeps) never count; diagonal strokes (+/-24 x, +/-2..10 y,
    2-3 frames a side) win at frame 80-100 (Link knocks Jolene back, straight to 0x2260d54); 1 frame a side fails.
    Same rule as the sand monster: diagonal strokes count.
  - fg_off: sub-state LS_CLASH_SUB 8 accepted as well as LS_HELD_SUB 6 (one cmpne); stroke unchanged.
  - dpad.bin 15061 bytes (299 free of 0x3C00). Built on top of v2.1.55-wip's dpad.s.
  Rig test (scratchpad clash2.py: state 360 holds v2.1.45 code, so its fg_off "cmpeq r1, #6" at 0x0219dfcc was
  poked to #8): A held from load = Link wins the clash at frame 75 (unpoked: loses at 190). Fresh boot of the wip
  with the playthrough .srm copy: file select, Adventure, save loads at sea, A / D-pad sea controls, no crash.
  Not tested: the full v2.1.56 code in the clash (rig poke only), the sand monster regression (no usable state),
  real RetroArch.
  Note: v2.1.54 / v2.1.55 were taken by other sessions; a first build of this change named v2.1.54-wip in the root
  was deleted (builds\ v2.1.54-wip and its .srm are the other session's, untouched).
  ROM: "Phantom Hourglass US - Button Controls v2.1.56-wip.nds", SHA-1 397cfa2ad38ff52f18acdcae0653151512570a5c,
  CRC32 2e664db6; save copied from the playthrough .srm.

v2.1.57-wip (2026-10-19, rig tested; user test due): magic box screen on buttons (user state 363 = the magic box
  man's Treasure / Ship Parts screen, three star boxes; made with the root playthrough ROM v2.1.47). Built on top of
  v2.1.56-wip's dpad.s (has v2.1.55 + v2.1.56).
  - Found (rig, state 363): mode 0x15 (in_coll), MC_OVL_SLOT 45, MC_PTR 0. The collection screen with new pages:
    COLL_PAGE 7 = Ship Parts, 8 = Treasure (coll_ctl took tab 4 / 5 = cl_no; pad_update's collection keys skip
    page >= SY_CUST), so no key worked. [COLL_OBJ 0x0211f4a0] = the collection object (0x021b61e0 there); +0x310 /
    +0x314 = Ship Parts / Treasure panel (heap 0x020f71c4 / 0x020f86ac; ov45 vtables MB_SVT 0x0218ec54 / MB_TVT
    0x0218e5a0). Panel states, slots, list rows / arrows: as the collection. Grid: tabs (62,15) / (192,15), red back
    arrow (12,178) = leave. Treasure entry: back arrow (16,153), Stow (218,176); a slide-in count at panel +0x54
    (3 -> 0, as the merchant). Ship Parts list: a tapped non-equipped row shows Stow (72,176) / Explanation
    (178,176) = the shipyard's Attach / Explanation places; the equipped row has Explanation only. Stow puts the
    item in the box at once (no confirm) and closes the screen (mode 0x17, then the field).
  - coll_ctl: tabs 5 / 6 = magic box Ship Parts / Treasure (cl_magic shares the owner / panel / vtable checks with
    cl_merch: r9 owner, r10 panel offset, r1 vtable table, r3 first tab; mc_vt now holds 4 vtables). Merchant-only
    list tests are now "tab == 3" (were ">= 3"). Grid: as the merchant; B taps the red back arrow. List: as the
    collection list, then A = Stow, X = Explanation (shipyard branch), B = back arrow. Treasure entry: the merchant
    Sell-view code with Stow (MB_STOW_X / Y) held once settled, A lifts = Stow, B = back arrow; cl_mquit now takes
    r2 / r3. cl_sel: 7 slot bytes, CL_LOCK 7, CL_KEY 8, CL_BACK 9, CL_PASS 10, CL_TGT 12. cl_near moved before
    cl_grid (adr range).
  - dpad.bin 15177 bytes (183 free of 0x3C00).
  Rig test (scratchpad hot.py: links dpad.o at a zero range, 0x023BB000, into a state, repoints the 9-11 hooks + the
  fs_btn vtable word; mb.py / reg.py): state 363 Ship Parts: Down = slot 0, Right x2 = slot 2, A = Hull list, Down =
  Bright Hull (Stow shown), X = Explanation, B = list, A = stowed (mode 0x17); Down x2 / Up rows, B = grid, B = let
  go, B = leave. Prow list (equipped part shown): A = nothing, X = Explanation, B, B. Treasure: Left = tab, Down,
  Right, A = entry, Stow held (lit); B = grid (slot held again); A = entry; A = stowed. Grid B with nothing held =
  field. Regression: state 235 merchant Treasure Sell held, B = Quit -> grid; state 195 shipyard Customize list, B,
  B = menu; fresh boot of the wip with the playthrough .srm copy (route screen B, Select, A = Items, R = Ship Parts,
  Down, A = list, B, B, B = closed).
  Not tested: real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.57-wip.nds", SHA-1 7fa1bd2ee32ae9c611d9b47136333b889f2a5426,
  CRC32 c245d876; save copied from the playthrough .srm.
  Released as v2.1.48 on the user's request (2026-10-20; builds\v2.1.48\: bps, xdelta, README, source zip) before a
  user test of v2.1.55 / v2.1.56 / v2.1.57. Source rebuilt to the same SHA-1 first, and again from the extracted
  source zip; patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the same SHA-1.
  Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.48.nds"; now the root playthrough ROM (v2.1.55-57
  wips moved to builds\). docs\README.txt: bow, clash rub and magic box lines, change section, testing line (test
  setup only). Save: the playthrough .srm was kept; no wip .srm was copied over it. docs\test-checklist.md now
  tests the root ROM. Release v2.1.48 = wip v2.1.57-wip (includes v2.1.55-wip and v2.1.56-wip).
  User test of release v2.1.48 (2026-10-20, RetroArch): magic box (v2.1.57) all checks pass; bow (v2.1.55) all
  pass; statue A (v2.1.54) all pass; sword clash (v2.1.56) still due (waiting for Jolene). Dungeon map floors
  (v2.1.53) FAIL: Up / Down close the map. User state 373 = dungeon map with several floors (root ROM v2.1.48).

## Finished future feature requests (moved from HANDOFF.md)

- (v2.1.67-wip, see above) Cutscene Skip on Start (user, 2026-10-21): in a scene where Start shows "Skip >>", a second Start taps Skip. No
  other button may skip. Rig research (2026-10-21, no build; root ROM = v2.1.56, NO battery save = new file):
  - Path to the opening story: run 900, touch (128,100) (title), run ~700 ("A file has been created."), A, A =
    name entry ("melonDS" prefilled), touch OK (210,180), A (Yes), A (Right hand), A (Yes), A = file list, A, A, A
    = story ("Our story begins not long ago.."). Start there = "Skip >>" at the bottom-screen top right.
  - Skip = touch button vtable 0x020e893c, id 0x8f, cell 0x36, two elements (heap 0x21ce900 / 0x21ce918 here; the
    objects exist before Start too). A held stylus at (228,10) = touch mgr [[0x27E103C]] +0x1c = 0x8f, the lift
    skips the story. Skip hides itself after ~5 s; while hidden a tap at (228,10) hits nothing, so the hit test
    (fs_btn's hook) runs only while Skip shows. No RAM "shown" flag found (main RAM + DTCM diff).
  - Clean game, second Start while Skip shows: Skip goes away, no skip. Start reached the game here, so the
    gate did not strip it. Our A text tap (128,168) and the field probes do not reach (228,10).
  - Design: fs_btn stamps id 0x8f (pad read, as SM_SEEN); new skip_ctl in pad_update: stamp fresh + Start new
    press = menu_tap_at the button centre (CellPos + offset, as fs_tab), and Start hidden from the game on that
    read. Not checked: other cutscenes use the same id 0x8f (likely: one shared button).
- (v2.1.59-wip, see above) Ghost Ship fog steering (user, 2026-10-20, state 376 = root ROM v2.1.48, Linebeck "Set the engine to GO"): a
  steering HUD (ship's wheel at the bottom, Go / Stop lever on the right, Menu bottom left; no Jump, no Route).
  Rig research (lr.py, state 376 + 6 A presses = HUD, scratchpad h3.raw, session-only; no build):
  - Still slot 15, mode 1, sea controller [0x218EE9C] (0x021FCB74 here). +0x34 = 0x30 the whole time, so the
    v2.1.10 sailing block's "+0x34 == 0" gate fails: Up / Down / A / B / X do nothing here today. Need another
    flag that marks this HUD (not found yet) so the menu bar case stays safe.
  - Lever: a tap at (238,110) toggles Go <-> Stop here too (+0x1c / +0x20 = 2 / 0).
  - Steering: a held stylus ANYWHERE sets the turn rate from its x only: target rate = (x - 128) * ~10.67
    (x 20 -> -0x480, x 110 -> -0xC0, x 60 -> -0x2D5); ctl +0x1a s16 = wheel rate (eases toward the target),
    +0x18 = heading accumulator, +0x10 / +0x14 = drift. Lift = the wheel eases back to straight. A touch at
    (128,40) does not turn; (250,40) turns right and does not hit the lever.
  - Proposed (approved by the user 2026-10-20, built as v2.1.59-wip with WH_STEP 4): Up = Go, Down = Stop (lever tap, as at sea); hold Left / Right = fake stylus
    held at y 40, x moving out from 128 by ~2 px a frame to 8 / 248 (short press = small turn, long hold = full
    lock), let go = lift; a lever tap during a turn lifts the steering stylus first. Code space: 183 bytes free.
- (v2.1.49-wip, see above) Game over screen research (2026-10-19, rig only, no build; user: "move on to your next discovered overlay idea").
  Getting there (rig, fresh boot of v2.1.48-wip with the playthrough .srm, Mercay dock, bombs equipped): poke both
  potion bytes gItemManager +0xbc/+0xbd = 0 (else Link drinks one and gets up), health [gPlayer] +0xa = 1 (u16
  quarters; 0 alone does nothing until damage), R, A = bomb set down, ~1300 frames = "GAME OVER" (scratchpad
  gover2.raw, session-only). Mode stays 1 the whole time.
  Found: big Continue (128,68) / Save and Quit (128,126) buttons = touch buttons (vtable 0x020e893c, cell 0x14,
  ids 0x53 / 0x54, elements 0 / 1; the save menu's are 0x50 / 0x51 / 0x52, same cell). A held press lights the
  button, the lift fires it, a slide off cancels ([[0x27E103C]] +0x1c = held id). A / B / Start / D-pad do nothing.
  Continue = respawn at the island entrance (mode 1). Save and Quit = "Save your progress?" Yes / No, then "End
  the game?": both are dialogue choices and already work with Up / Down / A (choice_ctl).
  Design idea (not built, needs the user's OK): fs_btn sends ids 0x53 / 0x54 into smenu's button slots (index =
  id - 0x53, y offset r2, SM_SEEN), so smenu_ctl drives them as the save menu: Continue pressed first, Up / Down
  switch, A lifts = fires. Small code (~15 instructions).
- (v2.1.48-wip: Y toggles, see above) Chart Memo / Erase research (2026-10-19, rig only, no build; user asked after an overlay survey). State 126 +
  builds\"...Dpad v2.1.35-wip4.nds" (the state's code): stylus taps Sea Chart (233,175), then NW (64,48) = mode 4,
  NW chart (raw state saved as scratchpad chart.raw, session-only). Memo (14,40) and Erase (14,78) on the left
  edge, Back (13,178); ids 0x18 / 0x19 / 0x17 (see v2.1.37). Found: the chart opens in pen mode (Memo lit), so a
  stylus drag draws at once; Erase tap = eraser mode (Erase lit, Memo dim), a drag over a line erases it; Memo tap =
  pen again. They are a mode toggle only: drawing / erasing still needs the stylus. Not checked: whether the mode
  stays after Back and reopen, free keys in mode 4 (B = Back via bk_tab), the land Map (same ids). Possible design
  if wanted: one free key (e.g. Y) taps Erase in pen mode and Memo in eraser mode. Low value: the stylus that draws
  can tap the buttons too.
- (v2.1.46-wip, see above) Salvage Arm on buttons (user, 2026-10-19, state 241 = first salvage, arm just lowered; made with release v2.1.42).
  Rig research (lr.py, root ROM + state 241, no build): the arm sinks by itself. Bottom screen lever bar at y ~174,
  handle starts at (128,174); the stylus grabs the handle and drags it. Handle x = arm side position (the arm swings
  over to it with lag: handle 112 -> claw ~92 after 2 s, handle 80 -> claw at the left edge); the handle STAYS where
  the stylus lets go. Stylus above the bar (y 140) = knob up = slower sink; below (y 187) = knob down = faster sink;
  y 192 is off the screen (no touch); let go = knob back to centre (normal speed). At the bottom the knob icon turns
  yellow and the arm climbs back (not studied: what up / down do on the climb). Mines cost a diamond (5) and
  Linebeck comments in a top-screen box that does not stop play. B = red back arrow already works (user).
  Design (user approved 2026-10-19): hold Left / Right = slide the handle (~2 px per frame, stays put
  on let go), hold Up = knob up, hold Down = knob down, diagonals combine (one stylus point (hx, y)), A = handle
  back to the centre. Needs: salvage mode / overlay test, the handle x in RAM (so a real stylus move doesn't desync
  the fake one), the knob y thresholds, what Up / Down do on the climb, and code space (3 bytes free).
- (v2.1.35-wip, see above) Sea menu bar Fish (user, 2026-10-18): D-pad can't reach Fish, stylus can't tap it.
  Open: fishing itself (cast / reel) is stylus only; "?" slots are dead stops until owned.
- (v2.1.35-wip3, see above) Fishing on buttons (user, 2026-10-18, after v2.1.35-wip): replace the stylus in the fishing game. See the
  fishing research under v2.1.35 wip2. Proposed: A on "PULL!" = set the hook (stylus flick), hold Down = pull
  up on the rod (slide down), hold B = reel (stylus circles), B with no fish / Select = quit (red arrow).
- (v2.1.34-wip: X = Route, B = cannon / back, see above) Sailing Routes button (user, 2026-10-18, after v2.1.32-wip): at sea, a controller button taps the sail HUD's
  Routes button (touch-button id 0x8e, see "Sailing research"; route screen = mode 0x11) to open the route screen.
  Drawing the route stays stylus only. With the route screen open, B closes it. Pick a free button at sea (A/Up/Down
  are taken; Left/Right/B/X/Y free there). User state: %RETROARCH_DIR%\states\melonDS DS\"Phantom Hourglass US -
  Dpad v2.1.32-wip.state1" (route screen shown; made with v2.1.32-wip, so it runs that code). Needs: the Routes
  button's tap point (fs_btn may already record id 0x8e's place, or measure it), and the route screen's close / back
  button and whether B already does anything there.
  Rig note (2026-10-18): state 1 loads at sea on the sail HUD (mode 1, SEA_OVL_SLOT 15, route already drawn on the
  top-screen chart), NOT on the route screen; "Route" button at the bottom right (~(238,176)). bk_tab empty there.
- (v2.1.31-wip, see above) Select = menu bar (user, 2026-10-18): Save / Collection / Sea Chart / Map on the D-pad,
  Collection first, A confirms, Select / B close, field after a screen with the bar closed, L free.
- (v2.1.30-wip, see above: game flag touch ctl +0x7c / +0x7d in slash_check) BUG (user, 2026-10-18, after v2.1.28-wip): a text box with no NPC (e.g. a note on a wall that opens an
  overlay, like the wall map's "~To my son~" text): the first B press, while the text is still being typed out,
  also swings the sword and Link shouts. That same B does close (or type out) the text. Likely cause: on that
  first read msg_guard / ch_seen are not set yet (dialog_advance has not run for the new box), so B reaches
  slash_check. Next: rig with state 59 (A at the map opens the text), watch msg_guard, ch_seen and the mode on
  the first frames of the text; then hide B from slash_check while a text box is up (e.g. a game-side "text
  box shown" flag, since msgwin is only set once dialog_advance runs).
- (v2.1.26-wip: B = Put Away, see above) BUG (user, 2026-10-18, after v2.1.24): R takes the shovel out, but no
  controller button puts it away.
- (v2.1.25-wip, see above) BUG (user, v2.1.24, 2026-10-18, RetroArch state 58: bomb-flower bomb held, boomerang equipped): run + A does
  nothing; standing A throws, never sets the bomb down. Found (rig, state 58): our carrying latch = 0 there and
  the equipped item is not bombs, so held_obj = 0: run + A goes to stop_probe, standing A probes. Game flag:
  gPlayer +0x3c = held actor id (-1 = nothing held; +0x40 index), 91 while holding, -1 right after the set-down.
  Plan: held_obj tests gPlayer +0x3c != -1. User answer (2026-10-18): standing A sets the bomb down, run + A
  throws it. Done in v2.1.25 (rig: bag bombs standing / stop + A = set down, run + A = throw; barrels have no
  set-down, so standing A throws them).
- Sailing buttons: see "Sailing research" above (done in v2.1.10-wip).
- (v2.1.13-wip fix, see above) BUG (user, v2.1.10-wip): in a merchant's (shop) window, A exits as if Quit were tapped. Expected: A should not
  quit (B is the game's way out). Suspects: an A-driven stylus tap landing on the Quit button, e.g. pad_update's
  text-box fallback tap at (128,168) (ch_seen set, msg_guard at MAX) or tap_front's text-box/probe tap. Next: get
  a state with the shop window open, find its buttons (touch-button scan as for the file select) and see which
  tap A sends; then either hide A there or make A/D-pad pick items like the other menus.
- (v2.1.17-wip, see above) Collection screen tabs: state 25 shows a collection screen with two buttons, Treasure and Ship Parts.
  User's design: extend the v2.1.4 Left/Right paging into one chain.
  - Main page 1 -> Right -> page 2 (as now) -> Right again -> Ship Parts.
  - Ship Parts -> Left -> Treasure -> Left again -> back to the main collection screen.
  Today Right on page 2 just taps the empty screen edge, so that press is free. Needs: which page each of these
  tabs belongs to, the tap points for the Treasure / Ship Parts buttons and the way back, and whether those
  screens are new game modes (they'd need adding to pad_update's 0x13-0x17 / 0x1d-0x21 checks).
- (v2.1.18-wip, see above) Collection browsing (user, after v2.1.17-wip): controller support for moving through the entries on the
  Treasure and Ship Parts tabs (2 rows x 4 slots, see state 25 / the rig's ship.raw), e.g. D-pad moves a
  highlight, A shows the entry on the top screen. Needs: how the game selects a slot (tap on a slot; check
  whether a held press highlights it, as on the file select), the slot tap points, and keys that stay free
  for the tab chain (today Left/Right switch tabs: maybe L/R, or Left/Right only at the row ends).
- (v2.1.38-wip, see above) Shake-off attack (user, 2026-10-17, after v2.1.18-wip): one enemy attack grabs Link and the game wants the
  stylus rubbed back and forth across him to shake the enemies off. Design a button for it (e.g. mash a key or
  hold it = menu_touch drags a stylus zig-zag over Link's screen position). Needs: a state in that attack, how
  the game detects the rub (distance / direction changes), and Link's screen point (ScreenFromWorld).
- (v2.1.19-wip, see above; bombchu path still stylus only) Equipped-item button (user, 2026-10-17, after v2.1.18-wip): a button that uses the item Link has equipped
  (the item icon on the touch screen). User's plan: undo the v2.1 L/Select swap (Select = collection again, as
  in the clean game) and use L to activate the item. Needs: how the equipped item is triggered (tap on its
  icon, then aim/draw for bow, boomerang path etc.), and per item what the button does.
- (v2.1.22-wip, see above; no wrap) Ship Parts list (user, after v2.1.19-wip3): on the Ship Parts tab, with a part's list open (e.g. the hull),
  D-pad Down does not step through the collected parts of that kind; only the stylus can. Known gap since
  v2.1.18 (coll_ctl hides A/B/D-pad while an entry shows; the list had only one part in the rig saves).
  User state: %RETROARCH_DIR%\states\melonDS DS\"Phantom Hourglass US - Dpad v2.1.19-wip3.state1" (Hull list
  open, two hulls owned; made with wip3 = v2.1.19 code, so load it with builds\"...v2.1.19-wip3.nds").
  Needs: how the list picks a part (tap on a row? held
  press?), the row tap points, and whether Up/Down should wrap. Then coll_ctl's entry-shown branch: Up/Down
  on SFN_LIST = tap / hold the next row.
- (v2.1.21-wip, see above; row ends stay, no wrap) Collection grid edges (user, after v2.1.20): on the Treasure / Ship Parts grid with a slot held, Left/Right
  past the last filled slot in the row must NOT let go and switch tab (today coll_ctl's "none: let go, then the
  tab chain" path, label 3 after the Left/Right loops). User example: Right through the Treasure row, Right on
  the last one jumped to Ship Parts. Wanted: the row end stays put (or wraps?); the tab chain is reached only
  by Up from the top row (let go = back to tab level, where Left/Right switch tabs as with nothing held).
- (v2.1.20-wip: Y, see above) Collection screen-swap button (user, after v2.1.17-wip): the Items page has a "switch screens" button
  (bottom-right icon, about (243,178) in the rig's b_open.png) that is touch only. Pick a button for it
  (free in the collection modes: X, Y, R?, Start?) and tap it with menu_tap. Check what it swaps and whether
  the page word / tap points change while swapped.
- (v2.1.7-wip fix, user confirmed fixed 2026-10-17) BUG (user, seen in v2.1.5 play): after finishing a conversation with an NPC, Link won't move toward or away
  from the NPC; only D-pad 90 degrees off works (facing up: Left/Right frees him; facing right: Up/Down).
  Likely cause: our push-block code. tap_front treats touch ctl +0x94 != -1 as "holding a block" (grab_on), and
  dpad_move then skips steering along the grab axis and only walks off sideways, which is exactly this symptom.
  Talking probably leaves +0x94 = the NPC's object id. Fix idea: also require a real grab (e.g. +0x98 value, or
  the grab heading check), or clear grab_on / ignore +0x94 while msg_guard is set and right after a text box.
  Check with ctlwatch.py (+0x94/+0x98 before, during and after a talk).
- (v2.1.8-wip fix, see above) BUG (user, v2.1.6-wip state 1): after Save > Continue/Save and Quit menu > Save and Quit > "Yes", the
  "Save complete." text box can't be closed with any button, only a stylus tap. User confirmed Continue / Save and
  Quit selection itself works. NOT a v2.1.6 regression: it happens in every version (the save menus are just
  where testing has got to). So A/B don't reach this box: probably dialog_advance (H2, 0x203A474) isn't on its
  path (different box type / tap handler), or InputGate is set and msg_guard is 0 so pad_update zeroes A/B.
  Next: check msg_guard / msgwin and the gate during this box (debug build + ragate.py, or a state diff), find
  its tap handler, then make A/B tap it (e.g. a menu_touch tap on the box, as the textbox tap at 128,168).
  Also make sure smenu_ctl doesn't strip A here once that works (it may still be live under the box).
- (v2.1.23-wip, see above; not reproduced in the rig, stuck-hold fix, no row highlight) Options screen (file select > Options), user on v2.1.9-wip: Left/Right don't change settings in RetroArch (worked
  in the rig: fs_ctl FS_ROWS mode taps the arrow ids 0x7f-0x84 only while ch_tap is CH_OFF). Up/Down have no
  visible effect by design (no row highlight), so they may be fine. Next: reproduce with the user's own state
  on that screen (lr.py + a v2.1.9 state), peek ch_tap / fs_cur / fs_tab; suspect ch_tap stuck non-OFF or the
  arrow ids not live in fs_tab. Consider a row highlight too.
- (v2.1.24-wip, see above) BUG (user): while Link runs carrying a pot, rock or bomb, the throw button does nothing;
  it only throws standing still (dangerous with bombs). Wanted: A throws while moving with the D-pad, as a stylus
  tap does in the clean game.
- (v2.1.11-wip, see below) Dialogue choices (user, v2.1.7-wip): (1) Up/Down feels slow; cut the time per move (choice_ctl's CH_HOLD/CH_DRAG
  stylus sequence, CHOICE_STEP updates per step). (2) Wrap-around: with 2 choices on the top one, Down twice should
  go to choice 2, then back to the top (Up from the top -> bottom likewise).
- (v2.1.8-wip fix, see above) Title screen (user, v2.1.7-wip state 1 = "Touch the screen!" title, seagull): needs a stylus tap to reach the
  first menu. Make A/Start do it (e.g. a menu_touch tap on the bottom screen while the title mode is up; find the
  title's game mode first, likely gated so pad_update/tap_front don't run there yet).
