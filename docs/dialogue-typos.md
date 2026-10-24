# English dialogue review: typos and mistakes

Source: clean US ROM (`.backup\`), all 32 files in `English/Message/*.bmg` (4071 entries, 3605 with text).
Full text dump: `docs/dialogue-en.txt` (made by `src/tools/dump_text.py`).
Method: an automatic word check (rare words, double words, spacing), then a full read of every entry.
Status: all items below are fixed in v2.1.65-wip (`src/patch_src/text_fix.py`), except the "Not mistakes" list.
`[LINK]` is the player name. In the dump, `\n` is a line break and `{...}` is a control code.

## Typos (sure)

| Entry | Where in the game | Current text | Fix |
|---|---|---|---|
| `sea.bmg#0` | First fish bite (fishing tutorial) | "the gauge on the top **sceen** will drop fast!" | "screen" |
| `field.bmg#12` | Joanne's letter (read by the Postman) | "her mermaid **constume**" | "costume" |
| `frost.bmg#171` | Isle of Frost, wrong Yook guess | "How **embarassing**!" | "embarrassing" |
| `frost.bmg#105` | Isle of Frost, Yook after the fight | "by some evil force**..** Now that I'm back" | "force... Now" |
| `main_isl.bmg#274` | Freedle, Tag Mode box swap | "I **Wonder** what's inside!" | "I wonder" |
| `hidari.bmg#159` | Joanne, rusty swordfish | "**Te-hee!** What an impressive..." | "Tee-hee!" (all other entries use "Tee-hee" / "Teehee") |
| `kaitei_F.bmg#11` | Oshus, Temple of the Ocean King, first visit after Leaf | "you will be fine.\n[LINK]." | "you will be fine, [LINK]." |

## Possible mistakes and style (not sure)

| Entry | Current text | Suggestion |
|---|---|---|
| `demo.bmg#4` | "passed down to **Hyrulian** princesses" | Fixed as "Hylian" |
| `demo.bmg#5` | "He **slayed** evil monsters" | "slew" (`demo.bmg#244` uses "slew") |
| `demo.bmg#61` | "I'll go with [LINK] and show him **who** he is." | Fixed as "and show him Linebeck." |
| `field.bmg#12` | "**Dear,** [LINK]!" | "Dear [LINK]," |
| `field.bmg#22` | "**Oh** scatterbrained one" | "O scatterbrained one" |
| `field.bmg#17`, `#18` vs `torii.bmg#68`, `#72` | "Friends of Battle Mode" vs "**Big** Friends of Battle Mode" | Fixed: "Big" removed in `torii.bmg` |
| `battle.bmg#15` | "Whoever has the most points**,** wins!" | Remove the comma |
| `battle.bmg#68` | "from the start of the starting count" | Awkward; "from the start of the countdown" |
| `collect.bmg#12` | "Smells fresh baked!" | "fresh-baked" |
| `brave.bmg#35`, `#36` | "the **north sea**" | Fixed as "Northern Sea" (line breaks moved) |
| `frost.bmg#69` vs `frost.bmg#86` | "has **sneaked** over" / "has **snuck** over" | Fixed: "snuck" in both |
| `frost.bmg#169` | "who calls **who** a liar" | "whom" |
| `ghost.bmg#7` | "Please bring my older sisters to me**?**" | Fixed as "Will you bring my older sisters to me?" |
| `ghost.bmg#75` | "your damsel saving" | "damsel-saving" |
| `hidari.bmg#20` | "listening to old wayfarer's tales" | Fixed as "old wayfarers' tales" (same width) |
| `hidari.bmg#124` | "As consolation prize" | "As a consolation prize" |
| `kaitei_F.bmg#56`, `#58` | "5th **F**loor", "11th **F**loor", "12th **F**loor" | `kaitei_F.bmg#57` uses "floor" |
| `kojima2.bmg#8` | "100 Rupees per **game**" | `#6` and `#7` say "per try" |
| `main_isl.bmg#1` | "Make way to the port." | "Make your way to the port." |
| `main_isl.bmg#109` | "look who's gracing our presence!" | Fixed as "gracing us with his presence! It's old man Oshus!" (line breaks moved) |
| `main_isl.bmg#148` | "You ready as I am?" | "You as ready as I am?" |
| `main_isl.bmg#275` | "...heart is broken.♪" | Fixed: "♪" added before "So sad" |
| `system.bmg#130` | "They're...so light... View **it** from the Collection screen" | "View them" |
| `torii.bmg#57` | "I know that **master** wants..." | Other Fuzo lines use "Master" |
| `wisdom.bmg#10` | "the map of **he** who knows" | "him who knows" |
| `demo.bmg#105`, `ghost.bmg#25` | "Oh...." / "Ahhh...." (four dots) | Three dots |

## Not mistakes (intentional)
- `frost.bmg#40`, `#82`: "Nobodo", "No-abodo", "[LINK]-abou" are Anouki jokes.
- `main_isl.bmg#240`: "'portant"; `ghost.bmg#67`: "nor'westeaster"; shipyard "dat", "da": dialect.
- `system.bmg#182`: "Hello Hello Hello" is a placeholder string. It probably does not show in the game.
