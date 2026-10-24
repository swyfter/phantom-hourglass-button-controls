@ Zelda: Phantom Hourglass (US) - D-pad controls, v2
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
        .equ DPAD,     0x0f0
        .equ MSG_GUARD_FRAMES, 12       @ logic frames (game runs logic at 30 Hz)
        .equ TEXTBOX_X, 128             @ where A/B taps while a text box is up
        .equ TEXTBOX_Y, 168
        .equ TAP_LIFT, 10               @ px: lift the A-button tap from Link's feet to body height
        @ game functions are supplied by the linker (--defsym), see build_v2.py

@ ---------------------------------------------------------------------------
@ Hook @ 0x0203a474 (ARM9), replaces: ldrh r1, [r0, #52]
@ A or B newly pressed counts as a screen tap for advancing dialogue.
@ Runs every logic frame while a text box is up, so it also arms msg_guard, which
@ stops tap_front from injecting a tap (v1 bug: pressing A while facing the speaker
@ re-tapped them, restarting the conversation; the closing A press also re-triggered it).
        .global dialog_advance
dialog_advance:
        push    {r2, lr}
        ldr     r2, =msg_guard
        mov     r1, #MSG_GUARD_FRAMES
        strb    r1, [r2]
        ldrh    r1, [r0, #52]
        ldr     r2, =PAD
        ldrh    r2, [r2, #2]
        tst     r2, #(KEY_A | KEY_B)
        orrne   r1, r1, #1
        pop     {r2, pc}

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
        ldrh    r6, [r1, #2]            @ base angle
        tst     r5, #KEY_Y
        moveq   r0, #0x5f0000           @ "stylus far away" -> run
        movne   r0, #0x060000           @ "stylus close"    -> walk
        str     r0, [r4, #0x58]
        ldr     r0, =CAMPTR
        ldr     r0, [r0]
        bl      GetCamera
        add     r0, r0, #0x200
        ldrsh   r0, [r0, #0x26]         @ camera yaw
        add     r0, r6, r0
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
        sub     sp, sp, #16             @ [sp]=5th arg, [sp+8]=x out, [sp+12]=y out
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
        cmp     r0, #MSG_GUARD_FRAMES
        bne     9f
        ldr     r2, =PAD
        ldrh    r0, [r2, #2]
        tst     r0, #(KEY_A | KEY_B)
        beq     9f
        mov     r8, #TEXTBOX_X
        mov     r7, #TEXTBOX_Y
        b       inject
3:      ldr     r2, =PAD
        ldrh    r0, [r2]
        tst     r0, #DPAD
        bne     9f
        ldrh    r0, [r2, #2]
        tst     r0, #KEY_A
        beq     9f
        mov     r0, #0
        str     r0, [sp]                @ 5th argument = 0, as in the game's own call
        mov     r0, r5
        add     r1, sp, #(16 + 16 + 44) @ caller's sp+44
        add     r2, sp, #8
        add     r3, sp, #12
        bl      ScreenFromWorld
        ldrh    r8, [sp, #8]            @ x
        ldrh    r7, [sp, #12]           @ y
        ldr     r0, =CAMPTR
        ldr     r0, [r0]
        bl      GetCamera
        add     r0, r0, #0x200
        ldrsh   r0, [r0, #0x26]
        ldrh    r1, [r4, #0x6a]         @ Link's heading
        add     r1, r1, r0
        mov     r1, r1, lsl #16         @ wrap to 16 bits (v1 bug: no wrap)
        mov     r1, r1, lsr #16
        @ x offset: heading in (0, 0x8000) -> +30, (0x8000, 0x10000) -> -30
        mov     r0, #0
        cmp     r1, #0x8000
        addlo   r0, r0, #30
        subhi   r0, r0, #30
        cmp     r1, #0
        moveq   r0, #0
        add     r8, r8, r0
        @ y offset: heading < 0x4000 or > 0xc000 -> +30, between -> -30
        mov     r0, #0
        cmp     r1, #0x4000
        addlo   r0, r0, #30
        blo     1f
        beq     1f
        cmp     r1, #0xc000
        addhi   r0, r0, #30
        sublo   r0, r0, #30
1:      sub     r0, r0, #TAP_LIFT       @ aim at body height, not ground level
        add     r7, r7, r0
inject: ldr     r6, =TOUCH
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
9:      add     sp, sp, #16
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
        movne   r0, #1
        pop     {r4, pc}

@ ---------------------------------------------------------------------------
@ Hook @ 0x020b0d74 (ov0, "no slash" return path), replaces: mov r0, #0
@ r5 = out slash type. B = wide slash (2), B + D-pad = long slash (3).
        .global slash_check
slash_check:
        ldr     r0, =PAD
        ldrh    r1, [r0, #2]
        tst     r1, #KEY_B
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
@ (v1 bug: clobbered flags and used a 32-bit store). Y+B held = spin attack.
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
        movne   r1, #1
        strbne  r1, [r0, #4]
        pop     {r2}
        msr     cpsr_f, r2
        pop     {r1, r2, pc}

        .pool

        .balign 4
msg_guard:
        .word   0
