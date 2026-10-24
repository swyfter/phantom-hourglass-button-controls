@ Zelda: Phantom Hourglass (US) - D-pad controls, v2.1.x (the v2 rewrite; version history in src/HANDOFF.md)
@ Based on the 2014 D-pad patch by griegamaster; rewritten and relocated.
@ All routines are ARM mode and are reached via BL from hooks in ARM9 / overlay 0.
@ Loaded at boot by an extra ARM9 autoload entry into RAM reserved above the overlays.

        .syntax unified
        .arm
        .section .text

        .equ PAD,      0x027e05f8      @ +0 held, +2 newly pressed (game's own pad state)
        .equ TOUCH,    0x027e0d84      @ game's touch sample: [0]=touching, [4]=x, [8]=y
        .equ CAMPTR,   0x027e0f64
        .equ KEY_A,    0x001
        .equ KEY_B,    0x002
        .equ KEY_Y,    0x800
        .equ KEY_SELECT, 0x004
        .equ KEY_START, 0x008
        .equ KEY_L,    0x200
        .equ KEY_R,    0x100
        .equ KEY_RIGHT, 0x010
        .equ KEY_LEFT, 0x020
        .equ KEY_UP,   0x040
        .equ KEY_DOWN, 0x080
        .equ PAGE_NEXT_X, 243           @ collection page arrows (bottom screen):
        .equ PAGE_PREV_X, 12            @   ">" at the right edge, "<" at the left,
        .equ PAGE_ARROW_Y, 84           @   both at y 84
        .equ SWAP_X, 243                @ Items page "switch screens" icon (bottom right):
        .equ SWAP_Y, 178                @   mode 0x15 <-> 0x1f, Items page only
        .equ COLL_PAGE, 0x0211f520      @ ov9 bss: collection screen shown (getter 0x211be64):
        .equ COLL_TREASURE, 4           @   2 = Items (page 1), page 2 tabs: 4 = Treasure,
        .equ COLL_SHIP, 3               @   3 = Ship Parts
        .equ COLL_ITEMS, 2              @   (1 = Fishing Journal, "<" from Items)
        .equ IP_LIST, 0x020fa1f0        @ Items page: first node of its item list (+8 next),
        .equ IP_VT, 0x020f6a0c          @   that node's vtable,
        .equ IP_COUNT, 27               @   nodes: 17 spirits half, then 10 hourglass half
        .equ IP_TOP, 0x5b               @   node byte: 1 = its half is on the top screen
        .equ IP_TOUCHABLE, 0x02113fa1   @ ov9 (thumb): node -> r0 != 0 if a touch can pick it
        .equ IP_GOFF, 0x0211f4a0        @ ov9: +4 / +8 = the page's screen offset x, y (fx)
        .equ IP_MIN, 4                  @ px an item must lie that way to be the next one
        .equ IP_PEND_READS, 40          @ pad reads an L / R waits for the swap back,
        .equ IP_SETTLE_READS, 8         @   then for taps to work again (rig: ~12 frames)
        .equ IP_SETTLING, 0x80          @ ip_pwait flag: swap back done, settle count below
        .equ TAB_TREASURE_X, 62         @ page 2 tab buttons (bottom screen), both at y 15
        .equ TAB_SHIP_X, 192
        .equ TAB_Y, 15
        .equ COLL_TFN, 0x020fc400       @ Treasure panel state (handler, thumb): grid / entry shown
        .equ TFN_GRID, 0x021185c5
        .equ TFN_ITEM, 0x021187dd
        .equ COLL_SFN, 0x020faf18       @ Ship Parts panel state: grid / parts list / Explanation
        .equ SFN_GRID, 0x02116fc9
        .equ SFN_LIST, 0x021173fd
        .equ SFN_INFO, 0x02117915
        .equ TREAS_SLOTS, 0xe0          @ slot objects (8, row by row) at panel + this (Treasure)
        .equ SHIP_SLOTS, 0xf0           @   or + this (Ship Parts); +0x44 = entry, -1 = empty slot
        .equ CL_SLOT_SIZE, 0x60
        .equ CL_SLOT_ENTRY, 0x44
        .equ CL_X0, 61                  @ page 2 slots (2 rows x 4): centre of the first one,
        .equ CL_DX, 47                  @   column and row spacing
        .equ CL_Y0, 81
        .equ CL_DY, 48
        .equ CL_BACK_X, 16              @ back arrow while an entry is shown
        .equ CL_BACK_Y, 153
        .equ CL_INFO_X, 213             @ Ship Parts list: Explanation button
        .equ CL_INFO_Y, 176
        .equ COLL_SPANEL, COLL_SFN - 0x10 @ Ship Parts panel: +0x18 list type, +0x1c row shown,
        .equ COLL_SL_POS, 0x1130        @   list slide position (moves to top * row height),
        .equ COLL_SL_ROWH, 0x1418       @   row height,
        .equ COLL_SL_TOP, 0x141c        @   top row on screen (3 rows show)
        .equ COLL_KINDS, 0x0211dacc     @ list type -> part kind (count owned: s8 at ItemMgr +0x48 + kind * 9 + row)
        .equ CL_ROWS, 9                 @ rows in a parts list
        .equ CL_ROW_X, 130              @ row centres: CL_ROW_Y0 + CL_ROW_DY * place
        .equ CL_ROW_Y0, 87
        .equ CL_ROW_DY, 26
        .equ CL_ARROW_X, 232            @ list scroll arrows
        .equ CL_UP_Y, 52
        .equ CL_DOWN_Y, 147
        .equ SY_OVL, 33                 @ shipyard overlay (OVL_SLOT): main menu = mode SHOP_MODE,
        .equ SY_CUST, 5                 @   Customize and View Ship = collection modes with
        .equ SY_VIEW, 6                 @   COLL_PAGE 5 / 6
        .equ SY_SFN, 0x020fa33c         @ Customize panel state (the Ship Parts panel class:
        .equ SY_PANEL, SY_SFN - 0x10    @   SFN_GRID / SFN_LIST / SFN_INFO; slots at panel +0xf0)
        .equ SY_ID_CUST, 0x87           @ main menu: Customize touch-button id (View Ship 0x88,
        .equ SY_AUTO, 1                 @   back arrow 0x89); sy_sel: sy_auto
        .equ SY_BTN_X, 128              @ main menu: Customize, View Ship (x 128)
        .equ SY_CUST_Y, 89
        .equ SY_VIEWB_Y, 144
        .equ SY_BACK_X, 12              @ red back arrow (main menu, Customize grid, View Ship)
        .equ SY_BACK_Y, 178
        .equ SY_ATTACH_X, 72            @ Customize parts list: Attach, Explanation
        .equ SY_INFO_X, 178
        .equ SY_LBTN_Y, 176
        .equ SY_ROTL_X, 70              @ View Ship: taps left / right of the ship turn it,
        .equ SY_ROTR_X, 180
        .equ SY_ROT_Y, 100
        .equ SY_ZOOM_X, 241             @   zoom + and - buttons
        .equ SY_ZIN_Y, 37
        .equ SY_ZOUT_Y, 173
        .equ MC_OVL_SLOT, 0x027e0920    @ overlay in the 0x21894c0 slot (ov41-45): 45 = treasure
        .equ MC_OVL, 45                 @   merchant (buys treasure and ship parts; mode SHOP_MODE)
        .equ MC_PTR, 0x0218ed24         @ ov45 bss: merchant object, +MC_PANELS its Ship Parts and
        .equ MC_PANELS, 0x148           @   Treasure panels (the collection's panel classes, heap)
        .equ MC_SVT, 0x0218ea6c         @   their vtables
        .equ MC_TVT, 0x0218eb78
        .equ MC_SSELL, 0x0218d020       @ Ship Parts panel state: Sell view (Treasure: TFN_ITEM)
        .equ MB_PAGE, 7                 @ magic box (same overlay slot, mode 0x15): COLL_PAGE 7 Ship
        .equ COLL_OBJ, 0x0211f4a0       @   Parts / 8 Treasure; [COLL_OBJ] = the collection object,
        .equ MB_PANELS, 0x310           @   +this its Ship Parts and Treasure panels (heap)
        .equ MB_SVT, 0x0218ec54         @   their vtables
        .equ MB_TVT, 0x0218e5a0
        .equ MB_STOW_X, 218             @ Treasure entry: Stow (Ship Parts list: SY_ATTACH_X, SY_LBTN_Y)
        .equ MB_STOW_Y, 176
        .equ MENU_TAP_FRAMES, 3         @ touch updates the fake arrow press lasts
        .equ CH_OFF, 0                  @ menu stylus (ch_tap phase; all touch menus share it):
        .equ CH_HOLD, 1                 @   pressed on a button
        .equ CH_DRAG, 2                 @   sliding to another button, then
        .equ CH_RELEASE, 3              @   lifted, then pressed there (CH_HOLD)
        .equ CH_CONFIRM, 4              @   lifted on the button = chosen, then off
        .equ CH_TAP, 5                  @   pressed (one phase), then CH_CONFIRM
        .equ CH_DRAGOFF, 6              @   slide off to empty space, then lift (CH_CONFIRM)
        .equ CH_LIFT, 7                 @   one touch update forced up (even with the real stylus
                                        @   down), then off: menu_touch, real press over ours
        .equ CH_TOUCHING, (1 << CH_HOLD) | (1 << CH_DRAG) | (1 << CH_TAP) | (1 << CH_DRAGOFF)
                                        @ phases that hold the stylus down (bit per phase)
        @ (Until v2.1.32 there were also CH_DRAGX 6 / CH_RELEASEX 7, a slide-lift-tap that no
        @ code ever started; CH_DRAGOFF was 8.)
        .equ CHOICE_STEP, 4             @ touch updates per drag / lift phase
        .equ CH_MOVE_STEP, 2            @   same, for a move between two buttons (ch_step)
        .equ CH_SETTLE, 2               @   touch updates a new press is held before it may move on
        .equ CH_AUTO_LOCK, 9            @ pad reads (30 Hz) A is ignored after the top bubble is auto-pressed
        .equ FS_OVL_SLOT, 0x027e090c    @ overlay in the 0x2112ba0 slot: 10 = file select menus
        .equ FS_OVL, 10
        .equ FS_ID0, 0x55               @ file select touch-button ids 0x55..0x86 (fs_tab)
        .equ FS_IDS, 0x32
        .equ FS_VERT, 0                 @ fs_specs modes: list moved by Up/Down,
        .equ FS_HORZ, 1                 @   list moved by Left/Right,
        .equ FS_ROWS, 2                 @   rows of (left arrow, right arrow)
        .equ BACK_ID, 0x45              @ touch-button id of the lower-left Back button (wall map, ...)
        .equ MAP_BACK_ID, 0x17          @   the same on a map (mode MAP_MODE: Map, or one sea chart,
        .equ MAP_MODE, 4                @   where it goes back to the sea chart screen)
        .equ MEMO_ID, 0x18              @ a map's Memo (pen) and Erase (eraser) buttons (ERASE_ID =
        .equ MM_SEL, 0x60               @   MEMO_ID + 1); byte MM_SEL of Memo's button = the tool
                                        @   in use (MEMO_ID or ERASE_ID)
        .equ FLOOR_ID, 0x1b             @ a dungeon map's floor button (lower left; opens the floor
        .equ FL_ID0, 0x35               @   list, modes FL_MODE1 / FL_MODE2), and the list: ids FL_ID0
        .equ FL_IDS, 8                  @   / +1 = its up / down arrows (scroll it by one floor), then
        .equ FL_P0, 2                   @   6 floor places, top first; fl_tab index = id - FL_ID0
        .equ FL_BTN, FL_IDS             @ fl_tab index of the floor button
        .equ FL_CELL, 0x13              @ byte +FL_CELL of a place's button = its label cell
        .equ FL_MODE1, 8                @ map modes with the floor list open (a tap on the map
        .equ FL_MODE2, 10               @   closes it: MAP_MODE)
        .equ MAP_OBJ, 0x027e07c0        @ the map screen object (the same word as ROUTE_OBJ):
        .equ FL_FLOOR, 0x30             @   s16 +FL_FLOOR = floor shown (1F 0, B1 -1, B2 -2 ...).
        .equ FL_CELL1F, 0x1a            @   A place's label cell = FL_CELL1F - that floor. (The
                                        @   block word v2.1.47-51 read is not the floor in every
                                        @   dungeon: B1 0x39, 1F 0xffff in user state 385.)
        .equ FL_WAIT, 120               @ pad reads an Up / Down waits (list opening, scroll, slide)
        .equ GO_ID0, 0x53               @ game over screen: Continue 0x53, Save and Quit 0x54
        .equ SKIP_ID, 0x8f              @ a cutscene's Skip (top right; the game's Start shows it)
        .equ GORON_FORM, 0x11           @ the swap button's byte: 1 = playing Gongoron (user states 518 / 522)
        .equ GORON_ID, 0x1c            @ the Goron Temple's Link / Gongoron swap button (top centre,
        .equ GORON_CELL, 0x30           @   layout cell GORON_CELL: the id alone is also used elsewhere)
        .equ SC_MODE, 0x2c              @ Sea Chart screen (four seas; from the menu bar)
        .equ SC_ID0, 0x1f               @   its sea buttons, ids SW 0x1f, SE, NW, NE 0x22; only owned
                                        @   seas are updated (sc_tab, by place: NW, NE, SW, SE)
        .equ SC_LEFT_X, 64              @   sea centres (bottom screen): x of the left / right
        .equ SC_RIGHT_X, 192            @   column, y of the top / low row
        .equ SC_TOP_Y, 48
        .equ SC_LOW_Y, 144
        .equ IS_ID0, 0x23               @   its island buttons (no layout element), one per island
        .equ IS_COUNT, 16               @   slot; only the ones a press can pick are updated
                                        @   (is_tab, right after sc_tab: objects 4 ..)
        .equ SC_OBJS, 4 + IS_COUNT      @   objects: 4 seas, then the islands
        .equ CELL_ANCHOR, 0x02034654    @ (cell, signed index, &x, &y): anchor point of a layout cell
        .equ SC_ISLE_R, 18              @   px from an island's centre a press still picks it (16)
        .equ SC_MIN, 4                  @   px an object must lie that way to be the next one
        .equ SC_ALTS, 8                 @   sc_alt: points tried to hold a sea off its islands
        .equ SC_SCREEN, 1               @ sc_sel: sc_screen, sc_key, sc_last
        .equ SC_KEY, 2
        .equ SC_LAST, 4
        .equ MB_Y, 176                  @ menu bar buttons: y (bottom screen); x per bar in mb_land / mb_sea
        .equ MB_DEF, 2                  @   button held first (place + 1): Collection
        .equ MB_OBJ, 0x1c               @ HUD buttons object (Menu, menu bar): [[UI_ROOT] + MB_OBJ],
        .equ MB_FLAG, 4                 @   its word +4 = MB_OPEN while the bar shows, 0 hidden (the
        .equ MB_OPEN, 8                 @   [+0x14] object's +8 stays 8 a while after a screen from it)
        .equ FS_OFF_X, 128              @ empty spot the stylus slides off to
        .equ FS_OFF_Y, 2
        .equ CH_SEEN_FRAMES, 3          @ pad reads msgwin stays valid after the text box was seen
        .equ MODE,     0x027e077c      @ current game mode (1 = field)
        .equ SHOP_MODE, 0x1a            @   merchant's shop window
        .equ SHOP_OVL, 31               @ the shop's overlay (OVL_SLOT)
        .equ SHOP_PTR, 0x02183de0       @ ov31 bss: shop object (+0x14 item shown, -1 = table;
                                        @   +0x70 actor handles: items 0-4, 5 table Quit, 6 Quit, 7 Buy)
        .equ ACTOR_MGR, 0x027e0fe4      @ actor manager (ActorFromHandle's first argument)
        .equ SH_TQUIT_X, 128            @ shop buttons (bottom screen): Quit under the table,
        .equ SH_BUY_X, 70               @   Buy and Quit in the item view,
        .equ SH_QUIT_X, 185
        .equ SH_BTN_Y, 178              @   all at y 178
        .equ SH_LIFT, 0x400             @ world units the highlighted item is lifted
        .equ OVL_SLOT, 0x027e091c      @ overlay loaded in the 0x217bce0 slot (ov30-40)
        .equ TITLE_OVL, 40              @ the title screen's overlay
        .equ GATE_OBJ, 0x027e0c54      @ argument of InputGate (the game's "ignore buttons" test)
        .equ SEA_OVL_SLOT, 0x027e0910  @ overlay in the 0x211f5c0 slot: 15 = sea (14 on land)
        .equ SEA_OVL, 15
        .equ SEA_CTL, 0x0218ee9c       @ ov15 bss: sea controller (+0x1c speed, +0x34 HUD cover,
                                        @   +0x41 lever locked); 0 when there is none
        .equ LEVER_X, 238               @ sail HUD (bottom screen): Go/Stop lever, either half
        .equ LEVER_Y, 110
        .equ JUMP_X, 127                @   Jump button
        .equ JUMP_Y, 181
        .equ CANNON_X, 128              @   open sea straight ahead of the ship (the camera
        .equ CANNON_Y, 70               @   looks along its heading): a tap fires the cannon
        .equ ROUTE_X, 238               @   Route button (bottom right) -> route screen
        .equ ROUTE_Y, 176
        .equ ROUTE_MODE, 0x11           @ route screen (chart on the bottom screen)
        .equ ROUTE_BACK_X, 14           @   its back arrow (lower left)
        .equ ROUTE_BACK_Y, 176
        .equ ROUTE_GO_X, 95             @   GO! and CANCEL on the panel shown once a route
        .equ ROUTE_GO_Y, 128            @   is drawn
        .equ ROUTE_CANCEL_X, 163
        .equ ROUTE_CANCEL_Y, 128
        .equ ROUTE_OBJ, 0x027e07c0     @ route screen object (vtable ROUTE_VT): byte
        .equ ROUTE_VT, 0x02189484       @   +ROUTE_PANEL = 1 while the panel shows
        .equ ROUTE_PANEL, 0x1e          @   (and while drawing), 0 after GO! / CANCEL
        .equ BCHU_MODE, 0x0d            @ bombchu map screen (path drawn on the map; back arrow lower left, as SLATE_BACK)
        .equ BCHU_GO_X, 92              @   GO! and CANCEL on the panel shown once a route is drawn
        .equ BCHU_GO_Y, 160
        .equ BCHU_CANCEL_X, 163
        .equ BCHU_CANCEL_Y, 160
        .equ BCHU_VT, 0x02158ef4        @   route object (0x5fc bytes below MAP_OBJ's, user states 525 / 526 / 537):
        .equ BCHU_PANEL, 0x14           @   byte +BCHU_PANEL = 1 once a route is drawn, 0 after GO! / CANCEL
        .equ SLATE_MODE, 0x3b          @ Cyclone Slate screen (sea item; draw a symbol to warp)
        .equ SLATE_BACK_X, 15           @   its back arrow (lower left) -> sailing (mode 1)
        .equ SLATE_BACK_Y, 177
        .equ SLATE_CHART_X, 233         @   Sea Chart button (lower right) -> four seas (0x2c)
        .equ SLATE_CHART_Y, 175
        .equ NOTE_MODE, 0x37            @ map note screen (wall map, sea note; land): back arrow
        .equ NOTE_CHART_X, 233          @   (B, bk_tab) and a lower-right button: Sea Chart ->
        .equ NOTE_CHART_Y, 176          @   four seas (0x2c), or Map -> map (4); B returns to the note
        .equ STATUE_OVL, 32             @ statue turn screen (also NOTE_MODE; the statue class is in
        .equ STATUE_VT, 0x02185ba4      @   this overlay (OVL_SLOT), vtable STATUE_VT). Statue +8 =
        .equ ST_IDLE, 12                @   state: ST_IDLE on the screen, ST_IDLE + 1 turning; +0xc =
        .equ ST_ANG, 0xc                @   u16 facing (0 = down the screen, 0x1555 = 30 deg)
        .equ OBJ_MGR, 0x027e0f68        @ object manager: +0xc pool (object pointers), +0x10 count
        .equ ST_SETTLE, 4               @ pad reads after a turn before the next tap is taken
        .equ ST_WAIT, 1                 @ st_pend + ST_WAIT = st_wait
        .equ ST_CX, 128                 @ the statue's screen centre on its screen
        .equ ST_CY, 101
        .equ ITEM_MGR, 0x027e0fb4     @ gItemManager: +0 equipped item, +0xac EquipItem* per item
        .equ TOUCH_CTL, 0x027e0fb8     @ player touch controller: +0x7c / +0x7d stylus input enables
        .equ LINK_STATE, 0x027e0fd0    @ gLinkState: Link's current state object
        .equ LINK_STATES, 0x027e0fdc   @ gLinkStates: state objects by id (1 = item out)
        .equ GPLAYER, 0x027e0f90       @ gPlayer: +0x3c held actor id (-1 = nothing held)
        .equ PLAYER_POS, 0x027e0f94    @ gPlayerPos (x, y, z)
        .equ PLAYER_ANGLE, 0x027e0fac  @ gPlayerAngle (u16, 0 = +z)
        .equ IT_FIRST, 2                @ items R uses: 2 boomerang, 3 shovel, 4 bombs, 5 bow,
        .equ IT_BOMBS, 4                @   6 grappling hook, 7 bombchu, 8 hammer
        .equ IT_BOW, 5
        .equ IT_LAST, 8
        .equ ITEM_ICON_X, 241           @ equipped-item icon (bottom screen, top right)
        .equ ITEM_ICON_Y, 15
        .equ IT_WAIT, 45                @ pad reads R is ignored while the item it took out comes out
        .equ IT_EDGE, 8                 @ use taps stay this far inside the screen
        .equ IT_PUT_WAIT, 30                 @ pad reads at most A / B / R wait after a Put Away tap
        .equ KEY_X,    0x400            @ (game's pad word: X = bit 10)
        .equ UI_ROOT,  0x027e103c      @ UI root object: +0xd = 1 while the item bar is open
        .equ UI_BAR_OPEN, 0xd
        .equ IM_POTIONS, 0xbc           @ gItemManager: potion per bottle (u8, 0 = empty),
        .equ IM_OWNED, 0x128            @   owned flags (bit per item id)
        .equ IB_Y, 178                  @ item bar icons: y (bottom screen)
        .equ DPAD,     0x0f0
        .equ MSG_GUARD_FRAMES, 12       @ logic frames (game runs logic at 30 Hz)
        .equ TEXTBOX_X, 128             @ where A/B taps while a text box is up
        .equ TEXTBOX_Y, 168
        .equ NPROBES, 7                 @ A tries up to 7 spots in front of Link (table row size)
        .equ PROBE_END, -128            @ dx marking the end of a shorter row
        .equ THROW_IDX, 0xff            @ probe index meaning "throw tap" (throw_table)
        .equ DROP_IDX, 0xfe             @ probe index meaning "set down" tap (drop_table)
        .equ DIR_FRESH, 45              @ logic frames (1.5 s) the last D-pad direction is used for aiming
        .equ FRAME, 32                  @ tap_front's local stack frame
        .equ PUSH_DIST, 0x2000          @ block arrows, world units from Link (1 tile = 0x1000):
        .equ PULL_DIST, -0x1000         @   push arrow 2 tiles ahead, pull arrow 1 tile behind,
        .equ ARROW_H, 0x600             @   both floating ~0.4 tile above the floor
        @ Field offsets into the data block at the end, for [rN, #X] (from the group's first
        @ label). Numbers here, as ldrh / strh / ldrsb / ldrsh can't take a label difference
        @ defined later; chk_off at each group stops the build if one no longer matches.
        .equ FISH_SEA, 0x0218f54f       @ ov15 byte: 0 while fishing (2 sailing, route screen; checked
                                        @   over 13 sea states. 0x020eaab4 was 1 only in the tutorial)
        .equ FISH_SCENE, 0x14ae         @ [SEA_CTL] + this: fishing scene (7 waiting, 8 bite, 9 fish on)
        .equ FISH_FIGHT, 9
        .equ FISH_QUIT_X, 16            @ fishing: the red arrow (quit), lower left
        .equ FISH_QUIT_Y, 178
        .equ FG_PULL, 1                 @ fg_mode: one stylus slide down (FG_SLIDE reads, 2 up)
        .equ FG_REEL, 2                 @   stylus circles while B is held
        .equ FG_SX, 128                 @ slide x (and circle centre x), y from FG_Y0 by FG_DY
        .equ FG_Y0, 60
        .equ FG_DY, 6
        .equ FG_SLIDE, 20
        .equ FG_DX, 6                   @ slide x step with Left / Right held (SW / SE)
        .equ FG_CY, 120                 @ circle centre y
        .equ FG_HIDE1, 0x0f7            @ keys the game must not see while fishing: A B Select D-pad,
        .equ FG_HIDE2, 0xc00            @   X Y
        .equ FG_SALV, 3                 @   Salvage Arm: stylus on the lever handle
        .equ SALV_MODE, 0x22            @ Salvage Arm game (at sea; FISH_SEA is 0 there too)
        .equ SV_HANDLE, 0x13a4          @ [SEA_CTL] + this: s16 lever handle x - SV_X0 (-50..50); the
        .equ SV_X0, 128                 @   arm swings over to it. The handle stays where it is let go
        .equ SV_Y, 174                  @ lever bar y; the stylus above it (SV_UP_Y) = knob up = the
        .equ SV_UP_Y, 144               @   arm sinks slower, below it (SV_DOWN_Y) = faster
        .equ SV_DOWN_Y, 189
        .equ SV_STEP, 3                 @ handle x moved per pad read
        .equ FGD_STEP, 1                @ fg_mode: fg_step, fg_x, fg_y
        .equ FGD_X, 2
        .equ FGD_Y, 3
        .equ FGD_DX, 4
        .equ FGD_WAIT, 5
        .equ FGD_PEND, 6
        .equ FGD_HK, 7
        .equ WH_DOWN, 0x80              @ fg_wait: our steering stylus was down last read
        .equ SEA_STEER, 0x3c            @ [SEA_CTL] + this: byte 1 = fog steering (Ghost Ship search:
                                        @   wheel HUD, no route; set by ov15 0x213D334)
        .equ WH_Y, 40                   @ fog steering stylus y; the game turns by its x - 128 only
        .equ WH_STEP, 4                 @   x moved out from 128 per pad read (30 Hz) while Left /
                                        @   Right held: full lock in ~2 s
        .equ WH_MAX, 120                @   up to 128 -/+ this (full lock)
        .equ LS_HELD, 4                 @ Link state id while an enemy holds him ("RUB!"),
        .equ LS_DAMAGE, 5               @ damage state id; its +0x18 = LS_ICE while Link is frozen
        .equ LS_ICE, 6
        .equ LS_FOLLOW, 3               @ Link state id on a grappling hook post (LinkStateFollow);
        .equ LS_POST_SUB, 10            @   its sub-state (state +4) while he stands on the post
        .equ LS_HELD_SUB, 6            @   its sub-state (state +4) then (user state 172)
        .equ LS_CLASH_SUB, 8            @   sub-state in a sword clash (Jolene, user state 360); 7 = Like Like
        .equ RUB_DX, 24                 @ held A there: stylus = Link +/- (RUB_DX, RUB_DY), a new
        .equ RUB_DY, 4                  @   side every pad read (diagonal: rubs along x only don't
        .equ RUB_EDGE, 8                @   count), kept RUB_EDGE inside the screen
        .equ BOW_MIN, 8                 @ bow out: pad reads the held-A stylus stays down at least
        .equ BOW_HUD_X, 208             @   and it keeps off x >= BOW_HUD_X, y <= BOW_HUD_Y (the
        .equ BOW_HUD_Y, 72              @   item icon and "Put Away", top right)
        .equ IT_HOOK, 6                 @ grappling hook out (item state +0x14): held A = a stylus line
        .equ HK_MIN, 6                  @   growing out from Link: pad reads it stays down at least,
        .equ HK_START, 20               @   its first length and the growth per read (1/256 of the way
        .equ HK_STEP, 5                 @   to the screen edge, up to 255), fg_hk = the length now
        .equ RL_FLAG, 0x80            @ fg_step while Gongoron rolls (B held, fg_roll); the roll stylus
        .equ RL_TOP, 40                 @   stays in y RL_TOP..RL_BOT (it must be 57+ px from him to roll)
        .equ RL_BOT, 168
        .equ BOW_AIM_Y, 0x800          @ bw_pt: world height above Link's feet the aim starts from
        .equ MT_X, 1                    @ menu_tap: x, y
        .equ MT_Y, 2
        .equ CT_LEFT, 1                 @ ch_tap: updates left, x, y
        .equ CT_X, 2
        .equ CT_Y, 3
        .equ MW_SEEN, 4                 @ msgwin: ch_seen, ch_auto, ch_queue
        .equ MW_AUTO, 5
        .equ MW_QUEUE, 6
        .equ SM_OFFY, 12                @ smenu (buttons 0-2 at +0, +4, +8): sm_offy, sm_seen,
        .equ SM_SEEN, 14                @   sm_sel, sm_auto, sm_queue
        .equ SM_SEL, 15
        .equ SM_AUTO, 16
        .equ SM_QUEUE, 17
        .equ SM_CLOSE, KEY_B | KEY_START  @ keys the game closes the save menu with (= Continue)
        .equ FS_SEL, 4                  @ fs_cur: fs_sel
        .equ SH_NEXT, 1                 @ sh_last: sh_next, sh_auto, sh_queue, sh_held,
        .equ SH_AUTO, 2                 @   sh_lslot, sh_ly
        .equ SH_QUEUE, 3
        .equ SH_HELD, 4
        .equ SH_LSLOT, 5
        .equ SH_LY, 8
        .equ CL_LOCK, 7                 @ cl_sel (slot per tab at +0 .. +6): cl_lock, cl_key,
        .equ CL_KEY, 8                  @   cl_back, cl_pass, cl_tgt
        .equ CL_BACK, 9
        .equ CL_PASS, 10
        .equ CL_TGT, 12
        .equ IP_KEY, 2                  @ ip_sel (item per half at +0, +1): ip_key, ip_own,
        .equ IP_OWN, 3                  @   ip_pass, ip_pend, ip_pwait
        .equ IP_PASS, 4
        .equ IP_PEND, 6
        .equ IP_PWAIT, 7
        .equ IT_OK, 1                   @ it_wait: it_ok, it_oct, it_put
        .equ IT_OCT, 2
        .equ IT_PUT, 3
        .equ IB_KEY, 2                  @ ib_sel: ib_key, ib_pass
        .equ IB_PASS, 4
        .equ MB_SCREEN, 1               @ mb_sel: mb_screen, mb_key
        .equ MB_KEY, 2
        .equ DIR_AGE, 1                 @ last_oct: dir_age
        .if (CT_Y - CT_X) - (MT_Y - MT_X)
        .error "touch_at reads ch_tap + (CT_X - MT_X) as menu_tap: same x, y spacing needed"
        .endif
        .if (IB_KEY - MB_KEY) | (IB_KEY - SC_KEY)
        .error "ctl_wait stores the key at [r4, #IB_KEY] for ib_ctl, mb_ctl, sc_ctl: same offset needed"
        .endif
        .if SC_SCREEN - MB_SCREEN
        .error "menu_touch sets [mb_sel or sc_sel + MB_SCREEN]: same offset needed"
        .endif
        .macro chk_off name, label, base
        .if (\label - \base) - \name
        .error "data block field offset \name no longer matches \label - \base"
        .endif
        .endm
        @ game functions are supplied by the linker (--defsym), see build_v2.py

@ ---------------------------------------------------------------------------
@ Hook @ 0x0203a474 (ARM9), replaces: ldrh r1, [r0, #52]
@ A or B newly pressed counts as a screen tap for advancing dialogue.
@ Runs every logic frame while a text box is up, so it also arms msg_guard, which
@ stops tap_front from injecting a tap (v1 bug: pressing A while facing the speaker
@ re-tapped them, restarting the conversation; the closing A press also re-triggered it).
@ r6 = the text box; remembered for choice_ctl.
        .global dialog_advance
dialog_advance:
        push    {r2, r3, lr}
        ldr     r2, =msg_guard
        mov     r1, #MSG_GUARD_FRAMES
        strb    r1, [r2]
        ldr     r2, =msgwin
        str     r6, [r2]
        mov     r1, #CH_SEEN_FRAMES
        strb    r1, [r2, #MW_SEEN]
        ldrh    r1, [r0, #52]
        ldr     r2, =PAD
        ldrh    r2, [r2, #2]
        tst     r2, #(KEY_A | KEY_B)
        orrne   r1, r1, #1
        ldr     r2, =ab_pend            @ or one pending from the last pad read (used once)
        ldrb    r3, [r2]
        cmp     r3, #0
        orrne   r1, r1, #1
        mov     r3, #0
        strb    r3, [r2]
        pop     {r2, r3, pc}

@ ---------------------------------------------------------------------------
@ Hook @ 0x0202ae3c (ARM9 pad read), replaces: bl PadUpdate   (r0 = PAD, r1 = keys)
@ The game skips the pad read while InputGate(GATE_OBJ) is nonzero: with the gate object
@ set (title, cutscenes; not on the field), every other frame (counter 0x027e070c), so a
@ 30 Hz scene sees each press once, on its next read. H1 removes that check, as v1 did;
@ here a gated read is undone the same way: no new presses, held keys as last read, so
@ presses come on the next read (until v2.1.8 they were lost). Except the keys we hand
@ over at once (deliver mask): A/B/Up/Down while a text box is up (A/B tap it, as a
@ stylus user would; the choice bubbles). These count as read. (Not on the title: a
@ press handed over on a gated frame is never seen there.)
@ The keys as last read are kept in held_real so PadUpdate still sees edges correctly.
@ Select opens and closes the menu bar (ov9; mb_ctl drives it). The collection screen
@ (from the bar's Collection button) closes on Select, as in the clean game. While it is up
@ (modes 0x13-0x17 from land, 0x1d-0x21 from the sea), a new B press also counts as a
@ Select press (B is free there; an entry's back arrow takes it first, see coll_ctl),
@ and D-pad Right / Left (or R / L) step one chain
@ through menu_touch taps: Fish -> ">" -> Items -> ">" -> Treasure -> Ship Parts tab, and
@ back with the Treasure tab, then "<". (On page 2 coll_ctl takes Left / Right while it
@ holds a slot; on Items ip_ctl takes the D-pad, so only L / R turn pages there.)
@ Dialogue choices are handled first (choice_ctl), from the ungated new presses; with
@ none up, the save menu's Continue / Save and Quit buttons (smenu_ctl).
@ A text box closes on the stylus lifting, so A/B (dialog_advance's press only) need a
@ whole tap: tap_front gives it on the field, otherwise (e.g. "Save complete.") menu_touch.
@ The title screen ("Touch the screen!") takes Start; A counts as Start there too.
        .global pad_update
pad_update:
        push    {r4, lr}
        ldr     r3, =held_real          @ edges against the keys as last read
        ldrh    r3, [r3]
        strh    r3, [r0]
        bl      PadUpdate
        mov     r4, r0
        ldr     r0, =GATE_OBJ
        bl      InputGate               @ leaf: r0-r2
        ldr     r2, =PAD
.ifdef DEBUGLOG
        bl      dbg_gate
.endif
        ldr     r3, =held_real
        cmp     r0, #0
        ldrheq  r1, [r2]
        beq     1f
        mov     r0, #0                  @ gated: r0 = deliver mask
        ldr     r1, =msg_guard
        ldrb    r1, [r1]
        cmp     r1, #0
        movne   r0, #(KEY_A | KEY_B | KEY_UP | KEY_DOWN)
        ldrh    r1, [r2, #2]
        and     r1, r1, r0
        strh    r1, [r2, #2]
        mov     r1, #0
        strh    r1, [r2, #4]
        ldrh    r1, [r2]                @ held: only the delivered keys (as before), and
        and     r1, r1, r0              @ held_real = those as read + the rest as last read
        strh    r1, [r2]
        ldrh    r12, [r3]
        bic     r12, r12, r0
        orr     r1, r1, r12
1:      strh    r1, [r3]
        ldr     r0, =OVL_SLOT           @ title: A = Start
        ldr     r0, [r0]
        cmp     r0, #TITLE_OVL
        bne     2f
        ldrh    r1, [r2, #2]
        tst     r1, #KEY_A
        orrne   r1, r1, #KEY_START
        strh    r1, [r2, #2]
2:      ldr     r3, =fs_frame           @ pad read counter (never 0) for fs_btn's stamps
        ldrb    r0, [r3]
        add     r0, r0, #1
        ands    r0, r0, #0xff
        moveq   r0, #1
        strb    r0, [r3]
        bl      choice_ctl              @ r0 = 1: dialogue choices are up
        cmp     r0, #0
        bleq    smenu_ctl               @ r0 = 1: save menu is up
        cmp     r0, #0
        bleq    shop_ctl                @ r0 = 1: shop window is up
        cmp     r0, #0
        bleq    coll_ctl                @ r0 = 1: collection Treasure / Ship Parts (or Customize) is up
        cmp     r0, #0
        bleq    ip_ctl                  @ r0 = 1: our stylus holds an item on the Items page
        cmp     r0, #0
        bleq    sy_ctl                  @ r0 = 1: shipyard main menu / View Ship is up
        cmp     r0, #0
        bleq    ib_ctl                  @ r0 = 1: item bar is open
        cmp     r0, #0
        bleq    mb_ctl                  @ r0 = 1: menu bar is open
        cmp     r0, #0
        bleq    sc_ctl                  @ r0 = 1: Sea Chart screen (four seas) is up
        cmp     r0, #0
        bne     10f
        bl      fs_ctl
        bl      back_ctl                @ B = a screen's Back button
        bl      mm_ctl                  @ Y = a map's Memo / Erase toggle
        bl      fl_ctl                  @ Up / Down = a dungeon map's floor up / down
        bl      skip_ctl                @ Start = a cutscene's Skip, once Start showed it
        bl      goron_ctl               @ L = the Goron Temple's Link / Gongoron swap
10:
        @ Text box up (seen by dialog_advance within the last pad reads) but msg_guard still
        @ at MAX: tap_front, which counts it down in the same frame, isn't running to tap it.
        @ The box needs both: dialog_advance seeing the press and the tap. In the fishing
        @ tutorial dialog_advance runs on the frames after half the press reads, so a press
        @ (text box up) stays pending in ab_pend for 2 pad reads; and tap_front runs on the
        @ frames dialog_advance does not, so the guard is MAX and MAX - 1 by turns: at sea
        @ MAX - 1 counts too.
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        ldr     r3, =ab_pend
        ldrb    r0, [r3]
        subs    r0, r0, #1
        movmi   r0, #0
        tst     r1, #(KEY_A | KEY_B)    @ (choice_ctl / smenu_ctl hid them if they took them)
        ldrne   r12, =ch_seen
        ldrbne  r12, [r12]
        cmpne   r12, #0
        movne   r0, #2
        strb    r0, [r3]
        tst     r1, #(KEY_A | KEY_B)
        ldrne   r3, =ch_seen
        ldrbne  r0, [r3]
        cmpne   r0, #0
        beq     3f
        ldr     r3, =SEA_OVL_SLOT
        ldr     r3, [r3]
        cmp     r3, #SEA_OVL
        moveq   r12, #(MSG_GUARD_FRAMES - 2)
        movne   r12, #(MSG_GUARD_FRAMES - 1)
        ldr     r3, =msg_guard
        ldrb    r0, [r3]
        cmp     r0, r12
        bls     3f
        mov     r0, #TEXTBOX_X
        mov     r1, #TEXTBOX_Y
        bl      menu_tap_at
        @ Shop window (merchant's table, Buy / Quit buttons), touch only: shop_ctl drives it.
        @ Fallback for a shop shop_ctl doesn't know: tap_front's probes landed on Quit, so hide
        @ A (not while a text box takes it).
3:      ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #SHOP_MODE
        ldreq   r0, =msg_guard
        ldrbeq  r0, [r0]
        cmpeq   r0, #0
        ldreq   r2, =PAD
        ldrheq  r1, [r2, #2]
        biceq   r1, r1, #KEY_A
        strheq  r1, [r2, #2]
        @ Sailing: Up = Go, Down = Stop, A = Jump, B = cannon, X = Route, as menu_tap taps
        @ on the sail HUD. The Go/Stop lever toggles on any tap, so Up taps it only while
        @ stopped, Down only while going. Only with the HUD showing (no menu bar over it;
        @ route / map are other modes) and no text box. At sea in mode 1 without a text box,
        @ A/B/X/Up/Down presses are hidden from the game even under the menu bar (tap_front's
        @ probes tapped the sea). On the route screen B taps its back arrow; while the GO! /
        @ CANCEL panel of a drawn route shows, A taps GO! and B taps CANCEL. On the Cyclone
        @ Slate B taps its back arrow and X its Sea Chart button (the four-seas screen).
        @ The fishing game (also mode 1 at sea) and the Salvage Arm go to fish_ctl instead.
        @ Fog steering (Ghost Ship search, wheel HUD): Up / Down = lever only, Left / Right =
        @ the wheel (wh_ctl).
        bl      fish_ctl                @ r0 = 1: fishing took the keys
        cmp     r0, #0
        bne     4f
        bl      wh_ctl                  @ fog steering: Left / Right = the wheel
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        tst     r1, #(KEY_A | KEY_B | KEY_UP | KEY_DOWN)
        tsteq   r1, #KEY_X
        beq     4f
        ldr     r0, =SEA_OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #SEA_OVL
        ldreq   r0, =msg_guard
        ldrbeq  r0, [r0]
        cmpeq   r0, #0
        ldreq   r0, =menu_tap
        ldrbeq  r0, [r0]
        cmpeq   r0, #0
        bne     4f
        ldr     r3, =SEA_CTL            @ sea controller (ov15 singleton), 0 = none
        ldr     r3, [r3]
        cmp     r3, #0
        beq     4f
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #ROUTE_MODE
        bne     6f
        tst     r1, #(KEY_A | KEY_B)    @ route screen: B = back arrow; while the GO! /
        beq     4f                      @   CANCEL panel shows, A = GO!, B = CANCEL
        ldr     r3, =ROUTE_OBJ
        ldr     r3, [r3]
        sub     r12, r3, #0x02000000    @ in main RAM?
        cmp     r12, #0x400000
        movhs   r12, #0
        bhs     11f
        ldr     r12, [r3]
        ldr     r0, =ROUTE_VT
        cmp     r12, r0
        ldrbeq  r12, [r3, #ROUTE_PANEL]
        movne   r12, #0
11:     tst     r1, #KEY_A              @ r12 = panel shown
        beq     12f
        cmp     r12, #0                 @ A with no panel: left to the game
        beq     4f
        bic     r1, r1, #KEY_A
        strh    r1, [r2, #2]
        mov     r0, #ROUTE_GO_X
        mov     r1, #ROUTE_GO_Y
        b       5f
12:     bic     r1, r1, #KEY_B
        strh    r1, [r2, #2]
        mov     r0, #ROUTE_BACK_X
        mov     r1, #ROUTE_BACK_Y
        cmp     r12, #0
        movne   r0, #ROUTE_CANCEL_X
        movne   r1, #ROUTE_CANCEL_Y
        b       5f
6:      cmp     r0, #SLATE_MODE
        bne     13f
        tst     r1, #KEY_B              @ Cyclone Slate: B = back arrow, X = Sea Chart button
        tsteq   r1, #KEY_X
        beq     4f
        bic     r12, r1, #KEY_B
        bic     r12, r12, #KEY_X
        strh    r12, [r2, #2]
        tst     r1, #KEY_B
        movne   r0, #SLATE_BACK_X
        movne   r1, #SLATE_BACK_Y
        moveq   r0, #SLATE_CHART_X
        moveq   r1, #SLATE_CHART_Y
        b       5f
13:     cmp     r0, #1
        bne     4f
        bic     r12, r1, #(KEY_A | KEY_B | KEY_UP | KEY_DOWN)
        bic     r12, r12, #KEY_X
        strh    r12, [r2, #2]
        ldrb    r0, [r3, #SEA_STEER]    @ fog steering HUD (+0x34 stays 0x30): only the lever
        cmp     r0, #1                  @   (no Jump / cannon / Route; the menu bar is mb_ctl's)
        beq     15f
        ldr     r0, [r3, #0x34]         @ HUD cover fade: 0 = sail HUD up
        cmp     r0, #0
        bne     4f
        tst     r1, #KEY_A
        movne   r0, #JUMP_X
        movne   r1, #JUMP_Y
        bne     5f
        tst     r1, #KEY_B
        movne   r0, #CANNON_X
        movne   r1, #CANNON_Y
        bne     5f
        tst     r1, #KEY_X
        movne   r0, #ROUTE_X
        movne   r1, #ROUTE_Y
        bne     5f
15:     ldrb    r12, [r3, #0x41]        @ lever locked
        cmp     r12, #0
        bne     4f
        ldr     r12, [r3, #0x1c]        @ speed: 0 = Stop, 2 = Go
        cmp     r12, #0
        andeq   r1, r1, #KEY_UP
        andne   r1, r1, #KEY_DOWN
        cmp     r1, #0
        beq     4f
        mov     r0, #LEVER_X
        mov     r1, #LEVER_Y
5:      bl      menu_tap_at
4:      ldr     r2, =PAD                @ bombchu map screen (mode BCHU_MODE): B = its back arrow;
        ldrh    r1, [r2, #2]            @   while the GO! / CANCEL panel of a drawn route shows,
        ldr     r0, =MODE               @   A = GO!, B = CANCEL
        ldr     r0, [r0]
        cmp     r0, #BCHU_MODE
        bne     bc_end
        tst     r1, #(KEY_A | KEY_B)
        beq     bc_end
        ldr     r0, =menu_tap
        ldrb    r0, [r0]
        cmp     r0, #0
        bne     bc_end
        ldr     r3, =MAP_OBJ            @ the route object lies BCHU_OBJ_OFF below the screen object
        ldr     r3, [r3]                @   (both new for each route screen; they move together)
        sub     r3, r3, #0x400
        sub     r3, r3, #0x1fc
        sub     r12, r3, #0x02000000    @ in main RAM?
        cmp     r12, #0x400000
        movhs   r12, #0
        bhs     bc_pan
        ldr     r12, [r3]
        ldr     r0, =BCHU_VT
        cmp     r12, r0
        ldrbeq  r12, [r3, #BCHU_PANEL]
        movne   r12, #0                 @ r12 = panel shown
bc_pan: tst     r1, #KEY_A
        bne     bc_a
        mov     r3, #KEY_B
        mov     r0, #SLATE_BACK_X
        mov     r1, #SLATE_BACK_Y
        cmp     r12, #0
        movne   r0, #BCHU_CANCEL_X
        movne   r1, #BCHU_CANCEL_Y
        b       bc_tap
bc_a:   cmp     r12, #0                 @ A with no panel: left to the game
        beq     bc_end
        mov     r3, #KEY_A
        mov     r0, #BCHU_GO_X
        mov     r1, #BCHU_GO_Y
bc_tap: ldrh    r12, [r2, #2]
        bic     r12, r12, r3
        strh    r12, [r2, #2]
        ldrh    r12, [r2]
        bic     r12, r12, r3
        strh    r12, [r2]
        bl      menu_tap_at
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
bc_end: tst     r1, #KEY_X              @ map note (mode NOTE_MODE): X = its Sea Chart / Map button
        beq     13f
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #NOTE_MODE
        ldreq   r0, =menu_tap
        ldrbeq  r0, [r0]
        cmpeq   r0, #0
        bne     13f
        bic     r1, r1, #KEY_X
        strh    r1, [r2, #2]
        mov     r0, #NOTE_CHART_X
        mov     r1, #NOTE_CHART_Y
        bl      menu_tap_at
13:     bl      st_ctl                  @ statue turn screen (same mode): Left / Right
14:     ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        tst     r1, #KEY_L              @ L / R count as Left / Right here (Items page:
        orrne   r1, r1, #KEY_LEFT       @   ip_ctl took the D-pad, so only L / R turn pages)
        tst     r1, #KEY_R
        orrne   r1, r1, #KEY_RIGHT
        tst     r1, #(KEY_B | KEY_RIGHT | KEY_LEFT)
        tsteq   r1, #KEY_Y
        beq     9f
        bl      in_coll
        bhi     9f
        ldr     r3, =COLL_PAGE
        ldr     r3, [r3]
        cmp     r3, #SY_CUST            @ shipyard screens in these modes: coll_ctl / sy_ctl
        bhs     9f                      @   (by page: OVL_SLOT keeps SY_OVL on Mercay's field)
        tst     r1, #KEY_B              @ B closes the collection, as Select does
        orrne   r1, r1, #KEY_SELECT
        strhne  r1, [r2, #2]
        mov     r0, #0
        cmp     r3, #COLL_TREASURE
        beq     6f
        cmp     r3, #COLL_SHIP
        beq     7f
        tst     r1, #KEY_RIGHT          @ Items (or unknown): the page arrows
        movne   r0, #PAGE_NEXT_X
        tst     r1, #KEY_LEFT
        movne   r0, #PAGE_PREV_X
        mov     r12, #PAGE_ARROW_Y
        tst     r1, #KEY_Y              @ Y = the switch-screens icon
        movne   r0, #SWAP_X
        movne   r12, #SWAP_Y
        b       8f
6:      mov     r12, #TAB_Y             @ Treasure: Right = Ship Parts tab, Left = "<"
        tst     r1, #KEY_RIGHT
        movne   r0, #TAB_SHIP_X
        tst     r1, #KEY_LEFT
        movne   r0, #PAGE_PREV_X
        movne   r12, #PAGE_ARROW_Y
        b       8f
7:      tst     r1, #KEY_LEFT           @ Ship Parts: Left = Treasure tab
        movne   r0, #TAB_TREASURE_X
        mov     r12, #TAB_Y
8:      cmp     r0, #0
        movne   r1, r12
        blne    menu_tap_at
9:      bl      item_ctl                @ R = item out / away, A = use it
        bl      gate_carry
        mov     r0, r4
        pop     {r4, pc}

@ A 30 Hz room on the field (gate obj set, e.g. the Cyclok fight) runs Link on the gated
@ reads only, which the gated branch above leaves empty: B / A never reached slash_check or
@ tap_front there. With Link free on land, a gated read gets the last ungated read's keys
@ (after our controllers took theirs), as the clean game leaves PAD unchanged then.
gate_carry:
        push    {r4, lr}
        ldr     r0, =GATE_OBJ
        bl      InputGate               @ leaf: r0-r2
        mov     r4, r0
        ldr     r3, =gate_pad
        bl      on_land
        movne   r0, #0                  @ not free on land: forget the keys
        strne   r0, [r3]
        popne   {r4, pc}
        ldr     r2, =PAD
        cmp     r4, #0
        ldreq   r0, [r2]                @ ungated: remember PAD +0 / +2
        streq   r0, [r3]
        ldrne   r0, [r3]                @ gated: hand them over again
        strne   r0, [r2]
        pop     {r4, pc}

@ ---------------------------------------------------------------------------
@ Hook @ 0x0207af30 (ov0, touch-screen update), replaces: bl TouchSample
@ r0 = touch manager, r1 = raw sample (u16 x, y, touch, validity), r2 = passed on.
@ While menu_tap runs, the sample is a stylus press on the page arrow, so the menu
@ sees an ordinary tap (press, then release once the real, untouched sample is back).
@ Otherwise ch_tap (set by choice_ctl, smenu_ctl, fs_ctl) steps the menu stylus through
@ its phases (ch_next): held on a button, or slid to another one and lifted for
@ CHOICE_STEP updates before pressing it, or lifted to choose (then off), etc.
@ Lifted = the real sample is passed through.
        .global menu_touch
menu_touch:
        ldr     r3, =menu_tap
        ldrb    r12, [r3]
        cmp     r12, #0
        subne   r12, r12, #1
        strbne  r12, [r3]
        bne     touch_at
        ldr     r3, =ch_tap
        ldrb    r12, [r3]
        push    {r0, r1}
        cmp     r12, #CH_OFF            @ off: no countdown
        beq     6f
        ldrh    r0, [r1, #4]            @ the real stylus down while the menu bar (or the Sea
        cmp     r0, #0                  @   Chart screen) holds ours: ours lets go and the screen
        beq     3f                      @   is the stylus's until it closes (mb_screen /
        ldr     r0, =mb_sel             @   sc_screen, as after A). This update the real sample
        ldrb    r1, [r0]                @   passes (a slide from ours: cancels its button), the
        cmp     r1, #0                  @   next one is forced up (CH_LIFT), so the real press is
        ldreq   r0, =sc_sel             @   a new press there (rig: taps of 10+ frames on another
                                        @   sea, 6+ on the bar or on the held button)
        ldrbeq  r1, [r0]
        cmpeq   r1, #0
        beq     3f
        mov     r1, #1
        strb    r1, [r0, #MB_SCREEN]
        strb    r1, [r3, #CT_LEFT]      @ (1 = one update forced up)
        mov     r1, #0
        strb    r1, [r0]
        mov     r1, #CH_LIFT
        strb    r1, [r3]
        mov     r12, #CH_OFF
        b       1f
3:      ldrb    r0, [r3, #CT_LEFT]
        cmp     r12, #CH_HOLD           @ held: settle count only, no next phase
        bne     2f
        cmp     r0, #0
        subne   r0, r0, #1
        strbne  r0, [r3, #CT_LEFT]
        b       1f
2:      subs    r0, r0, #1
        strb    r0, [r3, #CT_LEFT]
        bne     1f
        adr     r1, ch_next             @ phase over: on to the next one
        ldrb    r0, [r1, r12]
        strb    r0, [r3]
        add     r1, r1, #(ch_step - ch_next)
        ldrb    r0, [r1, r0]
        ldrb    r1, [r3]                @ item bar move (ib_sel + 1): the lift lasts one update
        cmp     r1, #CH_RELEASE
        ldreq   r1, =ib_sel
        ldrbeq  r1, [r1, #1]
        cmpeq   r1, #1
        moveq   r0, #1
        strb    r0, [r3, #CT_LEFT]
1:      mov     r0, #CH_TOUCHING        @ this update (old phase): stylus down?
        mov     r0, r0, lsr r12
        tst     r0, #1
        pop     {r0, r1}
        beq     7f
        add     r3, r3, #(CT_X - MT_X)
touch_at:                               @ press at x = [r3 + MT_X], y = [r3 + MT_Y]
        ldrb    r12, [r3, #MT_X]
        strh    r12, [r1]
        ldrb    r12, [r3, #MT_Y]
        strh    r12, [r1, #2]
        mov     r12, #1
        strh    r12, [r1, #4]
        mov     r12, #0
        strh    r12, [r1, #6]
        b       TouchSample
6:      ldr     r3, =fg_mode            @ menu stylus off: the fishing stylus (fish_ctl), if down
        ldrb    r12, [r3, #FGD_X]
        cmp     r12, #0
        pop     {r0, r1}
        beq     TouchSample
        add     r3, r3, #(FGD_X - MT_X)
        b       touch_at
7:      cmp     r12, #CH_LIFT           @ stylus up: the real sample, or forced up (CH_LIFT)
        moveq   r12, #0
        strheq  r12, [r1, #4]
        b       TouchSample

ch_next:        @ next ch_tap phase once a counted phase is over
        .byte   CH_OFF, CH_HOLD, CH_RELEASE, CH_HOLD, CH_OFF, CH_CONFIRM, CH_CONFIRM, CH_OFF
ch_step:        @ touch updates per counted phase (a bubble-to-bubble move is CH_DRAG + CH_RELEASE)
        .byte   0, CH_SETTLE, CH_MOVE_STEP, CH_MOVE_STEP, CHOICE_STEP, CHOICE_STEP, CHOICE_STEP, 1
        .if (ch_step - ch_next) - (CH_LIFT + 1)
        .error "ch_next needs one entry per phase, CH_OFF to CH_LIFT"
        .endif
        .balign 4

@ ---------------------------------------------------------------------------
@ Shared helpers.
@ Set the menu stylus (ch_tap) to phase r0, with its ch_step count. ch_go_at also moves it
@ to x = r2, y = r3; ch_go_off slides it off to empty space and lifts (CH_DRAGOFF).
@ Return r0 = 1 (the menu handlers' "taken"); clobber r1, r12 (ch_go_off also r2, r3).
ch_go_off:
        mov     r2, #FS_OFF_X
        mov     r3, #FS_OFF_Y
        mov     r0, #CH_DRAGOFF
ch_go_at:
        ldr     r12, =ch_tap
        strb    r2, [r12, #CT_X]
        strb    r3, [r12, #CT_Y]
        b       1f
ch_go:
        ldr     r12, =ch_tap
1:      strb    r0, [r12]
        adr     r1, ch_step
        ldrb    r1, [r1, r0]
        strb    r1, [r12, #CT_LEFT]
        mov     r0, #1
        bx      lr

@ r0, r1 = x, y: a menu_tap stylus tap there (MENU_TAP_FRAMES touch updates). Clobbers r2, r3.
menu_tap_at:
        ldr     r3, =menu_tap
        strb    r0, [r3, #MT_X]
        strb    r1, [r3, #MT_Y]
        mov     r2, #MENU_TAP_FRAMES
        strb    r2, [r3]
        bx      lr

@ -> flags ls if the collection screen is up (modes 0x13-0x17 from land, 0x1d-0x21 from
@ the sea), else hi. Clobbers r0 only.
in_coll:
        ldr     r0, =MODE
        ldr     r0, [r0]
        sub     r0, r0, #0x13
        cmp     r0, #4
        subhi   r0, r0, #(0x1d - 0x13)
        cmphi   r0, #4
        bx      lr

@ -> flags eq if Link is free in the field: mode 1 and no text box (msg_guard 0); on_land
@ also needs him on land (not at sea). Else ne. Clobber r0 only.
on_land:
        ldr     r0, =SEA_OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #SEA_OVL
        bne     on_field
        cmp     r0, #0                  @ at sea: ne
        bx      lr
on_field:
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #1
        ldreq   r0, =msg_guard
        ldrbeq  r0, [r0]
        cmpeq   r0, #0
        bx      lr

@ r0 = heading (0 = +z / down the screen, 0x4000 = +x) -> r0 = nearest octant 0-7.
hd_oct:
        add     r0, r0, #0x1000
        mov     r0, r0, lsl #16
        mov     r0, r0, lsr #29
        bx      lr

@ ---------------------------------------------------------------------------
@ Dialogue choices ("Sure" / "No way" bubbles over the text box). The game takes them by
@ touch only: each bubble is a touch button (entries at panel +0x180, 16 bytes: +8 layout
@ cell, +0xc element, 0xff = none) that fires when the stylus goes down and comes up on it.
@ Called from pad_update with the real new presses in PAD+2; returns r0 = 1 while choices
@ are up (else smenu_ctl, then fs_ctl, which switches the stylus off if no menu is up).
@ When the bubbles first show, the stylus is pressed on the top one (the game highlights
@ it); A is ignored for CH_AUTO_LOCK pad reads after that, so an A meant for the text
@ before doesn't choose it. Up/Down move the press to the next bubble, wrapping around
@ (Down on the bottom one = top, Up on the top one = bottom). A lifts the stylus there,
@ choosing it. A key pressed while the stylus is still moving is kept (ch_queue, the
@ latest one) and done once it is held again. While the bubbles are up, A/B/Up/Down are
@ hidden from the game, so no text-box tap moves the held touch.
@ Bubble centre = CellPos(cell, element, anchors 4, 4) + panel offset (+0x178, +0x17c),
@ the same space the game's hit test uses.
choice_ctl:
        push    {r4-r11, lr}
        sub     sp, sp, #16             @ [sp], [sp+4] = CellPos anchors, [sp+8] x, [sp+12] y
        ldr     r8, =ch_tap
        ldr     r4, =msgwin
        ldrb    r1, [r4, #MW_SEEN]
        subs    r1, r1, #1
        bmi     ch_off
        strb    r1, [r4, #MW_SEEN]
        ldr     r0, [r4]
        ldr     r5, [r0, #0x164]        @ the text box's choice panel
        cmp     r5, #0
        beq     ch_off
        add     r0, r5, #0x100
        ldrsh   r6, [r0, #0x6e]         @ number of choices (0 = none up)
        ldrsh   r1, [r0, #0x5c]         @ panel shown
        cmp     r6, #0
        cmpgt   r1, #0
        ble     ch_off
        cmp     r6, #4
        movgt   r6, #4
        add     r6, r5, r6, lsl #4
        add     r6, r6, #0x180          @ r6 = end of the bubble entries
        ldr     r2, =PAD
        ldrh    r7, [r2, #2]
        bic     r0, r7, #(KEY_A | KEY_B | KEY_UP | KEY_DOWN)
        strh    r0, [r2, #2]
        and     r7, r7, #(KEY_A | KEY_UP | KEY_DOWN)
        ldrb    r0, [r8]                @ r0 = stylus phase
        ldrb    r1, [r4, #MW_AUTO]
        cmp     r1, #1
        subhi   r1, r1, #1
        strbhi  r1, [r4, #MW_AUTO]
        bichi   r7, r7, #KEY_A          @ A locked just after the auto press
        cmp     r0, #CH_DRAG            @ moving: keep the latest key for later
        cmpne   r0, #CH_RELEASE
        beq     ch_wait
        cmp     r0, #CH_HOLD
        bne     2f
        ldrb    r2, [r8, #CT_LEFT]         @ press not settled yet (a move started now
        cmp     r2, #0                  @   could lift it on the old bubble)
        bne     ch_wait
        cmp     r7, #0
        ldrbeq  r7, [r4, #MW_QUEUE]          @ held again: a key kept from the move
        mov     r2, #0
        strb    r2, [r4, #MW_QUEUE]
        tst     r7, #KEY_A              @ A: lift the stylus off the held bubble
        movne   r0, #CH_CONFIRM
        bne     ch_set
        ands    r7, r7, #(KEY_UP | KEY_DOWN)
        beq     ch_done
        ldrb    r9, [r8, #CT_Y]         @ y of the held bubble
        b       ch_find
2:      cmp     r0, #CH_OFF
        bne     ch_done                 @ choosing
        cmp     r1, #0                  @ bubbles new: press the top one
        moveq   r1, #CH_AUTO_LOCK
        strbeq  r1, [r4, #MW_AUTO]
        moveq   r7, #KEY_DOWN
        ands    r7, r7, #(KEY_UP | KEY_DOWN)
        beq     ch_done
        mvn     r9, #0                  @ nothing held: nearest below y = -1 = top bubble
        mov     r7, #KEY_DOWN
ch_find:
        tst     r7, #KEY_DOWN           @ r10 = best y so far, r11 = its x (-1 = none)
        movne   r10, #0x10000
        mvneq   r10, #0
        mvn     r11, #0
        add     r4, r5, #0x180
3:      ldrb    r1, [r4, #0xc]
        cmp     r1, #0xff
        beq     4f
        mov     r0, #4
        str     r0, [sp]
        str     r0, [sp, #4]
        ldrsh   r0, [r4, #8]
        add     r2, sp, #8
        add     r3, sp, #12
        bl      CellPos
        ldr     r0, [sp, #12]
        ldr     r1, [r5, #0x17c]
        add     r0, r0, r1              @ screen y
        tst     r7, #KEY_DOWN
        beq     5f
        cmp     r0, r9                  @ Down: nearest below the held one
        cmpgt   r10, r0
        b       6f
5:      cmp     r9, r0                  @ Up: nearest above
        cmpgt   r0, r10
6:      ble     4f
        mov     r10, r0
        ldr     r11, [sp, #8]
        ldr     r1, [r5, #0x178]
        add     r11, r11, r1
4:      add     r4, r4, #16
        cmp     r4, r6
        bne     3b
        cmn     r11, #1
        bne     5f
        tst     r7, #KEY_DOWN           @ none past the held one: wrap around,
        mvnne   r0, #0                  @   Down from the top,
        moveq   r0, #0x10000            @   Up from the bottom
        cmp     r9, r0
        movne   r9, r0
        bne     ch_find
        b       ch_done
5:      ldrb    r0, [r8]
        cmp     r0, #CH_HOLD
        bne     6f
        ldrb    r1, [r8, #CT_Y]
        cmp     r1, r10
        beq     ch_done                 @ the only bubble: already held
6:      strb    r11, [r8, #CT_X]
        strb    r10, [r8, #CT_Y]
        cmp     r0, #CH_HOLD
        moveq   r0, #CH_DRAG            @ slide over, lift, press again
        movne   r0, #CH_HOLD            @ first press
ch_set: bl      ch_go
        b       ch_ret
ch_wait:
        cmp     r7, #0
        strbne  r7, [r4, #MW_QUEUE]
        b       ch_done
ch_off: mov     r0, #0                  @ (r4 = msgwin) bubbles gone: next ones are new
        strb    r0, [r4, #MW_AUTO]
        strb    r0, [r4, #MW_QUEUE]
        b       ch_ret
ch_done:
        mov     r0, #1
ch_ret: add     sp, sp, #16
        pop     {r4-r11, pc}

@ ---------------------------------------------------------------------------
@ Hook @ 0x020f16d8 and 0x020f1780 (ov3, save menu: Continue / Save and Quit), replaces:
@ blx r12 (the touch-button update, r0 = button, r2 = y offset of the buttons).
@ The save menu controller (r10; state +4 = 2 while the menu is up) updates its 3 buttons
@ (r5 = index: 0 = Continue, 1 = Save and Quit or 2 = its alternative, only one of them
@ shown) only while the menu takes input. Records them for smenu_ctl, then runs the update.
        .global smenu_btn
smenu_btn:
        push    {r1, r3}
        ldr     r3, =smenu
        str     r0, [r3, r5, lsl #2]
        cmp     r5, #0
        moveq   r1, #0                  @ new pass: forget 1 and 2
        streq   r1, [r3, #4]
        streq   r1, [r3, #8]
        strh    r2, [r3, #SM_OFFY]
        mov     r1, #CH_SEEN_FRAMES
        strb    r1, [r3, #SM_SEEN]
        pop     {r1, r3}
        bx      r12

@ The save menu (Select > Save): big Continue / Save and Quit buttons, touch only.
@ Same stylus handling as choice_ctl: when the menu first takes input, the stylus presses
@ the top button (Continue; A ignored for CH_AUTO_LOCK pad reads). Two buttons are shown,
@ so Up/Down switch to the other one (wrapping). A lifts the stylus there, which presses
@ it. Keys pressed while the stylus moves or settles wait in sm_queue. A/Up/Down are
@ hidden from the game while the menu is up (B / Start already mean Continue to the game).
@ Button centre = CellPos(cell, element, anchors 4, 4) + (0, y offset), as the game hit-tests.
smenu_ctl:
        push    {r4-r7, lr}
        sub     sp, sp, #20             @ [sp], [sp+4] = CellPos anchors, [sp+8] x, [sp+12] y
        ldr     r4, =smenu
        ldr     r6, =ch_tap
        ldrb    r0, [r4, #SM_SEEN]
        subs    r0, r0, #1
        bmi     sm_off
        strb    r0, [r4, #SM_SEEN]
        ldr     r2, =PAD
        ldrh    r7, [r2, #2]
        ldrb    r0, [r6]                @ r0 = stylus phase
        cmp     r0, #CH_OFF             @ B / Start with the stylus down: the game would close
        andsne  r1, r7, #SM_CLOSE       @   the menu under it and take its lift as a field tap
        bicne   r7, r7, #SM_CLOSE       @   (talking to whoever is there), so the key waits
        cmpne   r0, #CH_CONFIRM         @   until the stylus has slid off and lifted (not
        strbne  r1, [r4, #SM_QUEUE]     @   after A)
        ldrb    r1, [r4, #SM_QUEUE]
        ands    r3, r1, #SM_CLOSE       @ r3 = B / Start waiting
        cmpne   r0, #CH_OFF
        orreq   r7, r7, r3              @ lifted: hand it over now
        biceq   r1, r1, r3
        strbeq  r1, [r4, #SM_QUEUE]
        bic     r3, r7, #(KEY_A | KEY_UP | KEY_DOWN)
        strh    r3, [r2, #2]
        tst     r1, #SM_CLOSE
        bne     sm_boff
        and     r7, r7, #(KEY_A | KEY_UP | KEY_DOWN)
        ldrb    r1, [r4, #SM_AUTO]
        cmp     r1, #1
        subhi   r1, r1, #1
        strbhi  r1, [r4, #SM_AUTO]
        bichi   r7, r7, #KEY_A          @ A locked just after the auto press
        cmp     r0, #CH_DRAG            @ moving: keep the latest key for later
        cmpne   r0, #CH_RELEASE
        beq     sm_wait
        cmp     r0, #CH_HOLD
        bne     1f
        ldrb    r2, [r6, #CT_LEFT]         @ press not settled yet
        cmp     r2, #0
        bne     sm_wait
        cmp     r7, #0
        ldrbeq  r7, [r4, #SM_QUEUE]          @ held again: a key kept from the move
        mov     r2, #0
        strb    r2, [r4, #SM_QUEUE]
        tst     r7, #KEY_A              @ A: lift the stylus off the held button
        movne   r0, #CH_CONFIRM
        bne     sm_set
        tst     r7, #(KEY_UP | KEY_DOWN)
        beq     sm_done
        ldrb    r5, [r4, #SM_SEL]       @ on to the other button
        cmp     r5, #0
        movne   r5, #0
        bne     2f
        ldr     r1, [r4, #4]            @ the one below: index 1, or 2 if that one is shown
        cmp     r1, #0
        moveq   r5, #2
        movne   r5, #1
        b       2f
1:      cmp     r0, #CH_OFF
        bne     sm_done                 @ choosing
        cmp     r1, #0                  @ menu new: press the top button
        moveq   r7, #KEY_DOWN
        tst     r7, #(KEY_UP | KEY_DOWN)
        beq     sm_done
        mov     r5, #0                  @ nothing held: the top button
2:      ldr     r7, [r4, r5, lsl #2]
        cmp     r7, #0
        beq     sm_done
        cmp     r0, #CH_HOLD
        ldrbeq  r1, [r4, #SM_SEL]
        cmpeq   r1, r5
        beq     sm_done                 @ already held there
        strb    r5, [r4, #SM_SEL]
        mov     r0, #4
        str     r0, [sp]
        str     r0, [sp, #4]
        ldrsh   r0, [r7, #8]            @ layout cell
        ldrb    r1, [r7, #0xc]          @ element
        add     r2, sp, #8
        add     r3, sp, #12
        bl      CellPos
        ldr     r0, [sp, #8]
        strb    r0, [r6, #CT_X]
        ldr     r0, [sp, #12]
        ldrsh   r1, [r4, #SM_OFFY]
        add     r0, r0, r1
        strb    r0, [r6, #CT_Y]
        ldrb    r0, [r6]
        cmp     r0, #CH_HOLD
        moveq   r0, #CH_DRAG            @ slide over, lift, press again
        beq     sm_set
        ldrb    r1, [r4, #SM_AUTO]          @ first press: the menu's auto press is done
        cmp     r1, #0
        moveq   r1, #CH_AUTO_LOCK
        strbeq  r1, [r4, #SM_AUTO]
        mov     r0, #CH_HOLD
sm_set: bl      ch_go
        b       sm_ret
sm_wait:
        cmp     r7, #0
        strbne  r7, [r4, #SM_QUEUE]
        b       sm_done
sm_boff:                                @ B / Start waiting: once held, slide off to empty space, lift
        cmp     r0, #CH_HOLD
        bne     sm_done
        bl      ch_go_off
        b       sm_ret
sm_off: mov     r0, #0                  @ save menu not up (fs_ctl runs next): next one is new
        strb    r0, [r4, #SM_AUTO]
        strb    r0, [r4, #SM_QUEUE]
        b       sm_ret
sm_done:
        mov     r0, #1
sm_ret: add     sp, sp, #20
        pop     {r4-r7, pc}

@ ---------------------------------------------------------------------------
@ The shop window (merchant's table, overlay 31), touch only. Items 0-4 are 3D actors that
@ open the item view when tapped. The game shows no highlight while the stylus is held on one,
@ so the highlighted item is lifted (sh_lift): its home height +SH_LIFT, which the game keeps
@ it at. Table: the first item for sale is lifted, the D-pad moves the lift (Right/Down = next,
@ Left/Up = previous, wrapping), A taps the lifted item once it is in place. B taps Quit
@ under the table (leaves the shop). Item view (Buy / Quit): the stylus is held on Buy when it
@ first takes input (A ignored for CH_AUTO_LOCK pad reads); Left/Right hold Buy / Quit, A lifts
@ = presses it, B presses Quit (slides there first), Up/Down = previous / next item (Quit,
@ then the table opens it). Keys pressed while the stylus moves or the view is busy wait in
@ sh_queue. A/B/D-pad are hidden from the game while the shop is up. Returns r0 = 1 then.
@ Item tap point = the actor's position (+0x48, what the game hit-tests) on screen.
shop_ctl:
        push    {r4-r8, lr}
        sub     sp, sp, #12             @ [sp] = 5th argument, [sp+4] x, [sp+8] y
        ldr     r4, =sh_last
        ldr     r0, =OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #SHOP_OVL
        ldreq   r0, =MODE
        ldreq   r0, [r0]
        cmpeq   r0, #SHOP_MODE
        ldreq   r5, =SHOP_PTR
        ldreq   r5, [r5]
        movne   r5, #0
        mvn     r0, #0
        cmp     r5, #0
        beq     sh_reset                @ not in the shop: next one is new
        ldr     r0, =msg_guard
        ldrb    r0, [r0]
        cmp     r0, #0
        bne     sh_no                   @ a text box takes the keys
        ldr     r2, =PAD
        ldrh    r7, [r2, #2]
        bic     r0, r7, #(KEY_A | KEY_B | DPAD)
        strh    r0, [r2, #2]
        and     r7, r7, #(KEY_A | KEY_B | DPAD)
        ldr     r6, =ch_tap
        ldrb    r8, [r6]                @ r8 = stylus phase
        ldr     r0, [r5, #0x14]         @ item shown, -1 = table
        cmp     r0, #0
        bge     sh_item
        mov     r0, #5                  @ table Quit active: the table takes input
        bl      sh_active
        beq     sh_busy
        mov     r0, #0                  @ next item view is new
        strh    r0, [r4, #SH_AUTO]          @ (and SH_QUEUE)
        cmp     r8, #CH_OFF
        bne     sh_done
        tst     r7, #KEY_B
        movne   r0, #SH_TQUIT_X
        bne     sh_tapbtn
        ldrb    r1, [r4, #SH_NEXT]           @ an item to open (A, or Up/Down in the item view)
        cmp     r1, #0xff
        bne     2f
        ldrb    r1, [r4]                @ highlighted item if still for sale, else the next
        cmp     r1, #0xff               @   (none: the first)
        subne   r1, r1, #1
        mov     r2, #1
        bl      sh_search
        cmp     r1, #0
        blt     sh_done                 @ nothing for sale
        tst     r7, #DPAD
        beq     1f
        tst     r7, #(KEY_RIGHT | KEY_DOWN)
        mvneq   r2, #0
        bl      sh_search
1:      tst     r7, #KEY_A
        strbne  r1, [r4, #SH_NEXT]
2:      strb    r1, [r4]
        bl      sh_lift
        ldrb    r0, [r4, #SH_NEXT]
        cmp     r0, #0xff
        beq     sh_done
        mov     r0, r1                  @ open it once it sits at its (lifted) place
        bl      sh_actor
        cmp     r0, #0
        beq     sh_done
        ldr     r2, [r0, #0x4c]
        ldr     r3, [r0, #0x18]
        cmp     r2, r3
        bne     sh_done
        mov     r0, #0xff
        strb    r0, [r4, #SH_NEXT]
sh_open:                                @ r1 = item: tap it
        mov     r0, r1
        bl      sh_actor
        movs    r7, r0
        beq     sh_done
        ldr     r0, =CAMPTR
        ldr     r0, [r0]
        bl      GetCamera
        mov     r1, #0
        str     r1, [sp]
        add     r1, r7, #0x48
        add     r2, sp, #4
        add     r3, sp, #8
        bl      ScreenFromWorld
        ldrh    r0, [sp, #4]
        ldrh    r1, [sp, #8]
        b       sh_tap
sh_tapbtn:
        mov     r1, #SH_BTN_Y
sh_tap: strb    r0, [r6, #CT_X]           @ r0, r1 = x, y: press and lift
        strb    r1, [r6, #CT_Y]
        mov     r0, #CH_TAP
        b       sh_set
sh_item:                                @ r0 = item shown
        strb    r0, [r4]
        mov     r0, #7                  @ Buy active: the item view takes input
        bl      sh_active
        bne     1f
        mov     r0, #5                  @ only Quit under the table (e.g. after "You don't
        bl      sh_active               @   have enough Rupees!"): A/B tap it
        beq     sh_busy
        cmp     r8, #CH_OFF
        bne     sh_done
        tst     r7, #(KEY_A | KEY_B)
        movne   r0, #SH_TQUIT_X
        bne     sh_tapbtn
        b       sh_done
1:
        ldrb    r1, [r4, #SH_AUTO]
        cmp     r1, #1
        subhi   r1, r1, #1
        strbhi  r1, [r4, #SH_AUTO]
        movhi   r2, #KEY_A              @ r2 = A locked just after the auto press
        movls   r2, #0
        cmp     r8, #CH_DRAG            @ moving: keep the key for later
        cmpne   r8, #CH_RELEASE
        beq     sh_busy
        cmp     r8, #CH_HOLD
        beq     3f
        cmp     r8, #CH_OFF
        bne     sh_done                 @ pressing
        cmp     r1, #0                  @ nothing held: press Buy (view new: lock A)
        moveq   r1, #CH_AUTO_LOCK
        strbeq  r1, [r4, #SH_AUTO]
        cmp     r7, #0
        strbne  r7, [r4, #SH_QUEUE]
        mov     r1, #0
        b       sh_btn
3:      ldrb    r0, [r6, #CT_LEFT]         @ press not settled yet
        cmp     r0, #0
        bne     sh_busy
        cmp     r7, #0
        ldrbeq  r7, [r4, #SH_QUEUE]         @ held: a key kept from before
        mov     r0, #0
        strb    r0, [r4, #SH_QUEUE]
        bic     r7, r7, r2
        tst     r7, #(KEY_UP | KEY_DOWN)
        beq     4f
        ldr     r1, [r5, #0x14]         @ Up/Down: the item before / after this one,
        tst     r7, #KEY_DOWN
        movne   r2, #1
        mvneq   r2, #0
        bl      sh_search
        cmp     r1, #0
        strbge  r1, [r4, #SH_NEXT]         @   opened once the table is back,
        orr     r7, r7, #KEY_B          @   so leave this view
4:      tst     r7, #KEY_B
        beq     5f
        ldrb    r0, [r4, #SH_HELD]
        cmp     r0, #1
        beq     sh_press                @ Quit held: press it
        mov     r0, #KEY_B              @ else slide to Quit, then press it
        strb    r0, [r4, #SH_QUEUE]
        mov     r1, #1
        b       sh_btn
5:      tst     r7, #KEY_A
        bne     sh_press
        ands    r1, r7, #(KEY_LEFT | KEY_RIGHT)
        beq     sh_done
        cmp     r1, #KEY_RIGHT
        moveq   r1, #1
        movne   r1, #0
sh_btn:                                 @ r1 = 0 Buy / 1 Quit: hold the stylus on it
        cmp     r8, #CH_HOLD
        ldrbeq  r0, [r4, #SH_HELD]
        cmpeq   r0, r1
        beq     sh_done                 @ already held
        strb    r1, [r4, #SH_HELD]
        cmp     r1, #0
        moveq   r0, #SH_BUY_X
        movne   r0, #SH_QUIT_X
        mov     r1, #SH_BTN_Y
        strb    r0, [r6, #CT_X]
        strb    r1, [r6, #CT_Y]
        cmp     r8, #CH_HOLD
        moveq   r0, #CH_DRAG            @ slide over, lift, press again
        movne   r0, #CH_HOLD
        b       sh_set
sh_press:
        mov     r0, #CH_CONFIRM
sh_set: bl      ch_go
        b       sh_ret
sh_busy:                                @ keep a key for later (a waiting B stays)
        cmp     r7, #0
        ldrbne  r0, [r4, #SH_QUEUE]
        cmpne   r0, #KEY_B
        strbne  r7, [r4, #SH_QUEUE]
sh_done:
        mov     r0, #1
        b       sh_ret
sh_reset:                               @ r0 = -1
        strh    r0, [r4]                @ no last item, none to open
        mov     r0, #0
        strh    r0, [r4, #SH_AUTO]         @ auto, queue
sh_no:  mov     r0, #0
sh_ret: add     sp, sp, #12
        pop     {r4-r8, pc}

@ r1 = item (0xff = none), r2 = step +1/-1 -> r1 = the next item along that is for sale, or -1.
@ Needs r5 = the shop.
sh_search:
        push    {r3, lr}
        cmp     r1, #0xff
        bne     1f
        cmp     r2, #0                  @ none: Right/A from the first, Left from the last
        mvngt   r1, #0
        movlt   r1, #5
1:      mov     r3, #5
2:      add     r1, r1, r2
        cmp     r1, #0
        movlt   r1, #4
        cmp     r1, #4
        movgt   r1, #0
        mov     r0, r1
        bl      sh_actor
        cmp     r0, #0
        ldrne   r0, [r0, #0x158]        @ 1 = sold out (also the empty slot, item id -1);
        cmpne   r0, #1                  @   a tap only says so
        popne   {r3, pc}
        subs    r3, r3, #1
        bne     2b
        mvn     r1, #0
        pop     {r3, pc}

@ r1 = item: lift it (home y +SH_LIFT; the game moves it there), lowering the one lifted
@ before. sh_ly = the lifted home y, so an item that isn't ours (new shop) is never lowered.
@ Needs r4 = sh_last, r5 = the shop; keeps r1.
sh_lift:
        push    {r1, r6, r7, lr}
        mov     r6, r1
        ldr     r7, [r4, #SH_LY]
        ldrb    r0, [r4, #SH_LSLOT]
        cmp     r0, #5
        bhs     1f
        bl      sh_actor
        cmp     r0, #0
        beq     1f
        ldr     r1, [r0, #0x18]
        cmp     r1, r7
        bne     1f                      @ not lifted by us (any more)
        ldrb    r2, [r4, #SH_LSLOT]
        cmp     r2, r6
        beq     2f                      @ already lifted
        sub     r1, r1, #SH_LIFT
        str     r1, [r0, #0x18]
1:      mov     r0, r6
        bl      sh_actor
        cmp     r0, #0
        beq     2f
        ldr     r1, [r0, #0x18]
        add     r1, r1, #SH_LIFT
        str     r1, [r0, #0x18]
        str     r1, [r4, #SH_LY]
        strb    r6, [r4, #SH_LSLOT]
2:      pop     {r1, r6, r7, pc}

@ r0 = button slot -> r0 = 1 (flags ne) if it is shown and takes taps, else 0 (eq). Keeps r2-r3.
sh_active:
        push    {lr}
        bl      sh_actor
        cmp     r0, #0
        ldrne   r1, [r0, #0x160]        @ (as its tap test: +0x160 == 0, +0x164 != 0)
        ldrbne  r0, [r0, #0x164]
        cmpne   r1, #0
        movne   r0, #0
        cmp     r0, #0
        pop     {pc}

@ r0 = shop slot -> r0 = its actor, or 0. Needs r5 = the shop; keeps r1-r3.
sh_actor:
        push    {r1-r3, lr}
        add     r1, r5, #0x70
        add     r1, r1, r0, lsl #3
        ldr     r0, =ACTOR_MGR
        ldr     r0, [r0]
        bl      ActorFromHandle
        pop     {r1-r3, pc}
        .ltorg                          @ shared literal pool (v2.1.68: 4 pools, was 17; each pool repeats its constants)

@ ---------------------------------------------------------------------------
@ Collection page 2 (Treasure / Ship Parts tabs), touch only. Each tab is a grid of 2 x 4
@ slots: a held press lights a slot, the lift on it opens the entry (a drag to another slot
@ cancels). The tab's panel state (its handler address) tells the grid from an open entry.
@ Only slots with an entry are used (slot object +0x44 != -1; an empty slot shows no light).
@ Grid: Up/Down/A hold the stylus on the tab's last slot (or the first one with an entry);
@ back from an entry, that slot is held again at once. While it is held, the D-pad moves it
@ to the next slot with an entry (slide, lift, press there; Up/Down: the other row, same
@ column or the nearest), A lifts it = opens the entry, B slides it off and lifts (nothing
@ opens), then closes the collection (Select). Left / Right with no slot left that way in the row
@ stay. Up on the top row (or with no slot above) lets go the same way = tab level, where
@ Left / Right switch tabs; Down on the bottom row (or with no slot below) stays. Other keys (Select, ...) with the stylus down wait until it has let go,
@ so the game never sees a lift after the screen changed. Nothing held: Left/Right/B go on
@ to pad_update (tab chain; B = Select). Keys pressed while the stylus moves wait in cl_key.
@ Entry shown: B taps the back arrow; A too, except on the Ship Parts list, where A taps
@ Explanation (its back arrow returns to the list). A/B/D-pad are hidden from the game there.
@ Ship Parts list (9 rows of one part kind, 3 on screen): Up/Down pick the previous / next
@ part owned (none that way: stay, no wrap) as cl_tgt; then each pad read with the stylus
@ off and the list at rest taps a scroll arrow until that row is on screen, then taps the
@ row (the game shows the part on the release). Up/Down during a tap wait in cl_key.
@ Shipyard Customize (COLL_PAGE SY_CUST; only the shipyard has it) is the same Ship Parts
@ panel class at SY_PANEL, as a third tab with all 8 slots filled. Differences: no tabs, so
@ Up on the top row stays and Left/Right with nothing held hold a slot too; B (held slot:
@ after the let-go) taps the red back arrow (main menu); the game sees no A/B/D-pad. Parts
@ list: A = Attach, X = Explanation (B / Up / Down as above).
@ Treasure merchant (overlay MC_OVL, mode SHOP_MODE): the same two panels (heap, from the
@ merchant object) as tabs 3 / 4, with the tabs and Quit always on screen. Grid: as the
@ collection, but the game sees no A/B/D-pad; nothing held: Left / Right tap the Treasure /
@ Ship Parts tab, B taps Quit (leaves; a held slot lets go first). Parts list: a row is
@ always held (first the row shown): Up/Down slide the stylus to the previous / next part
@ owned (off screen: let go, scroll arrow taps, press there), A lifts = that part's Sell
@ view, B taps Quit (back to the grid). Sell view: once its buttons stop sliding in, the
@ stylus holds Sell (once per view); A lifts = Sell, B taps Quit (a held Sell lets go first).
@ Magic box (overlay MC_OVL, collection mode, COLL_PAGE 7 / 8): the panels (heap, from the
@ collection object) as tabs 5 / 6. Grid: as the merchant, but B taps the red back arrow
@ (leaves). Parts list: as the collection list, then A = Stow, X = Explanation (the shipyard
@ list's places), B = back arrow. Treasure entry: as the merchant Sell view with Stow held;
@ A lifts = Stow, B = back arrow.
coll_ctl:
        push    {r4-r10, lr}
        ldr     r4, =cl_sel
        ldr     r5, =COLL_PAGE
        ldr     r5, [r5]
        sub     r5, r5, #COLL_SHIP      @ r5 = tab: 0 Ship Parts, 1 Treasure, 2 shipyard Customize
        bl      in_coll                 @   (merchant: 3 Ship Parts, 4 Treasure; magic box: 5 / 6)
        bhi     cl_merch
        cmp     r5, #(SY_CUST - COLL_SHIP) @ collection: the two tabs, shipyard: Customize
        bhi     cl_magic                @   (by page: OVL_SLOT keeps SY_OVL on Mercay's field)
        bne     2f
        ldr     r0, =sy_sel             @ (sy_ctl's main menu is new when it comes back)
        mov     r1, #0
        strb    r1, [r0, #SY_AUTO]
2:      ldr     r9, =cl_base
        ldr     r9, [r9, r5, lsl #2]    @ r9 = the tab's panel
        cmp     r5, #1
        bhi     3f                      @ (shipyard Customize: the fixed panel)
        ldr     r0, =COLL_OBJ           @ collection tabs: the panels from the collection object
        ldr     r0, [r0]                @   (the fixed ones move once the magic box overlay is
        sub     r1, r0, #0x02000000     @   loaded: user state 552)
        cmp     r1, #0x3e0000
        addlo   r0, r0, #MB_PANELS
        ldrlo   r0, [r0, r5, lsl #2]
        sublo   r1, r0, #0x02000000
        cmplo   r1, #0x3e0000
        movlo   r9, r0
        b       3f
        .ltorg
cl_magic:
        sub     r5, r5, #(MB_PAGE - COLL_SHIP)
        ldr     r9, =COLL_OBJ
        ldr     r9, [r9]
        mov     r10, #MB_PANELS
        ldr     r1, =(mc_vt + 8)
        mov     r3, #5
        b       1f
cl_merch:
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #SHOP_MODE
        bne     cl_no
        ldr     r9, =MC_PTR
        ldr     r9, [r9]
        mov     r10, #MC_PANELS
        ldr     r1, =mc_vt
        mov     r3, #3
1:      ldr     r0, =MC_OVL_SLOT        @ r9 = owner object, r10 = its panel pointers,
        ldr     r0, [r0]                @   r1 = their vtables, r3 = first tab
        cmp     r0, #MC_OVL
        bne     cl_no
        cmp     r5, #1
        bhi     cl_no
        sub     r0, r9, #0x02000000     @ in main RAM?
        cmp     r0, #0x3e0000
        bhs     cl_no
        add     r9, r9, r10
        ldr     r9, [r9, r5, lsl #2]
        sub     r0, r9, #0x02000000
        cmp     r0, #0x3e0000
        bhs     cl_no
        ldr     r0, [r9]                @ the panel class we know?
        ldr     r1, [r1, r5, lsl #2]
        cmp     r0, r1
        bne     cl_no
        add     r5, r5, r3
3:      ldr     r6, [r9, #0x10]         @ r6 = the tab's panel state
        ldr     r8, =ch_tap
        ldrb    r0, [r8]                @ r0 = stylus phase
        ldr     r2, =PAD
        ldrh    r7, [r2, #2]            @ r7 = new presses
        ldr     r1, =cl_grid
        ldr     r1, [r1, r5, lsl #2]
        cmp     r6, r1
        beq     cl_gridv
        bic     r1, r7, #(KEY_A | KEY_B | DPAD)
        strh    r1, [r2, #2]
        ldr     r1, =TFN_ITEM           @ an entry shown (else the panel is busy)
        cmp     r6, r1
        ldrne   r1, =SFN_LIST
        cmpne   r6, r1
        ldrne   r1, =SFN_INFO
        cmpne   r6, r1
        ldrne   r1, =MC_SSELL
        cmpne   r6, r1
        bne     ctl_done
        mov     r1, #1                  @ back on the grid: hold the slot again
        strb    r1, [r4, #CL_BACK]
        cmp     r0, #CH_OFF
        beq     1f
        cmp     r5, #3                  @ merchant list: also with a row held (settled)
        cmphs   r0, #CH_HOLD
        ldrbeq  r1, [r8, #CT_LEFT]
        cmpeq   r1, #0
        beq     1f
        and     r3, r7, #(KEY_UP | KEY_DOWN)
        cmp     r5, #3                  @ (merchant list / Sell view: A / B too)
        andhs   r3, r7, #(KEY_A | KEY_B | KEY_UP | KEY_DOWN)
        cmp     r3, #0
        strbne  r3, [r4, #CL_KEY]        @ pressed while the stylus taps / moves
        b       ctl_done
1:      ldrb    r3, [r4, #CL_KEY]
        orr     r7, r7, r3
        mov     r3, #0
        strb    r3, [r4, #CL_KEY]
        ldr     r1, =SFN_LIST
        cmp     r6, r1
        bne     7f
        ldr     r10, [r9, #0x1c]        @ parts list: r10 = row shown
        strb    r3, [r4, #CL_LOCK]
        ldr     r1, [r9, #0x8a4]        @ rows still sliding in: wait (a press then is
        cmp     r1, #0                  @   not taken: the merchant's first A did nothing)
        bne     ctl_done
        cmp     r5, #3                  @ (the merchant's list is tab 3 only)
        beq     1f
        tst     r7, #(KEY_A | KEY_B)
        tsteq   r7, #KEY_X
        bne     6f
        b       2f
1:      tst     r7, #KEY_B              @ merchant: B = Quit (a held row lets go first)
        beq     1f
        mov     r2, #SH_TQUIT_X
        mov     r3, #SH_BTN_Y
cl_mquit:                               @ (r2, r3 = Quit / back arrow)
        cmp     r0, #CH_HOLD
        moveq   r1, #KEY_B
        strbeq  r1, [r4, #CL_KEY]
        beq     ctl_off
        b       5f
1:      tst     r7, #KEY_A              @   A: lift on the held row = its Sell view
        beq     2f
        cmp     r0, #CH_HOLD
        moveq   r0, #CH_CONFIRM
        beq     ctl_set
2:      ldrsb   r1, [r4, #CL_TGT]        @ r1 = cl_tgt, the row being brought up (-1 = none)
        cmp     r1, #0
        bge     1f
        cmp     r5, #3                  @   merchant: none yet = the row shown
        moveq   r1, r10
        beq     2f
1:      tst     r7, #(KEY_UP | KEY_DOWN) @ Up/Down = the next part owned that way (no wrap)
        beq     2f
        cmp     r1, #0
        movlt   r1, r10
        ldr     r12, =ITEM_MGR
        ldr     r12, [r12]
        ldr     r2, [r9, #0x18]         @ part kind: list-type table [panel +0x18]
        ldr     r3, =COLL_KINDS
        ldr     r2, [r3, r2, lsl #2]
        add     r2, r2, r2, lsl #3
        add     r12, r12, r2            @ r12 + 0x48 + row = count owned (s8, -1 = none)
        add     r12, r12, #0x48
        tst     r7, #KEY_DOWN
        movne   r3, #1
        mvneq   r3, #0
        mov     r2, r1
3:      add     r2, r2, r3
        cmp     r2, #CL_ROWS
        bhs     2f                      @   none: stay
        ldrsb   lr, [r12, r2]
        cmp     lr, #0
        blt     3b
        mov     r1, r2
2:      strb    r1, [r4, #CL_TGT]
        cmp     r1, #0
        blt     ctl_done
        cmp     r5, #3
        beq     1f
        cmp     r1, r10
        beq     6f                      @ shown: done
1:      add     r12, r9, #0x1000
        ldr     r2, [r12, #(COLL_SL_TOP - 0x1000)]
        ldr     r3, [r12, #(COLL_SL_ROWH - 0x1000)]
        ldr     r12, [r12, #(COLL_SL_POS - 0x1000)]
        mul     r3, r2, r3
        cmp     r12, r3
        bne     ctl_done                 @ list still sliding
        subs    r1, r1, r2              @ r1 = place on screen
        mov     r2, #CL_ARROW_X
        movlt   r3, #CL_UP_Y            @ above: scroll arrow up
        blt     4f
        cmp     r1, #3
        movhs   r3, #CL_DOWN_Y          @ below: scroll arrow down
        bhs     4f
        mov     r2, #CL_ROW_X           @ on screen: tap its row
        mov     r12, #CL_ROW_DY
        mov     r3, #CL_ROW_Y0
        mla     r3, r12, r1, r3
        cmp     r5, #3
        bne     5f
        cmp     r0, #CH_HOLD            @   merchant: hold it (slide there from the row held)
        movne   r0, #CH_HOLD
        bne     ctl_at
        ldrb    r12, [r8, #CT_Y]
        cmp     r12, r3
        beq     ctl_done                 @   held there already
        mov     r0, #CH_DRAG
        b       ctl_at
4:      cmp     r5, #3                  @ arrow: merchant lets the held row go first
        bne     5f
        cmp     r0, #CH_HOLD
        beq     ctl_off
5:      mov     r0, #CH_TAP
        b       ctl_at
6:      mvn     r1, #0
        strb    r1, [r4, #CL_TGT]
7:      cmp     r5, #3                  @ merchant Sell view: Sell held, A lifts = Sell,
        cmpne   r5, #4                  @   B = Quit (a held Sell lets go first); magic box
        cmpne   r5, #6                  @   Treasure entry: Stow held, B = back arrow
        bne     1f
        cmp     r5, #3
        ldreq   r1, [r9, #0x64]         @   buttons sliding in (Ship Parts / Treasure
        ldrhi   r1, [r9, #0x54]         @   count): taps are lost, wait
        cmp     r1, #0
        bne     ctl_done
        cmp     r5, #6
        moveq   r2, #CL_BACK_X
        moveq   r3, #CL_BACK_Y
        movne   r2, #SH_QUIT_X
        movne   r3, #SH_BTN_Y
        tst     r7, #KEY_B
        bne     cl_mquit
        cmp     r5, #6
        moveq   r2, #MB_STOW_X
        moveq   r3, #MB_STOW_Y
        movne   r2, #SH_BUY_X
        movne   r3, #SH_BTN_Y
        ldrb    r1, [r4, #CL_LOCK]
        cmp     r0, #CH_HOLD
        beq     2f
        cmp     r1, r3                  @ Sell / Stow held once per view (no double sale):
        strbne  r3, [r4, #CL_LOCK]      @   CL_LOCK = its y
        movne   r0, #CH_HOLD
        bne     ctl_at
        b       ctl_done
2:      tst     r7, #KEY_A
        movne   r0, #CH_CONFIRM
        bne     ctl_set
        b       ctl_done
1:      mov     r2, #CL_BACK_X
        mov     r3, #CL_BACK_Y
        tst     r7, #KEY_B
        bne     4b
        ldr     r1, =SFN_LIST           @ A on the parts list: Explanation; in the shipyard
        cmp     r6, r1                  @   A = Attach, X = Explanation (magic box: A = Stow,
        bne     8f                      @   the same place)
        cmp     r5, #(SY_CUST - COLL_SHIP)
        cmpne   r5, #5
        movne   r2, #CL_INFO_X
        movne   r3, #CL_INFO_Y
        bne     8f
        mov     r3, #SY_LBTN_Y
        mov     r2, #SY_INFO_X
        tst     r7, #KEY_X
        bne     4b
        mov     r2, #SY_ATTACH_X
8:      tst     r7, #KEY_A
        bne     4b
        b       ctl_done
cl_gridv:
        mvn     r3, #0
        strb    r3, [r4, #CL_TGT]        @ no parts-list row to bring up
        mov     r3, #0
        strb    r3, [r4, #CL_LOCK]
        ldrh    r3, [r4, #CL_PASS]       @ other keys waiting for the stylus to let go
        cmp     r0, #CH_OFF
        bne     1f
        orr     r7, r7, r3              @ let go: hand them over now
        mov     r3, #0
        strh    r3, [r4, #CL_PASS]
        strb    r3, [r4, #CL_KEY]
        cmp     r5, #1                  @ shipyard, merchant: the game sees no A/B/D-pad
        bicls   r1, r7, #(KEY_A | KEY_UP | KEY_DOWN)
        bichi   r1, r7, #(KEY_A | KEY_B | DPAD)
        strh    r1, [r2, #2]
        bls     6f
        mov     r0, #CH_TAP
        tst     r7, #KEY_B              @ B: merchant Quit / shipyard and magic box back arrow
        beq     5f
        cmp     r5, #3
        cmpne   r5, #4
        moveq   r2, #SH_TQUIT_X
        moveq   r3, #SH_BTN_Y
        movne   r2, #SY_BACK_X
        movne   r3, #SY_BACK_Y
        b       ctl_at
5:      tst     r7, #(KEY_LEFT | KEY_RIGHT)
        beq     6f
        cmp     r5, #(SY_CUST - COLL_SHIP) @ Left / Right: shipyard (no tabs) holds a slot,
        orreq   r7, r7, #KEY_A          @   merchant taps the Treasure / Ship Parts tab
        beq     6f
        tst     r7, #KEY_LEFT
        moveq   r2, #TAB_SHIP_X
        movne   r2, #TAB_TREASURE_X
        mov     r3, #TAB_Y
        b       ctl_at
6:      ldrb    r1, [r4, #CL_BACK]       @ just back from an entry
        strb    r3, [r4, #CL_BACK]
        cmp     r1, #0
        bne     4f
        tst     r7, #(KEY_A | KEY_UP | KEY_DOWN)
        beq     ctl_done
4:      ldrb    r1, [r4, r5]            @ hold the tab's last slot,
        bl      cl_has
        bne     cl_move
        mov     r1, #0                  @   else the first one with an entry
5:      bl      cl_has
        bne     cl_move
        add     r1, r1, #1
        cmp     r1, #8
        blo     5b
        b       ctl_done
1:      bic     r1, r7, #(KEY_A | KEY_B | DPAD)
        orr     r3, r3, r1
        strh    r3, [r4, #CL_PASS]
        mov     r12, #0                 @ stylus down: the game sees no presses
        strh    r12, [r2, #2]
        and     r7, r7, #(KEY_A | KEY_B | DPAD)
        cmp     r0, #CH_HOLD
        bne     cl_wait
        cmp     r1, #0
        bne     ctl_off                  @ another key: let go first
        ldrb    r1, [r8, #CT_LEFT]         @ press not settled yet
        cmp     r1, #0
        bne     cl_wait
        cmp     r7, #0
        ldrbeq  r7, [r4, #CL_KEY]         @ held again: a key kept from the move
        mov     r1, #0
        strb    r1, [r4, #CL_KEY]
        ldrb    r1, [r4, r5]            @ r1 = held slot
        tst     r7, #KEY_A
        movne   r0, #CH_CONFIRM         @ A: lift there = open it
        bne     ctl_set
        tst     r7, #KEY_B              @ B: let go, then close (as Select; shipyard: B = back
        beq     2f                      @   arrow, merchant: B = Quit)
        cmp     r5, #1
        orrls   r3, r3, #KEY_SELECT
        orrhi   r3, r3, #KEY_B
        strh    r3, [r4, #CL_PASS]
        b       ctl_off
2:
        tst     r7, #KEY_UP
        bne     cl_up
        tst     r7, #KEY_DOWN
        beq     3f
        tst     r1, #4                  @ Down on the bottom row: stay
        beq     cl_row
        b       ctl_done
3:      tst     r7, #KEY_LEFT
        beq     2f
1:      tst     r1, #3                  @ Left: the next slot with an entry to the left
        beq     ctl_done                 @   none: stay
        sub     r1, r1, #1
        bl      cl_has
        beq     1b
        b       cl_move
2:      tst     r7, #KEY_RIGHT
        beq     ctl_done
4:      and     r2, r1, #3              @ Right: same, to the right
        cmp     r2, #3
        beq     ctl_done
        add     r1, r1, #1
        bl      cl_has
        beq     4b
        b       cl_move
cl_up:  tst     r1, #4                  @ Up on the top row: let go (tab level; shipyard: stay)
        bne     cl_row
        cmp     r5, #(SY_CUST - COLL_SHIP)
        beq     ctl_done
        b       ctl_off
cl_row:                                 @ Up / Down: the other row, same column or the nearest
        eor     r8, r1, #4
        adr     r3, cl_near
1:      ldrsb   r2, [r3], #1
        cmp     r2, #9
        beq     6f                      @ none with an entry
        and     r10, r8, #3
        add     r10, r10, r2
        cmp     r10, #3
        bhi     1b
        bic     r1, r8, #3
        add     r1, r1, r10
        bl      cl_has
        beq     1b
        b       cl_move
6:      tst     r7, #KEY_UP             @   Up: let go as from the top row; Down: stay
        bne     ctl_off
        b       ctl_done
cl_move:                                @ r1 = slot to hold, r0 = phase
        strb    r1, [r4, r5]
        and     r2, r1, #3
        mov     r3, #CL_DX
        mov     r12, #CL_X0
        mla     r2, r3, r2, r12
        tst     r1, #4
        moveq   r3, #CL_Y0
        movne   r3, #(CL_Y0 + CL_DY)
        cmp     r0, #CH_HOLD
        moveq   r0, #CH_DRAG            @ slide over, lift, press again
        movne   r0, #CH_HOLD            @ first press
        b       ctl_at
cl_wait:                                @ moving / letting go: keep the latest key (not after A/B)
        cmp     r0, #CH_DRAG            @   (cl_key is a byte: cl_back follows it)
        cmpne   r0, #CH_RELEASE
        cmpne   r0, #CH_HOLD
        bne     ctl_done
        cmp     r7, #0
        strbne  r7, [r4, #CL_KEY]
        b       ctl_done
cl_no:  mov     r0, #0                  @ not on page 2: nothing waits
        strh    r0, [r4, #CL_KEY]        @ (and CL_BACK)
        strh    r0, [r4, #CL_PASS]
        strb    r0, [r4, #CL_LOCK]
        mvn     r0, #0
        strb    r0, [r4, #CL_TGT]
        mov     r0, #0
        pop     {r4-r10, pc}

@ r1 = slot of tab r5 (panel r9) -> flags eq if it is empty (no entry). Clobbers r6, r12.
cl_has:
        adr     r12, cl_soff
        ldrb    r12, [r12, r5]
        add     r12, r9, r12
        mov     r6, #CL_SLOT_SIZE
        mla     r12, r6, r1, r12
        ldr     r12, [r12, #CL_SLOT_ENTRY]
        cmn     r12, #1
        bx      lr
cl_near:        @ column steps tried for Up/Down, 9 = end
        .byte   0, 1, -1, 2, -2, 3, -3, 9
cl_grid:        @ panel state of the grid, per tab (Ship Parts, Treasure, shipyard Customize,
        .word   SFN_GRID, TFN_GRID, SFN_GRID, SFN_GRID, TFN_GRID @ merchant Ship Parts, Treasure,
        .word   SFN_GRID, TFN_GRID                               @ magic box Ship Parts, Treasure)
cl_base:        @ panel, per fixed tab (state word at +0x10)
        .word   COLL_SPANEL, COLL_TFN - 0x10, SY_PANEL
mc_vt:          @ merchant, then magic box panel vtables (Ship Parts, Treasure)
        .word   MC_SVT, MC_TVT, MB_SVT, MB_TVT
cl_soff:        @ first slot object, panel + this, per tab
        .byte   SHIP_SLOTS, TREAS_SLOTS, SHIP_SLOTS, SHIP_SLOTS, TREAS_SLOTS, SHIP_SLOTS, TREAS_SLOTS
        .balign 4

@ ---------------------------------------------------------------------------
@ Collection Items page (COLL_PAGE COLL_ITEMS, either layout): the game shows an item's
@ name while the stylus is held on it, so the D-pad holds the stylus on an item of the
@ half on the bottom screen and slides it to the nearest one that way (along + 2 x
@ across, at least IP_MIN px along; none: stay). First press: the item held last on this
@ half, else the first one in the list. Items = the nodes of IP_LIST that the game's own
@ touch test (IP_TOUCHABLE: owned, half on the bottom) takes; centre = CellPos(layout
@ +0x10, element +0x44) + offset +0x1c / +0x20 (fx; with +0x5e clear plus the page's
@ screen offset IP_GOFF +4 / +8: -20 px y while swapped), as that test hit-tests.
@ The D-pad never reaches the game or pad_update's collection block here. Other keys
@ while an item is held: let go first (ip_pass), then the block takes them (B closes,
@ Y swaps, L / R turn pages). The swapped layout has no page arrows: L / R tap Y first
@ and wait (ip_pend) until the spirits half is back at rest on the bottom.
ip_ctl:
        push    {r4-r10, lr}
        ldr     r4, =ip_sel
        bl      in_coll
        bhi     ip_no
        ldr     r0, =COLL_PAGE
        ldr     r0, [r0]
        cmp     r0, #COLL_ITEMS
        bne     ip_no
        bl      ip_head
        ldr     r0, [r6]
        ldr     r1, =IP_VT
        cmp     r0, r1
        bne     ip_no
        ldrb    r9, [r6, #IP_TOP]       @ r9 = half on the bottom: 0 spirits, 1 hourglass
        cmp     r9, #0
        movne   r9, #1
        ldr     r8, =ch_tap
        ldrb    r0, [r8]                @ r0 = stylus phase
        ldr     r2, =PAD
        ldrh    r7, [r2, #2]            @ r7 = new presses
        cmp     r0, #CH_OFF
        bne     ip_held
        ldrh    r1, [r4, #IP_PASS]      @ stylus off: keys kept while it let go
        orr     r7, r7, r1
        mov     r1, #0
        strh    r1, [r4, #IP_PASS]
        strb    r1, [r4, #IP_OWN]
        bic     r1, r7, #DPAD
        ldrb    r3, [r4, #IP_PEND]      @ L / R waiting for the swap back
        cmp     r3, #0
        beq     2f
        ldrb    r12, [r4, #IP_PWAIT]
        tst     r12, #IP_SETTLING
        bne     4f
        subs    r12, r12, #1
        strb    r12, [r4, #IP_PWAIT]
        strbeq  r12, [r4, #IP_PEND]     @ (waited too long: dropped)
        beq     2f
        cmp     r9, #0                  @ spirits half down, at rest (not sliding: busy
        ldreq   r12, =IP_GOFF           @   byte +0xc clear; y offset 0), no tap running:
        ldrbeq  r0, [r12, #0xc]
        cmpeq   r0, #0
        ldreq   r12, [r12, #8]
        cmpeq   r12, #0
        ldreq   r12, =menu_tap
        ldrbeq  r12, [r12]
        cmpeq   r12, #0
        bne     2f
        mov     r12, #(IP_SETTLING | IP_SETTLE_READS) @ then IP_SETTLE_READS more (taps right
4:      sub     r12, r12, #1            @   after the slide are still ignored)
        strb    r12, [r4, #IP_PWAIT]
        tst     r12, #(IP_SETTLING - 1)
        orreq   r1, r1, r3              @   now the page arrow (Left / Right)
        moveq   r3, #0
        strbeq  r3, [r4, #IP_PEND]
2:      cmp     r9, #0                  @ swapped: L / R = Y now, the arrow later
        beq     3f
        tst     r1, #(KEY_L | KEY_R)
        beq     3f
        tst     r1, #KEY_L
        moveq   r3, #KEY_RIGHT
        movne   r3, #KEY_LEFT
        strb    r3, [r4, #IP_PEND]
        mov     r3, #IP_PEND_READS
        strb    r3, [r4, #IP_PWAIT]
        bic     r1, r1, #(KEY_L | KEY_R)
        orr     r1, r1, #KEY_Y
3:      strh    r1, [r2, #2]
        ands    r7, r7, #DPAD
        ldrbeq  r7, [r4, #IP_KEY]       @ (or one kept while no item could be touched)
        cmp     r7, #0
        beq     ip_no0
        ldrb    r5, [r4, r9]            @ hold the item held last on this half,
        cmp     r5, #IP_COUNT
        bhs     1f
        bl      ip_node
        bl      ip_hit
        bne     3f
1:      mov     r5, #0                  @   else the first one a touch can pick
        bl      ip_head
2:      bl      ip_hit
        bne     3f
        ldr     r6, [r6, #8]
        add     r5, r5, #1
        cmp     r5, #IP_COUNT
        blo     2b
        strb    r7, [r4, #IP_KEY]       @ none now (e.g. screens sliding): keep the key
        b       ip_no0
3:      mov     r0, #0
        strb    r0, [r4, #IP_KEY]
        mov     r0, #CH_HOLD
        b       ip_go
ip_held:
        ldrb    r1, [r4, #IP_OWN]
        cmp     r1, #0
        beq     ip_no                   @ not our stylus
        mov     r1, #0
        strh    r1, [r2, #2]            @ stylus down: the game sees no presses
        and     r3, r7, #DPAD
        bic     r7, r7, #(DPAD | KEY_A)
        ldrh    r1, [r4, #IP_PASS]
        orr     r1, r1, r7
        strh    r1, [r4, #IP_PASS]
        cmp     r0, #CH_HOLD
        ldrbeq  r12, [r8, #CT_LEFT]
        cmpeq   r12, #0
        beq     1f
        cmp     r3, #0                  @ moving / settling: keep the latest D-pad key
        strbne  r3, [r4, #IP_KEY]
        b       ctl_done
1:      cmp     r1, #0
        bne     ctl_off                 @ another key: let go first
        cmp     r3, #0
        ldrbeq  r3, [r4, #IP_KEY]       @ (or a D-pad key kept from the move)
        strb    r1, [r4, #IP_KEY]
        movs    r7, r3                  @ r7 = direction
        beq     ctl_done
        ldrb    r5, [r4, r9]
        bl      ip_node
        bl      ip_pos
        orr     r10, r2, r3, lsl #16    @ r10 = held item's x | y << 16
        mvn     r8, #0xc0000000         @ r8 = best score,
        mov     r4, #0xff               @ r4 = best item
        mov     r5, #0
        bl      ip_head
2:      bl      ip_hit
        beq     4f
        bl      ip_pos
        mov     r0, r10, lsl #16
        sub     r2, r2, r0, lsr #16     @ r2, r3 = dx, dy
        sub     r3, r3, r10, lsr #16
        tst     r7, #(KEY_UP | KEY_DOWN)
        movne   r0, r2                  @ r2 = along, r3 = across
        movne   r2, r3
        movne   r3, r0
        tst     r7, #(KEY_UP | KEY_LEFT)
        rsbne   r2, r2, #0
        cmp     r2, #IP_MIN
        blt     4f
        cmp     r3, #0
        rsblt   r3, r3, #0
        add     r2, r2, r3, lsl #1
        cmp     r2, r8
        movlo   r8, r2
        movlo   r4, r5
4:      ldr     r6, [r6, #8]
        add     r5, r5, #1
        cmp     r5, #IP_COUNT
        blo     2b
        movs    r5, r4
        ldr     r4, =ip_sel
        cmp     r5, #0xff
        beq     ctl_done                @ none that way: stay
        mov     r0, #CH_DRAG            @ slide over, lift, press again
ip_go:                                  @ r5 = item, r0 = phase
        strb    r5, [r4, r9]
        mov     r7, r0
        bl      ip_node
        bl      ip_pos
        mov     r0, r7
        mov     r1, #1
        strb    r1, [r4, #IP_OWN]
        b       ctl_at
ip_no:  mov     r0, #0                  @ not on the Items page: nothing waits
        strb    r0, [r4, #IP_KEY]
        strb    r0, [r4, #IP_OWN]
        strh    r0, [r4, #IP_PASS]
        strh    r0, [r4, #IP_PEND]      @ (and ip_pwait)
ip_no0: mov     r0, #0
        pop     {r4-r10, pc}

@ r5 = item -> r6 = its node. Clobbers r12.
ip_node:
        push    {lr}
        bl      ip_head
        mov     r12, r5
1:      cmp     r12, #0
        popeq   {pc}
        ldr     r6, [r6, #8]
        sub     r12, r12, #1
        b       1b

@ -> r6 = the first node of the item list. It lies 0xd18 below the Ship Parts panel (collection
@ object + MB_PANELS), which moves with the heap once the merchant / magic box overlay is loaded
@ (v2.1.77-wip, user state 552), else the fixed IP_LIST. Clobbers r12.
ip_head:
        ldr     r6, =COLL_OBJ
        ldr     r6, [r6]
        sub     r12, r6, #0x02000000
        cmp     r12, #0x3e0000
        ldrlo   r6, [r6, #MB_PANELS]
        sublo   r12, r6, #0x02000000
        cmplo   r12, #0x3e0000
        sublo   r6, r6, #0xd00
        sublo   r6, r6, #0x18
        ldrhs   r6, =IP_LIST
        bx      lr
        .ltorg

@ r6 = node -> flags ne if a touch can pick it now (the game's own test).
ip_hit:
        push    {r0-r3, r12, lr}
        mov     r0, r6
        ldr     r12, =IP_TOUCHABLE
        blx     r12
        cmp     r0, #0
        pop     {r0-r3, r12, pc}

@ r6 = node -> r2, r3 = its centre x, y on the bottom screen. Clobbers r0, r1, r12.
ip_pos:
        push    {lr}
        sub     sp, sp, #16             @ [sp], [sp+4] = CellPos anchors, [sp+8] x, [sp+12] y
        mov     r1, #4
        str     r1, [sp]
        str     r1, [sp, #4]
        ldr     r0, [r6, #0x10]
        ldr     r1, [r6, #0x44]
        add     r2, sp, #8
        add     r3, sp, #12
        bl      CellPos
        ldr     r2, [sp, #8]
        ldr     r3, [sp, #12]
        add     sp, sp, #16
        ldr     r0, [r6, #0x1c]
        ldr     r1, [r6, #0x20]
        ldrb    r12, [r6, #0x5e]
        cmp     r12, #0
        ldreq   r12, =IP_GOFF
        ldreq   lr, [r12, #4]
        addeq   r0, r0, lr
        ldreq   lr, [r12, #8]
        addeq   r1, r1, lr
        add     r2, r2, r0, asr #12
        add     r3, r3, r1, asr #12
        pop     {pc}

@ ---------------------------------------------------------------------------
@ Shipyard (overlay SY_OVL, no text box), touch only; the game takes no buttons there.
@ Main menu (mode SHOP_MODE): a held press shows a button pressed, the lift on it opens
@ the screen. When the menu shows (its Customize button updated, sy_tab), the stylus holds
@ the button used last (first: Customize), A locked CH_AUTO_LOCK pad reads. Up holds it on
@ Customize, Down on View Ship (slide, lift, press there); A lifts it = opens that screen,
@ A with nothing held taps the button held last. B taps the red back arrow (leaves the
@ shipyard), after letting a held button go. Keys pressed while the stylus moves wait in
@ sy_key.
@ View Ship (COLL_PAGE SY_VIEW): menu_tap taps, one per press: Left / Right beside the ship
@ (turns it), Up / Down zoom + / -, B the back arrow. A/B/D-pad/X/Y hidden from the game
@ in both. (Customize: coll_ctl.)
sy_ctl:
        push    {r4-r10, lr}
        ldr     r4, =sy_sel
        ldr     r0, =OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #SY_OVL
        ldreq   r0, =msg_guard
        ldrbeq  r0, [r0]
        cmpeq   r0, #0
        bne     sy_no
        ldr     r8, =ch_tap
        ldrb    r7, [r8]                @ r7 = stylus phase
        ldr     r2, =PAD
        ldrh    r6, [r2, #2]            @ r6 = new presses
        bic     r1, r6, #(KEY_A | KEY_B | DPAD)
        bic     r1, r1, #(KEY_X | KEY_Y)
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #SHOP_MODE
        beq     sy_menu
        bl      in_coll
        bhi     sy_no
        ldr     r0, =COLL_PAGE
        ldr     r0, [r0]
        cmp     r0, #SY_VIEW
        bne     sy_no
        strh    r1, [r2, #2]            @ View Ship
        mov     r0, #0
        strb    r0, [r4, #SY_AUTO]
        ldr     r0, =menu_tap
        ldrb    r0, [r0]
        cmp     r0, #0                  @ a tap still running: this press is dropped
        bne     ctl_done
        mov     r1, #SY_ROT_Y
        tst     r6, #KEY_LEFT
        movne   r0, #SY_ROTL_X
        tst     r6, #KEY_RIGHT
        movne   r0, #SY_ROTR_X
        tst     r6, #KEY_UP
        movne   r0, #SY_ZOOM_X
        movne   r1, #SY_ZIN_Y
        tst     r6, #KEY_DOWN
        movne   r0, #SY_ZOOM_X
        movne   r1, #SY_ZOUT_Y
        tst     r6, #KEY_B
        movne   r0, #SY_BACK_X
        movne   r1, #SY_BACK_Y
        cmp     r0, #0
        blne    menu_tap_at
        b       ctl_done
sy_menu:
        strh    r1, [r2, #2]
        ldrb    r0, [r4, #SY_AUTO]      @ A-lock count down
        cmp     r0, #1
        subhi   r0, r0, #1
        strbhi  r0, [r4, #SY_AUTO]
        ldr     r0, =sy_tab             @ Customize button on screen?
        bl      tab_live                @ (clobbers r0-r2)
        cmp     r0, #0
        strbeq  r0, [r4, #SY_AUTO]      @   not yet / gone: the next menu is new
        beq     ctl_done
        ldrh    r3, [r4, #IB_KEY]       @ r3 = key kept from a move
        cmp     r7, #CH_OFF
        bne     1f
        ldrb    r0, [r4, #SY_AUTO]      @ new menu: hold the button used last (first Customize),
        cmp     r0, #0                  @   A locked a few pad reads (an A mashed through the text)
        bne     4f
        mov     r0, #(CH_AUTO_LOCK + 1)
        strb    r0, [r4, #SY_AUTO]
        mov     r6, #0
        mov     r0, #CH_HOLD
        ldrb    r1, [r4]
        cmp     r1, #0
        moveq   r1, #1
        b       2f
4:      orr     r6, r6, r3              @ stylus up
        mov     r3, #0
        strh    r3, [r4, #IB_KEY]
        tst     r6, #KEY_B              @ B: back arrow
        movne   r0, #CH_TAP
        movne   r2, #SY_BACK_X
        movne   r3, #SY_BACK_Y
        bne     ctl_at
        tst     r6, #(KEY_A | KEY_UP | KEY_DOWN)
        beq     ctl_done
        tst     r6, #KEY_A              @ A: tap the last button, Up / Down: hold one
        movne   r0, #CH_TAP
        moveq   r0, #CH_HOLD
        ldrb    r1, [r4]
        cmp     r1, #0
        moveq   r1, #1
        b       2f
1:      cmp     r7, #CH_HOLD
        bne     sy_wait
        ldrb    r0, [r8, #CT_LEFT]      @ press not settled yet
        cmp     r0, #0
        bne     sy_wait
        cmp     r6, #0
        moveq   r6, r3                  @ held again: the key kept from the move
        mov     r3, #0
        strh    r3, [r4, #IB_KEY]
        ldrb    r0, [r4, #SY_AUTO]
        cmp     r0, #1
        bichi   r6, r6, #KEY_A          @ (A locked)
        tst     r6, #KEY_A              @ A: lift there = that screen
        movne   r0, #CH_CONFIRM
        bne     ctl_set
        tst     r6, #KEY_B              @ B: let go, then the back arrow
        movne   r3, #KEY_B
        strhne  r3, [r4, #IB_KEY]
        bne     ctl_off
        ldrb    r1, [r4]
        mov     r0, #CH_DRAG            @ Up / Down: slide over, lift, press again
2:      tst     r6, #KEY_UP
        movne   r1, #1
        tst     r6, #KEY_DOWN
        movne   r1, #2
        cmp     r0, #CH_DRAG
        bne     3f
        ldrb    r2, [r4]
        cmp     r1, r2
        beq     ctl_done                @ already held there
3:      strb    r1, [r4]                @ r1 = button (1 Customize, 2 View Ship), r0 = phase
        mov     r2, #SY_BTN_X
        cmp     r1, #1
        moveq   r3, #SY_CUST_Y
        movne   r3, #SY_VIEWB_Y
        b       ctl_at
sy_wait:                                @ (r7 = phase, r6 = keys here)
        mov     r0, r7
        and     r7, r6, #(KEY_A | KEY_B | KEY_UP | KEY_DOWN)
        b       ctl_wait
sy_no:  mov     r0, #0                  @ not in the shipyard: nothing waits
        strh    r0, [r4, #IB_KEY]
        strb    r0, [r4, #SY_AUTO]      @ (the menu is new when it comes back)
        ldr     r1, =OVL_SLOT
        ldr     r1, [r1]
        cmp     r1, #SY_OVL
        strbne  r0, [r4]                @ (the button held last is kept while there)
        pop     {r4-r10, pc}

@ ---------------------------------------------------------------------------
@ Item bar (X opens it along the bottom of the touch screen: 2 potions, then the items in
@ a fixed order), touch only. A held press on an icon frames it; the lift on it equips
@ the item (the bar then closes by itself) or asks "Drink the potion?" (choice_ctl takes
@ that). A slide to another icon or off the bar cancels. An item not owned or an empty
@ bottle leaves its place empty: the D-pad skips it.
@ Bar open (UI root +0xd; field mode 1, no text box, on land): Left/Right never reach the
@ game (a walk closes the bar). The first one holds the stylus on the next place with
@ something in it, counted from the equipped item; then each one moves it (slide, lift,
@ press there; wraps). A lifts it = equip / drink. B or X let go (slide off, lift), then X
@ closes the bar; with nothing held B counts as X, A is hidden. Up/Down let go (Link then
@ walks, which closes the bar). Other keys with the stylus down wait until it let go;
@ keys pressed while it moves wait in ib_key (latest wins).
ib_ctl:
        push    {r4-r10, lr}
        ldr     r4, =ib_sel
        bl      on_land
        bne     ib_no
        ldr     r0, =UI_ROOT
        ldr     r0, [r0]
        cmp     r0, #0
        ldrbne  r0, [r0, #UI_BAR_OPEN]
        cmpne   r0, #0
        beq     ib_no
        ldr     r5, =ITEM_MGR
        ldr     r5, [r5]
        cmp     r5, #0
        beq     ib_no
        ldr     r8, =ch_tap
        ldrb    r0, [r8]                @ r0 = stylus phase
        ldr     r2, =PAD
        ldrh    r1, [r2]                @ held Left/Right: no walk
        bic     r1, r1, #(KEY_LEFT | KEY_RIGHT)
        strh    r1, [r2]
        ldrh    r7, [r2, #2]            @ r7 = new presses (R = X: it opens and closes the bar)
        tst     r7, #KEY_R
        bicne   r7, r7, #KEY_R
        orrne   r7, r7, #KEY_X
        ldrh    r3, [r4, #IB_PASS]       @ keys waiting for the stylus to let go
        cmp     r0, #CH_OFF
        bne     1f
        orr     r7, r7, r3              @ let go: hand them over now
        mov     r3, #0
        strh    r3, [r4, #IB_PASS]
        strh    r3, [r4, #IB_KEY]
        bic     r1, r7, #(KEY_A | KEY_B | KEY_LEFT | KEY_RIGHT)
        tst     r7, #KEY_B              @ B = X: close the bar
        orrne   r1, r1, #KEY_X
        strh    r1, [r2, #2]
        tst     r7, #(KEY_LEFT | KEY_RIGHT)
        beq     ctl_done
        ldr     r0, [r5]                @ count from the equipped item's place
        ldr     r12, =ib_ids            @   (none: from place 1, the last potion)
        mov     r1, #8
2:      ldrb    r6, [r12, r1]
        cmp     r6, r0
        beq     3f
        sub     r1, r1, #1
        cmp     r1, #1
        bhi     2b
3:      mov     r0, #CH_OFF
        b       ib_step
1:      bic     r1, r7, #(KEY_A | KEY_B | DPAD)
        bic     r1, r1, #KEY_X          @ r1 = other keys: they wait
        orr     r3, r3, r1
        strh    r3, [r4, #IB_PASS]
        mov     r12, #0                 @ stylus down: the game sees no presses
        strh    r12, [r2, #2]
        bic     r7, r7, r1              @ r7 = A/B/X/D-pad
        cmp     r0, #CH_HOLD
        bne     ctl_wait
        mov     r12, #0
        strb    r12, [r4, #1]           @ pressed again: the move is over
        cmp     r1, #0
        bne     ctl_off                  @ another key: let go first
        ldrb    r1, [r8, #CT_LEFT]         @ press not settled yet
        cmp     r1, #0
        bne     ctl_wait
        cmp     r7, #0
        ldrheq  r7, [r4, #IB_KEY]         @ held again: a key kept from the move
        mov     r1, #0
        strh    r1, [r4, #IB_KEY]
        tst     r7, #KEY_A
        movne   r0, #CH_CONFIRM         @ A: lift there = equip / drink
        bne     ctl_set
        tst     r7, #KEY_B
        tsteq   r7, #KEY_X
        orrne   r3, r3, #KEY_X          @ B / X: let go, then close the bar
        strhne  r3, [r4, #IB_PASS]
        bne     ctl_off
        tst     r7, #(KEY_UP | KEY_DOWN)
        bne     ctl_off                  @ Up / Down: let go (Link walks then)
        tst     r7, #(KEY_LEFT | KEY_RIGHT)
        beq     ctl_done
        ldrb    r1, [r4]                @ from the held place
ib_step:                                @ r1 = place, r0 = phase: the next one with something in it
        mov     r6, #9
4:      tst     r7, #KEY_RIGHT
        addne   r1, r1, #1
        subeq   r1, r1, #1
        cmp     r1, #0
        movlt   r1, #8
        cmp     r1, #8
        movgt   r1, #0
        bl      ib_has
        bne     ib_move
        subs    r6, r6, #1
        bne     4b
        b       ctl_done                 @ the bar is empty
ib_move:
        strb    r1, [r4]
        ldr     r2, =ib_x
        ldrb    r2, [r2, r1]
        mov     r3, #IB_Y
        cmp     r0, #CH_HOLD
        moveq   r0, #CH_DRAG            @ slide over, lift, press again
        movne   r0, #CH_HOLD            @ first press
        cmp     r0, #CH_DRAG
        moveq   r1, #1                  @ a move: slide and lift last one update each (menu_touch)
        movne   r1, #0
        strb    r1, [r4, #1]
        bl      ch_go_at
        ldrb    r1, [r4, #1]
        cmp     r1, #0
        ldrne   r12, =ch_tap
        strbne  r1, [r12, #CT_LEFT]
        pop     {r4-r10, pc}
ib_no:  mov     r0, #0                  @ bar closed: nothing waits
        strb    r0, [r4, #1]
        strh    r0, [r4, #IB_KEY]
        strh    r0, [r4, #IB_PASS]
        pop     {r4-r10, pc}

@ r1 = place -> flags ne if something is in it (r5 = gItemManager). Clobbers r10, r12.
ib_has:
        cmp     r1, #2
        bhs     1f
        add     r12, r5, r1             @ potion: 0 = empty bottle
        ldrb    r12, [r12, #IM_POTIONS]
        cmp     r12, #0
        bx      lr
1:      ldr     r12, =ib_ids            @ item: its owned flag
        ldrb    r12, [r12, r1]
        ldr     r10, [r5, #IM_OWNED]
        mov     r12, r10, lsr r12
        tst     r12, #1
        bx      lr
ib_x:           @ icon centre x per place (all at y IB_Y): potions 1-2, then the items
        .byte   14, 40, 70, 98, 123, 149, 175, 200, 226
ib_ids:         @ item id per place (0xff = potion): boomerang, bombs, bow, bombchu,
                @ grappling hook, hammer, shovel
        .byte   0xff, 0xff, 2, 4, 5, 7, 6, 8, 3
        .balign 4

@ ---------------------------------------------------------------------------
@ Menu bar (Select or the Menu button opens it along the bottom of the touch screen: Save,
@ Collection, Sea Chart, Map; no Map at sea), touch only. A held press on a button shows it
@ pressed (the icon drops a little); the lift on it opens that screen, a slide off cancels.
@ The buttons are not updated through the touch-button vtable (fs_btn never sees them), so
@ their places are fixed tables, measured in the rig: mb_land, or mb_sea at sea.
@ A real stylus press while ours holds a button: menu_touch lets ours go and sets mb_screen,
@ so the bar is left to the stylus until it closes.
@ Bar open (HUD buttons object +4 = MB_OPEN, slid in; mode 1, no text box): the game sees
@ no new presses and no held D-pad (no walk). The stylus holds Collection first;
@ Left/Right move it one button (slide, lift, press there; wraps from Save to the last
@ button and back). A lifts it there = that screen. B or Select let go (slide off, lift),
@ then Select (the game's own) closes the bar. Keys pressed while the stylus moves wait
@ in mb_key.
@ After A the bar stays "open" (+8) a while behind the screen and the field: mb_ctl leaves
@ it alone (mb_sel + 1) until it is closed, so the stylus is not put back on it.
mb_ctl:
        push    {r4-r10, lr}
        ldr     r4, =mb_sel
        bl      on_field
        bne     mb_no
        ldr     r0, =UI_ROOT            @ UI root -> manager -> bar object, each in main RAM
        ldr     r0, [r0]                @   (0x02000000-0x023fffff; not set up yet at boot)
        mov     r1, r0, lsr #22
        cmp     r1, #8
        ldreq   r0, [r0]
        moveq   r1, r0, lsr #22
        cmpeq   r1, #8
        ldreq   r0, [r0, #MB_OBJ]
        moveq   r1, r0, lsr #22
        cmpeq   r1, #8
        bne     mb_shut
        ldr     r0, [r0, #MB_FLAG]
        cmp     r0, #MB_OPEN
        bne     mb_shut
        ldr     r8, =ch_tap
        ldrb    r7, [r8]                @ r7 = stylus phase
        ldrb    r0, [r4, #MB_SCREEN]         @ a screen was opened from the bar: only let the
        cmp     r0, #0                  @   stylus finish its lift
        beq     1f
        cmp     r7, #CH_OFF
        beq     mb_no
1:      ldr     r2, =PAD
        ldrh    r1, [r2]                @ held D-pad: no walk
        bic     r1, r1, #DPAD
        strh    r1, [r2]
        ldrh    r6, [r2, #2]            @ r6 = new presses: the game sees none
        mov     r1, #0
        strh    r1, [r2, #2]
        ldrb    r0, [r4, #MB_SCREEN]
        cmp     r0, #0
        bne     ctl_done
        ldrh    r3, [r4, #MB_KEY]         @ r3 = key kept from a move
        cmp     r7, #CH_OFF
        bne     1f
        orr     r6, r6, r3              @ stylus up
        mov     r3, #0
        strh    r3, [r4, #MB_KEY]
        tst     r6, #(KEY_B | KEY_SELECT)
        movne   r1, #KEY_SELECT         @ B / Select: the game's Select closes the bar
        strhne  r1, [r2, #2]
        movne   r1, #0
        strbne  r1, [r4]
        bne     ctl_done
        ldrb    r1, [r4]                @ hold the button (first: Collection)
        cmp     r1, #0
        moveq   r1, #MB_DEF
        mov     r0, #CH_HOLD
        b       mb_go
1:      cmp     r7, #CH_HOLD
        bne     mb_wait
        ldrb    r0, [r8, #CT_LEFT]         @ press not settled yet
        cmp     r0, #0
        bne     mb_wait
        cmp     r6, #0
        moveq   r6, r3                  @ held again: the key kept from the move
        mov     r3, #0
        strh    r3, [r4, #MB_KEY]
        tst     r6, #KEY_A
        movne   r0, #1                  @ A: lift there = that screen
        strbne  r0, [r4, #MB_SCREEN]
        movne   r0, #CH_CONFIRM
        bne     ctl_set
        tst     r6, #(KEY_B | KEY_SELECT)
        movne   r3, #KEY_SELECT         @ B / Select: let go, then Select
        strhne  r3, [r4, #MB_KEY]
        bne     ctl_off
        ldrb    r1, [r4]                @ Left / Right: the next button, wrapping
        tst     r6, #KEY_RIGHT
        addne   r1, r1, #1
        tst     r6, #KEY_LEFT
        subne   r1, r1, #1
        bl      mb_table
        ldrb    r0, [r2]                @ r0 = buttons on this bar
        cmp     r1, #0
        moveq   r1, r0
        cmp     r1, r0
        movhi   r1, #1
        ldrb    r0, [r4]
        cmp     r1, r0
        beq     ctl_done
        mov     r0, #CH_DRAG            @ slide over, lift, press again
mb_go:  strb    r1, [r4]                @ r1 = place + 1, r0 = phase
        bl      mb_table
        ldrb    r2, [r2, r1]
        mov     r3, #MB_Y
@ Shared ends of coll_ctl, ib_ctl and mb_ctl (each pushes {r4-r10, lr}, no stack locals);
@ all return r0 = 1. ctl_at: r0 = phase, r2, r3 = x, y; ctl_set: r0 = phase; ctl_off: slide
@ the stylus off and lift. ctl_wait (r0 = phase, r7 = keys): while the stylus moves or
@ settles, keep the latest keys in the halfword [r4 + IB_KEY] (ib_key / mb_key).
ctl_at: bl      ch_go_at
        pop     {r4-r10, pc}
ctl_set:
        bl      ch_go
        pop     {r4-r10, pc}
ctl_off:
        bl      ch_go_off
        pop     {r4-r10, pc}
mb_wait:                                @ (r7 = phase, r6 = keys here)
        mov     r0, r7
        and     r7, r6, #(KEY_A | KEY_B | KEY_SELECT | KEY_LEFT | KEY_RIGHT)
ctl_wait:
        cmp     r0, #CH_DRAG
        cmpne   r0, #CH_RELEASE
        cmpne   r0, #CH_HOLD
        bne     ctl_done
        cmp     r7, #0
        strhne  r7, [r4, #IB_KEY]          @ (= MB_KEY)
ctl_done:
        mov     r0, #1
        pop     {r4-r10, pc}
mb_shut:                                @ bar closed: a new one starts on Collection
        mov     r0, #0
        strb    r0, [r4, #MB_SCREEN]
mb_no:  mov     r0, #0
        strb    r0, [r4]
        strh    r0, [r4, #MB_KEY]
        pop     {r4-r10, pc}

@ -> r2 = this bar's table (count, then x per button). Keeps r0, r1.
mb_table:
        ldr     r2, =SEA_OVL_SLOT
        ldr     r2, [r2]
        cmp     r2, #SEA_OVL
        adreq   r2, mb_sea
        adrne   r2, mb_land
        bx      lr
mb_land:        @ Save, Collection, Sea Chart, Map
        .byte   4, 43, 120, 164, 207
mb_sea:         @ Save, Collection, Sea Chart; the sea panel: two "?" (not owned yet in the
                @ playthrough), Fish (lights up only over a school of fish)
        .byte   6, 43, 84, 122, 161, 200, 235
        .balign 4
        .ltorg                          @ shared literal pool (v2.1.68: 4 pools, was 17; each pool repeats its constants)

@ ---------------------------------------------------------------------------
@ Sea Chart screen (mode SC_MODE: the four seas, from the menu bar's Sea Chart), touch
@ only. A held press on an owned sea lights it; the lift on it opens that sea's chart (a
@ map, MAP_MODE, whose Back arrow comes back here: B there is back_ctl's). A held press
@ on an island with a map (an island button, before the seas) shows its name; the lift
@ opens its map. A slide to another object or off cancels; a clouded (not owned) sea
@ takes no press and is not updated (fs_btn: sc_tab, is_tab).
@ Screen up, stylus free (also back from a chart): the stylus holds the object chosen last
@ (sc_last), else the first owned sea (NW, NE, SW, SE); the game sees no new A / B / D-pad.
@ A sea is held off its islands (sc_pt). The D-pad slides to the nearest object that way
@ (along + 2 x across from the held one's centre, at least SC_MIN px along; none: stay;
@ slide, lift, press there). The same screen opens from the Sun Crest note. A lifts it
@ there = that sea's chart / island's map. B lets go (slide to the opposite sea, lift),
@ then B (the game's own) closes the screen. A real stylus press makes the screen the
@ stylus's (menu_touch: sc_screen) until it closes. Keys pressed while the stylus moves
@ wait in sc_key.
sc_ctl:
        push    {r4-r10, lr}
        ldr     r4, =sc_sel
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #SC_MODE
        bne     sc_shut
        ldr     r8, =ch_tap
        ldrb    r7, [r8]                @ r7 = stylus phase
        ldrb    r0, [r4, #SC_SCREEN]    @ chosen / closing / the real stylus's: only let ours
        cmp     r0, #0                  @   finish its lift
        beq     1f
        cmp     r7, #CH_OFF
        beq     sc_no
        b       sc_hide
1:      cmp     r7, #CH_OFF
        bne     sc_hide
        ldrb    r5, [r4, #SC_LAST]      @ stylus up: the object chosen last, else the first owned
        bl      sc_live
        bne     sc_hide
        mov     r5, #0
2:      bl      sc_live
        bne     sc_hide
        add     r5, r5, #1
        cmp     r5, #4
        blo     2b
        ldr     r2, =PAD                @ no sea on screen yet (opening): B to the game, A /
        ldrh    r1, [r2, #2]            @   D-pad hidden (the game's D-pad closed the screen)
        bic     r1, r1, #(KEY_A | DPAD)
        strh    r1, [r2, #2]
        b       sc_no
sc_hide:
        ldr     r2, =PAD
        ldrh    r6, [r2, #2]            @ r6 = new presses: the game sees no A / B / D-pad
        bic     r1, r6, #(KEY_A | KEY_B | DPAD)
        strh    r1, [r2, #2]
        ldrb    r0, [r4, #SC_SCREEN]
        cmp     r0, #0
        bne     ctl_done
        ldrh    r3, [r4, #SC_KEY]       @ r3 = key kept from a move
        cmp     r7, #CH_OFF
        bne     3f
        orr     r6, r6, r3              @ stylus up
        mov     r3, #0
        strh    r3, [r4, #SC_KEY]
        tst     r6, #KEY_B              @ B: the game's own closes the screen
        orrne   r1, r1, #KEY_B
        strhne  r1, [r2, #2]
        movne   r0, #1
        strbne  r0, [r4, #SC_SCREEN]
        bne     ctl_done
        mov     r7, #CH_HOLD            @ hold the object found above (r5, r9)
        b       sc_go
3:      cmp     r7, #CH_HOLD
        bne     sc_wait
        ldrb    r0, [r8, #CT_LEFT]      @ press not settled yet
        cmp     r0, #0
        bne     sc_wait
        cmp     r6, #0
        moveq   r6, r3                  @ held again: the key kept from the move
        mov     r3, #0
        strh    r3, [r4, #SC_KEY]
        tst     r6, #KEY_A
        movne   r0, #1                  @ A: lift there = that sea's chart / island's map
        strbne  r0, [r4, #SC_SCREEN]
        movne   r0, #CH_CONFIRM
        bne     ctl_set
        ldrb    r0, [r4]
        ldr     r9, =sc_tab
        add     r9, r9, r0, lsl #2
        sub     r9, r9, #4              @ r9 = held object's entry
        ldrb    r10, [r9]               @ r10 = its centre x | y << 16
        ldrb    r1, [r9, #1]
        orr     r10, r10, r1, lsl #16
        tst     r6, #KEY_B
        beq     4f
        mov     r3, #KEY_B              @ B: let go, then B. FS_OFF (128, 2) is still on NW (a
        strh    r3, [r4, #SC_KEY]       @   lift there opens it): slide to the opposite sea's
        and     r1, r10, #0xff          @   centre instead (a slide to another object cancels)
        cmp     r1, #128
        movlo   r2, #SC_RIGHT_X
        movhs   r2, #SC_LEFT_X
        cmp     r10, #(96 << 16)
        movlo   r3, #SC_LOW_Y
        movhs   r3, #SC_TOP_Y
        mov     r0, #CH_DRAGOFF
        b       ctl_at
4:      ands    r7, r6, #DPAD           @ D-pad: the nearest object that way. Seen on this
        beq     ctl_done                @   screen = x != 0, not sc_live: the game stops
        mvn     r8, #0xc0000000         @   updating the objects after a held one (stamps go
        mov     r4, #0xff               @   stale); clouded seas are never seen
        mov     r5, #0                  @ r8 = best score, r4 = best object
        ldr     r9, =sc_tab
5:      ldrb    r2, [r9]
        cmp     r2, #0
        beq     6f
        ldrb    r3, [r9, #1]
        and     r0, r10, #0xff
        sub     r2, r2, r0              @ r2, r3 = dx, dy
        sub     r3, r3, r10, lsr #16
        tst     r7, #(KEY_UP | KEY_DOWN)
        movne   r0, r2                  @ r2 = along, r3 = across
        movne   r2, r3
        movne   r3, r0
        tst     r7, #(KEY_UP | KEY_LEFT)
        rsbne   r2, r2, #0
        cmp     r2, #SC_MIN
        blt     6f
        cmp     r3, #0
        rsblt   r3, r3, #0
        add     r2, r2, r3, lsl #1
        cmp     r2, r8
        movlo   r8, r2
        movlo   r4, r5
6:      add     r9, r9, #4
        add     r5, r5, #1
        cmp     r5, #SC_OBJS
        blo     5b
        mov     r5, r4
        ldr     r4, =sc_sel
        cmp     r5, #0xff
        beq     ctl_done                @ none that way: stay
        ldr     r9, =sc_tab
        add     r9, r9, r5, lsl #2
        mov     r7, #CH_DRAG            @ slide over, lift, press again
sc_go:  strb    r5, [r4, #SC_LAST]      @ r5 = object, r9 = its sc_tab entry, r7 = phase
        add     r1, r5, #1
        strb    r1, [r4]
        bl      sc_pt
        mov     r0, r7
        b       ctl_at
sc_wait:                                @ (r7 = phase, r6 = keys here)
        mov     r0, r7
        and     r7, r6, #(KEY_A | KEY_B | DPAD)
        b       ctl_wait
sc_shut:                                @ screen gone: the next one is new (its islands not
        mov     r0, #0                  @   seen yet)
        strb    r0, [r4, #SC_SCREEN]
        ldr     r1, =is_tab
        mov     r2, #IS_COUNT
1:      strb    r0, [r1], #4
        subs    r2, r2, #1
        bne     1b
sc_no:  mov     r0, #0
        strb    r0, [r4]
        strh    r0, [r4, #SC_KEY]
        pop     {r4-r10, pc}

@ r5 = place -> r0 = r9 = its sc_tab entry if on screen (updated in the last 2 pad reads),
@ else 0; flags ne if on screen. Clobbers r1, r2.
sc_live:
        push    {lr}
        ldr     r0, =sc_tab
        add     r0, r0, r5, lsl #2
        bl      tab_live
        movs    r9, r0
        pop     {pc}

@ r5 = object, r9 = its sc_tab entry -> r2, r3 = where the stylus holds it: an island's
@ centre; a sea's centre, else the first sc_alt point (from the centre) that no island seen
@ on this screen covers (a press there would pick the island). Clobbers r0, r1, r12.
sc_pt:
        push    {r4-r6, lr}
        ldrb    r2, [r9]
        ldrb    r3, [r9, #1]
        cmp     r5, #4
        bhs     9f
        ldr     r4, =sc_alt
1:      ldrsb   r0, [r4], #1            @ r0, r1 = next point
        ldrsb   r1, [r4], #1
        add     r0, r0, r2
        add     r1, r1, r3
        ldr     r6, =is_tab
        add     r12, r6, #(4 * IS_COUNT)
2:      ldrb    r5, [r6]                @ an island seen (x != 0) within SC_ISLE_R of it?
        cmp     r5, #0
        beq     3f
        subs    r5, r5, r0
        rsblt   r5, r5, #0
        cmp     r5, #SC_ISLE_R
        bgt     3f
        ldrb    r5, [r6, #1]
        subs    r5, r5, r1
        rsblt   r5, r5, #0
        cmp     r5, #SC_ISLE_R
        ble     4f
3:      add     r6, r6, #4
        cmp     r6, r12
        blo     2b
        mov     r2, r0                  @ clear of them all
        mov     r3, r1
        b       9f
4:      ldr     r0, =(sc_alt + 2 * SC_ALTS)
        cmp     r4, r0
        blo     1b                      @ (all covered: the centre)
9:      pop     {r4-r6, pc}
sc_alt:         @ x, y from a sea's centre (inside its quarter, off the Back button)
        .byte   0, 0, 0, -36, 0, 36, -44, -30, 44, -30, 44, 30, -48, 0, 48, 0
        .balign 4

@ ---------------------------------------------------------------------------
@ Vtable hook: ov0 0x020e893c [0] (touch-button update, 0x020d0610), r0 = button,
@ r1/r2 = x/y offset the button is hit-tested with, r3 passed on.
@ In the file select menus (overlay 10), remembers where each button with an id
@ FS_ID0.. is (CellPos centre + offset) and the pad read it was last updated in
@ (fs_frame), so fs_ctl can tell which buttons are on screen. The same for the Back
@ button (id BACK_ID, lower left) of any screen, and a map's Back (MAP_BACK_ID, map mode
@ only), in bk_tab, for back_ctl; and for the seas and islands of the Sea Chart screen,
@ in sc_tab / is_tab.
@ A map's Memo / Erase go to mm_tab (mm_ctl); the game over buttons to smenu (smenu_ctl).
        .global fs_btn
fs_btn:
        push    {r0-r6, lr}
        ldrh    r4, [r0, #10]           @ button id
        cmp     r4, #MAP_BACK_ID        @ a map's Back: only in the map mode
        ldreq   r3, =MODE
        ldreq   r3, [r3]
        cmpeq   r3, #MAP_MODE
        cmpne   r4, #BACK_ID
        ldreq   r4, =bk_tab
        beq     1f
        cmp     r4, #SKIP_ID            @ a cutscene's Skip: sk_tab
        ldreq   r4, =sk_tab
        beq     1f
        cmp     r4, #GORON_ID           @ the Goron Temple's swap button: gr_tab
        ldrsheq r3, [r0, #8]
        cmpeq   r3, #GORON_CELL
        ldreq   r4, =gr_tab
        ldrbeq  r3, [r0, #GORON_FORM]
        strbeq  r3, [r4, #3]
        beq     1f
        sub   r3, r4, #MEMO_ID       @ a map's Memo / Erase: mm_tab (map mode only),
        cmp     r3, #2                  @   Memo's entry also keeps the tool in use
        bhs     6f
        ldr     r4, =MODE
        ldr     r4, [r4]
        cmp     r4, #MAP_MODE
        bne     9f
        ldr     r4, =mm_tab
        add     r4, r4, r3, lsl #2
        cmp     r3, #0
        ldrbeq  r3, [r0, #MM_SEL]
        strbeq  r3, [r4, #3]
        b       1f
6:      ldr     r3, =MODE               @ a dungeon map's floor button / floor list: fl_tab
        ldr     r3, [r3]                @   (map modes only; entry 0 = the button, 1.. = floors)
        cmp     r3, #MAP_MODE
        cmpne   r3, #FL_MODE1
        cmpne   r3, #FL_MODE2
        bne     3f
        sub     r3, r4, #FL_ID0
        cmp     r3, #FL_IDS
        blo     7f
        cmp     r4, #FLOOR_ID
        bne     3f
        mov     r3, #FL_BTN
7:      ldr     r4, =fl_tab
        add     r4, r4, r3, lsl #2
        ldrb    r3, [r0, #FL_CELL]      @ (a place's label cell, for fl_shown)
        strb    r3, [r4, #3]
        b       1f
3:      sub     r3, r4, #GO_ID0        @ game over Continue / Save and Quit: into the save
        cmp     r3, #2                  @   menu's slots (as smenu_btn), so smenu_ctl drives them
        bhs     4f
        ldr     r4, =smenu
        str     r0, [r4, r3, lsl #2]
        strh    r2, [r4, #SM_OFFY]
        mov     r1, #CH_SEEN_FRAMES
        strb    r1, [r4, #SM_SEEN]
        b       9f
4:      sub     r3, r4, #SC_ID0         @ a sea on the Sea Chart screen: sc_tab by place
        cmp     r3, #4
        ldrlo   r4, =sc_tab
        addlo   r3, r3, #2
        andlo   r3, r3, #3
        addlo   r4, r4, r3, lsl #2
        blo     1f
        sub     r3, r4, #IS_ID0         @ an island on the Sea Chart screen: is_tab. No layout
        cmp     r3, #IS_COUNT           @   element: vtable [1] took its cell anchor off the
        bhs     5f                      @   offset, so the centre = anchor + offset
        ldr     r5, =MODE
        ldr     r5, [r5]
        cmp     r5, #SC_MODE
        bne     5f
        ldr     r4, =is_tab
        add     r4, r4, r3, lsl #2
        mov     r5, r1
        mov     r6, r2
        sub     sp, sp, #16
        ldrsb   r1, [r0, #16]
        ldrsh   r0, [r0, #8]
        add     r2, sp, #8
        add     r3, sp, #12
        ldr     r12, =CELL_ANCHOR
        blx     r12
        b       8f
5:      cmp     r4, #SY_ID_CUST         @ the shipyard menu's Customize button: sy_tab
        bne     2f
        ldr     r3, =OVL_SLOT
        ldr     r3, [r3]
        cmp     r3, #SY_OVL
        ldreq   r4, =sy_tab
        beq     1f
2:      ldr     r3, =FS_OVL_SLOT
        ldr     r3, [r3]
        cmp     r3, #FS_OVL
        bne     9f
        sub     r4, r4, #FS_ID0
        cmp     r4, #FS_IDS
        bhs     9f
        ldr     r3, =fs_tab
        add     r4, r3, r4, lsl #2      @ r4 = the button's table entry
1:      ldrb    r3, [r0, #0xc]          @ layout element
        cmp     r3, #0xff
        beq     9f
        mov     r5, r1
        mov     r6, r2
        sub     sp, sp, #16             @ [sp], [sp+4] = CellPos anchors, [sp+8] x, [sp+12] y
        mov     r1, #4
        str     r1, [sp]
        str     r1, [sp, #4]
        mov     r1, r3
        ldrsh   r0, [r0, #8]            @ layout cell
        add     r2, sp, #8
        add     r3, sp, #12
        bl      CellPos
8:      ldr     r0, [sp, #8]
        add     r0, r0, r5
        strb    r0, [r4]
        ldr     r0, [sp, #12]
        add     r0, r0, r6
        strb    r0, [r4, #1]
        ldr     r0, =fs_frame
        ldrb    r0, [r0]
        strb    r0, [r4, #2]
        add     sp, sp, #16
9:      pop     {r0-r6, lr}
        b       BtnUpdate

@ The file select menus, stylus only. The screen is told apart by which button is on
@ it (fs_specs, first match). Lists (files / Copy-Erase-Start / Adventure-Battle-Options):
@ the D-pad holds the stylus on an entry (first press = the default one), moving slides
@ it to the next; A lifts it there, which picks it (A with nothing held taps the default).
@ B is the game's own Back: a held stylus first slides off to empty space, so nothing
@ fires. Options rows: Up/Down pick a row (no highlight), Left/Right tap its arrows,
@ A taps Mic Test. Not up: the menu stylus is switched off (choices / save menu aren't up).
fs_ctl:
        push    {r4-r10, lr}
        ldr     r4, =fs_cur             @ [r4] = spec of the last screen, [r4 + FS_SEL] = fs_sel
        ldr     r0, =FS_OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #FS_OVL
        bne     fs_off
        ldr     r5, =fs_specs
1:      ldrb    r0, [r5]
        cmp     r0, #0
        beq     fs_off
        bl      fs_live
        cmp     r0, #0
        bne     2f
        ldrb    r0, [r5, #2]
        add     r5, r5, #4
        add     r5, r5, r0, lsl #1
        b       1b
2:      ldr     r6, =ch_tap
        ldrb    r7, [r6]                @ r7 = stylus phase
        ldr     r0, [r4]
        cmp     r0, r5
        beq     3f
        str     r5, [r4]                @ new screen: default entry, let go of the old one
        ldrb    r0, [r5, #3]
        strb    r0, [r4, #FS_SEL]
        cmp     r7, #CH_HOLD
        beq     fs_slideoff
3:      ldr     r0, =PAD
        ldrh    r8, [r0, #2]            @ r8 = new presses
        ldrb    r9, [r5, #1]            @ r9 = mode
        ldrb    r10, [r5, #2]           @ r10 = entries
        cmp     r9, #FS_ROWS
        beq     fs_rows
        tst     r8, #KEY_B
        beq     4f
        cmp     r7, #CH_HOLD
        beq     fs_slideoff
4:      tst     r8, #KEY_A
        beq     5f
        cmp     r7, #CH_HOLD
        moveq   r0, #CH_CONFIRM
        beq     fs_phase
        cmp     r7, #CH_OFF
        bne     fs_done
        ldrb    r0, [r5, #3]
        strb    r0, [r4, #FS_SEL]
        mov     r7, #CH_TAP
        b       fs_go
5:      cmp     r9, #FS_HORZ
        moveq   r0, #KEY_LEFT           @ r0 = previous, r1 = next
        moveq   r1, #KEY_RIGHT
        movne   r0, #KEY_UP
        movne   r1, #KEY_DOWN
        ldrb    r2, [r4, #FS_SEL]
        tst     r8, r1
        addne   r2, r2, #1
        bne     6f
        tst     r8, r0
        beq     fs_done
        sub     r2, r2, #1
6:      cmp     r7, #CH_OFF
        ldrbeq  r2, [r5, #3]            @ nothing held: the default entry
        moveq   r7, #CH_HOLD
        beq     7f
        cmp     r7, #CH_HOLD
        bne     fs_done                 @ still sliding / choosing
        mov     r7, #CH_DRAG
7:      cmp     r2, #0                  @ wrap around
        addlt   r2, r2, r10
        cmp     r2, r10
        subge   r2, r2, r10
        strb    r2, [r4, #FS_SEL]
fs_go:  ldrb    r2, [r4, #FS_SEL]          @ r7 = new phase, on entry fs_sel
        add     r2, r5, r2, lsl #1
        ldrb    r0, [r2, #4]
        ldrb    r1, [r2, #5]
        bl      fs_pos
        cmn     r0, #1
        beq     fs_done
fs_set: strb    r0, [r6, #CT_X]
        strb    r1, [r6, #CT_Y]
        mov     r0, r7
fs_phase:                               @ (CHOICE_STEP for every phase, not ch_step as ch_go: so a
        strb    r0, [r6]                @   CH_HOLD here settles CHOICE_STEP updates, not CH_SETTLE.
        mov     r0, #CHOICE_STEP        @   Known and kept on purpose until a change is tested.)
        strb    r0, [r6, #CT_LEFT]
        b       fs_done
fs_slideoff:                            @ (ch_step of CH_DRAGOFF = CHOICE_STEP, as fs_phase)
        bl      ch_go_off
        b       fs_done
fs_rows:
        cmp     r7, #CH_HOLD            @ a held stylus (never ours here; left by another
        beq     fs_slideoff             @   menu) would block the arrows: slide it off first
        ldrb    r2, [r4, #FS_SEL]         @ row
        tst     r8, #KEY_DOWN
        addne   r2, r2, #1
        tst     r8, #KEY_UP
        subne   r2, r2, #1
        cmp     r2, #0
        addlt   r2, r2, r10
        cmp     r2, r10
        subge   r2, r2, r10
        strb    r2, [r4, #FS_SEL]
        cmp     r7, #CH_OFF
        bne     fs_done
        add     r2, r5, r2, lsl #1
        ldrb    r0, [r2, #4]            @ left arrow id
        ldrb    r1, [r2, #5]            @ right arrow id
        cmp     r0, r1
        beq     9f
        tst     r8, #KEY_RIGHT
        movne   r0, r1
        bne     8f
        tst     r8, #KEY_LEFT
        bne     8f
        b       fs_done
9:      tst     r8, #KEY_A              @ a row that is a single button: A only
        beq     fs_done
8:      mov     r1, #0
        mov     r7, #CH_TAP
        bl      fs_pos
        cmn     r0, #1
        bne     fs_set
        b       fs_done
fs_off: mov     r0, #0
        str     r0, [r4]
        ldr     r1, =ch_tap
        strb    r0, [r1]
fs_done:
        pop     {r4-r10, pc}

@ r0 = button id -> r0 = its fs_tab entry if it was updated in the last 2 pad reads, else 0
fs_live:
        sub     r0, r0, #FS_ID0
        cmp     r0, #FS_IDS
        movhs   r0, #0
        bxhs    lr
        ldr     r1, =fs_tab
        add     r0, r1, r0, lsl #2
tab_live:                               @ r0 = a table entry (fs_tab, sc_tab): the same
        ldrb    r1, [r0, #2]            @ stamp (0 = never)
        cmp     r1, #0
        moveq   r0, #0
        bxeq    lr
        ldr     r2, =fs_frame
        ldrb    r2, [r2]
        sub     r1, r2, r1
        and     r1, r1, #0xff
        cmp     r1, #2
        bxls    lr                      @ live: r0 = the entry
        mov     r1, #0                  @ gone: forget the stamp, or it looks new again
        strb    r1, [r0, #2]            @   once the 8-bit counter wraps (255 reads later)
        mov     r0, #0
        bx      lr

@ fs_specs entry (r0, r1) = (x, y), or (button id, 0) -> r0 = x, r1 = y; r0 = -1 if not on screen
fs_pos:
        cmp     r1, #0
        bxne    lr
        push    {lr}
        bl      fs_live
        cmp     r0, #0
        mvneq   r0, #0
        ldrbne  r1, [r0, #1]
        ldrbne  r0, [r0]
        pop     {pc}

@ B = the Back button (lower left; touch button id BACK_ID) of whatever screen shows one,
@ e.g. a map on a wall (mode 0x37), where B swung the sword under the screen, or a map
@ (Map, or one sea's chart from the Sea Chart screen, which its Back returns to). fs_btn
@ records where it is and the pad read it was last updated in. While it is live, a new B
@ is hidden from the game (no slash) and menu_tap taps the button. Not while a text box
@ was seen (B advances it), in the collection (B = Select there) or in the file select
@ (B is the game's own Back there). Runs after the other menus (they take B first).
back_ctl:
        ldr     r3, =bk_tab
        ldrb    r0, [r3, #2]            @ stamp (0 = never)
        cmp     r0, #0
        bxeq    lr
        ldr     r12, =fs_frame
        ldrb    r12, [r12]
        sub     r0, r12, r0
        and     r0, r0, #0xff
        cmp     r0, #2
        movhi   r0, #0                  @ gone: forget the stamp (see fs_live)
        strbhi  r0, [r3, #2]
        bxhi    lr
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        tst     r1, #KEY_B
        bxeq    lr
        ldr     r0, =ch_seen
        ldrb    r0, [r0]
        cmp     r0, #0
        bxne    lr
        ldr     r0, =FS_OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #FS_OVL
        bxeq    lr
        mov     r12, lr                 @ (in_coll keeps r1-r3, r12)
        bl      in_coll
        mov     lr, r12
        bxls    lr
        bic     r1, r1, #KEY_B
        strh    r1, [r2, #2]
        ldrh    r1, [r2]
        bic     r1, r1, #KEY_B
        strh    r1, [r2]
        ldr     r12, =menu_tap
        ldrb    r0, [r12]
        cmp     r0, #0
        bxne    lr
        ldrb    r0, [r3]
        ldrb    r1, [r3, #1]
        b       menu_tap_at

@ Start = a cutscene's Skip button (touch button id SKIP_ID, top right). The game's own
@ Start only shows it (a second Start hides it again). fs_btn records where it is and the
@ pad read it was last updated in, which happens only while it shows. While it is live, a
@ new Start is hidden from the game and menu_tap taps the button. No other key taps it.
skip_ctl:
        push    {r4, lr}
        ldr     r4, =sk_tab
        mov     r0, r4
        bl      tab_live
        cmp     r0, #0
        popeq   {r4, pc}
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        tst     r1, #KEY_START
        popeq   {r4, pc}
        ldr     r0, =held_real          @ the real Start only: in the title overlay (the
        ldrh    r0, [r0]                @   opening story) pad_update gives A as Start too
        tst     r0, #KEY_START
        popeq   {r4, pc}
        bic     r1, r1, #KEY_START
        strh    r1, [r2, #2]
        ldrh    r1, [r2]
        bic     r1, r1, #KEY_START
        strh    r1, [r2]
        ldr     r0, =menu_tap
        ldrb    r0, [r0]
        cmp     r0, #0
        popne   {r4, pc}
        ldrb    r0, [r4]
        ldrb    r1, [r4, #1]
        bl      menu_tap_at
        pop     {r4, pc}

@ L = the Goron Temple's swap button (touch button id GORON_ID, top centre): Link <-> Gongoron.
@ fs_btn records where it is and the pad read it was last updated in (gr_tab). While it is
@ live, a new L is hidden from the game (it does nothing there) and menu_tap taps the button.
goron_ctl:
        push    {r4, lr}
        ldr     r4, =gr_tab
        mov     r0, r4
        bl      tab_live
        cmp     r0, #0
        popeq   {r4, pc}
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        tst     r1, #KEY_L
        popeq   {r4, pc}
        bic     r1, r1, #KEY_L
        strh    r1, [r2, #2]
        ldrh    r1, [r2]
        bic     r1, r1, #KEY_L
        strh    r1, [r2]
        ldr     r0, =menu_tap
        ldrb    r0, [r0]
        cmp     r0, #0
        popne   {r4, pc}
        ldrb    r0, [r4]
        ldrb    r1, [r4, #1]
        bl      menu_tap_at
        pop     {r4, pc}

@ Y on a map (Map, or a sea chart) = toggle pen / eraser: taps Erase while Memo (the pen)
@ is in use, else Memo. fs_btn records both buttons (mm_tab) and the tool in use. While the
@ button to tap is live, Y is hidden from the game. Drawing itself stays stylus only.
mm_ctl:
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        tst     r1, #KEY_Y
        bxeq    lr
        push    {r4, lr}
        ldr     r4, =mm_tab
        ldrb    r0, [r4, #3]            @ tool in use
        cmp     r0, #MEMO_ID
        addeq   r4, r4, #4              @ pen: tap Erase
        mov     r0, r4
        bl      tab_live
        cmp     r0, #0
        popeq   {r4, pc}
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        bic     r1, r1, #KEY_Y
        strh    r1, [r2, #2]
        ldrh    r1, [r2]
        bic     r1, r1, #KEY_Y
        strh    r1, [r2]
        ldr     r3, =menu_tap
        ldrb    r0, [r3]
        cmp     r0, #0
        popne   {r4, pc}
        ldrb    r0, [r4]
        ldrb    r1, [r4, #1]
        bl      menu_tap_at
        pop     {r4, pc}

@ Up / Down on a dungeon map = show the floor above / below. fs_btn records the floor
@ button (list closed), the list's arrows and its places with their label cells (fl_tab;
@ only floors shown are updated). While the button or a place is live, Up / Down are
@ hidden from the game (it closes the map on them) and the way waits in fl_pend: list
@ closed: tap the button once. Open: find the place of the floor shown (fl_shown) and
@ tap the next place that way; past the list's end tap its arrow once (it scrolls) and
@ try again. No floor that way, or the floor shown scrolled out of the list: nothing.
@ The list stays open (as after a stylus pick); a tap on the map closes it.
fl_ctl:
        push    {r4-r6, lr}
        ldr     r4, =fl_tab
        ldr     r5, =fl_pend
        ldr     r2, =PAD
        ldrh    r1, [r2, #2]
        ands    r6, r1, #(KEY_UP | KEY_DOWN)
        beq     2f                      @ no new press: a waiting one
        ldr     r1, =MODE               @ a new press only in map modes: elsewhere MAP_OBJ is
        ldr     r1, [r1]                @   another object (v2.1.60: Up / Down in the field froze
        cmp     r1, #MAP_MODE           @   the game in a data abort). A waiting one goes on
        cmpne   r1, #FL_MODE1           @   (mode 7 while the list opens).
        cmpne   r1, #FL_MODE2
        popne   {r4-r6, pc}
        add     r0, r4, #(4 * FL_BTN)
        bl      tab_live
        mov     r12, r0
        bl      fl_shown                @ (keeps r12)
        strb    r2, [r5, #3]            @ the floor shown at the press
        orrs    r1, r1, r12
        popeq   {r4-r6, pc}             @ neither: not a map with floors, keys go on
        ldr     r2, =PAD                @ hide Up / Down from the game
        ldrh    r1, [r2, #2]
        bic     r1, r1, #(KEY_UP | KEY_DOWN)
        strh    r1, [r2, #2]
        ldrh    r1, [r2]
        bic     r1, r1, #(KEY_UP | KEY_DOWN)
        strh    r1, [r2]
        tst     r6, #KEY_UP
        mvnne   r0, #0                  @ the way: -1 up, 1 down
        moveq   r0, #1
        mov     r1, #FL_WAIT
        strb    r0, [r5]
        strb    r1, [r5, #1]
        mov     r1, #0
        strb    r1, [r5, #2]
2:      ldrsb   r6, [r5]                @ r6 = the way waiting
        cmp     r6, #0
        popeq   {r4-r6, pc}
        ldrb    r1, [r5, #1]
        subs    r1, r1, #1
        strb    r1, [r5, #1]
        beq     8f                      @ timed out: drop it
        ldr     r3, =menu_tap
        ldrb    r1, [r3]
        cmp     r1, #0
        popne   {r4-r6, pc}             @ a tap still going
        ldr     r1, =MODE
        ldr     r1, [r1]
        cmp     r1, #FL_MODE2
        popeq   {r4-r6, pc}             @ the list or the map still sliding
        bl      fl_shown
        ldrb    r3, [r5, #3]
        and     r2, r2, #0xff
        cmp     r2, r3
        bne     8f                      @ the floor changed: done
        ldrb    r2, [r5, #2]
        cmp     r1, #0
        bne     3f
        tst     r2, #1                  @ list closed: tap the button once
        popne   {r4-r6, pc}
        orr     r2, r2, #1
        strb    r2, [r5, #2]
        add     r0, r4, #(4 * FL_BTN)
        b       6f
3:      cmp     r0, #0
        beq     8f                      @ the floor shown is not in the list
        add     r0, r0, r6              @ r0 = the place that way
        sub     r1, r0, #FL_P0
        cmp     r1, #(FL_IDS - FL_P0)
        bhs     4f
        ldrb    r1, [r5, #1]            @ tapped again until the floor changes (the game
        tst     r2, #4                  @   ignores taps while the map slides to a floor),
        tstne   r1, #15                 @   every 16 reads (it needs the stylus off between)
        popne   {r4-r6, pc}
        orr     r2, r2, #4
        strb    r2, [r5, #2]
        add     r0, r4, r0, lsl #2
        b       6f
4:      tst     r2, #2                  @ past the list's end: its arrow once, then wait
        popne   {r4-r6, pc}
        orr     r2, r2, #2
        strb    r2, [r5, #2]
        cmp     r6, #0
        movlt   r0, r4                  @ up arrow
        addgt   r0, r4, #4              @ down arrow
6:      bl      tab_live
        cmp     r0, #0
        beq     8f
        ldrb    r1, [r0, #1]
        ldrb    r0, [r0]
        bl      menu_tap_at
        pop     {r4-r6, pc}
8:      mov     r1, #0                  @ drop the waiting way
        strb    r1, [r5]
        pop     {r4-r6, pc}

@ r0 = fl_tab index of the live place showing the floor shown (0 = none), r1 = nonzero if
@ a place is live, r2 = the floor shown's label cell (0 = none). Keeps r12.
fl_shown:
        push    {r4-r7, r12, lr}
        ldr     r0, =MAP_OBJ
        ldr     r0, [r0]
        sub     r1, r0, #0x02000000     @ the object must be in main RAM (a read outside it
        cmp     r1, #0x00400000         @   aborts and freezes the game)
        ldrshlo r5, [r0, #FL_FLOOR]
        rsblo   r5, r5, #FL_CELL1F      @ r5 = the floor shown's label cell
        andlo   r5, r5, #0xff
        movhs   r5, #0
        mov     r4, #(FL_IDS - 1)
        mov     r6, #0
        mov     r7, #0
1:      ldr     r0, =fl_tab
        add     r0, r0, r4, lsl #2
        bl      tab_live
        cmp     r0, #0
        beq     2f
        mov     r6, #1
        ldrb    r1, [r0, #3]
        cmp     r1, r5
        moveq   r7, r4
2:      sub     r4, r4, #1
        cmp     r4, #FL_P0
        bge     1b
        mov     r0, r7
        mov     r1, r6
        mov     r2, r5
        pop     {r4-r7, r12, pc}
@ Statue turn screen (NOTE_MODE): Left / Right turn the statue one 30-degree step. The game
@ turns it toward the side of a stylus tap, measured from the line through its face (any
@ distance), and its arrows turn with it. So the tap goes 90 deg off the face, from the
@ statue's facing: Left = clockwise on the screen (the left arrow at the start), Right = the
@ other way. A press while the statue turns waits (st_pend); a held key repeats per step.
@ The game ignores a tap in the first reads after a turn ends: ST_SETTLE reads wait (st_wait).
@ No statue on the screen (a map note): nothing, keys passed on.
st_ctl:
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #NOTE_MODE
        bxne    lr
        push    {r4-r6, lr}
        bl      st_find
        ldr     r4, =st_pend
        cmp     r0, #0
        strheq  r0, [r4]                @ no statue: nothing waits
        beq     9f
        ldr     r5, =PAD
        ldr     r1, =ch_seen            @ A too, unless a text box is up (A advances it): the
        ldrb    r1, [r1]                @   field A taps landed on the screen and turned the
        ldr     r2, =msg_guard          @   statue
        ldrb    r2, [r2]
        orrs    r1, r1, r2
        movne   r3, #(KEY_LEFT | KEY_RIGHT)
        moveq   r3, #(KEY_LEFT | KEY_RIGHT | KEY_A)
        ldrh    r1, [r5]                @ held: A only (held Left / Right repeat below)
        and     r2, r3, #KEY_A
        bic     r1, r1, r2
        strh    r1, [r5]
        ldrh    r1, [r5, #2]
        ands    r2, r1, #(KEY_LEFT | KEY_RIGHT)
        strbne  r2, [r4]                @ a new press waits for the statue
        bic     r1, r1, r3              @ the game gets no Left / Right here
        strh    r1, [r5, #2]
        ldrb    r1, [r0, #8]
        cmp     r1, #ST_IDLE
        movne   r1, #ST_SETTLE          @ turning: wait, then ST_SETTLE reads more
        strbne  r1, [r4, #ST_WAIT]
        bne     9f
        ldrb    r1, [r4, #ST_WAIT]
        subs    r1, r1, #1
        strbhs  r1, [r4, #ST_WAIT]
        bhs     9f
        ldrh    r6, [r5]
        and     r6, r6, #(KEY_LEFT | KEY_RIGHT)
        ldrb    r1, [r4]
        orrs    r6, r6, r1              @ r6 = wanted: waiting or held
        beq     9f
        ldr     r1, =menu_tap
        ldrb    r1, [r1]
        cmp     r1, #0
        bne     9f                      @ tapping: later
        strb    r1, [r4]
        ldrh    r0, [r0, #ST_ANG]       @ step index = round(facing * 12 / 0x10000)
        add     r0, r0, #0xa00
        add     r0, r0, #0xaa
        mov     r0, r0, lsl #16
        mov     r0, r0, lsr #16
        add     r0, r0, r0, lsl #1
        mov     r0, r0, lsr #14
        adr     r2, st_cos
        ldrsb   r3, [r2, r0]            @ r3 = cos, r12 = sin (cos of index - 3)
        subs    r0, r0, #3
        addmi   r0, r0, #12
        ldrsb   r12, [r2, r0]
        tst     r6, #KEY_LEFT
        rsbeq   r3, r3, #0
        rsbeq   r12, r12, #0
        rsb     r0, r3, #ST_CX          @ Left: x = cx - cos, y = cy + sin
        add     r1, r12, #ST_CY
        bl      menu_tap_at
9:      pop     {r4-r6, pc}

@ -> r0 = the statue on the turn screen (state ST_IDLE / turning), else 0. Clobbers r1-r3, r12.
st_find:
        ldr     r0, =OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #STATUE_OVL
        bne     8f
        ldr     r0, =OBJ_MGR
        ldr     r0, [r0]
        cmp     r0, #0
        beq     8f
        ldr     r1, [r0, #0x10]         @ count
        ldr     r0, [r0, #0xc]          @ pool
        ldr     r3, =STATUE_VT
1:      subs    r1, r1, #1
        bmi     8f
        ldr     r2, [r0], #4
        cmp     r2, #0x02000000         @ (main RAM below the no-access range 0x023e0000 only)
        blo     1b
        cmp     r2, #0x023c0000
        bhs     1b
        ldr     r12, [r2]
        cmp     r12, r3
        bne     1b
        ldrb    r12, [r2, #8]
        sub     r12, r12, #ST_IDLE
        cmp     r12, #1
        bhi     1b
        mov     r0, r2
        bx      lr
8:      mov     r0, #0
        bx      lr
st_cos:         @ 40 x cos(index x 30 deg)
        .byte   40, 35, 20, 0, -20, -35, -40, -35, -20, 0, 20, 35
        .balign 4

fs_specs:       @ per screen: id seen on it, mode, entries, default entry; then the entries
        .byte   0x7f, FS_ROWS, 4, 0,  0x7f, 0x80, 0x81, 0x82, 0x83, 0x84, 0x86, 0x86   @ Options
        .byte   0x5a, FS_VERT, 3, 0,  0x5a, 0, 0x5b, 0, 0x5c, 0           @ Adventure, Battle, Options
        .byte   0x56, FS_HORZ, 3, 2,  0x57, 0, 0x58, 0, 0x56, 0           @ Copy, Erase, Start
        .byte   0x55, FS_VERT, 3, 0,  128, 70, 128, 130, 0x55, 0          @ file 1, file 2, WFC Setup
        .byte   0
        .balign 4

@ ---------------------------------------------------------------------------
@ R = take the equipped item out / put it away (field only, mode 1, no text box, not at sea).
@ The game takes items out with a tap on their icon (top right of the touch screen) and uses
@ them with a tap on the field (boomerang: a tap = straight throw to that point, a drag = path).
@ Item not out: R taps the icon (out only, no use: the user can then draw with the stylus);
@ R is ignored until it is out (IT_WAIT reads at most). Item out (Link's state = the item
@ state): R or B = "Put Away" (the same icon tap); A (not bombs: held_obj's throw / set-down)
@ = the use tap on the field ahead of Link. Ahead = the last D-pad direction (fresh within
@ DIR_FRESH), else the way the last use tap went while the item stayed out (it_oct), else the
@ way Link faces; it_dist per item, shortened until the point is on screen. Out = the item
@ state with the equipped item in +0x14 (the sword swing uses the same state).
@ Called from pad_update on every pad read.
item_ctl:
        push    {r4-r8, lr}
        sub     sp, sp, #24             @ [sp] 5th arg, [sp+4] x, [sp+8] y, [sp+12] vec
        ldr     r4, =it_wait
        bl      on_land
        bne     it_off
        ldr     r2, =PAD                @ the game takes the item out itself while L or R
        ldrh    r0, [r2, #2]            @   is held (and back on the release, before our
        and     r8, r0, #KEY_R          @   tap): hide R, and held L / R. (A new L press
        bic     r0, r0, #KEY_R          @   does nothing since v2.1.31.)
        strh    r0, [r2, #2]            @   r8 = R pressed
        ldrh    r0, [r2]
        bic     r0, r0, #(KEY_L | KEY_R)
        strh    r0, [r2]
        ldr     r0, =UI_ROOT            @ item bar open: X is the game's (it closes the bar)
        ldr     r0, [r0]
        cmp     r0, #0
        ldrbne  r0, [r0, #UI_BAR_OPEN]
        cmpne   r0, #0
        bne     1f
        ldrh    r0, [r2, #2]            @ X = the item out / away key (R's job before v2.1.69):
        tst     r0, #KEY_X              @   hidden from the game, as X opens its item bar
        orrne   r8, r8, #KEY_X
        bic     r0, r0, #KEY_X
        strh    r0, [r2, #2]
        ldrh    r0, [r2]
        bic     r0, r0, #KEY_X
        strh    r0, [r2]
1:      ldr     r0, =ITEM_MGR
        ldr     r0, [r0]
        cmp     r0, #0
        beq     it_nox
        ldr     r5, [r0]                @ r5 = equipped item
        sub     r1, r5, #IT_FIRST
        cmp     r1, #(IT_LAST - IT_FIRST)
        bhi     it_nox
        ldr     r0, [r0, #0xac]         @ EquipItem* per item
        cmp     r0, #0
        beq     it_nox
        ldr     r6, [r0, r5, lsl #2]
        cmp     r6, #0
        beq     it_nox
        ldr     r0, =LINK_STATES        @ r7 = item out: Link's state is the item state
        ldr     r0, [r0]
        cmp     r0, #0
        beq     it_nox
        ldr     r0, [r0, #4]            @ (LinkStateId_Item = 1)
        ldr     r7, =LINK_STATE
        ldr     r7, [r7]
        cmp     r7, r0
        ldreq   r0, [r7, #0x14]         @ the item it holds out: a sword swing is the same
        cmpeq   r0, r5                  @   state with +0x14 = 0, so a B combo would tap the icon
        movne   r7, #0
        movne   r0, #0xff               @ not out: forget the use tap's way (it_oct)
        strbne  r0, [r4, #IT_OCT]
        movne   r0, #0                  @   and the Put Away latch (it_put)
        strbne  r0, [r4, #IT_PUT]
        bne     1f
        ldrb    r0, [r4, #IT_PUT]         @ Put Away tapped, item still out (it goes on the tap's
        cmp     r0, #0                  @   release): A / B / R are hidden, or a second icon
        beq     1f                      @   tap could land just after the release and take the
        sub     r0, r0, #1              @   item out again (user: B B B flashed the shovel), or
        strb    r0, [r4, #IT_PUT]         @   A probe it. IT_PUT_WAIT reads at most
        ldrh    r0, [r2, #2]
        bic     r0, r0, #(KEY_A | KEY_B)
        strh    r0, [r2, #2]
        b       it_done
1:      cmp     r7, #0                  @ A with the item out = the use tap, aimed straight
        cmpne   r5, #IT_BOMBS           @   (tap_front's probes went 10px up the screen, so a
        beq     1f                      @   side dig was diagonal). Bombs: A stays (held_obj throw)
        ldrh    r0, [r2, #2]
        tst     r0, #KEY_A
        bicne   r0, r0, #KEY_A
        strhne  r0, [r2, #2]
        orrne   r8, r8, #KEY_A          @ r8 = R / A pressed
1:      ldr     r0, =menu_tap           @ a tap still running
        ldrb    r0, [r0]
        cmp     r0, #0
        bne     it_done
        ldr     r2, =PAD                @ B or R with the item out = the icon's "Put Away" (a tap
        ldrh    r0, [r2, #2]            @   on the icon puts any item away); B is hidden, so no
        cmp     r7, #0                  @   slash after it
        beq     7f
        tst     r0, #KEY_B
        tsteq   r8, #(KEY_R | KEY_X)
        beq     7f
        bic     r0, r0, #KEY_B
        strh    r0, [r2, #2]
        mov     r0, #0
        strh    r0, [r4]                @ it_wait, it_ok (IT_OK): no use tap after it
        mov     r0, #IT_PUT_WAIT
        strb    r0, [r4, #IT_PUT]
        mov     r0, #ITEM_ICON_X
        mov     r1, #ITEM_ICON_Y
        bl      menu_tap_at
        b       it_done
7:      ldrb    r0, [r4]                @ it_wait: R tapped the icon, the item is not out yet:
        cmp     r0, #0                  @   ignore R (a second icon tap would undo the first)
        beq     2f
        cmp     r7, #0
        movne   r0, #0                  @ out now: done waiting, this read's keys count
        subeq   r0, r0, #1
        strb    r0, [r4]
        beq     it_done
2:      cmp     r8, #0
        beq     it_done
        cmp     r7, #0                  @ item out here = A (R / B were Put Away above)
        bne     it_use
        tst     r8, #KEY_X              @ R only: the item bar opens (it_nox)
        beq     it_nox
        mov     r0, #ITEM_ICON_X        @ X: take it out, no use tap
        mov     r1, #ITEM_ICON_Y
        bl      menu_tap_at
        mov     r0, #IT_WAIT
        strb    r0, [r4]
        b       it_done
it_use:
        adr     r1, it_dist
        sub     r0, r5, #IT_FIRST
        ldrb    r7, [r1, r0]            @ r7 = distance, 1/16 tiles (0 = no use tap)
        mov     r0, #0
        strh    r0, [r4]                @ it_wait, it_ok
        cmp     r7, #0
        beq     it_done
        ldr     r0, =CAMPTR
        ldr     r0, [r0]
        bl      GetCamera
        mov     r8, r0                  @ r8 = camera
        ldr     r2, =last_oct
        ldrb    r0, [r2, #DIR_AGE]
        cmp     r0, #DIR_FRESH
        bhs     3f
        ldrb    r0, [r2]                @ screen octant -> world heading
        add     r1, r8, #0x200
        ldrsh   r1, [r1, #0x26]         @ camera yaw
        add     r0, r1, r0, lsl #13
        b       4f
3:      ldrb    r0, [r4, #IT_OCT]         @ else the way the last use tap went while the item stayed
        cmp     r0, #8                  @   out (it_oct; a dig turns Link toward a point ~28 deg
        blo     6f                      @   off, so his heading made the next side dig diagonal)
        ldr     r0, =PLAYER_ANGLE
        ldrh    r0, [r0]
4:      bl      hd_oct                  @ world octant
6:      strb    r0, [r4, #IT_OCT]
        adr     r1, it_vec
        add     r6, r1, r0, lsl #1      @ r6 = its (dx, dz), 64 = 1
        mov     r5, #6                  @ tries
5:      ldr     r3, =PLAYER_POS
        ldmia   r3, {r0-r2}
        ldrsb   r12, [r6]
        mul     r12, r7, r12
        add     r0, r0, r12, lsl #2     @ (64 * 16 * 4 = 0x1000 = 1 tile)
        ldrsb   r12, [r6, #1]
        mul     r12, r7, r12
        add     r2, r2, r12, lsl #2
        add     r3, sp, #12
        stmia   r3, {r0-r2}
        mov     r0, #0
        str     r0, [sp]
        mov     r0, r8
        add     r1, sp, #12
        add     r2, sp, #4
        add     r3, sp, #8
        bl      ScreenFromWorld
        ldrh    r0, [sp, #4]
        ldrh    r1, [sp, #8]
        sub     r2, r0, #IT_EDGE        @ on screen, off the edges?
        cmp     r2, #(256 - 2 * IT_EDGE)
        subls   r2, r1, #IT_EDGE
        cmpls   r2, #(192 - 2 * IT_EDGE)
        bls     6f
        add     r7, r7, r7, lsl #1      @ no: 3/4 as far
        mov     r7, r7, lsr #2
        subs    r5, r5, #1
        bne     5b
        b       it_done
6:      bl      menu_tap_at
        b       it_done
it_nox: tst     r8, #KEY_R              @ R with no item out = X: the item bar opens
        ldrne   r2, =PAD
        ldrhne  r0, [r2, #2]
        orrne   r0, r0, #KEY_X
        strhne  r0, [r2, #2]
it_off: mov     r0, #0
        strh    r0, [r4]
it_done:
        add     sp, sp, #24
        pop     {r4-r8, pc}

it_vec:         @ world octant (heading 0 = +z, screen down; 0x4000 = +x) -> (dx, dz), 64 = 1
        .byte   0, 64, 45, 45, 64, 0, 45, -45, 0, -64, -45, -45, -64, 0, -45, 45
it_dist:        @ per item from IT_FIRST, 1/16 tiles: boomerang, shovel, bombs (throw), bow,
                @ grappling hook, bombchu, hammer. Bombchu 0: it swaps the screens and is
                @ steered by a path drawn on the map, so R only takes it out.
        .byte   96, 16, 48, 128, 96, 0, 24
        .balign 4
        .ltorg                          @ shared literal pool (v2.1.68: 4 pools, was 17; each pool repeats its constants)

@ ---------------------------------------------------------------------------
@ Fishing game (at sea, Fish on the menu bar; touch only), told from sailing by
@ FISH_SEA. Without a text box: A = one stylus slide down the screen (sets the hook on
@ "PULL!"), held Down = one slide after another (raises the gauge; with Left / Right held at
@ the start of a slide it goes down-left (SW) / down-right (SE)), held B with a fish on
@ the line = stylus circles (reels it in), B without one or Select = the red arrow (quit).
@ "LET GO!" (the fish jumps) wants the stylus off: let go of B / Down. The game sees none of
@ these keys. The stylus point for this read goes to fg_x / fg_y (x 0 = up); menu_touch
@ presses there. The Salvage Arm (mode SALV_MODE) branches to sv_ctl. Called from
@ pad_update on every pad read. -> r0 = 1 while fishing or salvaging, no text box.
fish_ctl:
        push    {r4-r6, lr}
        ldr     r4, =fg_mode
        ldr     r0, =SEA_OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #SEA_OVL
        bne     fg_off
        ldr     r0, =FISH_SEA
        ldrb    r0, [r0]
        cmp     r0, #0
        bne     fg_off
        ldr     r0, =msg_guard          @ a text box: A / B tap it as usual
        ldrb    r0, [r0]
        cmp     r0, #0
        bne     fg_off
        ldr     r0, =SEA_CTL
        ldr     r0, [r0]
        sub     r1, r0, #0x02000000     @ in main RAM?
        cmp     r1, #0x400000
        bhs     fg_off
        add     r0, r0, #(FISH_SCENE & 0xff00)
        ldrb    r3, [r0, #(FISH_SCENE & 0xff)]  @ r3 = scene
        ldr     r2, =held_real          @ r5 = held (as read: PAD+0 is cleared on gated reads),
        ldrh    r5, [r2]                @   r6 = new presses
        ldr     r2, =PAD
        ldrh    r6, [r2, #2]
        ldrh    r0, [r2]
        bic     r0, r0, #FG_HIDE1
        bic     r0, r0, #FG_HIDE2
        strh    r0, [r2]
        bic     r0, r6, #FG_HIDE1
        bic     r0, r0, #FG_HIDE2
        strh    r0, [r2, #2]
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #SALV_MODE
        beq     sv_ctl
        ldrb    r0, [r4]                @ r0 = mode, r1 = step
        ldrb    r1, [r4, #FGD_STEP]
        cmp     r0, #FG_REEL            @ circles end when B is let go
        bne     1f
        tst     r5, #KEY_B
        moveq   r0, #0
1:      cmp     r0, #FG_PULL            @ a slide ends after its lift
        bne     1f
        cmp     r1, #(FG_SLIDE + 2)
        movhs   r0, #0
1:      cmp     r0, #0                  @ none running: start one
        bne     3f
        mov     r1, #0
        tst     r6, #KEY_A
        tsteq   r5, #KEY_DOWN
        beq     6f
        mov     r0, #FG_PULL
        mov     r2, #0                  @ slide direction: Left held = SW, Right = SE, else S
        tst     r5, #KEY_LEFT
        mvnne   r2, #(FG_DX - 1)
        tst     r5, #KEY_RIGHT
        movne   r2, #FG_DX
        strb    r2, [r4, #FGD_DX]
        b       3f
6:      tst     r5, #KEY_B
        beq     2f
        cmp     r3, #FISH_FIGHT
        moveq   r0, #FG_REEL
        beq     3f
2:      and     r2, r6, #(KEY_B | KEY_SELECT)
        cmp     r3, #FISH_FIGHT
        biceq   r2, r2, #KEY_B
        cmp     r2, #0
        movne   r0, #FISH_QUIT_X
        movne   r1, #FISH_QUIT_Y
        blne    menu_tap_at
        mov     r0, #0
        mov     r1, #0
3:      strb    r0, [r4]
        add     r2, r1, #1
        strb    r2, [r4, #FGD_STEP]
        mov     r2, #0                  @ r2, r12 = the point (x 0 = up)
        cmp     r0, #FG_PULL
        bne     4f
        cmp     r1, #FG_SLIDE
        ldrsblo r2, [r4, #FGD_DX]
        mullo   r2, r1, r2
        addlo   r2, r2, #FG_SX
        movlo   r12, #FG_DY
        mullo   r12, r1, r12
        addlo   r12, r12, #FG_Y0
        b       5f
4:      cmp     r0, #FG_REEL
        bne     5f
        and     r1, r1, #15
        ldr     r12, =fg_circle
        add     r12, r12, r1, lsl #1
        ldrsb   r2, [r12]
        ldrsb   r12, [r12, #1]
        add     r2, r2, #FG_SX
        add     r12, r12, #FG_CY
5:      strb    r2, [r4, #FGD_X]
        strb    r12, [r4, #FGD_Y]
        mov     r0, #1
        pop     {r4-r6, pc}
@ Salvage Arm (fish_ctl's keys hidden, r4 = fg_mode, r5 held, r6 new presses): held D-pad =
@ the stylus on the lever handle; Left / Right slide it SV_STEP per pad read, Up / Down hold
@ the knob up / down. A = slide the handle back to the centre (Left / Right stop it). B /
@ Select = the red back arrow (as fishing's quit). The first read presses on the handle
@ itself (a press anywhere else on the bar does not grab it). fg_dx = 1 while centring.
sv_ctl:
        tst     r6, #(KEY_B | KEY_SELECT)
        movne   r0, #FISH_QUIT_X
        movne   r1, #FISH_QUIT_Y
        blne    menu_tap_at
        ldr     r0, =SEA_CTL
        ldr     r0, [r0]
        add     r0, r0, #(SV_HANDLE & 0xff00)
        ldrsh   r3, [r0, #(SV_HANDLE & 0xff)]
        add     r3, r3, #SV_X0          @ r3 = handle x
        ldrb    r0, [r4]                @ r0 = stylus on the handle, r1 = centring
        ldrb    r1, [r4, #FGD_DX]
        mov     r2, r3                  @ r2, r12 = the point
        mov     r12, #SV_Y
        cmp     r0, #0
        bne     1f
        and     r1, r6, #KEY_A          @ stylus up: press on the handle for the D-pad or A
        tst     r5, #DPAD
        cmpeq   r1, #0
        beq     8f
        mov     r0, #FG_SALV
        b       7f
1:      tst     r6, #KEY_A
        movne   r1, #1
        tst     r5, #(KEY_LEFT | KEY_RIGHT)
        movne   r1, #0
        tst     r5, #KEY_LEFT
        subne   r2, r2, #SV_STEP
        tst     r5, #KEY_RIGHT
        addne   r2, r2, #SV_STEP
        cmp     r1, #0                  @ centring: up to SV_STEP toward SV_X0, over once there
        beq     2f
        subs    r0, r3, #SV_X0
        moveq   r1, #0
        cmp     r0, #SV_STEP
        movgt   r0, #SV_STEP
        cmn     r0, #SV_STEP
        mvnlt   r0, #(SV_STEP - 1)
        sub     r2, r3, r0
2:      tst     r5, #DPAD               @ nothing held, not centring: let go
        cmpeq   r1, #0
        beq     8f
        mov     r0, #FG_SALV
        tst     r5, #KEY_UP
        movne   r12, #SV_UP_Y
        tst     r5, #KEY_DOWN
        movne   r12, #SV_DOWN_Y
7:      strb    r0, [r4]
        strb    r1, [r4, #FGD_DX]
        strb    r2, [r4, #FGD_X]
        strb    r12, [r4, #FGD_Y]
        mov     r0, #1
        pop     {r4-r6, pc}
8:      mov     r0, #0
        strb    r0, [r4]
        strb    r0, [r4, #FGD_DX]
        strb    r0, [r4, #FGD_X]
        mov     r0, #1
        pop     {r4-r6, pc}
fg_off: mov     r0, #0
        strb    r0, [r4]
        @ Not fishing: an enemy holding Link wants the stylus rubbed back and forth (Link
        @ state LS_HELD, sub-state LS_HELD_SUB or LS_CLASH_SUB). Held A (no text box) = the stylus zig-zags
        @ across Link's screen point through fg_x / fg_y; A is hidden from the game.
        @ Bow out (the item state, +0x14 = IT_BOW): held A = the stylus held near the screen
        @ edge on the way A aims from Link (it_oct; the D-pad turns it: dpad_move does not run
        @ while the stylus is down), so the camera pans that way as for a stylus drag (user: to
        @ see targets off the screen). A let go = the stylus lifts = the arrow. The stylus stays
        @ down BOW_MIN reads at least, so a quick A press still shoots.
        ldr     r1, =msg_guard
        ldrb    r1, [r1]
        cmp     r1, #0
        bne     8f
        ldr     r0, =LINK_STATES
        ldr     r0, [r0]
        cmp     r0, #0
        beq     8f
        ldr     r1, =LINK_STATE
        ldr     r1, [r1]
        ldr     r3, =held_real
        ldrh    r3, [r3]                @ r3 = held
        ldr     r2, [r0, #(4 * LS_HELD)]
        cmp     r1, r2
        ldreq   r2, [r1, #4]
        beq     1f
        ldr     r2, [r0, #4]            @ (LinkStateId_Item = 1)
        cmp     r1, r2
        ldreq   r2, [r1, #0x14]
        bne     fg_grab
        cmp     r2, #IT_HOOK
        beq     hk_hold
        cmp     r2, #IT_BOW
        bne     fg_grab
        ldr     r2, =PAD
        ldrh    r0, [r2, #2]
        ldrb    r5, [r4, #FGD_STEP]     @ fg_step = reads the stylus stays down at least
        tst     r0, #KEY_A
        movne   r5, #BOW_MIN
        tst     r3, #KEY_A
        cmpeq   r5, #0
        beq     8f                      @ A up, minimum over: lift (shoot)
        cmp     r5, #0
        subne   r5, r5, #1
        strb    r5, [r4, #FGD_STEP]
        bic     r0, r0, #KEY_B          @ B / R (Put Away) wait for the shot: its tap slid our
        bic     r0, r0, #KEY_R          @   stylus off = an arrow, and the bow stayed out
        strh    r0, [r2, #2]
        mov     r5, #1                  @ r5 = 1: bow
        b       2f
1:      sub     r2, r2, #LS_HELD_SUB    @ sub-states 6 to 8 (7 = Like Like, user state 518)
        cmp     r2, #(LS_CLASH_SUB - LS_HELD_SUB)
        bhi     fg_grab4
        tst     r3, #KEY_A
        beq     8f
        mov     r5, #0
2:
fg_hide:
        ldr     r2, =PAD
        ldrh    r1, [r2]
        bic     r1, r1, #KEY_A
        strh    r1, [r2]
        ldrh    r1, [r2, #2]
        bic     r1, r1, #KEY_A
        strh    r1, [r2, #2]
        sub     sp, sp, #32             @ [sp] 5th arg, [sp+4] x, [sp+8] y, [sp+12] vec, [sp+24] x2, [sp+28] y2
        ldr     r0, =CAMPTR
        ldr     r0, [r0]
        bl      GetCamera
        mov     r6, r0                  @ r6 = camera
        mov     r1, #0
        str     r1, [sp]
        ldr     r1, =PLAYER_POS
        add     r2, sp, #4
        add     r3, sp, #8
        bl      ScreenFromWorld
        mov     r12, #1                 @ r12 = reads per stroke side
        cmp     r5, #4                  @ r5 = 4: ice (user state 608: pad read every frame, the game
        moveq   r5, #0                  @   samples the stylus every 2nd one: a side per read cancels)
        moveq   r12, #2
        cmp     r5, #0
        bne     bw_pt
        ldrsh   r0, [sp, #4]
        ldrsh   r1, [sp, #8]
        add     sp, sp, #32
        ldrb    r2, [r4, #FGD_STEP]
        add     r2, r2, #1
        strb    r2, [r4, #FGD_STEP]
        tst     r2, r12                 @ diagonal strokes: the game ignores a rub with no y change
        addne   r0, r0, #RUB_DX
        subeq   r0, r0, #RUB_DX
        addne   r1, r1, #RUB_DY
        subeq   r1, r1, #RUB_DY
fg_clamp:
        cmp     r0, #RUB_EDGE
        movlt   r0, #RUB_EDGE
        cmp     r0, #(256 - RUB_EDGE)
        movgt   r0, #(256 - RUB_EDGE)
        cmp     r1, #RUB_EDGE
        movlt   r1, #RUB_EDGE
        cmp     r1, #(192 - RUB_EDGE)
        movgt   r1, #(192 - RUB_EDGE)
        strb    r1, [r4, #FGD_Y]
        b       9f
8:
fg_lift:
        mov     r0, #0
        strb    r0, [r4, #FGD_STEP]
        strb    r0, [r4, #FGD_HK]
9:      strb    r0, [r4, #FGD_X]
        mov     r0, #0
        pop     {r4-r6, pc}
bw_pt:  ldr     r0, =held_real          @ D-pad held: its way (screen heading + camera yaw)
        ldrh    r0, [r0]
        and     r0, r0, #DPAD
        cmp     r5, #2                  @ on a grappling hook post (user state 601: facing the void,
        beq     bw_po                   @   A alone / A + Up jumped into the pit): always the post's
bw_dp:  ldr     r1, =dir_table          @   own way (the game's jump, state +0x16: 0 = +z)
        add     r2, r1, #(8 * 4)
1:      ldrh    r3, [r1], #4
        cmp     r3, r0
        beq     2f
        cmp     r1, r2
        blo     1b
        b       3f
2:      ldrh    r0, [r1, #-2]
        add     r1, r6, #0x200
        ldrsh   r1, [r1, #0x26]
        add     r0, r0, r1
        bl      hd_oct
        ldr     r1, =it_wait
        strb    r0, [r1, #IT_OCT]
3:      ldr     r1, =it_wait            @ else the way A aimed last, else Link's facing
        ldrb    r0, [r1, #IT_OCT]
        cmp     r0, #8
        blo     4f
        ldr     r0, =PLAYER_ANGLE
        ldrh    r0, [r0]
        bl      hd_oct
        strb    r0, [r1, #IT_OCT]
4:      mov     r5, r0                  @ r5 = octant
bw_oc:  ldr     r3, =PLAYER_POS         @ Link raised BOW_AIM_Y, on the screen (the game aims from
        ldmia   r3, {r0, r1, r3}        @   above his feet: from the feet, Left / Right tilted ~5 deg down)
        add     r1, r1, #BOW_AIM_Y
        add     r2, sp, #12
        stmia   r2, {r0, r1, r3}
        mov     r0, r6
        add     r1, sp, #12
        add     r2, sp, #4
        add     r3, sp, #8
        bl      ScreenFromWorld
        ldr     r1, =it_vec             @ the point 2 tiles on that way, on the screen
        add     r1, r1, r5, lsl #1
        ldrsb   r2, [r1]
        ldrsb   r12, [r1, #1]
        add     r1, sp, #12
        ldr     r0, [r1]
        add     r0, r0, r2, lsl #7      @ (64 = 1 -> 0x2000 = 2 tiles)
        str     r0, [r1]
        ldr     r0, [r1, #8]
        add     r0, r0, r12, lsl #7
        str     r0, [r1, #8]
        mov     r0, r6
        add     r2, sp, #24
        add     r3, sp, #28
        bl      ScreenFromWorld
        ldrsh   r0, [sp, #4]            @ step from Link (1/16 px) along it to the last point
        ldrsh   r1, [sp, #8]            @   inside IT_EDGE
        ldrsh   r2, [sp, #24]
        ldrsh   r3, [sp, #28]
        add     sp, sp, #32
        strb    r0, [r4, #FGD_X]        @ (the hook's line starts here: hk_pt)
        strb    r1, [r4, #FGD_Y]
        sub     r2, r2, r0
        sub     r3, r3, r1
        cmp     r2, #0
        cmpeq   r3, #0
        beq     fg_lift
        mov     r0, r0, lsl #4
        mov     r1, r1, lsl #4
5:      add     r0, r0, r2              @ only the edges ahead count (the pan can put Link
        add     r1, r1, r3              @   himself past the edge behind)
        mov     r12, r0, asr #4
        cmp     r2, #0
        rsblt   r12, r12, #256
        cmpne   r12, #(256 - IT_EDGE)
        bgt     bw_out
        mov     r12, r1, asr #4
        cmp     r3, #0
        rsblt   r12, r12, #192
        cmpne   r12, #(192 - IT_EDGE)
        ble     5b
bw_out: sub     r0, r0, r2              @ back one step, and on back while on the item icon
        sub     r1, r1, r3              @   or its "Put Away" (a lift there taps it: no arrow)
        mov     r12, r0, asr #4
        cmp     r12, #BOW_HUD_X
        blt     bw_ok
        mov     r12, r1, asr #4
        cmp     r12, #BOW_HUD_Y
        ble     bw_out
bw_ok:  mov     r0, r0, asr #4
        mov     r1, r1, asr #4
        ldrb    r12, [r4, #FGD_HK]      @ the hook: only fg_hk / 256 of the way from Link
        cmp     r12, #0
        ldrbne  r2, [r4, #FGD_X]
        ldrbne  r3, [r4, #FGD_Y]
        subne   r0, r0, r2
        subne   r1, r1, r3
        mulne   r0, r12, r0
        mulne   r1, r12, r1
        addne   r0, r2, r0, asr #8
        addne   r1, r3, r1, asr #8
        ldrb    r12, [r4, #FGD_STEP]
        cmp     r12, #RL_FLAG           @ the roll (fg_roll): keep off the swap button (top centre)
        bne     fg_clamp                @   and Menu / Items (bottom)
        cmp     r1, #RL_TOP
        movlt   r1, #RL_TOP
        cmp     r1, #RL_BOT
        movgt   r1, #RL_BOT
        b       fg_clamp
bw_po:  ldr     r2, =LINK_STATE
        ldr     r2, [r2]
        ldrb    r1, [r2, #0x15]         @ (the game jumps only with this set)
        cmp     r1, #0
        beq     bw_dp
        ldrh    r0, [r2, #0x16]
        bl      hd_oct
        mov     r5, r0
        b       bw_oc
fg_circle:      @ 16 points round a circle of radius 20: (dx, dy)
        .byte   20, 0, 18, 8, 14, 14, 8, 18, 0, 20, -8, 18, -14, 14, -18, 8
        .byte   -20, 0, -18, -8, -14, -14, -8, -18, 0, -20, 8, -18, 14, -14, 18, -8
        .balign 4
@ Grappling hook out (item state, +0x14 = IT_HOOK; r0 = state table, r1 = state, r3 = held):
@ held A = the stylus down on Link, then out along the aim way (bw_pt) a little more each pad
@ read; the game throws the hook as far as the line went when it lifts (A let go). fg_step =
@ reads down (a short press stays down HK_MIN), fg_hk = the length (bw_ok).
hk_hold:
        ldr     r2, =PAD
        ldrh    r0, [r2, #2]
        ldrb    r5, [r4, #FGD_STEP]
        tst     r3, #KEY_A
        tsteq   r0, #KEY_A
        bne     1f
        cmp     r5, #0
        beq     fg_lift
        cmp     r5, #HK_MIN
        bhs     fg_lift
1:      cmp     r5, #100                @ (stays under RL_FLAG)
        addlo   r5, r5, #1
        strb    r5, [r4, #FGD_STEP]
        bic     r0, r0, #KEY_B          @ B / R (Put Away) wait for the throw, as for the bow
        bic     r0, r0, #KEY_R
        strh    r0, [r2, #2]
        mov     r12, #HK_STEP
        mul     r0, r12, r5
        add     r0, r0, #HK_START
        cmp     r0, #255
        movhi   r0, #255
        strb    r0, [r4, #FGD_HK]
        mov     r5, #1
        b       fg_hide
@ Little green blobs cling to Link (user state 531, "RUB!" bubble): gPlayer +0x48 bit 2 set
@ (+0x48 is 0 free, 8 sand monster, 32 sword clash, 2 blobs). He is in state 0 until a rub
@ stroke starts a 16 frame shake-off (state 4, sub-state 4), then back to 0: held A = the
@ rub (r5 = 0) in both. Not blobs: on to the Gongoron roll (state 0) or the stylus up (state 4).
@ Standing on a grappling hook post (user state 587: the game wants a held stylus on the floor
@ away from him to step off): held A = the stylus held far on the post's own way (state +0x16, the
@ way the game jumps across; user state 601: facing the void, the D-pad's or his way jumped into
@ the pit), bw_pt with r5 = 2. A is hidden from the game; let go = the stylus lifts.
fg_grab:                                @ (r0 = the state table, r1 = Link's state, r3 = held)
        ldr     r2, [r0, #(4 * LS_FOLLOW)]
        cmp     r1, r2
        ldreq   r2, [r1, #4]
        cmpeq   r2, #LS_POST_SUB
        bne     fg_grab1
        tst     r3, #KEY_A
        beq     fg_lift
        mov     r5, #2                          @ r5 = 2: the post (bw_pt)
        mov     r0, #0
        strb    r0, [r4, #FGD_STEP]
        b       fg_hide
fg_grab1:
        ldr     r2, =GPLAYER
        ldr     r2, [r2]
        cmp     r2, #0
        ldrne   r2, [r2, #0x48]
        tst     r2, #2
        bne     fg_rub
        ldr     r0, [r0, #(4 * LS_DAMAGE)]      @ frozen in ice (user state 584): Link in the damage
        cmp     r1, r0                          @   state (+0x18 = 6, +0x48 = 0)
        ldreq   r2, [r1, #0x18]
        cmpeq   r2, #LS_ICE
        bne     fg_roll
        tst     r3, #KEY_A
        beq     fg_lift
        mov     r5, #4                          @ r5 = 4: the ice rub (half-rate strokes)
        b       fg_hide
fg_rub:
        tst     r3, #KEY_A
        beq     fg_lift
        mov     r5, #0
        b       fg_hide
fg_grab4:
        ldr     r2, =GPLAYER
        ldr     r2, [r2]
        cmp     r2, #0
        ldrne   r2, [r2, #0x48]
        tst     r2, #2
        bne     fg_rub
        b       fg_lift
@ Gongoron (gr_tab byte 3 = 1, the swap button's +0x11) with B held: the stylus held far off on
@ the D-pad's way (else the way he faces), as bw_pt does for the bow. After ~24 reads of it
@ the game curls him into a ball and he rolls (user state 522: a held far stylus rolls; the
@ D-pad run never does). B is hidden from the game; let go = the stylus lifts.
fg_roll:
        tst     r3, #KEY_B
        beq     fg_lift
        ldr     r0, =gr_tab
        ldrb    r1, [r0, #3]
        cmp     r1, #1
        bne     fg_lift
        bl      tab_live                @ (keeps r3)
        cmp     r0, #0
        beq     fg_lift
        tst     r3, #DPAD
        moveq   r0, #0xff               @ no D-pad: the way he faces, not the bow's last aim
        ldreq   r1, =it_wait
        strbeq  r0, [r1, #IT_OCT]
        ldr     r2, =PAD
        ldrh    r1, [r2]
        bic     r1, r1, #KEY_B
        strh    r1, [r2]
        ldrh    r1, [r2, #2]
        bic     r1, r1, #KEY_B
        strh    r1, [r2, #2]
        mov     r5, #1
        mov     r0, #RL_FLAG
        strb    r0, [r4, #FGD_STEP]
        b       fg_hide

@ Fog steering (Ghost Ship search: wheel HUD, [SEA_CTL] + SEA_STEER = 1; mode 1, no text
@ box), touch only: a held stylus anywhere turns the wheel by its x - 128 (the y does not
@ count); let go = the wheel eases back to straight. Held Left / Right = our stylus at
@ (128 + fg_dx, WH_Y), fg_dx moving out WH_STEP per pad read up to WH_MAX, so a short
@ press is a small turn. Neither or both = let go, fg_dx 0. fish_ctl lifts fg_x on every
@ read it does not fish, so the point is set again each read. The menu bar (mb_ctl) hides
@ the held D-pad: no steering under it. A new Up / Down while ours is down waits one read
@ in fg_pend with ours up (a press that slides from ours onto the lever only turns the
@ wheel); while the menu_tap on the lever runs and one read after it, ours stays up too, so
@ the lever sees a press and a lift of its own. Pad reads are 30 Hz here.
@ Called from pad_update when fish_ctl did not take the keys. Clobbers r0-r3, r12.
wh_ctl:
        push    {r4, lr}
        bl      on_field                @ mode 1, no text box
        bne     9f
        ldr     r0, =SEA_OVL_SLOT
        ldr     r0, [r0]
        cmp     r0, #SEA_OVL
        bne     9f
        ldr     r3, =SEA_CTL
        ldr     r3, [r3]
        sub     r0, r3, #0x02000000     @ in main RAM?
        cmp     r0, #0x400000
        bhs     9f
        ldrb    r0, [r3, #SEA_STEER]
        cmp     r0, #1
        bne     9f
        ldr     r3, =fg_mode
        ldr     r2, =PAD
        ldrh    r1, [r2]
        and     r1, r1, #(KEY_LEFT | KEY_RIGHT)
        ldrsb   r0, [r3, #FGD_DX]       @ r0 = stylus x - 128
        cmp     r1, #KEY_LEFT
        bne     1f
        cmp     r0, #0                  @ (from the other side: start at the centre)
        movgt   r0, #0
        sub     r0, r0, #WH_STEP
        cmn     r0, #WH_MAX
        mvnlt   r0, #(WH_MAX - 1)
        b       2f
1:      cmp     r1, #KEY_RIGHT
        movne   r0, #0
        bne     2f
        cmp     r0, #0
        movlt   r0, #0
        add     r0, r0, #WH_STEP
        cmp     r0, #WH_MAX
        movgt   r0, #WH_MAX
2:      strb    r0, [r3, #FGD_DX]
        ldrh    r1, [r2, #2]            @ a lever press (Up / Down) kept from the last read: now
        ldrb    r12, [r3, #FGD_PEND]
        orr     r1, r1, r12
        mov     r12, #0
        strb    r12, [r3, #FGD_PEND]
        ldrb    r4, [r3, #FGD_WAIT]     @ r4 = reads to stay up | WH_DOWN (ours down last read)
        tst     r4, #WH_DOWN            @ ours down: a new lever press waits one read with it up
        andne   r12, r1, #(KEY_UP | KEY_DOWN)   @   (else menu_tap's press is a slide = a turn)
        strbne  r12, [r3, #FGD_PEND]
        bicne   r1, r1, #(KEY_UP | KEY_DOWN)
        strh    r1, [r2, #2]
        bic     r4, r4, #WH_DOWN
        cmp     r12, #0
        movne   r4, #1                  @ press kept: up this read
        ldr     r1, =menu_tap
        ldrb    r1, [r1]
        cmp     r1, #0
        movne   r4, #2                  @ lever tap running: up, and one read after it
        cmp     r4, #0
        subne   r4, r4, #1
        bne     3f
        cmp     r0, #0
        addne   r0, r0, #128
        strbne  r0, [r3, #FGD_X]
        movne   r0, #WH_Y
        strbne  r0, [r3, #FGD_Y]
        movne   r4, #WH_DOWN
3:      strb    r4, [r3, #FGD_WAIT]
9:      pop     {r4, pc}

@ ---------------------------------------------------------------------------
@ Hook @ 0x020b79b0 (ov0), replaces: bl TouchCtl_Stop   (r0 = r4 = touch controller)
@ Runs when the stylus is not down. After the normal stop, if the D-pad is held,
@ steer Link: direction from the table plus camera yaw; Y held = walk slowly.
        .global dpad_move
dpad_move:
        push    {r0-r6, lr}
        bl      TouchCtl_Stop
        ldr     r0, =PAD
        ldrh    r5, [r0]                @ held keys
        and     r6, r5, #DPAD
        adr     r1, dir_table
        mov     r2, #0
1:      ldrh    r3, [r1, r2]
        cmp     r3, r6
        beq     2f
        add     r2, r2, #4
        cmp     r2, #(8 * 4)
        blt     1b
        b       9f                      @ no single valid direction (e.g. L+R) -> do nothing
2:      add     r1, r1, r2
        ldrh    r6, [r1, #2]            @ base angle (screen-relative)
        mov     r0, r6                  @ remember the D-pad direction as an octant
        bl      hd_oct                  @ (0 = down, 1 = down-right ... 7 = down-left)
        ldr     r1, =last_oct           @ so A aims where you last pressed, even if
                                        @ Link hasn't finished turning yet
        strb    r0, [r1]
        mov     r0, #0
        strb    r0, [r1, #DIR_AGE]       @ dir_age = 0
        ldr     r1, =aim_hold
        strb    r0, [r1]
        ldr     r0, =CAMPTR
        ldr     r0, [r0]
        bl      GetCamera
        add     r0, r0, #0x200
        ldrsh   r3, [r0, #0x26]         @ camera yaw
        @ Bow out: the bow takes the fake stylus as its aim and shoots when it lets go (no walk
        @ there), so the D-pad only picks the way A shoots (it_oct, kept past DIR_FRESH).
        ldr     r0, =LINK_STATES
        ldr     r0, [r0]
        cmp     r0, #0
        beq     4f
        ldr     r0, [r0, #4]            @ (LinkStateId_Item = 1)
        ldr     r1, =LINK_STATE
        ldr     r1, [r1]
        cmp     r1, r0
        bne     4f
        ldr     r0, [r1, #0x14]         @ the item it holds out
        cmp     r0, #IT_BOW
        bne     4f
        add     r0, r6, r3
        bl      hd_oct                  @ world octant
        ldr     r1, =it_wait
        strb    r0, [r1, #IT_OCT]
        b       9f
        @ Holding a block: steering makes Link let go, so D-pad toward / away from the
        @ block only picks the direction for A (tap_front). Sideways still walks off.
4:      ldr     r0, =grab_on
        ldrb    r0, [r0]
        cmp     r0, #0
        beq     3f
        ldr     r0, [r4, #0x94]
        cmn     r0, #1
        beq     3f
        add     r0, r6, r3
        add     r0, r0, #0x2000
        and     r0, r0, #0xc000
        ldr     r1, =grab_h
        ldrh    r1, [r1]
        sub     r0, r0, r1
        tst     r0, #0x4000             @ same axis: diff is 0 or 0x8000
        beq     9f
3:      tst     r5, #KEY_Y
        moveq   r0, #0x5f0000           @ "stylus far away" -> run
        movne   r0, #0x060000           @ "stylus close"    -> walk
        str     r0, [r4, #0x58]
        add     r0, r6, r3
        strh    r0, [r4, #0x6a]         @ target heading (16-bit wrap is intended)
        mov     r0, #0
        strh    r0, [r4, #0x60]
        strh    r0, [r4, #0x64]
9:      pop     {r0-r6, pc}             @ r0 restored = original return value (r4)

        .balign 4
dir_table:                               @ D-pad mask, heading
        .hword  0x40, 0x8000            @ up
        .hword  0x80, 0x0000            @ down
        .hword  0x20, 0xc000            @ left
        .hword  0x10, 0x4000            @ right
        .hword  0x50, 0x6000            @ up+right
        .hword  0x90, 0x2000            @ down+right
        .hword  0x60, 0xa000            @ up+left
        .hword  0xa0, 0xe000            @ down+left

@ ---------------------------------------------------------------------------
@ Hook @ 0x020b7938 (ov0, inside the touch-controller update), replaces: strh r1, [r4, #98]
@ Caller registers: r4 = touch controller, r5 = camera, r7/r8 = touch y/x,
@ caller sp+44 = Link's position. r0-r3, r12 are dead after the hook.
@ A pressed with no D-pad: inject a stylus tap ~30px in front of Link, so the game's
@ own tap logic talks / reads / picks up / opens. Sets r8/r7 to the fake tap point.
        .global tap_front
tap_front:
        push    {r4-r6, lr}             @ 16 bytes
        strh    r1, [r4, #98]
        sub     sp, sp, #FRAME          @ [sp]=5th arg, [sp+8]=x out, [sp+12]=y out, [sp+16]=vec
.ifdef DEBUGLOG
        ldr     r2, =dbg_ctl            @ expose the touch controller to the RAM logger
        str     r4, [r2]
        ldr     r2, =dbg_gated          @ player control running while the game ignores buttons
        ldrb    r0, [r2]
        cmp     r0, #0
        beq     1f
        ldr     r0, =MODE
        ldr     r0, [r0]
        cmp     r0, #95
        movhi   r0, #95
        ldr     r2, =dbg_modes
        ldrb    r1, [r2, r0]
        orr     r1, r1, #4
        strb    r1, [r2, r0]
1:
.endif
        @ Text box handling (msg_guard is re-armed by dialog_advance each logic frame a
        @ text box is up, and dialog_advance runs before us in the same frame):
        @   guard == MAX : box is up now -> A/B taps the text box (like a stylus user)
        @   0 < guard < MAX : box just closed -> no tap, so we don't re-talk
        ldr     r2, =msg_guard
        ldrb    r0, [r2]
        cmp     r0, #0
        beq     3f
        sub     r1, r0, #1
        strb    r1, [r2]
        ldr     r1, [r4, #0x94]         @ the object we talked to / read stays in +0x94 after the
        ldr     r2, =talk_id            @ box closes, so remember it: it's not a block we hold
        str     r1, [r2]
        ldr     r2, =probe_state        @ a text box opened: probing is done
        mov     r1, #0
        strb    r1, [r2]
        ldr     r2, =carrying           @ and it was a sign/person, not a lift
        strb    r1, [r2]
        cmp     r0, #MSG_GUARD_FRAMES
        bne     9f
        ldr     r2, =PAD
        ldrh    r0, [r2, #2]
        tst     r0, #(KEY_A | KEY_B)
        beq     9f
        mov     r8, #TEXTBOX_X
        mov     r7, #TEXTBOX_Y
        b       inject
3:      ldr     r2, =aim_hold       @ age the remembered D-pad direction
        ldrb    r0, [r2]            @ (not while it holds the direction of a block let go of)
        cmp     r0, #0
        ldr     r2, =last_oct
        ldrb    r0, [r2, #DIR_AGE]
        bne     30f
        cmp     r0, #255
        addlo   r0, r0, #1
        strblo  r0, [r2, #DIR_AGE]
30:
        @ --- block grabbing ---
        @ While Link holds a push block, touch controller +0x94 = the block's object id (else -1;
        @ +0x98 varies), and the game shows tap arrows on both sides of the block. +0x6a then
        @ still holds the heading of the tap that grabbed it (toward the block).
        @ After talking to an NPC (or reading a sign) +0x94 = that object until Link walks off,
        @ so skip the object a text box came from (talk_id), or D-pad toward/away gets locked.
        ldr     r0, [r4, #0x94]
        ldr     r1, =talk_id
        cmn     r0, #1
        streq   r0, [r1]                @ target gone: forget the talk object
        beq     no_grab
        ldr     r1, [r1]
        cmp     r0, r1
        beq     no_grab
        ldr     r1, =carrying           @ not while carrying something we lifted
        ldrb    r0, [r1]
        ldrb    r1, [r4, #0x82]
        orrs    r0, r0, r1
        bne     no_grab
        bl      held_obj                @ nor while Link holds an object (a Force Gem picked up
        cmp     r0, #0                  @   leaves +0x94 = the gem, and the D-pad got locked)
        bne     no_grab
        ldr     r2, =probe_state        @ no follow-up probes while holding a block
        mov     r0, #0
        strb    r0, [r2]
        ldr     r2, =PAD
        ldrh    r3, [r2]                @ held keys
        ldr     r1, =grab_on
        ldrb    r0, [r1]
        cmp     r0, #0
        bne     32f
        @ first frame holding it: latch the block direction (world heading, snapped to 90deg).
        @ After one of our arrow taps (the grab can drop for a moment while the block moves)
        @ keep the old one: a pull tap's heading points away from the block.
        tst     r3, #DPAD               @ +0x6a is the D-pad heading while steering
        bne     9f
        mov     r0, #1
        strb    r0, [r1]
        ldr     r1, =arrow_sent
        ldrb    r0, [r1]
        cmp     r0, #0
        bne     32f
        ldrh    r0, [r4, #0x6a]
        add     r0, r0, #0x2000
        and     r0, r0, #0xc000
        ldr     r1, =grab_h
        strh    r0, [r1]
32:     ldrh    r0, [r2, #2]
        tst     r0, #KEY_A
        beq     9f                      @ holding: A is the only thing we handle
        @ A: tap the arrow in the D-pad direction (held now, or pressed within DIR_FRESH);
        @ with no recent D-pad, push. Toward the block = push, away = pull, sideways = nothing.
        ldr     r6, =grab_h
        ldrh    r6, [r6]
        ldr     r2, =last_oct
        ldrb    r0, [r2, #DIR_AGE]
        tst     r3, #DPAD
        movne   r0, #0
        cmp     r0, #DIR_FRESH
        movhs   r1, r6
        bhs     33f
        ldrb    r0, [r2]                @ screen octant -> world heading, snapped
        add     r1, r5, #0x200
        ldrsh   r1, [r1, #0x26]         @ camera yaw
        add     r1, r1, r0, lsl #13
        add     r1, r1, #0x2000
        and     r1, r1, #0xc000
33:     sub     r0, r1, r6
        movs    r0, r0, lsl #16
        ldreq   r2, =PUSH_DIST
        beq     34f
        cmp     r0, #0x80000000
        bne     9f
        ldr     r2, =PULL_DIST
34:     ldr     r1, =arrow_sent
        mov     r0, #1
        strb    r0, [r1]
        add     r3, sp, #(FRAME + 16 + 44)   @ caller's sp+44 = Link's position (x, y, z)
        ldr     r0, [r3]
        ldr     r1, [r3, #4]
        ldr     r3, [r3, #8]
        add     r1, r1, #ARROW_H
        str     r1, [sp, #20]
        cmp     r6, #0x8000             @ heading 0 = +z (screen down), 0x4000 = +x (right),
        rsbhs   r2, r2, #0              @ 0x8000 = -z, 0xc000 = -x
        tst     r6, #0x4000
        addne   r0, r0, r2
        addeq   r3, r3, r2
        str     r0, [sp, #16]
        str     r3, [sp, #24]
        mov     r0, #0
        str     r0, [sp]
        mov     r0, r5
        add     r1, sp, #16
        add     r2, sp, #8
        add     r3, sp, #12
        bl      ScreenFromWorld
        ldrh    r8, [sp, #8]
        ldrh    r7, [sp, #12]
        b       inject
no_grab:
        ldr     r1, =grab_on
        ldrb    r0, [r1]
        cmp     r0, #0
        beq     35f
        mov     r0, #0                  @ just let go: aim the next A back at the block
        strb    r0, [r1]                @ (until the D-pad is used), so it grabs it again
        ldr     r2, =grab_h
        ldrh    r0, [r2]
        add     r1, r5, #0x200
        ldrsh   r1, [r1, #0x26]
        sub     r0, r0, r1
        bl      hd_oct
        ldr     r2, =last_oct
        strb    r0, [r2]
        mov     r0, #0
        strb    r0, [r2, #DIR_AGE]
        ldr     r2, =aim_hold
        mov     r0, #1
        strb    r0, [r2]
35:     ldr     r2, =PAD
        ldrh    r0, [r2]
        tst     r0, #DPAD
        beq     36f
        ldrh    r0, [r2, #2]            @ moving: no probes, cancel any probing; but A while
        tst     r0, #KEY_A              @   carrying = the throw tap (a stylus tap throws
        beq     stop_probe              @   while running too), aimed the D-pad way
        bl      held_obj
        cmp     r0, #0
        beq     stop_probe
        b       start_probe
36:     ldrh    r0, [r2, #2]
        tst     r0, #KEY_A
        bne     start_probe
        @ --- follow-up probes for an earlier A press ---
        ldr     r2, =probe_state
        ldrb    r0, [r2]
        cmp     r0, #0
        beq     9f
.ifdef DEBUGLOG
        bl      dbg_flags
.endif
        ldrb    r1, [r4, #0x81]         @ did the last tap hit something?
        cmp     r1, #0                  @   +0x81 target set, +0x82 liftable/readable
        bne     stop_probe              @   under the tap, +0x84 talk target
        ldrb    r1, [r4, #0x82]
        cmp     r1, #0
        bne     lifted
        ldr     r1, [r4, #0x84]
        cmn     r1, #1
        bne     stop_probe
        add     r0, r0, #1
        strb    r0, [r2]
        tst     r0, #1                  @ odd states are release frames between taps,
        bne     9f                      @ so the game sees separate taps (not a drag) and
        cmp     r0, #(2 * NPROBES + 2)  @ has a frame to register a hit before the next one
        bge     stop_probe
        mov     r6, r0, lsr #1
        sub     r6, r6, #1              @ probe index = state/2 - 1
        b       do_probe
lifted:                                 @ the tap picked something up (or read a sign:
        ldr     r1, =carrying           @ the text box handler clears this again)
        mov     r0, #1
        strb    r0, [r1]
        @ Aim the throw the way this probe went. Without a recent D-pad, A otherwise falls
        @ back to +0x6a, the heading of the lifting tap, which sits 10px up the screen and
        @ so tilts side lifts into a diagonal throw. Held until the D-pad is used.
        ldr     r1, =probe_oct
        ldrb    r0, [r1]
        ldr     r1, =last_oct
        strb    r0, [r1]
        mov     r0, #0
        strb    r0, [r1, #DIR_AGE]       @ dir_age = 0
        ldr     r1, =aim_hold
        mov     r0, #1
        strb    r0, [r1]
        b       stop_probe
start_probe:
        ldr     r1, =arrow_sent         @ a normal A press (maybe a new grab): latch afresh
        mov     r0, #0
        strb    r0, [r1]
        bl      held_obj                @ carrying something or a bomb out?
        ldr     r1, =carrying           @ (the latch is cleared by this press)
        mov     r3, #0
        strb    r3, [r1]
        ldr     r2, =probe_state
        cmp     r0, #0
        movne   r0, #0                  @ throw: one tap straight ahead, no follow-up probes
        movne   r6, #THROW_IDX          @ (extra off-axis taps after a throw bent its direction)
        moveq   r0, #2                  @ state 2 = probe 0 sent
        moveq   r6, #0
        strb    r0, [r2]
        cmp     r6, #THROW_IDX          @ held and standing (no D-pad): set it down at
        bne     do_probe                @   Link's feet instead (run + A throws)
        ldr     r1, =PAD
        ldrh    r1, [r1]
        tst     r1, #DPAD
        moveq   r6, #DROP_IDX
do_probe:
        mov     r0, #0
        str     r0, [sp]                @ 5th argument = 0, as in the game's own call
        mov     r0, r5
        add     r1, sp, #(FRAME + 16 + 44)   @ caller's sp+44 = Link's position
        add     r2, sp, #8
        add     r3, sp, #12
        bl      ScreenFromWorld
        ldrh    r8, [sp, #8]            @ Link on screen: x
        ldrh    r7, [sp, #12]           @                 y
        ldr     r2, =last_oct
        ldrb    r0, [r2, #DIR_AGE]
        cmp     r0, #DIR_FRESH
        ldrblo  r0, [r2]                @ D-pad used recently: aim that way
        blo     4f
        ldr     r0, =CAMPTR             @ otherwise Link's heading, made screen-relative
        ldr     r0, [r0]
        bl      GetCamera
        add     r0, r0, #0x200
        ldrsh   r0, [r0, #0x26]
        ldrh    r1, [r4, #0x6a]
        cmp     r6, #DROP_IDX           @ set down: the way Link faces (+0x6a is the last tap's
        ldreq   r1, =PLAYER_ANGLE       @   heading, always up-right after a lift tap or a pickup)
        ldrheq  r1, [r1]
        sub     r0, r1, r0
        bl      hd_oct
4:      ldr     r1, =probe_oct          @ remembered for the throw if this tap lifts
        strb    r0, [r1]
        cmp     r6, #DROP_IDX
        adreq   r1, drop_table
        beq     7f
        cmp     r6, #THROW_IDX
        bne     5f
        adr     r1, throw_table
7:      add     r1, r1, r0, lsl #1
        b       6f
5:      mov     r1, #NPROBES
        mla     r0, r1, r0, r6          @ octant * NPROBES + probe
        adr     r1, probe_table
        add     r1, r1, r0, lsl #1
6:      ldrsb   r0, [r1]
        cmn     r0, #-PROBE_END         @ end of this octant's list
        beq     stop_probe
        add     r8, r8, r0
        ldrsb   r0, [r1, #1]
        add     r7, r7, r0
        b       inject
stop_probe:
        ldr     r2, =probe_state
        mov     r0, #0
        strb    r0, [r2]
        b       9f

@ r0 = nonzero if Link holds something A should throw (clobbers r1): the game's held actor
@ (gPlayer +0x3c != -1: pots, barrels, rocks, bomb-flower bombs; our carrying latch and +0x82
@ missed a bomb-flower bomb), or a bomb out (R): Link in the item state with bombs equipped.
held_obj:
        ldr     r1, =GPLAYER
        ldr     r1, [r1]
        cmp     r1, #0
        beq     1f
        ldr     r0, [r1, #0x3c]
        cmn     r0, #1
        movne   r0, #1
        bxne    lr
1:      mov     r0, #0
        ldr     r1, =ITEM_MGR
        ldr     r1, [r1]
        cmp     r1, #0
        bxeq    lr
        ldr     r1, [r1]
        cmp     r1, #IT_BOMBS
        bxne    lr
        ldr     r1, =LINK_STATES
        ldr     r1, [r1]
        cmp     r1, #0
        bxeq    lr
        ldr     r0, [r1, #4]            @ (LinkStateId_Item = 1)
        ldr     r1, =LINK_STATE
        ldr     r1, [r1]
        subs    r0, r0, r1
        moveq   r0, #1
        movne   r0, #0
        bx      lr

        .balign 4
throw_table:   @ (dx, dy) per octant for a throw: straight along the direction, no lift
               @ (up goes further so the tap clears the object held over Link's head).
               @ A tap within ~40px of Link sets a bomb down at his feet, so the sides and
               @ diagonals reach further (left/right 40 failed, 48 threw).
        .byte   0, 44, 40, 32, 60, 0, 40, -44, 0, -48, -40, -44, -60, 0, -40, 32
drop_table:    @ (dx, dy) per octant of the "set down" tap: 20px the way Link faces (a tap
               @ on Link himself, (0, -8), turned him up first, so the bomb always went down above him;
               @ up is 30: 20-24px up is still on his head and the bomb went up-right)
        .byte   0, 20, 14, 14, 20, 0, 14, -14, 0, -30, -14, -14, -20, 0, -14, 14

probe_table:   @ (dx, dy) per octant: ahead 30, 18, 42, then 30 +/- 14 sideways; all lifted 10px
               @ Octant 4 (facing up): a first tap 40px up lands on the ground behind a barrel/rock,
               @ which the game takes as a walk command (Link is blocked, or runs to a nearby exit)
               @ and which also ends probing. A stylus tap on Link's head lifts the object in front,
               @ so tap there first: 18px (stones) and 26px (top of his head; taller barrels), then
               @ 22px +/- 8 sideways (barrels slightly off-centre). Signs/Ciela targets need a tap on
               @ the object itself: one right in front sits 23-40px up, half hidden by Link's head, so
               @ 34px (just above his head) comes next, then 42/52 for people seen from below.
               @ Taps on Link himself don't start a walk, so they don't end probing early.
               @ Other octants use 5 probes and end with PROBE_END.
        .byte   0, 20, 0, 8, 0, 32, -14, 20, 14, 20, PROBE_END, 0, PROBE_END, 0   @ octant 0
        .byte   21, 11, 13, 3, 30, 20, 11, 21, 31, 1, PROBE_END, 0, PROBE_END, 0   @ octant 1
        .byte   30, -10, 18, -10, 42, -10, 30, 4, 30, -24, PROBE_END, 0, PROBE_END, 0   @ octant 2
        .byte   21, -31, 13, -23, 30, -40, 31, -21, 11, -41, PROBE_END, 0, PROBE_END, 0   @ octant 3
        .byte   0, -18, 0, -26, -8, -22, 8, -22, 0, -34, 0, -42, 0, -52   @ octant 4
        .byte   -21, -31, -13, -23, -30, -40, -11, -41, -31, -21, PROBE_END, 0, PROBE_END, 0   @ octant 5
        .byte   -30, -10, -18, -10, -42, -10, -30, -24, -30, 4, PROBE_END, 0, PROBE_END, 0   @ octant 6
        .byte   -21, 11, -13, 3, -30, 20, -31, 1, -11, 21, PROBE_END, 0, PROBE_END, 0   @ octant 7

inject:
.ifdef DEBUGLOG
        bl      dbg_tap
.endif
        ldr     r6, =TOUCH
        mov     r1, #1
        str     r1, [r6]
        str     r8, [r6, #4]
        str     r7, [r6, #8]
        strb    r1, [r4, #12]
        str     r8, [r4, #16]
        str     r7, [r4, #20]
        mov     r0, r4
        mov     r1, #2
        bl      TouchCtl_Begin
9:      add     sp, sp, #FRAME
        pop     {r4-r6, pc}

@ ---------------------------------------------------------------------------
@ Hook @ 0x020aec04 (ov0), replaces: bl RollGesture   -> returns nonzero to roll
@ A newly pressed while the D-pad is held = roll.
        .global roll_check
roll_check:
        push    {r4, lr}
        bl      RollGesture
        ldr     r1, =PAD
        ldrh    r2, [r1, #2]
        tst     r2, #KEY_A
        ldrhne  r2, [r1]
        tstne   r2, #DPAD
        ldrne   r2, =grab_on            @ holding a block: D-pad + A moves it instead
        ldrbne  r2, [r2]
        cmpne   r2, #1
        movne   r0, #1
        pop     {r4, pc}

@ ---------------------------------------------------------------------------
@ Hook @ 0x020b0d74 (ov0, "no slash" return path), replaces: mov r0, #0
@ r5 = out slash type. B = wide slash (2), B + D-pad = long slash (3).
@ r7 = touch controller: no slash while its +0x7c (player takes stylus input) or +0x7d
@ (set by the game each frame, 0 in modes 55/59, the wall map) is 0, so B can't slash
@ where the stylus can't: under the wall map (+0x7c was 1 for a few frames while it opens)
@ and while a text box is up (the wall map's text left Link free to swing).
        .global slash_check
slash_check:
        ldrh    r1, [r7, #0x7c]
        ldr     r0, =PAD
        tst     r1, #0xff
        tstne   r1, #0xff00
        ldrhne  r1, [r0, #2]
        tstne   r1, #KEY_B
        moveq   r0, #0
        bxeq    lr
        ldrh    r1, [r0]
        tst     r1, #DPAD
        moveq   r1, #2
        movne   r1, #3
        str     r1, [r5]
        mov     r0, #1
        bx      lr

@ ---------------------------------------------------------------------------
@ Hook @ 0x020a9480 (ov0, spin-gesture check), replaces: strb r1, [r0, #4]
@ Sits inside a chain of conditional compares, so flags and r1-r3 MUST survive
@ (v1 bug: clobbered flags and used a 32-bit store). Y+B held = spin attack, only while
@ the touch controller's +0x7c and +0x7d are both nonzero (as slash_check: not under the
@ wall map or its text box).
        .global spin_check
spin_check:
        push    {r1, r2, lr}
        mrs     r2, cpsr
        push    {r2}
        strb    r1, [r0, #4]
        ldr     r1, =PAD
        ldrh    r1, [r1]
        tst     r1, #KEY_B
        tstne   r1, #KEY_Y
        ldrne   r1, =TOUCH_CTL
        ldrne   r1, [r1]
        cmpne   r1, #0
        ldrhne  r1, [r1, #0x7c]
        tstne   r1, #0xff
        tstne   r1, #0xff00
        movne   r1, #1
        strbne  r1, [r0, #4]
        pop     {r2}
        msr     cpsr_f, r2
        pop     {r1, r2, pc}

.ifdef DEBUGLOG
@ ---------------------------------------------------------------------------
@ Diagnostic build only (DEBUGLOG): ring of the last 16 injected taps, read over
@ RetroArch network commands by ralog.py. Entry (8 bytes):
@   [0] probe_state when sent (2,4,..) or 0xEE = text-box tap
@   [1..3] +0x81, +0x82, low byte of +0x84 seen on the following frames (0xFF = not checked)
@   [4] x (s16), [6] y (s16)
dbg_tap:                                @ at inject: r8/r7 = tap point; clobbers r0-r3, r12
        ldr     r12, =dbg_seq
        ldr     r3, [r12]
        add     r0, r3, #1
        str     r0, [r12]
        and     r3, r3, #15
        add     r12, r12, #4
        add     r12, r12, r3, lsl #3
        ldr     r1, =probe_state
        ldrb    r1, [r1]
        ldr     r0, =msg_guard
        ldrb    r0, [r0]
        cmp     r0, #0
        movne   r1, #0xee
        strb    r1, [r12]
        mov     r1, #0xff
        strb    r1, [r12, #1]
        strb    r1, [r12, #2]
        strb    r1, [r12, #3]
        strh    r8, [r12, #4]
        strh    r7, [r12, #6]
        bx      lr
dbg_flags:                              @ before the hit test; keeps r0, r2
        ldr     r12, =dbg_seq
        ldr     r3, [r12]
        sub     r3, r3, #1
        and     r3, r3, #15
        add     r12, r12, #4
        add     r12, r12, r3, lsl #3
        ldrb    r1, [r4, #0x81]
        strb    r1, [r12, #1]
        ldrb    r1, [r4, #0x82]
        strb    r1, [r12, #2]
        ldr     r1, [r4, #0x84]
        strb    r1, [r12, #3]
        bx      lr
dbg_gate:                               @ r0 = InputGate result; keeps r0, r2. dbg_modes[mode]:
        ldr     r12, =dbg_gated         @   bit0 seen open, bit1 seen gated,
        strb    r0, [r12]               @   bit2 tap_front ran while gated (ragate.py)
        ldr     r1, =MODE
        ldr     r1, [r1]
        cmp     r1, #95
        movhi   r1, #95
        ldr     r12, =dbg_modes
        ldrb    r3, [r12, r1]
        cmp     r0, #0
        orreq   r3, r3, #1
        orrne   r3, r3, #2
        strb    r3, [r12, r1]
        bx      lr
.endif

        .pool

        .balign 4
msg_guard:
        .byte   0                       @ logic frames left of the text-box guard
        .balign 4, 0                    @ (zero fill: a code-section .balign pads with nop bytes)
talk_id:
        .word   -1                      @ touch ctl +0x94 seen while a text box was up (-1 = none)
last_oct:
        .byte   0                       @ last D-pad octant
dir_age:
        .byte   255                     @ logic frames since the D-pad was last held
        chk_off DIR_AGE, dir_age, last_oct
probe_state:
        .byte   0
carrying:
        .byte   0                       @ 1 after one of our taps lifted something
grab_on:
        .byte   0                       @ 1 while holding a push block (grab_h latched)
aim_hold:
        .byte   0                       @ 1: last_oct = block just let go of; don't age it
grab_h:
        .hword  0                       @ world heading toward the held block (0/0x4000/0x8000/0xc000)
arrow_sent:
        .byte   0                       @ 1 after we tapped a block arrow
probe_oct:
        .byte   0                       @ octant of the last tap sent by do_probe
held_real:
        .hword  0                       @ held keys as read (PAD+0 is zeroed while gated)
menu_tap:
        .byte   0                       @ frames left of a page-arrow tap,
mt_x:   .byte   0                       @   its x,
mt_y:   .byte   PAGE_ARROW_Y            @   its y
        chk_off MT_X, mt_x, menu_tap
        chk_off MT_Y, mt_y, menu_tap
ch_tap:
        .byte   CH_OFF                  @ menu stylus (all touch menus): phase,
ch_left:
        .byte   0                       @   updates left,
ch_x:   .byte   0                       @   x,
ch_y:   .byte   0                       @   y
        chk_off CT_LEFT, ch_left, ch_tap
        chk_off CT_X, ch_x, ch_tap
        chk_off CT_Y, ch_y, ch_tap
        .balign 4
msgwin:
        .word   0                       @ text box seen by dialog_advance
ch_seen:
        .byte   0                       @ (msgwin + 4) pad reads it stays valid
ch_auto:
        .byte   0                       @ (msgwin + 5) 0 = bubbles new, else A-lock reads left + 1
ch_queue:
        .byte   0                       @ (msgwin + 6) key pressed while the choice stylus moved
        chk_off MW_SEEN, ch_seen, msgwin
        chk_off MW_AUTO, ch_auto, msgwin
        chk_off MW_QUEUE, ch_queue, msgwin
        .balign 4
smenu:
        .word   0, 0, 0                 @ save menu buttons seen by smenu_btn (index 0-2, 0 = hidden)
sm_offy:
        .hword  0                       @ (smenu + 12) y offset the game hit-tests them with
sm_seen:
        .byte   0                       @ (smenu + 14) pad reads the buttons stay valid
sm_sel:
        .byte   0                       @ (smenu + 15) index of the button held by our stylus
sm_auto:
        .byte   0                       @ (smenu + 16) 0 = menu new, else A-lock reads left + 1
sm_queue:
        .byte   0                       @ (smenu + 17) key pressed while the stylus moved
        chk_off SM_OFFY, sm_offy, smenu
        chk_off SM_SEEN, sm_seen, smenu
        chk_off SM_SEL, sm_sel, smenu
        chk_off SM_AUTO, sm_auto, smenu
        chk_off SM_QUEUE, sm_queue, smenu
        .balign 4
fs_cur:
        .word   0                       @ fs_specs entry of the file select screen seen last
fs_sel:
        .byte   0                       @ (fs_cur + 4) selected entry / options row
fs_frame:
        .byte   0                       @ pad read counter, 1..255
        chk_off FS_SEL, fs_sel, fs_cur
        .balign 4
sh_last:
        .byte   0xff                    @ shop item shown last (0xff = none)
sh_next:
        .byte   0xff                    @ (sh_last + 1) item to open once the table is back
sh_auto:
        .byte   0                       @ (sh_last + 2) 0 = item view new, else A-lock reads left + 1
sh_queue:
        .byte   0                       @ (sh_last + 3) key kept while the stylus moved / view busy
sh_held:
        .byte   0                       @ (sh_last + 4) button the stylus holds: 0 Buy, 1 Quit
sh_lslot:
        .byte   0xff                    @ (sh_last + 5) item lifted by sh_lift (0xff = none)
        .byte   0, 0                    @ (pad: sh_ly is a word; sh_last is word aligned, so a
                                        @   .balign here would stop chk_off reading sh_ly - sh_last)
sh_ly:
        .word   0                       @ (sh_last + 8) its lifted home y
        chk_off SH_NEXT, sh_next, sh_last
        chk_off SH_AUTO, sh_auto, sh_last
        chk_off SH_QUEUE, sh_queue, sh_last
        chk_off SH_HELD, sh_held, sh_last
        chk_off SH_LSLOT, sh_lslot, sh_last
        chk_off SH_LY, sh_ly, sh_last
cl_sel:
        .byte   0, 0, 0, 0, 0, 0, 0     @ last slot held per tab (Ship Parts, Treasure, shipyard
                                        @   Customize, merchant Ship Parts, merchant Treasure,
                                        @   magic box Ship Parts, magic box Treasure)
cl_lock:
        .byte   0                       @ (cl_sel + 7) Sell / Stow held in this view (SH_BTN_Y / MB_STOW_Y)
cl_key:
        .byte   0                       @ (cl_sel + 8) key pressed while the slot stylus moved
cl_back:
        .byte   0                       @ (cl_sel + 9) 1 = an entry was shown: hold its slot again
cl_pass:
        .hword  0                       @ (cl_sel + 10) other keys waiting for the stylus to let go
cl_tgt:
        .byte   0xff                    @ (cl_sel + 12) parts-list row Up/Down is bringing up (0xff = none)
        chk_off CL_LOCK, cl_lock, cl_sel
        chk_off CL_KEY, cl_key, cl_sel
        chk_off CL_BACK, cl_back, cl_sel
        chk_off CL_PASS, cl_pass, cl_sel
        chk_off CL_TGT, cl_tgt, cl_sel
        .balign 4
ip_sel:
        .byte   0xff, 0xff              @ Items page: item held last per half (spirits, hourglass)
ip_key:
        .byte   0                       @ (ip_sel + 2) D-pad key pressed while the stylus moved or
                                        @   while no item could be touched (screens sliding)
ip_own:
        .byte   0                       @ (ip_sel + 3) 1 = ch_tap is ip_ctl's
ip_pass:
        .hword  0                       @ (ip_sel + 4) other keys waiting for the stylus to let go
ip_pend:
        .byte   0                       @ (ip_sel + 6) page arrow (Left / Right) after the swap back
ip_pwait:
        .byte   0                       @ (ip_sel + 7) pad reads ip_pend may still wait
        chk_off IP_KEY, ip_key, ip_sel
        chk_off IP_OWN, ip_own, ip_sel
        chk_off IP_PASS, ip_pass, ip_sel
        chk_off IP_PEND, ip_pend, ip_sel
        chk_off IP_PWAIT, ip_pwait, ip_sel
        .balign 2
it_wait:
        .byte   0                       @ pad reads left to wait for the item R took out (0 = none)
it_ok:
        .byte   0                       @ (it_wait + 1) unused since v2.1.36-wip2 (was: pad reads it has been out)
it_oct:
        .byte   0xff                    @ (it_wait + 2) world octant of the last use tap (0xff = none)
it_put:
        .byte   0                       @ (it_wait + 3) pad reads left to wait for Put Away to finish
        chk_off IT_OK, it_ok, it_wait
        chk_off IT_OCT, it_oct, it_wait
        chk_off IT_PUT, it_put, it_wait
        .balign 4
ib_sel:
        .byte   0, 0                    @ item bar: place held by the stylus, 1 = a move (short lift)
ib_key:
        .hword  0                       @ (ib_sel + 2) key pressed while the stylus moved
ib_pass:
        .hword  0                       @ (ib_sel + 4) other keys waiting for the stylus to let go
        chk_off IB_KEY, ib_key, ib_sel
        chk_off IB_PASS, ib_pass, ib_sel
        .balign 4
sy_sel:
        .byte   0                       @ shipyard main menu: button held last (1 Customize, 2 View
                                        @   Ship, 0 = none)
sy_auto:
        .byte   0                       @ (sy_sel + 1) 0 = menu new, else A-lock reads left + 1
sy_key:
        .hword  0                       @ (sy_sel + 2) key kept while the stylus moved / let go
        chk_off SY_AUTO, sy_auto, sy_sel
        chk_off IB_KEY, sy_key, sy_sel
        .balign 4
mb_sel:
        .byte   0                       @ menu bar: button held by the stylus (place + 1, 0 = none)
mb_screen:
        .byte   0                       @ (mb_sel + 1) 1 = a screen was opened from the bar (wait
                                        @   until it closed)
mb_key:
        .hword  0                       @ (mb_sel + 2) key kept while the stylus moved / let go
        chk_off MB_SCREEN, mb_screen, mb_sel
        chk_off MB_KEY, mb_key, mb_sel
ab_pend:
        .byte   0                       @ pad reads an A / B press (text box up) waits for dialog_advance
        .balign 4, 0
gate_pad:
        .word   0                       @ PAD +0 / +2 of the last ungated read, Link free on land (gate_carry)
fg_mode:
        .byte   0                       @ fishing stylus: 0 up, FG_PULL, FG_REEL, FG_SALV
fg_step:
        .byte   0                       @ (fg_mode + 1) pad reads into it
fg_x:   .byte   0                       @ (fg_mode + 2) point this read, 0 = up
fg_y:   .byte   0                       @ (fg_mode + 3)
fg_dx:  .byte   0                       @ (fg_mode + 4) slide x step (signed): 0 S, -6 SW, 6 SE;
                                        @   Salvage Arm: 1 = A centring the handle; fog steering:
                                        @   stylus x - 128
fg_wait:
        .byte   0                       @ (fg_mode + 5) fog steering: reads to stay up | WH_DOWN
fg_pend:
        .byte   0                       @ (fg_mode + 6) fog steering: Up / Down kept for the next read
fg_hk:
        .byte   0                       @ (fg_mode + 7) grappling hook line length (hk_hold), 0 = not the hook
        chk_off FGD_HK, fg_hk, fg_mode
        chk_off FGD_STEP, fg_step, fg_mode
        chk_off FGD_WAIT, fg_wait, fg_mode
        chk_off FGD_PEND, fg_pend, fg_mode
        chk_off FGD_X, fg_x, fg_mode
        chk_off FGD_Y, fg_y, fg_mode
        chk_off FGD_DX, fg_dx, fg_mode
        .balign 4, 0
sc_sel:
        .byte   0                       @ Sea Chart screen: sea held by the stylus (place + 1, 0 = none)
sc_screen:
        .byte   0                       @ (sc_sel + 1) 1 = chosen / B / the real stylus: wait until
                                        @   the screen closed
sc_key:
        .hword  0                       @ (sc_sel + 2) key kept while the stylus moved / let go
sc_last:
        .byte   0                       @ (sc_sel + 4) object chosen last (place: NW, NE, SW, SE;
                                        @   4 + island)
        chk_off SC_SCREEN, sc_screen, sc_sel
        chk_off SC_KEY, sc_key, sc_sel
        chk_off SC_LAST, sc_last, sc_sel
sc_tab:
        .space  4 * 4                   @ per sea (place): x, y, fs_frame when last updated, -
is_tab:
        .space  4 * IS_COUNT            @ per island button (id - IS_ID0): the same; x = 0: not
                                        @   seen on this screen (cleared when it closes)
bk_tab:
        .byte   0, 0, 0, 0              @ Back button: x, y, fs_frame when last updated, -
sk_tab:
        .byte   0, 0, 0, 0              @ a cutscene's Skip button: the same
gr_tab:
        .byte   0, 0, 0, 0              @ the Goron Temple's swap button: the same
sy_tab:
        .byte   0, 0, 0, 0              @ shipyard menu's Customize button: the same
mm_tab:
        .byte   0, 0, 0, 0              @ a map's Memo button: x, y, fs_frame, tool in use
        .byte   0, 0, 0, 0              @   and its Erase button: x, y, fs_frame, -
fl_tab:
        .space  4 * (FL_IDS + 1)        @ a dungeon map's floor list (id - FL_ID0: arrows, places),
                                        @   then its floor button: x, y, fs_frame, label cell
fl_pend:
        .byte   0, 0, 0, 0              @ Up / Down waiting: way (-1 / 1, 0 none), pad reads left,
                                        @   done (1 = button, 2 = arrow, 4 = a floor tapped), floor word at the press
st_pend:
        .byte   0, 0, 0, 0              @ statue screen: Left / Right press waiting for the statue,
                                        @   st_wait (ST_WAIT): pad reads left before a tap, -, -
fs_tab:
        .space  FS_IDS * 4              @ per button id: x, y, fs_frame when last updated, -
.ifdef DEBUGLOG
        .balign 4
dbg_ctl:
        .word   0
dbg_seq:
        .word   0
dbg_log:
        .space  16 * 8
dbg_gated:
        .word   0
dbg_modes:
        .space  96
.endif
