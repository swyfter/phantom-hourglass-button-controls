# Security Policy

## Supported versions

Only the latest release gets fixes.

| Version | Supported |
|---|---|
| Latest release ([v2.1.75](https://github.com/swyfter/phantom-hourglass-button-controls/releases/latest)) | Yes |
| Older versions | No |

## What this project contains

- **Patch files** (`.xdelta`, `.bps`). They change the game ROM only. They do not contain programs that run on your computer.
- **Python build and test scripts** in `src/`. Only modders who build the patch themselves run these.

The patch code runs only inside the game, in your emulator.

## How to stay safe

1. Download the patch only from the [Releases page](https://github.com/swyfter/phantom-hourglass-button-controls/releases) of this repo. Copies on other sites can be changed.
2. Check the patched ROM. Its CRC32 must be `8eccd90c` and its SHA-1 must be `c49f77eab798667024d85cafe516eaa75dfb79c7`.
3. Use a patcher that runs in your browser, such as [Rom Patcher JS](https://www.marcrobledo.com/RomPatcher.js/), or a patcher from its official site.

Releases are immutable. After a release is published, nobody can change its files or move its tag.

## Report a security problem

Report a security problem privately. Do **not** open a public issue.

1. Open the [Security tab](https://github.com/swyfter/phantom-hourglass-button-controls/security) of this repo.
2. Click **Report a vulnerability**.
3. Tell us what the problem is, which file or version it is in, and how to see it.

Examples of security problems:
- A release file that is different from the checksums above.
- A copy of this patch on another site that contains malware.
- A script in `src/` that can harm a computer.

This is a hobby project, so there is no fixed response time. We try to reply within 14 days.

A bug in the game controls is not a security problem. See the [README](README.md) for the known limits.
