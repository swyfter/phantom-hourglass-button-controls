# Contributing

Thank you for your help with **Phantom Hourglass - Button Controls**.

You can help in three ways:

1. Report a bug.
2. Ask for a feature.
3. Send a code or documentation change.

> **Please do not ask for ROMs or ROM links.** Such requests are deleted. Dump the game from your own cartridge.

A security problem is not a bug report. See [SECURITY.md](SECURITY.md) and report it privately.

---

## Before you open an issue

1. Use the [latest release](https://github.com/swyfter/phantom-hourglass-button-controls/releases/latest). Only the latest release gets fixes.
2. Check your patched ROM. Its CRC32 must be `8eccd90c`.
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

An in-game save file (`.sav` or `.srm`) near the bug helps us to find the problem fast. Attach it to the issue as a `.zip` file.

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

## Send a change

The patch code is ARM assembly. The build tools are Python scripts. All of it is in [`src/`](src).

> [!NOTE]
> **This project is AI-written.** Claude, an AI model by Anthropic, writes the patch code, the tools and the documentation. swyfter tests each build in the game.
> Changes from people are welcome. We test each change in the game before it goes into a release.

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

The patch code has a fixed size limit (`CODE_RESERVE` in `build_v2.py`). Keep new code small. Tell us in the pull request how many bytes your change adds.

### Rules for a pull request

1. Make one change in each pull request.
2. Tell us what the change does and why.
3. Tell us how you tested it: emulator, core, and the place in the game.
4. Keep the stylus working. The patch adds buttons. It must not remove a stylus action.
5. Do not commit ROMs (`.nds`), saves (`.sav`, `.srm`), save states or RAM dumps. The `.gitignore` file blocks most of them.
6. Do not commit game text or other copyrighted game data.

For a large change, open an issue first. Then we can agree on the plan before you start.

### Documentation

Documentation changes are welcome too. Use short sentences and plain words. The README and the docs use [Simplified Technical English](https://www.asd-ste100.org/) style.

---

## Rules for everyone

- Be polite and patient. This is a hobby project.
- There is no fixed response time. We try to reply within 14 days.
- Requests for ROMs, ROM links or patched ROMs are deleted.
