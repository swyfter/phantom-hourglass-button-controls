# Contributing

Thank you for your help with **Phantom Hourglass - Button Controls**.

You can help in two ways:

1. Report a bug.
2. Ask for a feature.

This repo does not accept pull requests.

> **Please do not ask for ROMs or ROM links.** Such requests are deleted. Dump the game from your own cartridge.

A security problem is not a bug report. See [SECURITY.md](SECURITY.md) and report it privately.

---

## Before you open an issue

1. Use the [latest release](https://github.com/swyfter/phantom-hourglass-button-controls/releases/latest). Only the latest release gets fixes.
2. Check your patched ROM. Its CRC32 must be `e0267fc6`.
3. Load your **in-game save**, not an old emulator save state. An old save state brings back the old version's code.
4. Read the [known limits](docs/README.txt) and the "What still needs the stylus" list in the [README](README.md).
5. Search the [open issues](https://github.com/swyfter/phantom-hourglass-button-controls/issues). Add a comment to an issue that already exists.

---

## Report a bug

Open a [new issue](https://github.com/swyfter/phantom-hourglass-button-controls/issues/new) and add the `bug` label.

Give this information:

| Item | Example |
|---|---|
| Patch version | v2.1.75 |
| Emulator and core | RetroArch 1.19, melonDS DS 1.2 |
| Where in the game | Temple of the Ocean King, floor 2, after the first sand of hours |
| What you pressed | Hold A at the "RUB!" prompt |
| What you expected | Link rubs free |
| What happened | Nothing. Link stays frozen |
| Can you do it again? | Yes, every time |

Also tell us if the stylus does the action correctly. This shows if the bug is in the patch or in the game.

A screenshot or a short video helps a lot.

### Save files

Do not attach a save file or a `.zip` file to a new issue. We ask for a save in the issue if we need one.

If we ask, attach your in-game save file (`.sav` or `.srm`) from a point near the bug. GitHub does not accept these file types, so put the save in a `.zip` file. Put only the save file in the `.zip` file.

Do not attach an emulator save state. A save state holds the code of the patch version that made it. It can also hold your DS firmware nickname.

---

## Ask for a feature

Open a [new issue](https://github.com/swyfter/phantom-hourglass-button-controls/issues/new) and add the `enhancement` label.

1. Name the action that needs the stylus now.
2. Tell us where in the game it occurs.
3. Tell us which buttons you want to use for it, if you know.

Some actions stay on the stylus. For example, drawing a route on the sea chart needs a free line, and a D-pad cannot draw it well.

Use the `accessibility` label if the stylus is a barrier for you. For example, you cannot use a touch screen or a mouse.

---

## Code and documentation changes

This repo does not accept pull requests.

> [!NOTE]
> **This project is AI-written.** Claude, an AI model by Anthropic, writes the patch code, the tools and the documentation. swyfter tests each build in the game.

To suggest a change, open an issue:

- For a code change, tell us what to change and why. You can paste a short piece of code in the issue.
- For a documentation change, add the `documentation` label. Tell us which file and which text to change.

---

## Build the patch yourself

The patch code is ARM assembly. The build tools are Python scripts. All of it is in [`src/`](src).

### What you need

- Python 3.
- [LLVM](https://releases.llvm.org/) (`clang`, `ld.lld`, `llvm-objcopy`, `llvm-nm`). On Windows, the build also looks in `C:\Program Files\LLVM\bin`. You can set `LLVM_DIR` to another folder.
- Your own clean ROM: **Phantom Hourglass (USA)**, SHA-1 `4c8f52dd719918bbcd46e73a8bae8628139c1b85`.

### Where the code is

| Path | Contents |
|---|---|
| `src/patch_src/dpad.s` | The patch code (ARM assembly) |
| `src/patch_src/build_v2.py` | Builds the patched ROM from a clean ROM |
| `src/patch_src/link.py` | Assembles and links `dpad.s` |
| `src/patch_src/mkpatch.py` | Makes the `.bps` and `.xdelta` files |
| `src/patch_src/text_fix.py` | Dialogue typo fixes |
| `src/DEVLOG.md` | Development notes, research and history |

### Build the patch

1. Go to the `src/patch_src` folder.
2. Build the patched ROM:

   ```powershell
   python build_v2.py clean.nds patched.nds
   ```

3. Make the patch files:

   ```powershell
   python mkpatch.py clean.nds patched.nds my_patch
   ```

`build_v2.py` stops if your ROM is not the clean USA ROM.

The patch code has a fixed size limit (`CODE_RESERVE` in `build_v2.py`). The build stops if the code is too large.

Do not share a patched ROM. Share only the `.bps` or `.xdelta` patch file.

---

## Rules for everyone

- Be polite and patient. This is a hobby project.
- There is no fixed response time. We try to reply within 14 days.
- Requests for ROMs, ROM links or patched ROMs are deleted.
