# Zelda: Phantom Hourglass - Button Controls

Play **The Legend of Zelda: Phantom Hourglass** (Nintendo DS) with the D-pad and buttons instead of the stylus.

Run with the D-pad, swing the sword with B, roll with A + D-pad, and open the items, menus, shops and sea chart with buttons. The stylus still works for everything, so you can use both.

This patch was first called the "D-pad Patch". It is based on the 2014 D-pad patch by **griegamaster**, then rewritten, moved and bug-fixed.

> [!NOTE]
> **This patch is AI-written.** Claude, an AI model by Anthropic, wrote the patch code, the build tools and the documentation.
> swyfter chose the features, reported the bugs and played the game with each build to test it.
> Most releases are tested by a human in RetroArch. Some are tested only with an automated emulator script first.

**Latest version: [v2.1.84](https://github.com/swyfter/phantom-hourglass-button-controls/releases/latest)**

---

## What you need

- Your own copy of the game: **Phantom Hourglass (USA)**, full 64 MB ROM. This repo does **not** include the game.

> **Please do not ask for ROMs or ROM links.** Such requests are deleted. Dump the game from your own cartridge.
- A Nintendo DS emulator. The patch is tested in **RetroArch** with the **melonDS DS** core.

To check that your ROM is the correct one, compare its checksum:

| | Before the patch | After the patch |
|---|---|---|
| CRC32 | `8b431c41` | `5b02447a` |
| SHA-1 | `4c8f52dd719918bbcd46e73a8bae8628139c1b85` | `8915d99da2dd99bd2c05bc7a79fd2660a5e8ce5e` |

---

## How to install (about 2 minutes)

1. Download **one** patch file from the [latest release](https://github.com/swyfter/phantom-hourglass-button-controls/releases/latest):
   - [`zelda_phantom_hourglass_buttons_v2.1.84.xdelta`](https://github.com/swyfter/phantom-hourglass-button-controls/releases/download/v2.1.84/zelda_phantom_hourglass_buttons_v2.1.84.xdelta), or
   - [`zelda_phantom_hourglass_buttons_v2.1.84.bps`](https://github.com/swyfter/phantom-hourglass-button-controls/releases/download/v2.1.84/zelda_phantom_hourglass_buttons_v2.1.84.bps)
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

## English text fixes

The patch also corrects the English dialogue (since v2.1.55): 7 typos and 26 small wording mistakes. For example, "the top sceen" in the fishing tutorial is now "the top screen". These changes affect only the text. [See the full list of text fixes](docs/dialogue-typos.md).

---

## What still needs the stylus

- Drawing: routes at sea, boomerang and bombchu paths, map notes, Cyclone Slate symbols and the signature on a letter.
- Aiming the cannon at a point, and turning the camera at sea.
- Microphone spots ("talk into the mic"). In RetroArch with melonDS DS, set **Core Options > Audio > Microphone Input Mode** to **Blow**. Then hold the Microphone button (L3 by default) at the prompt.

---

## How the patch works, and possible quirks

The game is made for the stylus. The patch does not remove the touch controls. It turns your button presses into the touches, taps and strokes that the game expects. For example, **A** taps the text box to advance text, and **Hold A** rubs at a "RUB!" prompt.

The game does not expect these touches, so some quirks can still occur. For example, a button can tap the wrong thing on the screen, or it can do nothing.

If a button does not work at a place in the game, use the stylus there. Then please [report the bug](CONTRIBUTING.md#report-a-bug), so that we can fix it.

---

## More information

- [Full controls, changelog and known limits](docs/README.txt)
- [All releases](https://github.com/swyfter/phantom-hourglass-button-controls/releases)
- [Source code and build scripts](src) (for modders)
- [How to report a bug or ask for a feature](CONTRIBUTING.md)

## Credits

- **griegamaster** - the original 2014 D-pad patch.
- **swyfter** - Button Controls v2 and later: features, bug reports and play testing.
- **Claude** (Anthropic) - the v2 and later patch code, the tools and the documentation.

## License

The patch code, the tools and the documentation in this repo use the [GNU General Public License v3.0](LICENSE.md).

- The license does not cover parts that come from griegamaster's 2014 D-pad patch.
- The license does not cover the game or the game text. Nintendo owns them.
- `src/emu/melonDS_watch_hooks.diff` changes [melonDS](https://github.com/melonDS-emu/melonDS), which also uses GPL-3.0.

This is a fan project. It is not made or approved by Nintendo. The Legend of Zelda is a trademark of Nintendo.
