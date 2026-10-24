# Zelda: Phantom Hourglass - Button Controls

Play **The Legend of Zelda: Phantom Hourglass** (Nintendo DS) with the D-pad and buttons instead of the stylus.

Run with the D-pad, swing the sword with B, roll with A + D-pad, and open the items, menus, shops and sea chart with buttons. The stylus still works for everything, so you can use both.

This patch was first called the "D-pad Patch". It is based on the 2014 D-pad patch by **griegamaster**, then rewritten, moved and bug-fixed.

**Latest version: [v2.1.75](https://github.com/swyfter/phantom-hourglass-button-controls/releases/latest)**

---

## What you need

- Your own copy of the game: **Phantom Hourglass (USA)**, full 64 MB ROM. This repo does **not** include the game.

> **Please do not ask for ROMs or ROM links.** Such requests are deleted. Dump the game from your own cartridge.
- A Nintendo DS emulator. The patch is tested in **RetroArch** with the **melonDS DS** core.

To check that your ROM is the correct one, compare its checksum:

| | Before the patch | After the patch |
|---|---|---|
| CRC32 | `8b431c41` | `8eccd90c` |
| SHA-1 | `4c8f52dd719918bbcd46e73a8bae8628139c1b85` | `c49f77eab798667024d85cafe516eaa75dfb79c7` |

---

## How to install (about 2 minutes)

1. Download **one** patch file from the [latest release](https://github.com/swyfter/phantom-hourglass-button-controls/releases/latest):
   - [`zelda_phantom_hourglass_buttons_v2.1.75.xdelta`](https://github.com/swyfter/phantom-hourglass-button-controls/releases/download/v2.1.75/zelda_phantom_hourglass_buttons_v2.1.75.xdelta), or
   - [`zelda_phantom_hourglass_buttons_v2.1.75.bps`](https://github.com/swyfter/phantom-hourglass-button-controls/releases/download/v2.1.75/zelda_phantom_hourglass_buttons_v2.1.75.bps)
2. Open [Rom Patcher JS](https://www.marcrobledo.com/RomPatcher.js/) in your browser. It works offline and does not upload your ROM.
3. Select your **clean** (unpatched) ROM, then select the patch file.
4. Click **Apply patch** and save the new `.nds` file.
5. Load the new file in your emulator.

Both patch files make the same result. The patch refuses a wrong ROM, so you cannot break your file by mistake.

> **Updating from an older version?** Patch a **clean** ROM again, not the old patched one.
> Load your **in-game save**, not an emulator save state. An old save state brings back the old version's code.

---

## Main controls

| Button | On the field |
|---|---|
| **D-pad** | Run |
| **Y + D-pad** | Walk slowly |
| **A** | Talk, read, pick up, open, throw |
| **A + D-pad** | Roll |
| **B** | Sword |
| **Y + B** | Spin attack |
| **R** | Open the item bar (D-pad to pick, A to equip) |
| **X** | Take out the equipped item, then **A** to use it |
| **Select** | Menu bar (Collection, Sea Chart, Map, Save) |
| **Start** | Pause menu. Press twice to skip a cutscene |
| **Hold A** | Rub free at a "RUB!" prompt |

| Button | At sea |
|---|---|
| **D-pad Up / Down** | Go / Stop |
| **A** | Jump |
| **B** | Fire the cannon straight ahead |
| **X** | Routes screen |

Menus, shops, the shipyard, fishing, the salvage arm and more also work with buttons.
See the **[full controls list](docs/README.txt)**.

---

## What still needs the stylus

- Drawing: routes at sea, boomerang and bombchu paths, map notes and Cyclone Slate symbols.
- Aiming the cannon at a point, and turning the camera at sea.
- Microphone spots ("talk into the mic"). In RetroArch with melonDS DS, set **Core Options > Audio > Microphone Input Mode** to **Blow**. Then hold the Microphone button (L3 by default) at the prompt.

---

## More information

- [Full controls, changelog and known limits](docs/README.txt)
- [All releases](https://github.com/swyfter/phantom-hourglass-button-controls/releases)
- [Older versions](builds)
- [Source code and build scripts](src) (for modders)

## Credits

- **griegamaster** - the original 2014 D-pad patch.
- **swyfter** - Button Controls v2 and later.

This is a fan project. It is not made or approved by Nintendo. The Legend of Zelda is a trademark of Nintendo.
