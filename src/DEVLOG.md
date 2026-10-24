# Phantom Hourglass Button Controls patch - development log

## State (2026-10-21)
- Latest release: v2.1.68 (builds\v2.1.68\, = root playthrough ROM, = v2.1.80-wip; released 2026-10-22 after the user's RetroArch test: "button combo works").
- Root wip: none (v2.1.78-wip released as v2.1.66). v2.1.42-wip to v2.1.78-wip are in builds\.
- Root wip: none (v2.1.79-wip released as v2.1.67; it is in builds\). v2.1.79-wip (2026-10-21, NOT rig-tested in the ice scene, user test due): hold A rubs Link out of ice.
  User state 584 (Link frozen in a block, "RUB!" bubble): Link state = damage state (id 5, state +0x18 = 6, +0x20 counts
  15 to 0 per stroke), gPlayer +0x48 = 0, so the green-blob test missed it. Rig (state 584, old code, raw strokes): diagonal
  zig-zag frees Link in ~23 strokes; horizontal-only strokes do nothing. Fix: fg_grab also takes state 5 + +0x18 = 6
  (LS_DAMAGE, LS_ICE). State 157 (deck) is also state 5 with +0x18 = 2: not matched. Needs a fresh ice freeze to test
  (state 584 holds the old code). CODE_RESERVE 0x4300, 223 bytes free.
- Root wip: none (v2.1.80-wip released as v2.1.68; it is in builds\; user tested in RetroArch: hold A jumps off a grappling hook post). Entry below.
- Latest release: v2.1.69 (builds\v2.1.69\, = root playthrough ROM, = v2.1.81-wip, released 2026-10-22 on the user's request; user tested the bomb set-down in RetroArch 2026-10-24: passed).
- Root wip: none (v2.1.81-wip released as v2.1.69; it is in builds\). Entry below.
- Latest release: v2.1.70 (builds\v2.1.70\, = root playthrough ROM, = v2.1.82-wip, released 2026-10-22 on the user's request; user test of the hook hold A due). Root wip: none.
- Latest release: v2.1.82 (builds\v2.1.82\, = root playthrough ROM, = v2.1.97-wip, released 2026-10-24 after the user's RetroArch test: "all buttons work"; bombchu map GO! / CANCEL found through the game's list). Root wip: v2.1.98-wip (L taps the final fight's Phantom Hourglass button; user test due). Next wip: v2.1.99-wip.
- Previous release: v2.1.81 (builds\v2.1.81\, = v2.1.95-wip, released 2026-10-24 on the user's request before a RetroArch test; user tested in RetroArch the same day: passed; merchant grid light kept on long Left / Right, keys wait during a tab switch).
- Previous release: v2.1.80 (builds\v2.1.80\, = v2.1.93-wip, released 2026-10-24 after the user's RetroArch test: "both buttons work great"; letter screen A = OK, B = Rewrite).
- Previous release: v2.1.79 (builds\v2.1.79\, = v2.1.92-wip, released 2026-10-24 after the user's RetroArch test: "all tests pass!"; stylus picks dialogue choices again).
- Previous release: v2.1.78 (builds\v2.1.78\, = v2.1.91-wip, released 2026-10-24 on the user's request; hammer facing, boulder let-go; user tested in RetroArch the same day: works). Root wip: none.
- Previous release: v2.1.77 (builds\v2.1.77\, = v2.1.90-wip, released 2026-10-24 on the user's request; A swings straight; user tested in RetroArch the same day: works).
- Code space: CODE_RESERVE 0x4800 since v2.1.93-wip, 111 bytes free since v2.1.95-wip (was 0x4700 since v2.1.91-wip).
- Previous release: v2.1.76 (builds\v2.1.76\, = v2.1.89-wip, released 2026-10-24 after the user's RetroArch test: "all tests pass"; same game as v2.1.75, ~28 KB patches).
- Previous release: v2.1.75 (builds\v2.1.75\, = v2.1.88-wip, released 2026-10-24 on the user's request; A below a pedestal places the carried stone).
- Previous release: v2.1.74 (builds\v2.1.74\, = v2.1.87-wip; user tested in RetroArch 2026-10-23).
- Previous release: v2.1.73 (builds\v2.1.73\, = v2.1.86-wip; full line at once, could not catch a post beside Link: replaced by v2.1.74).
- Previous release: v2.1.72 (builds\v2.1.72\, = v2.1.85-wip, released 2026-10-22 on the user's request; Gongoron rolls with A / B in the rupee minigame; user test due).
- Previous release: v2.1.71 (builds\v2.1.71\, = v2.1.84-wip, released 2026-10-22 on the user's request; ice rub fixed, includes v2.1.83-wip's hook post jump; user test due). Root wip: none. Next wip: v2.1.85-wip. Other sessions also build wips: check root, builds\ and this file for the next free number.
- Code space: CODE_RESERVE 0x4400 since v2.1.83-wip, 219 bytes free.
- Pending user tests: none. The user passed every docs\test-checklist.md section in RetroArch by 2026-10-24, including the v2.1.69 bomb set-down and the v2.1.81 merchant grid.
- Name "Button Controls" since v2.1.36 (files zelda_phantom_hourglass_buttons_*, buttons_vX.Y.Z_source.zip).
- Older history (v2 to v2.1.57-wip, the old State text, finished future items): src\DEVLOG-archive.md.

Releases since v2.1.41 ("User test" = tested by the user in RetroArch; "rig" = only the lr.py test setup):

| Release | wip | Date | ROM SHA-1 | Change | User test |
|---|---|---|---|---|---|
| v2.1.41 | v2.1.41-wip | 2026-10-18 | 6298721bf21d83f91478788fa5060e5e370aa694 | D-pad picks a sea on the Sun Crest's Sea Chart | rig; crest test still due |
| v2.1.42 | v2.1.45-wip | 2026-10-19 | 409fb4d8baddaf7971f8d32b29ba76c6d539de30 | treasure merchant on buttons, Sell held, collection keys on Mercay fixed | yes |
| v2.1.43 | v2.1.46-wip | 2026-10-19 | bc27edc7e1d664ad8d4300ba643bd903e0419f0d | Salvage Arm | yes |
| v2.1.44 | v2.1.47-wip | 2026-10-19 | 311d5a529a7aa19db777a453e6575f10c2eb4c6d | collection Items page, L / R pages | yes |
| v2.1.45 | v2.1.50-wip | 2026-10-19 | dc7390b66698d8f926dc5877ae809342aa2c8a45 | Sea Chart D-pad over seas and islands, Y = Memo / Erase, game over screen | yes |
| v2.1.46 | v2.1.52-wip | 2026-10-19 | 2cee9d4fd29630919fec7bf017a7365557d88ae5 | statue turn screen, Left / Right full turns | yes |
| v2.1.47 | v2.1.54-wip | 2026-10-19 | 1776672c102711b91905c8ee524126a8d1978c32 | dungeon map floors on Up / Down, A no longer turns a statue | rig |
| v2.1.48 | v2.1.57-wip | 2026-10-20 | 7fa1bd2ee32ae9c611d9b47136333b889f2a5426 | bow D-pad no longer shoots, sword clash rub, magic box | yes (sword clash: rig) |
| v2.1.49 | v2.1.58-wip | 2026-10-20 | 8795da73ede5e5ef2fe333b3e9ba2303336ea348 | dungeon map floors in the Temple of the Ocean King | rig; FREEZES on Up / Down in the field |
| v2.1.50 | v2.1.59-wip | 2026-10-20 | 9ec94c8f9ce7fe9a2d62a71bc8300e9315ccf595 | Ghost Ship fog steering | rig; same freeze |
| v2.1.51 | v2.1.60-wip | 2026-10-20 | 51687e898257c53cb124ae41a4bc0c8837c6fe01 | freeze fix (data abort in fl_shown) | yes |
| v2.1.52 | v2.1.62-wip | 2026-10-20 | a8849e859f7ba04df8ca7041b0a23d2c25b9d050 | bow hold A aim (v2.1.61-wip), dungeon map floors for user state 385 | rig |
| v2.1.53 | v2.1.63-wip | 2026-10-20 | 663c9aeec7beae076d1a13c07a32b24c848d88d8 | Force Gem D-pad lock fix | rig |
| v2.1.54 | v2.1.64-wip | 2026-10-20 | 20aa1f1739252e958097b042233ce371a52c3586 | bow hold A Left / Right aim straight | yes |
| v2.1.55 | v2.1.65-wip | 2026-10-20 | 445f869a535258d137a1ce53f6db2d9a7ba57ba8 | English text typo fixes | rig |
| v2.1.56 | v2.1.66-wip | 2026-10-20 | 3f1b7ae7dfb9db48cd532671b8a56e5228340f3d | Start on the save menu no longer talks to the NPC under it | rig |
| v2.1.57 | v2.1.67-wip | 2026-10-21 | 9badc41668863a8308c8341c585f03fd68b86ebf | a second Start skips a cutscene | rig |
| v2.1.58 | v2.1.68-wip | 2026-10-21 | 95a6bc66b34f6899c9f671554de599374c968f1b | literal pool cleanup (303 bytes free), README fixes | yes |
| v2.1.59 | v2.1.69-wip | 2026-10-21 | 9c60796315d1fe52c3215e1650e19509fd5125b4 | R opens the item bar, X takes the item out | yes |
| v2.1.60 | v2.1.70-wip | 2026-10-21 | e3890baadfeb6fe378a536645cc89e177cc7683a | L swaps Link / Gongoron in the Goron Temple | rig; released on the user's request before a RetroArch test |
| v2.1.61 | v2.1.71-wip | 2026-10-21 | e4fa50ce18a10a7d5607f3d36211e42cb392bf7e | hold A rubs free from a Like Like (Goron Temple) | yes (RetroArch, 2026-10-21) |
| v2.1.62 | v2.1.72-wip | 2026-10-21 | e293c692cb084e8d31c5649e574cd4f800b69991 | hold B = Gongoron curls and rolls (CODE_RESERVE 0x4100) | yes (RetroArch, 2026-10-21) |
| v2.1.63 | v2.1.73-wip | 2026-10-21 | 44d01a52c97f547522b5de10fed06a60bffe1e3b | bombchu map: B = Back, A = GO!, B = CANCEL | rig; released on the user's request for a live test |
| v2.1.64 | v2.1.74-wip | 2026-10-21 | fd864d8fefe768d448f76b9cb4ca1028f8b617dc | hold A rubs green blobs off Link (CODE_RESERVE 0x4200) | yes (RetroArch, 2026-10-21) |
| v2.1.65 | v2.1.76-wip | 2026-10-21 | b432fa09096ecbc4d29dedb54380cb5cfe035997 | item bar D-pad moves flash shorter (gap 8 to 4 frames), bombchu GO! / CANCEL fix (v2.1.75-wip) | rig; released on the user's request |
| v2.1.66 | v2.1.78-wip | 2026-10-21 | 9f6e07bc728f138e94993c438ef81b2076f85d34 | collection Ship Parts / Treasure / Items D-pad after the merchant overlay (v2.1.77-wip + v2.1.78-wip, CODE_RESERVE 0x4300) | rig; released on the user's request for a RetroArch test |
| v2.1.67 | v2.1.79-wip | 2026-10-22 | b90297b17de54ac85a1256fa962e845fe4018ec7 | hold A rubs Link out of ice (damage state 5, +0x18 = 6) | yes (RetroArch, 2026-10-23) |
| v2.1.68 | v2.1.80-wip | 2026-10-22 | 1e0d8d5fc3372aceb7ebe57d3b546ebc1fd5dd00 | hold A jumps off a grappling hook post (Link state 3 / sub-state 10); fg_grab state table load fixed (ice rub) | yes (RetroArch, 2026-10-22 post jump; 2026-10-23 ice rub) |
| v2.1.69 | v2.1.81-wip | 2026-10-22 | 58d7d6087d15eb3a2c25d30c9d0250c5409c7964 | standing A with a bomb held sets it down the way Link faces (was always up-right) | yes (RetroArch, 2026-10-24: passed); released on the user's request before the test |
| v2.1.70 | v2.1.82-wip | 2026-10-22 | f6f40cb45ca773b5f0244e90517daef8356c781e | grappling hook out: hold A draws the line farther the longer, release throws (CODE_RESERVE 0x4300, 7 bytes free) | yes (RetroArch, 2026-10-23) |
| v2.1.71 | v2.1.84-wip | 2026-10-22 | 8cb83c5349d062f4691dcdf7d2cd90141b0ede31 | ice rub fixed, hook post jump aim | yes (RetroArch, 2026-10-23) |
| v2.1.72 | v2.1.85-wip | 2026-10-22 | 0d4bdabc8a175a8e975d15fc4a2359860ca0a4f9 | hold A / B rolls Gongoron in the rupee minigame (CODE_RESERVE 0x4400, 35 bytes free) | yes (RetroArch, 2026-10-23) |
| v2.1.73 | v2.1.86-wip | 2026-10-22 | 39941546bbc536ffb8448ba1b16d4183acf01809 | hook hold A draws the line at full length at once (HK_START 255); could not catch a post beside Link | not tested; released on the user's request |
| v2.1.74 | v2.1.87-wip | 2026-10-22 | a6fe4bccaa152c32d487c4b52f760fd4eded8d2b | hook line starts at Link, full in 8 reads (HK_START 0, HK_STEP 32) | yes (RetroArch, 2026-10-23) |
| v2.1.75 | v2.1.88-wip | 2026-10-24 | c49f77eab798667024d85cafe516eaa75dfb79c7 | A below a pedestal places the carried stone (drop_up, CODE_RESERVE 0x4500) | yes (RetroArch, 2026-10-24: "placing stone shapes in slots" passes); released on the user's request before the test |
| v2.1.76 | v2.1.89-wip | 2026-10-24 | 74504cc896a5ccaa043b8fcb48a91ced316237d8 | same game as v2.1.75; patches ~28 KB instead of 1.3 MB (blzenc.recompress, mkpatch moved-data copies) | yes |
| v2.1.77 | v2.1.90-wip | 2026-10-24 | 0e0bc014d2f026794304066cb6190b740110dc74 | A on bare ground: one sword swing, straight the way Link faces (was diagonal, repeated) | yes (RetroArch, 2026-10-24: "A swings once and does not turn Link") |
| v2.1.80 | v2.1.93-wip | 2026-10-24 | a7227218c7711da0e3640f157cdf7bc2c29114ab | letter screen at a red mailbox: A = OK, B = Rewrite (sig_ctl, CODE_RESERVE 0x4800) | yes (RetroArch, 2026-10-24: "both buttons work great") |
| v2.1.81 | v2.1.95-wip | 2026-10-24 | 52abbcf6388772c005fda7d1b0166012b8f1204b | merchant / collection grid: light kept on long Left / Right (v2.1.94-wip), keys wait during a tab switch (cl_wtk) | yes (RetroArch, 2026-10-24: passed); released on the user's request before the test |
| v2.1.82 | v2.1.97-wip | 2026-10-24 | de2b6e539a6d9a2fc9338f1fc8b554a0140580f3 | bombchu map GO! / CANCEL: route object found in the list at 0x020e9c28 (was a fixed distance below MAP_OBJ) | yes (RetroArch, 2026-10-24: "all buttons work") |
| v2.1.79 | v2.1.92-wip | 2026-10-24 | 33735b5fb6d9678051042ad758b262adfbbc19f7 | a stylus tap picks a dialogue choice again (menu_touch takeover while choices are up) | yes (RetroArch, 2026-10-24: "all tests pass!") |
| v2.1.78 | v2.1.91-wip | 2026-10-24 | d0b363811cd1c4916fc4e4a7eee262be68f7970e | hammer keeps Link's facing (its aim was the fairy), D-pad lets go of a boulder (CODE_RESERVE 0x4700) | yes (RetroArch, 2026-10-24: hammer keeps the facing, boulder no longer locks Link); square push block: yes (RetroArch, 2026-10-24: "the stone block" passes) |

Each release folder builds\vX.Y.Z\ has the bps, xdelta, README and source zip. Release steps: see "ROM files" below.

## ROM files (project root)
Layout (user's, 2026-10-17):
- .backup\  original clean ROM "Legend of Zelda, The - Phantom Hourglass.nds" (= CLEAN build source) and the
           2014 v1 xdelta. Don't write here.
- root\     "Legend of Zelda, The - Phantom Hourglass.nds" = user's playthrough: copy of the latest RELEASE,
           no version in the name (RetroArch keys saves by ROM name). Replace only on release.
           Plus at most ONE current test build: "Phantom Hourglass US - Button Controls vX.Y.Z-wipN[-debug].nds"
           ("Dpad" in the name before v2.1.36).
- builds\   finished wip builds, released ROMs, and release folders (builds\vX.Y.Z\: bps, xdelta, README, src zip).
- docs\     README.txt (current release README), test-checklist.md (pending user tests), dialogue-en.txt and
           dialogue-typos.md (the v2.1.55 text fixes).
- src\      tools, patch_src, this file, DEVLOG-archive.md (older history).
Saves (user rule, 2026-10-18): NEVER copy a wip's .srm over the playthrough .srm ("Legend of Zelda, The -
Phantom Hourglass.srm"), not even on release, and don't offer it. Copying the playthrough .srm to a new wip name is fine.
When a wip is superseded, move it to builds\. On release: builds\vX.Y.Z\, root playthrough ROM, docs\README.txt.

## Build
  python3 patch_src/build_v2.py clean.nds out.nds   # needs clang, ld.lld, llvm-objcopy, llvm-nm (link.py)
  python3 patch_src/mkpatch.py clean.nds out.nds name   # makes .bps/.xdelta (prefer the official xdelta3 -e -9 -S djw)
  (since v2.1.89-wip build_v2 reuses the original BLZ streams (blzenc.recompress) and mkpatch copies moved data, so the
  patches hold our code and small fragments only: ~28 KB instead of 1.3 MB)
Clean ROM: US AZEE rev0, SHA-1 4c8f52dd719918bbcd46e73a8bae8628139c1b85.
Windows (2026-10-16): winget Python 3.12 + LLVM. build_v2.py now calls link.py (clang assembles; the Windows
LLVM package has no llvm-mc). Verified: building dpad_v2_0.s reproduces the released v2 SHA-1 exactly.
  python src\patch_src\build_v2.py ".backup\Legend of Zelda, The - Phantom Hourglass.nds" out.nds ; python src\verify.py clean.nds out.nds
  (2026-10-21: "python" is not on the PATH in this shell; use "py -3".)

## Recent wip entries (v2.1.58-wip and later; older ones in src\DEVLOG-archive.md)

v2.1.98-wip (2026-10-24, rig tested; user test due): L taps the Phantom Hourglass button in the final boss fight
  (user request, user state 938: "a new button to press for the phantom hourglass"; design as the Gongoron swap).
  - Found (rig, state 938): the hourglass = touch button (vtable 0x020e893c) id HG_ID 0x1d, layout cell HG_CELL 0x4a,
    bottom centre ~(128, 180); a stylus tap there sets its +0xd to 4 and time stops. Its +0x11 (GORON_FORM) = 0.
  - Code: fs_btn records it in gr_tab like the Goron swap button, so goron_ctl taps it on a new L. +0x11 = 0, so
    fg_roll does not take B for a Gongoron roll. dpad.bin 18357 bytes, 75 bytes free of 0x4800.
  Rig (state 938 = v2.1.97-wip code; new dpad.bin poked at 0x0219B120, 5 BL hooks re-aimed): L = button +0xd 8, time
  stops (yellow corners, Menu / Items gone); L again while stopped = nothing; time runs again later.
  Not tested: real RetroArch; whether id 0x1d / cell 0x4a shows on other screens (L would tap it there too).
  ROM: "Phantom Hourglass US - Button Controls v2.1.98-wip.nds" (root), SHA-1 d9b324c6b8f62070ac6b8d3aeeffca23001517ef,
  CRC32 1abb3228; save: "...v2.1.98-wip.srm" in RetroArch saves\melonDS DS\ = a copy of the playthrough .srm.

v2.1.97-wip (2026-10-24, rig tested; user tested in RetroArch 2026-10-24: "all buttons work"; released as v2.1.82 the same day on the user's request (builds\v2.1.82\: bps 28,442, xdelta 30,420, README, source zip rebuilt to the same SHA-1, xdelta re-applied with src/apply.py to the same SHA-1); ROM in builds\, = root playthrough ROM; playthrough .srm kept, 87 bytes free of 0x4800):
  bombchu route panel, fix for v2.1.96-wip: user state "v2.1.96-wip.state2" (Mercay Island, route drawn): no button worked.
  - Cause: there the route object (0x021d0dd0) is 0xccf8 below [MAP_OBJ] (0x021ddac8, whose first word is a heap address,
    so MAP_OBJ does not hold the map screen object here). No fixed distance to MAP_OBJ exists.
  - Found: the static list BCHU_LIST 0x020e9c28 holds {func, object, id} entries (12 bytes, func 0 = end); while a route is
    drawn one entry is {0x02199181, route object, 0x2334a} (states 526, 537, 841, v2.1.96 state1 / state2; at entry 1, 2 or 4).
    No route (state 525): no such entry. In the last 150 user states the list held at most 6 entries.
  - Code: dpad.s bombchu block: walk BCHU_LIST (at most 16 entries, stop at func 0), take the first object in main RAM
    with vtable BCHU_VT, panel byte +BCHU_PANEL; none = no panel. Replaces the v2.1.96 scan below MAP_OBJ.
  - Rig (new block linked at 0x0219F8C0, old block start 0x219b4fc branched to it): v2.1.96 state2 and state 841 (v2.1.80
    code): A = mode 0x0d -> 0x0e -> 0x01 (bombchu launches); B = panel 0, map stays; B again = back arrow (mode 0x01).
    v2.1.96 code in state2: A / B = nothing. Fresh boot of the full ROM (playthrough .srm copy): file select, sea; no crash.
  - Not tested: real RetroArch; a full hot-link of v2.1.97 into a user state (only the bombchu block was swapped).
  ROM SHA-1 de2b6e539a6d9a2fc9338f1fc8b554a0140580f3, CRC32 e0267fc6. Save: "...v2.1.97-wip.srm" = a copy of the playthrough .srm.

v2.1.96-wip (2026-10-24, rig tested; failed the user test (v2.1.96-wip state2: no button works, fixed in v2.1.97-wip); ROM in builds\, 99 bytes free of 0x4800):
  bombchu route panel: A (GO!) and B (CANCEL) did nothing again (user state 841, which holds the v2.1.80 code).
  - Cause: v2.1.75-wip reads the route object at [MAP_OBJ] - 0x5fc. In state 841 it is at [MAP_OBJ] - 0x600 (MAP_OBJ
    0x021d3fac, route object 0x021d39ac); the word at - 0x5fc is 0, so "no panel": A went to the game, B tapped the
    back arrow, which does nothing while the panel shows. The gap between the two heap objects is not fixed.
  - Code: dpad.s bombchu block (pad_update, label 4): find BCHU_VT in the words from [MAP_OBJ] - 0x620 to - 0x5f0
    (lr = end; pad_update pushed it), panel byte from the first match (+BCHU_PANEL). Covers 0x5fc (525 / 526 / 537) and 0x600 (841).
  - Rig, state 841 (new block linked in the unused end of the v2.1.80 CODE_RESERVE, 0x0219F8A0, old block start
    0x219b4fc branched to it): A = mode 0x0d -> 0x0e -> 0x01, bombchu launches; B = panel 0, map stays (CANCEL); B again =
    back arrow (mode 0x01). Without the fix: A / B = mode 0x0d, panel 1 after 180 frames. Fresh boot of the full ROM with a
    playthrough .srm copy: file select, Adventure, sea; no crash.
  - Not tested: real RetroArch; a full hot-link of v2.1.96 into state 841 (only the bombchu block was swapped).
  ROM SHA-1 c26846e78025762d8fb634691bdd1d248192b3eb, CRC32 fcc861d0. Save: "...v2.1.96-wip.srm" = a copy of the playthrough .srm.

v2.1.95-wip (2026-10-24, rig tested; released as v2.1.81 the same day on the user's request, before a user test (builds\v2.1.81\: bps 28,398, xdelta 30,376, README, source zip; xdelta re-applied with src/apply.py to the same SHA-1); ROM in builds\, = root playthrough ROM; playthrough .srm kept): a key pressed during a tab switch waits for the new tab (user
  request: "Fix the tab switch race: Down pressed right after a tab tap holds a slot on the old tab").
  ROM "Phantom Hourglass US - Button Controls v2.1.95-wip.nds", SHA-1 52abbcf6388772c005fda7d1b0166012b8f1204b,
  CRC32 b78f0457; based on v2.1.94-wip; source known/v2.1.95-wip_dpad.s; dpad.bin 18321 bytes, CODE_RESERVE 0x4800,
  111 bytes free:
  - Found (rig, state 828, merchant): from our tab tap (CH_TAP, CH_CONFIRM at TAB_Y, frames 1-16) the switch takes
    about 58 frames. Both panels' +0xc bit 0 is 0 from frame 12 to frame 58 (COLL_PAGE changes at frame 30); it is 1
    at rest (merchant, and the collection panels in user states 551 / 552). A raw stylus press made after the bit is
    back is always seen. Down in that time held a slot on the old tab (or the new one before it was ready), and
    the game never saw the press. Down during the tap itself was dropped.
  - Fix: cl_gridv (all tabbed grids; not shipyard Customize, no tabs) treats the grid as busy while panel +0xc bit 0
    is 0, or while ch_tap is CH_TAP / CH_CONFIRM at TAB_Y: new A / B / D-pad are hidden from the game and kept in
    cl_wtk (new byte, cl_sel + 13, in the old .balign pad); the CH_OFF path adds them once the grid is ready; cl_no
    clears cl_wtk. Collection page 2 tab taps use menu_tap, not ch_tap: there only the bit 0 wait applies (no
    collection state in the rig to test).
  - Rig (state 828 hot-linked, scratchpad hot.py / t_race.py / t_fix2.py): Left (to Treasure) or Right (to Ship
    Parts), then Down 0 / 2 / 4 / 8 / 12 / 16 / 20 / 30 / 40 / 50 / 60 frames later: 22 of 22 hold a slot on the new tab
    with the game's press. Random bursts (seeds 1-3): 662 checked, 0 lost. Left / Right held 2-40 frames: pressed.
    Left then Right 10 frames apart: ends on Ship Parts. B during a switch: waits, then Quit leaves the merchant.
    (The hot-linked rig shows noise on the top-screen map: the rig's code range at 0x21d2000 is not free there.)

v2.1.94-wip (2026-10-24, rig tested; replaced by v2.1.95-wip before a user test; ROM in builds\): the merchant grid keeps its light after a long Left / Right press
  (user report, user state 828: treasure merchant, Ship Parts tab, "sometimes the dpad cursor disappears from the tile
  that should be selected when moving from left or right", both tabs).
  ROM "Phantom Hourglass US - Button Controls v2.1.94-wip.nds", SHA-1 8634c92465eba4e21dbc4024f4ed445e83295541,
  CRC32 05f7955a; based on v2.1.93-wip; source known/v2.1.94-wip_dpad.s; dpad.bin 18241 bytes, CODE_RESERVE 0x4800,
  191 bytes free:
  - Found (rig, state 828 = v2.1.93-wip code): our stylus held slot 5 (ch_tap CH_HOLD, settled), but the game's slot
    had no press (slot object +0x59 / +0x5a = 0; both are 1 while the game sees a press there). A lift there opened
    nothing. The game's grid takes no new press while Left or Right is held in PAD +0 (Up / Down do not block it).
    coll_ctl hid only the new presses (PAD +2), so a slot move (CH_DRAG, CH_RELEASE, CH_HOLD: about 11 frames) with
    Left / Right still held lost the press at the new slot. Rig: Left / Right held 2-6 frames = pressed, 8+ frames
    (about 0.13 s, a normal press) = lost every time.
  - Fix: cl_gridv clears held Left / Right in PAD +0 (all grid tabs: collection, shipyard, merchant, magic box).
    pad_update takes its edges from held_real, so the next read does not change.
  - Rig (state 828 hot-linked at 0x21d2000, old / new symbols re-aimed, cache flush stub, scratchpad hot.py): Ship
    Parts Left / Right held 2-40 frames = pressed; Treasure tab Right / Down / Left / Up held 4 / 12 / 24 frames =
    pressed, light shown. Random bursts (1-4 D-pad keys, each held 1-12 frames, gaps 0-10 frames), then a check
    of the game's press at the slot our stylus holds: v2.1.93-wip code 118 of 431 lost, v2.1.94-wip 1 of 435.
  - Still open (fixed in v2.1.95-wip): that 1 loss is a tab switch race. Right taps the Ship Parts tab, and
    Down within 12 frames (before COLL_PAGE changes) holds a slot on the old tab; the new tab then has no press.

v2.1.93-wip (2026-10-24, rig tested; user tested in RetroArch 2026-10-24: "both buttons work great"; released as v2.1.80 the same day on the user's request (builds\v2.1.80\: bps 28,342, xdelta 30,321, README, source zip rebuilt to the same SHA-1, xdelta re-applied with src/apply.py to the same SHA-1); ROM in builds\, = root playthrough ROM; playthrough .srm kept): letter screen on buttons (user request, user state 825: a red mailbox,
  "sign" a letter in an ink box, OK and Rewrite buttons). Design approved by the user; the user then dropped the planned
  auto-signature (Y / A on an empty box wrote "Link" via fg_x / fg_y strokes) to save code space.
  ROM "Phantom Hourglass US - Button Controls v2.1.93-wip.nds", SHA-1 a7227218c7711da0e3640f157cdf7bc2c29114ab,
  CRC32 904b5c25; based on v2.1.92-wip; source known2.1.93-wip_dpad.s; dpad.bin 18229 bytes, CODE_RESERVE 0x4800
  (was 0x4700), 203 bytes free:
  - Found (rig, state 825 = v2.1.91-wip code): OK = touch button id 0x90, Rewrite = 0x91 (layout cell 0x47, elements
    0 / 1, centres (69, 177) / (185, 177)). Mode 1, keys not gated. The game hides OK (no update) while the box is
    empty. Two stylus samples in a row are joined by a line (a stroke).
  - Old behaviour: A / B on this screen hit the text box rule (ch_seen set): a tap at (128, 168), which does nothing.
  - Fix: fs_btn stamps ids SIGN_ID / + 1 into sg_tab; new sig_ctl (after goron_ctl, so before the text box rule):
    while Rewrite is live, A / B are hidden from the game; B taps Rewrite, A taps OK if OK is live.
  - Rig (state 825 hot-linked at 0x21d2000, old / new symbols re-aimed, one-shot cache flush stub, scratchpad hot.py):
    A with ink = OK ("Wooo! Thanks much!"); B = box cleared, OK gone; A on the empty box = nothing; stylus strokes
    then A = OK.

v2.1.92-wip (2026-10-24, rig tested; user tested in RetroArch 2026-10-24: "all tests pass!" (NPC choices by stylus and D-pad, Save No); released as v2.1.79 the same day on the user's request (builds\v2.1.79\: bps 28,262, xdelta 30,241, README, source zip rebuilt to the same SHA-1, xdelta re-applied with src/apply.py to the same SHA-1); ROM in builds\, = root playthrough ROM; playthrough .srm kept): a stylus tap picks a dialogue choice again.
  ROM "Phantom Hourglass US - Button Controls v2.1.92-wip.nds", SHA-1 33735b5fb6d9678051042ad758b262adfbbc19f7,
  CRC32 56b04042; based on v2.1.91-wip; source known2.1.92-wip_dpad.s; dpad.bin 18073 bytes, 103 free of 0x4700:
  - User report: the D-pad works on dialogue choices, but a stylus tap on a bubble no longer picks it.
    Cause: since v2.1.11-wip choice_ctl holds the fake stylus on the top bubble (ch_tap CH_HOLD, no end), and
    menu_touch writes that press over every real sample. Only the menu bar / Sea Chart (mb_sel / sc_sel) let the
    real stylus take over.
  - Fix (menu_touch): the same takeover while msgwin MW_AUTO is set (choices up, set by choice_ctl) and the phase
    is not CH_LIFT: the first real update passes (a slide off the held bubble cancels it), the next is forced up,
    then the real stylus owns the screen. MW_AUTO stays set, so choice_ctl presses again only on Up / Down.
  - Rig (fresh boot, playthrough .srm copy, Select > Save = "Save your progress?", Yes held): stylus 10 frames on
    No = back to the field, no save; on Yes = "Save complete."; Down + A = No; A = Yes (saving). A 4-frame tap only
    cancels the held Yes (no bubble lit); a second tap on No then picks it, or Down x2 + A picks No. Menu bar: Save
    held, stylus on Map = map opens (old takeover still works).
  - Not tested: NPC choices with 3-4 bubbles.

v2.1.91-wip (2026-10-24, rig tested (hot-linked into user states 806 / 807, which hold the v2.1.76 code); user tested in RetroArch 2026-10-24: "hammer is equipped in the direction link is facing
  without turning him", "boulders do not lock Link in place, he is able to move left and right after pushing them"; released as v2.1.78 the same day on the user's
  request (builds\v2.1.78\: bps 28,242, xdelta 30,221, README, source zip rebuilt to the same SHA-1, xdelta re-applied with
  src/apply.py to the same SHA-1); ROM in builds\, = root playthrough ROM; playthrough .srm kept;
  SHA-1 d0b363811cd1c4916fc4e4a7eee262be68f7970e, CRC32 38239636; based on v2.1.90-wip; source known\v2.1.91-wip_dpad.s;
  CODE_RESERVE 0x4500 -> 0x4700, 18041 bytes, 135 free):
  - User report 1 (state 806, 1F with a switch on a pedestal): taking the hammer out turned Link away from his facing.
    Cause (decomp LinkStateItem::func_ov059_021990a4 / 02198ffc): with the hammer out and idle, each frame Link turns
    (0x2000 steps) toward touch ctl +0xbc (PlayerControl::mAimWorld), and taking the hammer out sets that to the fairy's
    position (rig: (-10096, 2075, 5588), 2075 above the floor). A stylus user moves it with the next touch; buttons never did.
    The user saw it too: "it almost looks like equipping the hammer faces him in the direction of his fairy".
    Fix (ham_aim, called by tap_front each touch update): hammer equipped, EquipHammer +0x18 = 0 (idle), no stylus down,
    no menu_tap: aim point = Link + 1.5 tiles the held D-pad way, else gPlayerAngle (8 ways, it_vec). So Link keeps his
    facing and the D-pad turns him (it did nothing with the hammer out before).
    Rig (state 806): X from facing none / down / left / up-left / down-right: angle kept (0eef snapped to 0000);
    out: Down / Right / Up / Down-left turn Link; A swings down-left; X puts it away; walking after it works.
  - User report 2 (state 807, B1, a round boulder): pushing it froze Link until he found the right direction.
    Cause (rig): A grabs it (Link state 2 = Interact, touch ctl +0x94 = 0x7c, grab_on). (1) After the push Link is free
    (state 0) but +0x94 keeps the boulder, so dpad_move still skipped Left / Right (the push axis). (2) While grabbing,
    the game ignores our D-pad steering (it lets go only on a stylus touch), so no direction moved Link.
    Fix (tap_front): (1) a grab also needs Link out of the Move state. (2) Link in the Interact state with the D-pad held
    (no new A): sideways = one release tap that way at once (do_probe THROW_IDX, the D-pad octant); away = the same after
    REL_AWAY (12) touch updates, so away + A still pulls a block; toward = waits for A (push). No release for REL_ARROW
    (32) touch updates after an arrow tap (rel_wait < 0), while the block moves. New helper pad_dir (dir_table lookup).
    Rig (state 807): after the grab, Up / Down / Left / Up-left / Up-right / Down-left walk off; Right / Down-right (toward)
    stay; A pushes 1 tile; after the push Left and Right walk; Right held + A pushes.
  - Rig method: states 806 / 807 hold v2.1.76 code (99.5 % match with a v2.1.88-wip source build). New dpad.o linked at
    0x023B0000 (free in both states), runtime variables copied, 11 hooks / pointers re-aimed by old -> new symbol.
  - Not tested: square push blocks (no state near one; the Move-state check assumes Link is in the Interact state while
    holding one, as with the boulder), a real RetroArch run. Fresh boot (playthrough .srm copy): file select, field walk, B.

v2.1.90-wip (2026-10-24, rig tested; user tested in RetroArch 2026-10-24: "A swings once and does not turn Link"; released as v2.1.77 the same day on the user's
  request (builds\v2.1.77\: bps 27,930, xdelta 29,909, README, source zip rebuilt to the same SHA-1, xdelta re-applied with
  src/apply.py to the same SHA-1); ROM in builds\, = root playthrough ROM; playthrough .srm kept; SHA-1
  0e0bc014d2f026794304066cb6190b740110dc74, CRC32 898a0164; based on v2.1.76; source known\v2.1.90-wip_dpad.s; committed 9dc2a1c):
  - User report (state 1, v2.1.89-wip, a dungeon 1F, two tablets): standing facing left or down, A turned Link slightly and
    swung the sword diagonally.
  - Cause (rig log): A on bare ground sends the probe taps; the first tap ~18-20px from Link on the ground (left/right:
    probe 1) starts the swing toward that tap. (1) The probes went on during the swing and each one swung again
    toward its own off-axis spot (down: (-14, 20) swung down-left). (2) Each follow-up probe took its octant from
    touch ctl +0x6a = the last tap's heading, which the 10px lift turns, so left drifted to up-left. (3) The game takes
    the swing heading from a point ~6px below Link's feet on screen, so the lifted side tap swung ~25 deg up
    (rig sweep: (-18, 0) -> 0xb98b, (-18, 6) -> 0xc000). Diagonal headings also depend on where earlier probes turned Link.
  - Fix (tap_front): follow-up probes keep probe_oct (the first probe's octant). In the follow-up path, Link in the
    item state (sword swing) = stop probing and set gPlayerAngle = camera yaw + probe_oct * 0x2000 (Link and the
    swing turn with it; rig: forced 0x6000 held). probe_table unchanged (object probing stays as tuned).
  - New .ltorg after dir_table: the added literals put the end pool out of reach of fg_ctl (3949). 17541 bytes, 123 free.
  - Rig (state 1, hot-linked into the v2.1.89 code): one swing per A, end heading left c000, right 4000, down 0, up 8000,
    down-left e000, down-right 2000, up-left a000, up-right 6000 (two Link spots). The first 1-2 frames of a side
    swing still start tilted, before the next logic frame turns Link. In the start spot, up-right probe 0 hits the
    tablet with Ciela and the game swings toward it 10 frames later (6cdb): a target, not a probe swing; unchanged.

v2.1.89-wip (2026-10-24, rig tested; user tested in RetroArch: "all tests pass"; released as v2.1.76 the same day (builds\v2.1.76\: bps, xdelta,
  README, source zip rebuilt to the same SHA-1, xdelta re-applied with src/apply.py to the same SHA-1); ROM and wip patches in builds\;
  SHA-1 74504cc896a5ccaa043b8fcb48a91ced316237d8, CRC32 dde8472d): same game as v2.1.75, much smaller patch (pre-public review).
  Patch size: bps 1,311,010 -> 27,886 bytes, xdelta 1,311,568 -> 29,866 bytes. Literal bytes in the patch: 24,790 (our compressed
  code + autoload table 12,007; edit fragments in ARM9 / overlays ~300; BMG text edits and their offset tables ~12,200).
  Cause: build_v2 recompressed ARM9 and overlays 0/3/9/14 from scratch, so each new BLZ stream differed everywhere.
  - blzenc.recompress(orig, data): parses the original BLZ token stream, keeps every token that still decodes to the new bytes,
    re-encodes only the spans between them, and splits refs (len l -> l-1 + literal) so that the next kept token has its
    original slot in its group of 8 (one flag byte per group). Then the stream after an edit is the original bytes, only
    shifted. Keeps the original cut (raw prefix) if blz_dec (an in-place decode, as on the DS) still matches, else the
    argmax cut as compress(). recompress(f, blz_dec(f)) == f for ARM9 and overlays 0/3/9/14 of the clean ROM.
  - ARM9: the plan was to leave the tail (autoload table + our code) uncompressed. Not possible: the clean ARM9 is
    compressed to its end (comp_end = file end, raw prefix 1 byte, the old table is inside the stream), and an uncompressed
    tail after comp_end would be overwritten by the in-place decode. So our code + the new table are new tokens at the
    reversed start of the original stream.
  - mkpatch: ops() adds copies from any source offset (hash of each 32-byte aligned source block, then the match grows
    both ways): BPS SourceCopy; VCDIFF COPY in each window's own source segment (window <= 8 MiB, segment <= 16 MiB).
    Both still verified (apply_bps, src/apply.py). Not yet checked with the official xdelta3 or Flips (none installed here).
  - Proof (scratchpad prove.py, v2.1.75 vs v2.1.89-wip): decoded ARM9 identical except compressed_static_end
    (0x02000b78); all 62 decoded overlays and overlay table entries identical except the size field; all other files
    identical (15 MESG text files too); ARM7 identical; header differs only in ARM9 size (0x2c) and CRC (0x15e).
  - Rig (fresh boot, playthrough .srm copy): title, file select (Start, A), in the field D-pad Right / Up move Link,
    B slashes. The playthrough .srm was copied to the wip save name (not the other way).
  - compress() gives the same output as before (rebuilt v2.1.75: same SHA-1).
v2.1.88-wip (2026-10-23, rig tested by data poke only; released as v2.1.75 on 2026-10-24 (builds\v2.1.75\: bps, xdelta, README, source zip rebuilt to the same SHA-1); ROM in builds\;
  SHA-1 c49f77eab798667024d85cafe516eaa75dfb79c7, CRC32 8eccd90c, 255 bytes free of 0x4500): A below a pedestal places the stone.
  User report (state 649, Temple of the Ocean King B9, Link below the center pedestal, carrying a stone): A did not place it.
  Cause (rig): standing + carrying = set-down tap (drop_table), 30px up for octant 4 = on Link's head / the held stone, so the
  stone was set down at his feet. A stylus tap 19px up (y 98 on the touch screen; 88 does nothing) hits the pedestal and places it.
  Change: do_probe: DROP + octant 4 + gPlayer+0x3c != -1 (actor carried) uses drop_up (0, -19) (octant index 8 of drop_table).
  Bombs unchanged (-30). CODE_RESERVE 0x4400 -> 0x4500. Source: patch_src/dpad.s (= known\v2.1.88-wip_dpad.s).
  Not tested: the new code itself (state 649 holds old code; poking drop_table byte -30 -> -19 in the state gave the stylus result),
  pedestals to the left / right of Link, real RetroArch.v2.1.87-wip (2026-10-22, NOT rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.87-wip.nds",
  SHA-1 a6fe4bccaa152c32d487c4b52f760fd4eded8d2b, CRC32 c84b2512, 35 bytes free of 0x4400): hook line starts at Link, then sweeps out.
  User report on v2.1.73: full length at the first read cannot attach the hook to a post beside Link (the line never passed it).
  Change: HK_START 255 -> 0, HK_STEP 5 -> 32 (first point ~1/8 of the way to the edge, full at the 8th read = BOW_MIN, as fast as
  the bow's minimum). Source: patch_src/dpad.s (= known\v2.1.87-wip_dpad.s). Not released; v2.1.73 is the playthrough ROM.
v2.1.86-wip (2026-10-22, NOT rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.86-wip.nds",
  SHA-1 39941546bbc536ffb8448ba1b16d4183acf01809, CRC32 12edaa52, 35 bytes free of 0x4400): hook hold A draws the line at once.
  User request: the line was slow (HK_START 20 + HK_STEP 5 per read, full in ~47 reads); the bow's line is full at the first read.
  Change: .equ HK_START 20 -> 255 (hk_hold caps at 255 = full length at once). A quick tap now throws the full length; the
  growth code stays (HK_STEP unused). Source: patch_src/dpad.s (= known\v2.1.86-wip_dpad.s). Built on v2.1.85-wip's code.
v2.1.85-wip (2026-10-22, rig tested on user state 615; user test due; root "Phantom Hourglass US - Button Controls v2.1.85-wip.nds",
  SHA-1 0d4bdabc8a175a8e975d15fc4a2359860ca0a4f9, 35 bytes free of 0x4400): hold A (or B) rolls Gongoron in the Goron rupee minigame.
  - Found (user state 615): the minigame has no swap button, so gr_tab byte 3 never says "Gongoron" and fg_roll did nothing. The roll
    is the same far held stylus (Link state 4, sub-state 9, ~24 reads). The minigame controller is the one object in the pool
    (OBJ_MGR) with vtable 0x0217a724 (states 615 / 617 / 618 yes; 613 / 614 / 616 in the same hall no).
  - Code: fg_roll: neither A nor B held = lift; swap button live with Gongoron = B as before; else mg_find (pool scan for MG_VT) = A or B.
    Minigame: fg_step = RL_FLAG + 1 (no RL_TOP / RL_BOT clamp: no swap button, and Gongoron near the top needs the stylus 57+ px away).
    New .ltorg after skip_ctl (a new literal pool was out of range). Dungeon: B only (A is not a roll key there).
  - Rig (hotx.py, state 615): A alone, B alone, A + Left all roll (state 4 / 9 after ~24 frames; Left rolls to the left edge); state 616
    (Yes / Nope text box): A is not taken. NOT tested: real RetroArch; the ball steering with the D-pad mid-roll.
  - Rig note: state 615 holds v2.1.70 code (msg_guard 0x219f230, CODE_RESERVE 0x4300), not the root ROM's v2.1.71. The new code does not fit
    that reserve, so it is linked at a free RAM range (zeros at 0x021df000), hooks re-aimed, runtime variables copied (scratchpad hotx.py).
v2.1.84-wip (2026-10-22, rig tested; released as v2.1.71; ROM in builds\; 187 bytes free of 0x4400):
  fix: hold A did not free Link from ice (user state 608, root v2.1.70: state 5, +0x18 = 6, counter +0x20 stayed 15 after 120 frames
  of hold A). Cause (rig, raw touches on state 608): pad_update runs every frame here, the game samples the stylus every 2nd one,
  and fg_hide flipped the stroke side every read, so the game always saw the same side. Raw strokes with a side per 2, 3, 4 or
  6 frames freed Link; a side per frame never did. Fix: fg_grab1 ice branch sets r5 = 4; fg_hide turns that into r5 = 0 and
  r12 = 2 (a side per 2 reads: tst r2, r12). Other rubs unchanged (r12 = 1).
  Rig: hot.py (old v2.1.70 symbols from a rebuilt copy, new dpad.bin linked into state 608): hold A 150 frames = Link free,
  no ice, no bubble. Not tested: real RetroArch; a fresh freeze.
  ROM SHA-1 8cb83c5349d062f4691dcdf7d2cd90141b0ede31, CRC32 afe233a6. Source: patch_src/dpad.s (= known\v2.1.84-wip_dpad.s).
  Released as v2.1.71 on the user's request: builds\v2.1.71\ (bps, xdelta, README, source zip; zip rebuilt to the same SHA-1,
  xdelta re-applied with src/apply.py, same SHA-1). Root playthrough ROM = v2.1.71; docs\README.txt and test-checklist.md updated;
  the playthrough .srm is untouched. v2.1.83-wip moved to builds\ (released inside v2.1.71).
v2.1.83-wip (2026-10-22, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.83-wip.nds", 219 bytes free of 0x4400):
  fix: hold A on a grappling hook post jumped the wrong way when Link faced the void (user state 601: facing up, the platform is
  down the screen). The old code aimed the stylus at the D-pad's way, else the way he faces: A alone / A + Up jumped into the pit
  (damage, then he comes back to the post). Now fg_grab calls fg_hide with r5 = 2 and bw_pt (r5 = 2) takes the post's own way:
  Link state +0x16 (u16 angle, 0 = +z) when state +0x15 is set, via hd_oct (bw_po); else the old aim. Every D-pad way jumps along
  the post's line (post-specific; the game's jump cone is 0x2000 each side of +0x16, 0x210bed0). CODE_RESERVE 0x4400 (was 0x4300).
  Rig (hot.py: new dpad.bin linked into state 601, hooks re-aimed by symbol; the 65 bytes past the old reserve did no harm in a
  short test): A alone, A + Down, A + Left, A + Down + Left, 8 frame tap: Link lands on the platform (state 0). A + Up held: he
  lands, then the held Up walks him back onto the post (sub-state 10 again; release Up). Not tested: real RetroArch; other posts.
  ROM SHA-1 1d9b2b05ab77d4a6b551fb416d39701bd0bcc257, CRC32 5cc7a057. Save: "...v2.1.83-wip.srm" = a copy of the playthrough .srm.
  Source: patch_src/dpad.s (= known\v2.1.83-wip_dpad.s).
v2.1.82-wip (2026-10-22, rig tested; user test due; wip moved to builds\; 7 bytes free of 0x4300):
  feature: grappling hook out (item state +0x14 = 6, IT_HOOK; user state 597): held A = the longer, the farther the throw.
  - Game: a stylus line from Link, lifted = the hook flies as far as the line went (rig: strokes of 30 / 90 px).
  - Code: fg_off dispatch -> hk_hold (new, before fg_grab). fg_step = reads down (a short press stays down HK_MIN 6), fg_hk (new byte,
    fg_mode + 7) = length HK_START 20 + HK_STEP 5 per read, max 255 (/256 of the way to the screen edge on the aim way). bw_pt aims as for
    the bow (D-pad, else last aim / facing); bw_ok scales the edge point from Link's point (stored in fg_x / fg_y before the loop).
    fg_lift clears fg_hk. adr fg_circle changed to ldr = (out of range).
  Rig (hot.py on user state 597, old v2.1.81 symbols): A 4 frames = short hook; A 25 frames = medium; A 70 frames + Left = reaches the
  far stump. Not tested: real RetroArch; Up / Down / diagonals; hook on a post target; pad read rate vs growth speed (full length ~47 reads).
  Source: patch_src/dpad.s (= known\v2.1.82-wip_dpad.s). Save: "...v2.1.82-wip.srm" = a copy of the playthrough .srm.
  Released as v2.1.70 on the user's request (2026-10-22): builds\v2.1.70\ (bps, xdelta, README, source zip; rebuilt from the extracted zip to the same SHA-1,
  xdelta re-applied with src/apply.py, same SHA-1). ROM SHA-1 f6f40cb45ca773b5f0244e90517daef8356c781e, CRC32 501836f6. Root playthrough ROM = v2.1.70; docs\README.txt and test-checklist.md updated; the playthrough .srm is untouched.

v2.1.81-wip (2026-10-22, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.81-wip.nds", 171 bytes free of 0x4300):
  fix: carrying a bomb and standing, A always set it down to the NE (user state 592: Link faces down, bomb went up-right).
  - Cause: standing A with a held object = DROP_IDX tap (drop_table, octant per Link's facing). With no D-pad press in the last
    DIR_FRESH frames, do_probe took the octant from [r4 + 0x6a] = the touch controller's heading of the LAST TAP, not Link's
    facing; after a lift / pickup tap that heading is always up-right. (Throws and probes keep +0x6a: unchanged.)
  - Fix: do_probe, DROP_IDX only: heading = PLAYER_ANGLE (gPlayerAngle, 0x027e0fac). drop_table up entry (0, -20) -> (0, -30):
    20-24 px up is still on Link's head, the bomb went up-right (28 and 32 were straight above him).
  Rig (hot-linked into state 592, old / new dpad.sym re-aimed, scratchpad hot.py): idle 30+ frames then A = bomb below Link
  (he faces down); after Left / Right / Down / Up + Up-Right / Up-Left walks of 8 frames and 70 idle frames, A = bomb set down
  on that side. Old code, same state: bomb up-right. A pressed 5 frames after the state loads is lost (rig start-up, not code).
  Not tested: real RetroArch; down-left / down-right facings (table unchanged).
  ROM SHA-1 58d7d6087d15eb3a2c25d30c9d0250c5409c7964, CRC32 39c50914. Save: "...v2.1.81-wip.srm" = a copy of the playthrough .srm.
  Source: patch_src/dpad.s (= known\v2.1.81-wip_dpad.s).
  Released as v2.1.69 on the user's request (2026-10-22): builds\v2.1.69\ (bps, xdelta, README, source zip; rebuilt from the
  extracted zip to the same SHA-1, xdelta re-applied with src/apply.py, same SHA-1). Root playthrough ROM = v2.1.69, wip moved
  to builds\; docs\README.txt updated; the playthrough .srm is untouched.

v2.1.80-wip (2026-10-22, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.80-wip.nds", 183 bytes free of 0x4300):
  fix: Link stuck on a grappling hook post (user states 587 / 588: no button freed him; the item bar in 588 was a slip).
  The post is Link state id 3 (LinkStateFollow, table [[LINK_STATES]] + 12, vtable 0x020e5744), sub-state (state +4) 10
  = standing on it. The game steps him off when the stylus is held on the floor away from him (ov0 0x0210bed0; a 6 frame
  tap did nothing, 30 frames did). Fix: fg_grab first checks that state and sub-state: held A = the stylus held far on the
  D-pad's way (else the way he faces), as the bow does (fg_hide / bw_pt). Rig (hot.py: new dpad.bin linked into state 587,
  hooks re-aimed by symbol; scratchpad): A alone and A + Left jump the way he faces, into the pit (damage state 5);
  A + Down and A + Right land on the platform. Same edit fixed a probable bug in the v2.1.79 ice rub: fg_grab read the
  state table with one load instead of two (LINK_STATES is a pointer to the table), so the damage state never matched.
  The ice rub is still untested (state 584 is from older code and hot.py does not map it).
v2.1.78-wip (2026-10-21, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.78-wip.nds", 247 bytes free of 0x4300):
  fix: after a visit to the treasure merchant the D-pad did not click through the collection Items page (user report; no state).
  - Cause: ip_ctl read the item list at the fixed IP_LIST 0x020fa1f0. It is the Ship Parts panel - 0xd18 (fixed 0x020faf08 gives
    exactly IP_LIST), so it moves with the panels once overlay 45 is loaded (state 552: 0x020f7214).
  - Code: ip_head (new, after ip_node): r6 = [[COLL_OBJ] + MB_PANELS] - 0xd18 when that pointer is in main RAM, else IP_LIST.
    ip_ctl and ip_node call it (4 sites; ip_node now pushes lr). CODE_RESERVE 0x4300 (was 0x4200); dpad.bin 16905 bytes.
  Rig (state 552 with the code poked in as for v2.1.77-wip, COLL_PAGE poked to 2): Down asks for a stylus hold at (58, 59), an
  item; no key: none. The screen still shows Ship Parts (page poke only), so the item itself was not seen. Fresh boot with the
  playthrough .srm: field mode 1, Link walks. Not tested: real RetroArch; swap (Y) and L / R pages after the merchant.
  ROM SHA-1 9f6e07bc728f138e94993c438ef81b2076f85d34, CRC32 e37e421e. Save: "...v2.1.78-wip.srm" = a copy of the playthrough .srm.
  Source: patch_src/dpad.s (= known\v2.1.78-wip_dpad.s). Includes v2.1.77-wip.
  Released as v2.1.66 on the user's request (2026-10-21, before a RetroArch test): builds\v2.1.66\ (bps, xdelta, README, source zip;
  rebuilt from the extracted zip to the same SHA-1, xdelta re-applied with src/apply.py, same SHA-1). Root playthrough ROM = v2.1.66;
  the playthrough .srm is untouched.

v2.1.77-wip (2026-10-21, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.77-wip.nds", 67 bytes free of 0x4200):
  fix: the D-pad did nothing on the collection Ship Parts / Treasure screen (user state 552, magic box unlocked).
  - Cause: coll_ctl took the two tab panels from the fixed table cl_base (0x020faf08, 0x020fc3f0). The panels are allocated with the
    collection object: with overlay 45 (merchant / magic box, MC_OVL_SLOT = 45) resident they sit elsewhere (states 551 / 552:
    0x020f7f2c, 0x020f9414 = 0x2fdc lower; state 363 page 7: 0x020f71c4, 0x020f86ac). States 25, 27, 236, 237 (no overlay 45)
    keep the fixed addresses. [COLL_OBJ] + MB_PANELS (0x310) points at the real panels in every state (checked all 7 states with a
    collection mode). With the wrong panel coll_ctl saw no grid, hid A / B / D-pad from the game and did nothing.
  - Code: coll_ctl, tabs 0 / 1 (collection, not the shipyard Customize): r9 = [[COLL_OBJ] + MB_PANELS + 4 * tab] when that is in
    main RAM, else the cl_base entry. A .ltorg after it (the pool for coll_ctl's first literals went out of range).
  Rig (state 552 is keyed to older code: scratchpad hot5.py pokes the new dpad.bin at 0x0219B120, re-aims the 8 BL hooks and the
  fs_btn vtable word, and runs a one-shot cache invalidate stub (the emulated caches hold the old code and data): Down = Ship
  Parts slot 1 held, Right = slot 2, A = Weighty Anchor entry; Up, Left = Treasure tab, Down, A = Pink Coral, B = back to the grid.
  The same keys on the old code: nothing. Fresh boot with the playthrough .srm: field mode 1, Link walks.
  Not tested: real RetroArch; merchant / magic box / shipyard after the change (their code path is unchanged).
  Open (not fixed): the Items page uses the fixed IP_LIST 0x020fa1f0 too; in state 552 its list is at 0x20f7214 (= Ship Parts
  panel - 0xd18, the same delta as the fixed addresses), so the Items page D-pad is probably broken the same way with overlay 45.
  ROM SHA-1 f293ea06aa4c8d1b7af7bed1100d319641452c32, CRC32 99b887b7. Save: "...v2.1.77-wip.srm" = a copy of the playthrough .srm.
  Source: patch_src/dpad.s (= known\v2.1.77-wip_dpad.s). Based on v2.1.65 (v2.1.76-wip).

v2.1.76-wip (2026-10-21, rig tested; user test due; released as v2.1.65 on the user's request; 123 bytes free of 0x4200):
  item bar flash (user report, state 542): a D-pad move is slide + lift + press; with no icon pressed the game draws its frame on the
  equipped item (the shovel), for CH_MOVE_STEP + CH_MOVE_STEP = 4 touch updates (~8 frames). Now ib_move sets ib_sel + 1 = 1 on a
  CH_DRAG: the slide lasts 1 update and menu_touch makes the CH_RELEASE lift 1 update (~4 frames). Cleared when the stylus is
  pressed again (ib_ctl CH_HOLD) or the bar is closed. Other menus keep their step counts.
  Rig (fresh boot with a playthrough .srm copy, dungeon): R opens, Right x3 / Left move, A equips, R + Left x2, B closes; gap 4 frames.
  Includes v2.1.75-wip (bombchu panel fix, user test still due). Released as v2.1.65: builds\v2.1.65\ (bps, xdelta, README, source zip;
  rebuilt from the extracted zip, xdelta re-applied with src/apply.py, same SHA-1). Root playthrough ROM replaced. Playthrough .srm kept.

v2.1.75-wip (2026-10-21, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.75-wip.nds", 199 bytes free of 0x4200):
  fix for v2.1.63 / v2.1.73-wip: on the bombchu route panel (user state 537) A (GO!) and B (CANCEL) did nothing; B = Back worked.
  - Cause: the panel flag was read through the word 0x020e9c2c, which points at the route object only in some states (526: yes,
    525 / 537: no; 537 has it at 0x020e9c38). Now: route object = [MAP_OBJ] - 0x5fc (525 / 526: 0x21d2f3c, 537: 0x21d303c,
    both with the screen object 0x5fc above), vtable 0x02158ef4, byte +0x14 = panel. Not a button hook: the GO! / CANCEL
    buttons (id 0x1e, cells 4 / 5) never reached fs_btn in the rig.
  - Rig (state code relinked at a free RAM range, scratchpad hotgen2.py, 11 hooks re-aimed): state 537: A = bombchu launches
    (mode 1); B = flag 0, map stays (mode 0x0d); state 525 (no route): B = back (mode 1), A left to the game (mode 0x0d).
  - Based on v2.1.64 (the other session's release; dpad.s already had it).

v2.1.74-wip (2026-10-21, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.74-wip.nds", 203 bytes free of 0x4200):
  hold A rubs little green blobs off Link (user state 531: Link in a temple room, 3 green blobs on his hands / feet, "RUB!" bubble).
  - Found (rig, state 531, root v2.1.63): Link is in state 0 (not 4) with gPlayer (0x027e0f90) +0x48 = 2 while the blobs cling.
    That word is 0 free, 8 sand monster (state 172), 32 sword clash (state 360), 2 blobs (state 531): checked over all 558
    user states, only those four are nonzero (Like Like state 518 = 0). A stylus zig-zag (every 2 frames a side, any
    place) starts a 16 frame shake-off (state 4, sub-state 4, +0xc counts 1, 2), then state 0 again; about 70 frames of
    rubbing frees Link (flag 0, blobs scatter). No input: never ends (300+ frames).
  - Cause: fish_ctl fg_off only rubbed in state 4 sub-states 6 to 8, so A did nothing in state 0, and in the shake-off
    (state 4, sub-state 4) A went back to the game after 4 reads (stylus up, the rub restarted every ~24 frames).
  - Code: fish_ctl fg_off: state not held and not the bow -> fg_grab (was fg_roll): gPlayer +0x48 bit 2 set and A held ->
    fg_rub (the rub, r5 = 0); else fg_roll as before. State 4 with a sub-state outside 6 to 8 -> fg_grab4: the same flag
    test, rub or stylus up. CODE_RESERVE 0x4200 (was 0x4100); dpad.bin 16693 bytes.
  Rig (scratchpad hot531.py: dpad.o linked at a free range 0x023C0000, poked into state 531, hooks re-aimed, JIT off):
  held A = Link freed after ~75 frames (flag 0), no input = still held at 300. States 172 / 360 with the new code: still
  freed (no worse than without A). Fresh boot with the playthrough .srm: file select, field, Link walks, A held = no crash.
  Not tested: real RetroArch; other blob rooms; several blob groups; hold A while a text box is open (msg_guard stops it).
  ROM: root "Phantom Hourglass US - Button Controls v2.1.74-wip.nds", SHA-1 fd864d8fefe768d448f76b9cb4ca1028f8b617dc, CRC32
  2bae26b3. Save: "...v2.1.74-wip.srm" in RetroArch saves\melonDS DS\ = a copy of the playthrough .srm. Source: patch_src/dpad.s.
  User state 531 is keyed to the playthrough ROM and holds the old code: the user needs a new grab with this wip.
  Released as v2.1.64 on the user's request (2026-10-21, before a RetroArch test): builds\v2.1.64\ (bps, xdelta, README, source
  zip; rebuilt from the extracted zip to the same SHA-1, xdelta re-applied with src/apply.py, same SHA-1). Root playthrough ROM
  replaced; wip moved to builds\ (release ROM builds\"... v2.1.64.nds"). docs\README.txt updated. Playthrough .srm kept.

v2.1.73-wip (2026-10-21, rig tested; user test due; root "Phantom Hourglass US - Button Controls v2.1.73-wip.nds", 15 bytes free):
  bombchu map screen (mode 0x0d, user states 525 / 526): B = its back arrow; once a route is drawn A = GO!, B = CANCEL.
  - Code: dpad.s, in pad_update at label 4 (before the map note X code), block BCHU_MODE. Taps by menu_tap_at: back (SLATE_BACK 15,177),
    GO! (92,160), CANCEL (163,160). Panel flag: word 0x020e9c2c = route object (vtable 0x02158ef4), byte +0x14 = 1 once a
    route is drawn, 0 after GO! / CANCEL. Not checked: the flag value while the stylus is still drawing.
  - Rig (state 525 + new code poked over the old, 9 hooks re-aimed, route drawn with a temporary scratch drag command): B on
    the screen = back (mode 0x0d -> 0x0f); A after a route = GO! (bombchu launches, mode 0x0f); B after a route = CANCEL
    (panel flag 0, still mode 0x0d); A with no route = left to the game.
  Released as v2.1.63 on the user's request (2026-10-21) for a live test: builds\v2.1.63\ (bps, xdelta, README, source zip;
  rebuilt from the extracted zip and xdelta re-applied with src/apply.py, same SHA-1). Root playthrough ROM replaced; wip
  moved to builds\ (release ROM builds\"... v2.1.63.nds"). docs\README.txt updated. Playthrough .srm kept.

v2.1.72-wip (2026-10-21, rig tested; user test due): hold B = Gongoron curls and rolls (user request, user state 522:
  Gongoron could only roll after a stylus drag away from him).
  - Found (rig, state 522): the roll = Link state 4, sub-state 9. A stylus held 57+ px from Gongoron (screen ~128,106)
    for ~24 pad reads starts it (50 px or less never; the D-pad run, which sets the touch ctl +0x58 without a stylus,
    never does). The roll goes on a while after the stylus lifts, then Link state 5, 0.
  - Form: the swap button object (id 0x1c, cell 0x30) byte +0x11 = 1 while playing Gongoron, 0 as Link (states 517 / 518 / 522).
    fs_btn copies it to gr_tab byte 3 (GORON_FORM).
  - Code: fish_ctl fg_off: Link state not held and not the bow, gr_tab live with byte 3 = 1, B held -> fg_roll: B hidden
    from the game, the bow's far-stylus path (bw_pt) on the D-pad's way (else the way he faces; it_oct reset to 0xff so the bow's
    old aim is not used); fg_step = RL_FLAG makes bw_ok keep y in RL_TOP 40 .. RL_BOT 168 (the swap button is at the top
    centre: a stylus there swapped to Link; Menu / Items at the bottom). Link form: B stays the sword (rig: state 517, B = state 1).
  - CODE_RESERVE 0x4100 (was 0x4000); dpad.bin 16441 bytes (199 free). A rig copy of the code is linked at a free RAM
    range (scratchpad hot522.py: ld.lld on dpad.o at the first zero 0x4200 range, hooks re-aimed) because the new reserve
    does not fit a state made with the old one.
  Rig (state 522): B alone = rolls in the facing way after ~28 frames; B + Up, B + Left roll too (Left until the wall, then
  state 5); B released = stylus up. Not tested: real RetroArch; steering the roll with the D-pad mid-roll; Gongoron near
  the screen edge (the roll stylus can be closer than 57 px there); bow aim in the temple still reaches the swap button.
  ROM: "Phantom Hourglass US - Button Controls v2.1.72-wip.nds" (root), SHA-1 e293c692cb084e8d31c5649e574cd4f800b69991,
  CRC32 bc032330. Save: "...v2.1.72-wip.srm" = a copy of the playthrough .srm. Source: patch_src/dpad.s.
  User test (RetroArch): "working as designed". Released as v2.1.62 (2026-10-21): builds\v2.1.62\ (bps, xdelta, README, source
  zip; rebuilt from the extracted zip and xdelta re-applied with src/apply.py, same SHA-1). Root playthrough ROM replaced; wip
  moved to builds\ (release ROM builds\"... v2.1.62.nds"). docs\README.txt updated. Playthrough .srm kept.

v2.1.71-wip (2026-10-21, rig tested; user test due): hold A rubs free from a Like Like (Goron Temple; user state 518).
  - Cause: the Like Like holds Link in Link state 4 with sub-state 7; the rub code only knew 6 (sand monster) and
    8 (sword clash). fish_ctl fg_off now takes sub-states 6 to 8 (sub / cmp / bhi, same size).
  - dpad.bin 16305 bytes (79 free of 0x4000).
  Rig (scratchpad hot518.py: new dpad.bin poked into state 518, hooks re-aimed, JIT off): no input = Link held ~200
  frames (second grab: state 4/7 -> 5 -> 0); held A = freed after ~100 frames.
  Not tested: real RetroArch; other Like Like rooms; rub with several Like Likes.
  ROM: "Phantom Hourglass US - Button Controls v2.1.71-wip.nds" (root), SHA-1 e4fa50ce18a10a7d5607f3d36211e42cb392bf7e,
  CRC32 4a0f147c. Source: patch_src/dpad.s. Save: "...v2.1.71-wip.srm" in RetroArch saves\melonDS DS\ = a copy of the playthrough .srm.
  Released as v2.1.61 on the user's request (2026-10-21, before a RetroArch test): builds\v2.1.61\ (bps, xdelta, README,
  source zip); rebuilt from the extracted zip to the same SHA-1, xdelta re-applied with src/apply.py to the same SHA-1.
  Root playthrough ROM replaced; wip moved to builds\ (release ROM builds\"... v2.1.61.nds"). docs\README.txt updated.
  Playthrough .srm kept.

v2.1.70-wip (2026-10-21, rig tested; user test due): L swaps Link and Gongoron in the Goron Temple (user request,
  design: L, the only free key; Y is a modifier). Research from user state 517 (Goron Temple B1, Link).
  - The swap button = touch button (vtable 0x020e893c) id GORON_ID 0x1c, layout cell word (+8) GORON_CELL 0x30,
    element 0, centre (128, 16). Found by diffing the button objects while a stylus touch was held at (128, 16);
    its byte +0xd is the press animation (1, 2, 4, 8). Same button and id in Link and Gongoron form.
  - Code: fs_btn records it in gr_tab (x, y, fs_frame) when id and cell both match (the id alone may exist on
    other screens). goron_ctl (pad_update chain after skip_ctl, so only when no menu took the keys): while gr_tab is
    live a new L is hidden from the game (it does nothing on the field) and menu_tap taps the button.
  - dpad.bin 16305 bytes (79 free of 0x4000).
  Rig (scratchpad hot.py: new dpad.bin poked at 0x0219B120 into state 517, the 10 BL hooks and the vtable re-aimed;
  JIT off): gr_tab = (128, 16); L = Gongoron, L again = Link; two L presses 10 frames apart = one swap; L held 90
  frames = one swap; L + Left = swap and Gongoron walks left. Fresh boot of the wip with the playthrough .srm copy:
  file select, field (mode 1), L = nothing (mode stays 1, no crash).
  Not tested: real RetroArch; L with an item out or the item bar open in the temple; other Goron Temple rooms
  (assumed the same button); Gongoron rolling / mid-action.
  ROM: "Phantom Hourglass US - Button Controls v2.1.70-wip.nds" (root), SHA-1 e3890baadfeb6fe378a536645cc89e177cc7683a,
  CRC32 a1dd77a0; save: "...v2.1.70-wip.srm" in RetroArch saves\melonDS DS\ = a copy of the playthrough .srm.
  Source: patch_src/dpad.s (v2.1.69-wip + the L swap only).
  Released as v2.1.60 on the user's request (2026-10-21, before a RetroArch test): builds\v2.1.60\ (bps, xdelta,
  README, source zip); rebuilt from the extracted zip to the same SHA-1, xdelta re-applied with src/apply.py to the
  same SHA-1. Root playthrough ROM replaced; wip moved to builds\ (release ROM builds\"... v2.1.60.nds"). docs\README.txt
  updated. Playthrough .srm kept; the wip .srm copy stays in RetroArch saves.

v2.1.69-wip (2026-10-21, rig tested; user test due): R and X swapped (user request: "flip how it works in the release").
  - R = open / close the item bar (D-pad Left/Right picks, A equips, B closes). X = take the equipped item out / Put Away
    (old R job); A uses it. R with an item out = Put Away too. X while the bar is open stays the game's (closes the bar).
  - Code: item_ctl hides a new X from the game (not with the bar open), r8 = KEY_X; R with no item out goes to it_nox, which
    sets X in PAD +2 so the game opens its own bar; ib_ctl maps R to X in its new-press word (closes the bar).
  - dpad.bin 16181 bytes (203 free of 0x4000). Rig (fresh boot, playthrough .srm copy): R opens the bar, R closes it, R,
    Left, A equips the bow, X = bow out ("Put Away" shown), A shoots (ammo 50 -> 49), X = away.
  Not tested: real RetroArch; R with the bar open during the slide-in; no equipped item (R goes to it_nox).
  ROM: "Phantom Hourglass US - Button Controls v2.1.69-wip.nds" (root), SHA-1 9c60796315d1fe52c3215e1650e19509fd5125b4;
  save copied from the playthrough .srm. Released as v2.1.59 after the user's RetroArch test (builds\v2.1.59\: bps, xdelta, README, source zip; rebuilt from the extracted zip to the same SHA-1; patches by mkpatch.py, xdelta re-applied with src/apply.py to the same SHA-1). Now the root playthrough ROM; wip moved to builds\. Playthrough .srm kept.

v2.1.58-wip (2026-10-20, rig tested; user test due): dungeon map floors fixed for the Temple of the Ocean King
  (user state 373: ToOK 1F, floors 1F..B6 known, a list that scrolls).
  - Cause (rig, state 373): the floor block moves inside the map object (MAP_OBJ +0x562 in the small dungeon of
    state 297, +0x716 here: the block = [MAP_OBJ +0x2c] (FL_BLK), floor word at block +0x12a (FL_SEL) in both), so
    v2.1.53 read 0, saw no floor and let Up / Down through (the game closes the map). Also the list scrolls here
    (1F at the top place, id 0x37; in state 297 1F was place 0x3a), so "place = floor word + 0x20" was wrong too.
  - Found: each list place is a touch button (vtable 0x020e893c, 0x18 bytes) with byte +0x11 = floor number (6 =
    1F, 7 = B1 ..., in both dungeons) and +0x13 = its label cell (floor number + 0x14). The floor word = label cell
    + 0x10 * k (k = 0 in state 297: 1F 0x1a; k = 1 in ToOK: 1F 0x2a, B6 0x30), so they match in the low 4 bits.
    No other RAM byte tracks the floor (scans of 0x020f0000-0x021f0000 and DTCM). Arrows: up 0x35 (15,18), down
    0x36 (15,139): one tap scrolls the list by one floor (1F..B5 -> B1..B6). Mode 10 (FL_MODE2) = the map sliding
    to a picked floor (~40 frames; the floor word changes during it); taps are ignored then, and back-to-back taps
    with no release between are ignored too.
  - fs_btn: fl_tab = ids 0x35..0x3c (arrows, then 6 places; index = id - FL_ID0) + the floor button (FL_BTN 8);
    byte 3 = the button's label cell. fl_shown: the live place whose cell matches the floor word in the low 4 bits.
    fl_ctl: a new Up / Down with the button or a place live is hidden from the game and waits in fl_pend (way,
    FL_WAIT 120 reads, done flags, floor word at the press). Each read (menu_tap idle, mode not 10): floor word
    changed = done; list closed = tap the button once; open = tap the place that way (again every 16 reads until
    the floor changes); past the list's end = tap that arrow once, then the next read finds the place. No floor
    that way, or the floor shown scrolled out of the list = dropped.
  - dpad.bin 15349 bytes (11 free of 0x3C00): the next feature needs a bigger CODE_RESERVE.
  Rig test (state 373, code poked over the v2.1.48 code at 0x0219B120 + hooks re-aimed; scratchpad hot2.py):
  Down x7 40+40 frames apart = 1F -> B1 .. B5, B6 (list scrolled once), Down at B6 = no change; Up x7 = back to 1F
  (scrolled back), Up at 1F = no change. Down / Up 34 frames apart (during the slide) all land. Closed list: Down =
  list + B1; map tap = list closed (mode 4); Down = B2; Up, Up = 1F; B = field (mode 1). State 297 (two floors, code
  linked at 0x023C3000): Down = B1, Down = no change, Up = 1F, Up = no change, map tap closes the list, Up closed =
  no change, Down closed = B1, B = map closed (mode 0x29 then 0x37, the same as after a stylus pick). Fresh boot of
  the wip with the playthrough .srm copy: file select, save loads at sea (mode 0x11), no crash.
  Not tested: real RetroArch; the floor shown scrolled out of the list; ToOK with more floors known (> 7).
  Source: v2.1.48 release source + the floor changes only (the shared patch_src/dpad.s also has another session's
  unfinished bow-hold edit, which did not assemble at the time); exact file: patch_src/known/v2.1.58-wip_dpad.s.
  ROM: "Phantom Hourglass US - Button Controls v2.1.58-wip.nds", SHA-1 8795da73ede5e5ef2fe333b3e9ba2303336ea348,
  CRC32 242b21e6; save copied from the playthrough .srm.
  Released as v2.1.49 on the user's request (2026-10-20; builds\v2.1.49\: bps, xdelta, README, source zip) before a
  user test ("I'll process them with the other builds"). Source = patch_src/known/v2.1.58-wip_dpad.s + the v2.1.48
  zip's other files; rebuilt to the same SHA-1 first, and again from the extracted source zip; patches made with
  mkpatch.py (both verified), xdelta re-applied with src/apply.py to the same SHA-1. Release ROM builds\"Phantom
  Hourglass US - Button Controls v2.1.49.nds"; now the root playthrough ROM (wip moved to builds\). docs\README.txt:
  floor line (list scrolls), change section, testing lines (v2.1.48 user results; v2.1.49 test setup only). Save:
  the playthrough .srm was kept; no wip .srm was copied over it. docs\test-checklist.md: the sword clash and floor
  sections now use the root ROM. Release v2.1.49 = wip v2.1.58-wip. The shared patch_src/dpad.s holds the same floor
  code plus other sessions' newer work.

v2.1.59-wip (2026-10-20, rig tested; user test due): Ghost Ship fog steering on buttons (user request, design approved:
  Up = Go, Down = Stop, hold Left / Right = gradual turn). Research: Future list "Ghost Ship fog steering".
  - Fog steering HUD = sea controller byte [SEA_CTL] +0x3c (SEA_STEER) = 1 (set by ov15 0x213D334, which also zeroes
    the wheel fields +0x10/+0x14/+0x18/+0x1a; 0 on the normal sail HUD in states 24 / 62). +0x34 stays 0x30 there,
    also with the menu bar open, so the old "+0x34 == 0" gate blocked every key.
  - Sailing block: with SEA_STEER = 1 it skips the +0x34 test and A / B / X (no Jump / cannon / Route there; the keys
    stay hidden) and goes straight to the lever (Up while stopped / Down while going = menu_tap (238,110)).
  - wh_ctl (pad_update, after fish_ctl when it did not take the keys): held Left / Right = fake stylus at
    (128 + fg_dx, WH_Y 40) through fg_x / fg_y (menu_touch's fishing stylus); fg_dx moves out WH_STEP 4 per pad read
    (pad reads are 30 Hz here) up to WH_MAX 120 (full lock ~2 s); neither / both = lift, fg_dx 0. A new Up / Down
    while ours is down waits one read in fg_pend with ours up, and ours stays up while the lever menu_tap runs and
    one read after (fg_wait | WH_DOWN): without that the lever press was a slide from ours = a turn, no toggle.
    Menu bar: mb_ctl clears the held D-pad, so no steering under it.
  - CODE_RESERVE 0x3C00 -> 0x3E00 (debug 0x4000); dpad.bin 15649 bytes (223 free).
  Rig test (scratchpad hot.py: links dpad.s at 0x023B3000 and re-aims the hooks; t1.py / t2.py on state 376 + 6 A
  presses = wheel HUD): Right held 90 frames = rate up to 1547 (full lock), let go = back to 0; Left 6 frames = small
  turn; Down = Stop, Up = Go; Left held + Down = Stop and the turn goes on; Right held + Up (stopped) = Go; A / B / X / Y
  = nothing; Select = menu bar, Left / Right there = no turn, closed again = turns. t3.py, state 62 (normal sail HUD):
  Left / Right nothing, Down / Up lever, A jumps, B fires. Fresh boot of the wip with the playthrough .srm copy:
  file select, Mercay field (mode 1).
  Not tested: real RetroArch; the whole Ghost Ship search to its end; text boxes during steering.
  ROM: "Phantom Hourglass US - Button Controls v2.1.59-wip.nds", SHA-1 9ec94c8f9ce7fe9a2d62a71bc8300e9315ccf595,
  CRC32 b455b75a; save copied from the playthrough .srm.
  Released as v2.1.50 on the user's request (2026-10-20; builds\v2.1.50\: bps, xdelta, README, source zip) before a
  user test ("I'll test in my active playthrough"). Source rebuilt to the same SHA-1 first, and again from the
  extracted source zip; patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the same
  SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.50.nds"; now the root playthrough ROM (wip
  moved to builds\). docs\README.txt: wheel control lines, change section, testing line (test setup only).
  docs\test-checklist.md: new fog steering section (state 376 keeps the old code: in-game save). Save: the
  playthrough .srm was kept; no wip .srm was copied over it. Release v2.1.50 = wip v2.1.59-wip.

v2.1.60-wip (2026-10-20, rig tested; user test due): fix for a freeze in v2.1.49 / v2.1.50 (user state 377, root ROM
  v2.1.50: Linebeck on the dock, the game stops when Link gets control after the cutscene).
  - Cause (rig): the first Up / Down in the field runs fl_ctl -> fl_shown, which reads [MAP_OBJ] (0x021ddd84 here, not
    the map) +FL_BLK = 0x030f0064 (not a pointer) and ldrh's 0x030f018e. No PU region covers it: data abort, the
    game's abort handler is "b ." (state 377: CPSR 0x20000097 = abort mode, fault at 0x0219daf8 = that ldrh).
    v2.1.48 read MAP_OBJ +0x562 directly (no second pointer), so it did not fault.
  - Triage: state 377 in lr.py (no move, ARM9 registers fixed); fresh boot with the playthrough .srm copy freezes
    on v2.1.49 / v2.1.50 only (clean ROM, v2.1.36 / 42 / 45 / 48 walk); fl_ctl = bx lr from boot = no freeze.
  - Fix: fl_ctl takes a new Up / Down only in modes MAP_MODE / FL_MODE1 / FL_MODE2 (else the keys go on); a
    waiting one still runs (the game is in mode 7 while the floor list opens; a first try that also dropped the
    waiting press there made the first Down only open the list). fl_shown uses MAP_OBJ and its block only if each
    is in main RAM (0x02000000-0x023fffff), else "no floor".
  - dpad.bin 15693 bytes (179 free of 0x3E00).
  Rig test, fresh boot of the wip with a playthrough .srm copy: at the Linebeck dock, Down / Left / Up walk, stylus
  walks, mode 1, no freeze. State 373 (ToOK map, code linked rig-only at 0x023C3000, hooks re-aimed; scratchpad
  hot60.py): Down = list + B1, Down = B2, Up, Up = 1F, B = field, Down walks.
  Seen, not from this change: in the rig the menu bar highlight does not move on Left / Right at the dock (v2.1.48
  the same).
  Not tested: real RetroArch; small dungeons; the Sea Chart / island map with Up / Down.
  ROM: "Phantom Hourglass US - Button Controls v2.1.60-wip.nds", SHA-1 51687e898257c53cb124ae41a4bc0c8837c6fe01,
  CRC32 c60c4df0; save copied from the playthrough .srm. Source: shared patch_src/dpad.s (= v2.1.50 + this fix).
  User test (RetroArch, 2026-10-20): passed (no freeze in the field, dungeon map floors work).
  Released as v2.1.51 on the user's request (2026-10-20; builds\v2.1.51\: bps, xdelta, README, source zip). Source
  rebuilt to the same SHA-1 first, and again from the extracted source zip; patches made with mkpatch.py (both
  verified), xdelta re-applied with src/apply.py to the same SHA-1. Release ROM builds\"Phantom Hourglass US -
  Button Controls v2.1.51.nds"; now the root playthrough ROM (wip moved to builds\). docs\README.txt: change
  section, testing line. docs\test-checklist.md: the v2.1.60-wip section removed. Save: the playthrough .srm was
  kept; no wip .srm was copied over it. Release v2.1.51 = wip v2.1.60-wip.

v2.1.61-wip (2026-10-20, rig tested; user test due): bow, hold A = aim with the camera pan, let go = shoot (user
  request, Future "Hold A with an item readied" part 1; 8 D-pad ways only, user OK). Built on v2.1.51's dpad.s (source
  rebuilt to its SHA-1 51687e89 first).
  - Research: see the Future entry (a held stylus aims and pans the camera toward it, the lift shoots).
  - fish_ctl fg_off: with the bow out (item state, +0x14 = IT_BOW) and no text box: A press = fg_step BOW_MIN (8
    reads); while A is held or fg_step > 0, fg_x / fg_y = the point near the screen edge on the aim way from Link
    (bw_pt), A / B / R hidden (B / R Put Away taps slid our stylus off = an arrow, bow stayed out). A let go and
    fg_step 0 = fg_lift (fg_x 0 = the lift = the arrow). A quick press still shoots (BOW_MIN). The rub (LS_HELD)
    shares the code from the A hide on (label 2, r5 = 0 rub / 1 bow; clamp fg_clamp).
  - bw_pt: aim way = held D-pad (dir_table + camera yaw: dpad_move does not run while the stylus is down), else
    it_oct, else Link's facing; ScreenFromWorld of Link and of 2 tiles on (it_vec << 7); steps from Link in 1/16 px
    to the last point inside IT_EDGE, testing only the edges ahead (the pan can put Link past the edge behind:
    with both edges tested a right aim fell back onto Link, x 8); then back off x >= BOW_HUD_X 208, y <= BOW_HUD_Y
    72 (item icon / "Put Away": a lift there taps it, no arrow; Up-Right failed every time before).
  - it_use (A tap with the item out) no longer runs for the bow: fish_ctl hides A first.
  - CODE_RESERVE 0x3E00 -> 0x4000 (debug 0x4200); dpad.bin 16121 bytes (263 free).
  Rig test (hot-swap into user state 374 = bow out, 32 arrows, Link mid-screen; scratchpad hot.py links dpad.s at
  0x023BA000 and re-aims the hooks; arrows = byte 0x021be282 there): 8 ways x 24 holds (20-158 frames, after the
  way's D-pad press) all shoot 1 arrow; A 1-4 frames = 1 arrow; turns while A is held (Right, Up, Up-Right) shoot
  the new way; D-pad alone no arrow; A held + B / R = still aiming, arrow on the release, bow stays out, then B puts
  it away; bow away: Up / Down walk (no v2.1.49 freeze). Fresh boot of the wip with the playthrough .srm copy: Mercay
  dock field (mode 1), R = bow out (Menu / Items buttons hide), 8 ways x 4 holds all shoot (arrows byte 0x021be682).
  Found on the way: v2.1.49 / v2.1.50 field freeze on Up / Down (fixed by v2.1.51 in another session).
  Not tested: real RetroArch; a real target off the screen; the boomerang (Future part 2, not started).
  ROM: "Phantom Hourglass US - Button Controls v2.1.61-wip.nds", SHA-1 0d1ace23685bf9890030fb06dd7f3c3812c8510b,
  CRC32 61b26e46; save copied from the playthrough .srm.

v2.1.62-wip (2026-10-20, rig tested; user test due): dungeon map floors fixed for user state 385 (root ROM v2.1.51,
  Select > Map, Down = list open on B1; Up / Down then did nothing; a stylus tap on a floor worked).
  - Cause (rig, state 385): fl_shown read the floor from the block word ([MAP_OBJ +0x2c] +0x12a). In this dungeon
    it is 0x39 on B1 and 0xffff on 1F, so no list place matched and every press was dropped. RAM diff of B1 / 1F /
    B1 / 1F (main RAM + DTCM): MAP_OBJ s16 +0x30 (FL_FLOOR) = floor shown, 1F 0, B1 -1, B2 -2 ... Checked the same
    in state 297 (small dungeon) and 373 (ToOK, to B6). Place label cell = 0x1a (FL_CELL1F) - that floor.
  - Fix: fl_shown reads FL_FLOOR from MAP_OBJ (main RAM check kept) and matches the place's label cell exactly.
    FL_BLK / FL_SEL removed. Built on v2.1.61-wip's dpad.s (bow hold A aim in it too).
  - dpad.bin 16097 bytes (287 free of 0x4000).
  Rig test (scratchpad hot62.py: links dpad.s at 0x023C3000 into a user state, re-aims the hooks by name):
  state 385: Up = 1F, Up at the top = no change, Down = B1, Down at the bottom = no change, map tap = list closed
  (mode 4), Up = list + 1F, B = field (mode 1), Down walks. State 373: Down x6 = 1F..B6 (list scrolls), Down at B6
  = no change, Up = B5. State 297: Down = B1, Up = 1F, B = map closed. Fresh boot of the wip with the playthrough
  .srm copy (same dungeon, now 1F / B1 / B2): field Up / Down walk (mode 1), Select > Map (A closes the "You can't
  write on this map." text), Down = list + B1, Up = 1F, B = field, Down walks.
  Seen, not from this change (v2.1.51 code the same in the rig, state 373): a second Up / Down pressed while the
  map still slides to the first floor (~20 frames after) is lost: the map moves one floor only.
  Not tested: real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.62-wip.nds", SHA-1 a8849e859f7ba04df8ca7041b0a23d2c25b9d050,
  CRC32 c3f2e61e; save copied from the playthrough .srm.
  Released as v2.1.52 on the user's request before a user test (2026-10-20; "I'll test them all together";
  builds\v2.1.52\: bps, xdelta, README, source zip). Source rebuilt to the same SHA-1 first, and again from the
  extracted source zip; patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the
  same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.52.nds"; now the root playthrough
  ROM (wip moved to builds\). docs\README.txt: bow hold A control line, change section, testing line (test setup
  only). docs\test-checklist.md: bow and floor sections now use the root ROM. Save: the playthrough .srm was
  kept; no wip .srm was copied over it. Release v2.1.52 = wip v2.1.62-wip.

v2.1.63-wip (2026-10-20, rig tested; user test due): D-pad lock after picking up a Force Gem fixed (user state 388,
  root ROM v2.1.51, ToOK B1: Link holds the gem and cannot move for a few seconds).
  - Cause (rig, state 388): the pickup leaves touch ctl +0x94 = the gem's object id, and neither carrying nor +0x82
    is set, so tap_front's block grab latched grab_on with grab_h 0x4000; dpad_move then dropped Left / Right (the
    "block" axis) until a press on the other axis let go. gPlayer +0x3c = 0x80 (the gem) the whole time.
  - Fix: the grab check also skips to no_grab when held_obj is nonzero (Link holds an object or has a bomb out).
    Push blocks are not lifted, so gPlayer +0x3c stays -1 for them. Built on v2.1.62-wip's dpad.s (source rebuilt to
    its SHA-1 a8849e85 first). dpad.bin 16109 bytes (275 free of 0x4000).
  Rig test (scratchpad hot63.py = hot62.py with pos / sym / held commands; state 388, code linked at 0x023C3000):
  control (same source without the fix): grab_on 1, Left 60 / Right 60 = no move. Fix: grab_on 0, Left 60 = x 206 ->
  158, Right 60 -> 202, Up / Down walk; A = gem set down (gPlayer +0x3c -1), then Left / Right walk, grab_on 0.
  Not tested: push blocks (no state near one), real RetroArch.
  ROM: "Phantom Hourglass US - Button Controls v2.1.63-wip.nds", SHA-1 663c9aeec7beae076d1a13c07a32b24c848d88d8,
  CRC32 204cfd8a; save copied from the playthrough .srm.
  Released as v2.1.53 on the user's request before a user test (2026-10-20; "i will test them all together";
  builds\v2.1.53\: bps, xdelta, README, source zip). Source rebuilt to the same SHA-1 first, and again from the
  extracted source zip; patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the
  same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.53.nds"; now the root playthrough
  ROM (wip moved to builds\). docs\README.txt: change section, testing line. docs\test-checklist.md: the Force Gem
  section now uses the root ROM. Save: the playthrough .srm was kept; no wip .srm was copied over it. Release
  v2.1.53 = wip v2.1.63-wip.

v2.1.64-wip (2026-10-20, rig tested; user test due): bow hold A, Left / Right aimed ~5 deg toward the screen bottom
  (user state 403, root ROM v2.1.53, ToOK B3, bow out: "he will face 80-85 degrees").
  - Cause (rig, state 403): bw_pt put the fake stylus on the screen row of Link's FEET (ScreenFromWorld of
    PLAYER_POS). The game aims from a point higher up: a touch at (240, y) gave y 92 = 0x4051 (straight), y 98 =
    0x3d75 (our row). Measured with A held 40 frames: Right 0x3d24, Left 0xc3cf, Up 0x8051, Down 0.
  - Fix: bw_pt projects Link and the point 2 tiles on with world y + BOW_AIM_Y (0x800, half a tile). Tried 0x400 /
    0x800 / 0xc00 / 0x1000: 0x800 = Right 0x4051, Left 0xbfaf. The rub path (r5 = 0) is unchanged.
    Source rebuilt to v2.1.53's SHA-1 663c9aee first. dpad.bin 16153 bytes (231 free of 0x4000).
  Rig test (scratchpad hot64.py = hot63.py with ang / peek commands, code linked at 0x023C3000): state 403 and state
  374 (Mercay field): Right 0x4051, Left 0xbfaf, Up-Right 0x607c, Down-Left 0xdedb, Up 0x8000, Down 0 (old code on
  374: 0x3d24 / 0xc3cf / 0x5ced / 0xe1d4). State 374, 8 ways x 50-frame holds = 1 arrow each, A tap = 1 arrow.
  Fresh boot of the wip with the playthrough .srm copy: Mercay house, Items > bow, R = bow out, Right 0x4051, Left
  0xbfaf, Up-Right 0x6052, Down-Left 0xdf30, Up 0x8000, Down 0.
  Not tested: real RetroArch; an arrow against a real target.
  ROM: "Phantom Hourglass US - Button Controls v2.1.64-wip.nds", SHA-1 20aa1f1739252e958097b042233ce371a52c3586,
  CRC32 ae2e0dfa; save copied from the playthrough .srm.
  User test of wip (2026-10-20, RetroArch): all checks pass (Left / Right / Up / Down / Up-Right straight, A tap, B).
  Released as v2.1.54 (2026-10-20; builds\v2.1.54\: bps, xdelta, README, source zip). Source rebuilt to the same
  SHA-1, and again from the extracted source zip; patches made with mkpatch.py (both verified), xdelta re-applied
  with src/apply.py to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.54.nds"; now
  the root playthrough ROM (wip moved to builds\). docs\README.txt: change section, testing line.
  docs\test-checklist.md: the v2.1.64-wip section removed. Save: the playthrough .srm was kept; no wip .srm was
  copied over it. Release v2.1.54 = wip v2.1.64-wip.

v2.1.65-wip (2026-10-20, rig tested; user test due): English text fixes (user request: all dialogue checked for
  typos). Code is unchanged (dpad.s = v2.1.64-wip; ARM9 and overlays byte-identical to v2.1.64-wip).
  - Review: src/tools/dump_text.py dumps all English text (English/Message/*.bmg, 4071 entries) to
    docs/dialogue-en.txt; every entry was read. Report: docs/dialogue-typos.md (7 typos, 26 wording items).
  - Fix: src/patch_src/text_fix.py (EDITS list, 38 edits in 15 .bmg files), called by build_v2.py after the
    overlays. It replaces text in DAT1, moves the INF1 offsets of later entries, grows DAT1 in 32-byte steps if the
    end padding is too small (header size field = end of DAT1, FLW1 / FLI1 move along), and stores each file in
    place if it fits before the next 0x200 boundary, else appends it. In this build only main_isl.bmg grew (+32
    bytes, in place); no file moved. Line count of every entry is kept; widest new line 195 px (zeldaDS_15
    advances; widest original dialogue line 207 px).
  - Rig: the new ROM's dump differs from the old one only in the 36 edited entries. Fresh boot with the
    playthrough .srm copy, Continue to Mercay: main RAM has the new main_isl.bmg / system.bmg text ("Make your way
    to", "gracing\nus with", "I wonder", "View them from") and not the old text.
  Not tested: real RetroArch; the changed text boxes on screen.
  ROM: "Phantom Hourglass US - Button Controls v2.1.65-wip.nds", SHA-1 445f869a535258d137a1ce53f6db2d9a7ba57ba8,
  CRC32 e7b360c4; save copied from the playthrough .srm.
  Released as v2.1.55 before a user test (user request, 2026-10-20; builds\v2.1.55\: bps, xdelta, README, source
  zip). The source zip now also has text_fix.py; rebuilt from the extracted zip to the same SHA-1. Patches made
  with mkpatch.py (both verified), xdelta re-applied with src/apply.py to the same SHA-1. Release ROM
  builds\"Phantom Hourglass US - Button Controls v2.1.55.nds"; now the root playthrough ROM (wip moved to
  builds\). docs\README.txt: title, result SHA-1 / CRC32, patch names, change section, testing line.
  docs\test-checklist.md: the text section now names v2.1.55 (test still due). Save: the playthrough .srm was
  kept; no wip .srm was copied over it. Release v2.1.55 = wip v2.1.65-wip.

v2.1.66-wip (2026-10-20, rig tested; user test due): Start on the save menu no longer talks to the NPC under it.
  - Found (user's RetroArch state 464: merchant's table on Mercay, Start menu up with only "Continue"; mode 1,
    OVL_SLOT 31; the state carries older patch code, data 0x2c lower than v2.1.65): smenu_ctl had auto-pressed
    Continue (ch_tap CH_HOLD at 128, 97). Start (the game's own Continue key) closed the menu under the held
    stylus, and its lift became a field tap on the merchant -> "OHHH! Welcome!". B already waited for the
    stylus to slide off (sm_boff); Start did not.
  - Fix (smenu_ctl): new SM_CLOSE = KEY_B | KEY_START. Both keys wait in sm_queue until ch_go_off has slid the
    stylus to empty space and lifted it, then go to the game. dpad.bin 16149 bytes, 235 bytes free.
  - User also said A did nothing on state 464. Not reproduced: in the rig A (1, 2, 3, 4 frames) closes the menu
    from state 464 with no talk; at sea (fresh boot) A closes it at both frame parities, also after a Start
    close and a B close. Only the rig's 2-frame press is sometimes lost (30 Hz pad reads).
  Rig test: state 464 with the new smenu_ctl block poked in (same address 0x0219ba68; nop added to keep the
  layout): Start 1 / 2 frames and B close the menu with no talk; no input keeps it up. Fresh boot of the wip with
  the playthrough .srm (Continue at sea): Start opens the menu (Continue / Save and Quit), Start / B / A close it.
  Not tested: Save and Quit, real RetroArch, a fresh-boot run to the merchant.
  ROM: "Phantom Hourglass US - Button Controls v2.1.66-wip.nds", SHA-1 3f1b7ae7dfb9db48cd532671b8a56e5228340f3d,
  CRC32 193fcdfd; save copied from the playthrough .srm.
  Released as v2.1.56 before a user test (user request, 2026-10-20; builds\v2.1.56\: bps, xdelta, README, source
  zip). Patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py and the source zip
  rebuilt, both to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.56.nds"; now
  the root playthrough ROM (wip moved to builds\). docs\README.txt: title, result SHA-1 / CRC32, patch names,
  change section, testing line. docs\test-checklist.md: new v2.1.56 section. Save: the playthrough .srm was
  kept; no wip .srm was copied over it. Release v2.1.56 = wip v2.1.66-wip.

v2.1.67-wip (2026-10-21, rig tested; user test due): a second Start taps a cutscene's Skip button (user request; research
  under "Future feature requests"). The game's own Start shows "Skip >>" (touch button id 0x8f) but only the stylus
  could press it; a second Start just hid it.
  - fs_btn: id SKIP_ID (0x8f) -> sk_tab (x, y, fs_frame), as bk_tab. The game updates the button only while it shows.
  - skip_ctl (pad_update, after fl_ctl): sk_tab live (tab_live) + Start new press + Start in held_real -> Start
    hidden from the game, menu_tap_at the button. The held_real test is needed: the opening story runs in the
    title overlay, where pad_update gives A as Start too (first build: A alone skipped there).
  - dpad.bin 16297 bytes, 87 bytes free.
  Rig test (fresh boot of the wip with NO save = new file, path as in the research note): opening story: Start =
  Skip shows; second Start (2- and 6-frame presses, both frame parities) skips. Skip shown + each of A, B, X, Y, L,
  R, Select, Up, Down, Left, Right alone: no skip (v2.1.56 the same). Start, Skip times out (~5 s), Start = Skip
  shows again, no skip. Next scene ("Save me...", mode 1, overlay 9, text box): Start = Skip, second Start skips
  (to Link on the beach); each other key alone: no skip, A advances the text. Start twice through the next scenes
  reaches Mercay field control.
  Not tested: real RetroArch; later cutscenes (Skip id 0x8f assumed shared); a cutscene with a dialogue choice
  (choice_ctl runs first and may take the read).
  ROM: "Phantom Hourglass US - Button Controls v2.1.67-wip.nds", SHA-1 9badc41668863a8308c8341c585f03fd68b86ebf,
  CRC32 7f2aebea; save copied from the playthrough .srm.
  Released as v2.1.57 before a user test (user request, 2026-10-21; builds\v2.1.57\: bps, xdelta, README, source
  zip). Patches made with mkpatch.py (both verified), xdelta re-applied with src/apply.py and the extracted source
  zip rebuilt, both to the same SHA-1. Release ROM builds\"Phantom Hourglass US - Button Controls v2.1.57.nds"; now
  the root playthrough ROM (wip moved to builds\). docs\README.txt: title, result SHA-1 / CRC32, patch names,
  Start, Start control line, change section, testing line. docs\test-checklist.md: the section now names v2.1.57.
  Save: the playthrough .srm was kept; no wip .srm was copied over it. Release v2.1.57 = wip v2.1.67-wip.

v2.1.68-wip (2026-10-21, rig tested; user tested: all checks passed; released as v2.1.58): code-size cleanup, literal pools only, no intended behaviour change
  (user request: "finding #3, the cleanup pass").
  - dpad.s had 17 literal pools (16 .ltorg + the end pool): 182 pool words, only 91 different constants (PAD 17
    times, menu_tap 10, ch_tap 9, MODE 9 ...). 13 .ltorg lines removed; the three kept (old lines 1508, 2658 and 3744)
    carry a comment. Picked by a greedy search plus a swap search (scratchpad
    ltorg_opt.py, session-only): each step dropped one .ltorg and kept it out only if both the normal and the
    DEBUGLOG build still assemble and dpad.bin got smaller. No .ltorg was added and no instruction changed.
  - dpad.bin 16297 -> 16081 bytes (128 pool words), 303 bytes free (was 87).
  - Same-code check (scratchpad samecode.py): old and new .elf/.bin read word by word, pool words skipped, every
    pc-relative load replaced by the value it loads, every address inside the block (branch targets, adr, loaded
    label addresses) by its index among the non-pool words: 3892 words each, all equal except one, sc_pt's
    "ldr r0, =sc_alt + 16" (the end of the sc_alt table; in v2.1.67 a pool followed the table, now fs_btn does).
  Rig test (fresh boot with a copy of the playthrough .srm; scripts smoke.txt / field.txt, session-only):
  - Menus (title, file list Up / Down, Copy / Erase / Start row, the copy Yes / No question, mode select):
    all 24 shots byte-equal to v2.1.67-wip on the same script.
  - Field / sea (the save starts at sea on the route screen): menu bar, item bar, Start menu (Down = Save and
    Quit held), collection with R, Down, A = Golden Prow list, B, R item out, B, walking, sword. The collection
    shots are byte-equal to v2.1.67-wip; the sea shots differ only in the clouds / seagull / smoke animation.
    v2.1.67-wip run twice with the same script gives equal shots, so this comes from the build, most likely
    timing: the ARM9 autoload block is 216 bytes shorter, so boot takes fewer cycles and the game's random
    draws shift. lr.py runs with the real time as the DS clock; scratchpad lrfixed.py set a fixed clock
    (melonds_start_time_mode absolute) for these runs.
  - The rig's lr_system\melonDS DS\wfcsettings.bin is shared by all runs: a run that enters WFC Setup changes it.
    Put back the copy before each compared run.
  Not tested: real RetroArch, shops, fishing, Salvage Arm, statue, dungeon maps, bow (no code changed there).
  ROM: "Phantom Hourglass US - Button Controls v2.1.68-wip.nds", SHA-1 95a6bc66b34f6899c9f671554de599374c968f1b,
  CRC32 53c15f33; save copied from the playthrough .srm.
  User test (RetroArch, 2026-10-21, docs\test-checklist.md v2.1.68-wip section): all checks passed.
  Released as v2.1.58 (user request, 2026-10-21; builds\v2.1.58\: bps, xdelta, README, README_v2.1.58, source
  zip). Source rebuilt to the same SHA-1 first, and again from the extracted source zip; patches made with
  mkpatch.py (both verified), xdelta re-applied with src/apply.py to the same SHA-1. Release ROM
  builds\"Phantom Hourglass US - Button Controls v2.1.58.nds"; now the root playthrough ROM (wip moved to
  builds\). docs\README.txt: title, result SHA-1 / CRC32, patch names, change section, testing line (the README
  review fixes ship with it). docs\test-checklist.md: the v2.1.68-wip section removed (passed), header names
  v2.1.58. Save: the playthrough .srm was kept; no wip .srm was copied over it. Release v2.1.58 = wip v2.1.68-wip.

## Microphone spots (2026-10-17, no build; user hit a "talk into the mic" spot)
- melonDS DS 1.4.0 core options (Quick Menu > Core Options > Audio): melonds_mic_input = silence / blow (loops a
  built-in blowing sound) / noise (white noise) / microphone (host mic, falls back to silence); melonds_mic_input_active
  = hold / toggle / always (the Microphone button gates every mode except silence); melonds_show_mic_state.
- Microphone button = RetroPad id 14 = L3 (input descriptors read with a scratch env-11 hook on lr.py). The user's
  retroarch.cfg has no keyboard L3 (nul); xinput pad L3 = left stick click. Remap in Quick Menu > Controls >
  Port 1 Controls > "Microphone" if wanted, so no patch code is needed.
- User's .opt had mic_input = microphone, active = hold: with no working host mic or without holding L3 the game
  hears silence. Fix given: Microphone Input Mode = Blow, hold L3 (or the remapped button) at the prompt.
- User confirmed (2026-10-17): Blow + hold L3 passes the "talk into the mic" spot. No patch change needed.
  For a later mic spot that Blow can't pass, try Noise, then get a state there and find the game's mic level read.

## Future feature requests (user, 2026-10-17) - open items only (finished ones in src\DEVLOG-archive.md)
- (bow part: v2.1.61-wip, see above; boomerang part not started) Hold A with an item readied (user, 2026-10-20, on v2.1.48): today A = it_use = the use tap at once. New: a quick
  A press keeps that; a held A does a per-item action:
  1. Bow: while A is held, draw the aim line out to the maximum the game allows; the arrow fires on the A release.
  2. Boomerang: while A is held, draw a teardrop path in the way Link faces (out on one side, round the far point,
     back on the other side), large enough to go round an enemy a few Link-widths away; throw on the release.
  Bow purpose (user, 2026-10-20): the long line is an aim guide. Targets can be off the screen edge, where the game
  wants a line drawn to them; with the short line the user can't see if Link is lined up. So the line must show
  on the screen as far as the game allows (to the screen edge or the max length), and stay while the D-pad
  turns the aim. 8 D-pad directions only (user OK, 2026-10-20: no fine turn steps).
  Bow research (2026-10-20, rig, user state 374 = v2.1.48 root ROM, Link at (127,72), bow out, 32 arrows;
  scratchpad bowdrag.py / bowpan.py, session-only): a stylus drag that starts on Link and stays held aims the bow
  and does NOT fire; the camera pans toward the stylus point. Pan size follows the stylus distance from Link:
  stylus at (127,2) = pan up until Link is at the screen's bottom edge (door eye switch shows), ~60 frames to
  settle; stylus at (127,50) = small pan. Lift = 1 arrow (31). No aim line was seen at 256x192. A plain held
  touch away from Link (no drag) aims and pans the same way (first read as a walk: it was the pan). So the build: hold A = fake stylus held at the screen
  edge in it_oct's way (the camera pans there), D-pad turns it, A release = lift = shoot; check whether a fake
  point past the screen edge (touch ctl +0x58) pans further. Open questions (research before a design): (a) bow: the game's max line length, whether the
  shown line follows the fake stylus distance (touch ctl +0x58), and whether the D-pad can turn the aim while
  A is held (today dpad_move only sets last_oct / it_oct in the bow state). (b)
  boomerang: the game's path length budget and how many points it records per frame (the teardrop must fit the
  budget and stay inside the screen near the edges, see it_dist 96 / the 3/4 shrink loop). (c) the tap-vs-hold
  threshold (e.g. 10 logic frames) so a quick A still uses the item at once. (d) code space: 183 bytes free
  (CODE_RESERVE 0x3C00); a teardrop table may need a bigger reserve. Hold A is also the rub (grab, sword clash):
  those states have no item out, so no clash expected, but check.
- (done since v2.1.36; kept here as the naming rule) Rename "Dpad" -> "Button Controls" (user, 2026-10-18, after v2.1.34): from the next release on, name the
  builds "Phantom Hourglass US - Button Controls vX.Y.Z[-wipN].nds" and the patches
  "zelda_phantom_hourglass_buttons_vX.Y.Z.bps/.xdelta"; README title too. Old builds\ folders keep their names.
  Keep "D-pad" in the README description (people search for it) and keep the griegamaster credit. Reason: the
  patch does far more than the D-pad, and only 1 byte of the 2014 v1 code is left (H1, 0x0202ADEC beq -> b).
  The root playthrough ROM name does not change (RetroArch saves). "Controller Support" rejected (sounds like
  gamepad hardware support).
- Walk with the item out (user, 2026-10-18, v2.1.24): boomerang taken out by its icon (to draw a path), can
  the D-pad still walk? Rig (v2.1.24, fresh boot with the playthrough .srm): icon tap (241,15) = item out ("Put
  Away" shown, gLinkState = LinkStateItem); Right held 60 frames = gPlayerPos unchanged. The clean game has no
  walk in the item state (the stylus draws the path there), so dpad_move's walk path never runs. Told the user:
  base-game restriction. Possible later option (not requested): D-pad with the item out = tap "Put Away", walk.
- View camera: today it's moved by pressing the stylus and dragging it around the screen. Can one of the
  analog sticks emulate that? (The DS has no stick, so check what melonDS DS / RetroArch pass through,
  e.g. a right-stick touch cursor, or whether the patch could read it at all.)

## Headless rig on Windows: src/lr.py (2026-10-17)
- Drives RetroArch's melonDS DS core DLL through libretro from Python (py -3.14 for zstd states): software
  renderer, JIT off, ~200 fps. Loads the user's RetroArch .stateN (RZIP) or its own raw states, LR_SAVE=.srm boots
  with a battery save. Script commands: run / hold / press / touch X Y N / shot / peek (main RAM or DTCM) / poke /
  save. A state brings its own patch code back, so test a new build from a fresh boot (title: run 900, touch,
  run 700, then Start) or a state saved by the same build.

## Emulator test rig (emu/, Linux, not built here)
- melonDS (commit in melonDS_commit.txt) with melonDS_watch_hooks.diff applied (read/write watch). cmake -DBUILD_QT_SDL=OFF
  -DENABLE_OGLRENDERER=OFF -DENABLE_GDBSTUB=OFF, ninja core, then compile headless.cpp with -DJIT_ENABLED
  -DARCHITECTURE_x86_64=1 (the defines must match the core build or it segfaults).
- headless ROM script [state] [save]: commands run N / hold KEYS N / touch X Y N (bottom-screen coords) / shot f.png /
  savestate f / peek ADDR N (DTCM-aware) / poke / watch ADDR (reads) / wwatch ADDR (writes) / hits / dump f / loadbin ADDR f.
- hotload.py prints loadbin+poke lines to hot-swap new dpad.bin into an existing savestate (states hold old code).
- Saves: saves/mercay.sav (just after the intro), saves/oshus2.sav (in Oshus's house, before the sword).
  bootsave2.sh ROM name SAVE boots into gameplay. Game logic runs at 30 Hz, so hold keys >= 2 frames.

## Key addresses
PAD 0x27E05F8 (+0 held, +2 pressed); TOUCH 0x27E0D84; CAMPTR 0x27E0F64; mode 0x27E077C (1 field, 4/8/44 map).
Code lives at 0x0219B120 (3rd autoload entry; arena literals 0x200E580/0x202F744 point past it). The reserve was 2 KB in
v2 (arena 0x219B920); now CODE_RESERVE 0x4000.
Hooks: ARM9 0x203A474 dialog; ov0 0x20B79B0 move, 0x20B7938 tap, 0x20AEC04 roll, 0x20B0D74 slash, 0x20A9480 spin;
ov9 0x211B134/0x211B214/0x211B300 HUD; ov14 0x214414C item.These are the v2 hooks; later hooks (H1-H5 and on) are in the wip entries and patch_src/dpad.s.
