; Logo plotting.

.equ Logo_Width, 216
.equ Logo_Height, 68
.equ Logo_Gap, Screen_Stride-Logo_Width/Screen_PixelsPerByte
.equ Logo_Stride, Logo_Width/Screen_PixelsPerByte
.equ Logo_Bytes, Logo_Stride*Logo_Height

.equ Logo_Y_Radius, 12
.equ Logo_Centre_Left, 56
.equ Logo_Centre_Top, 14

logo_data_p:
    .long logo_data_no_adr

logo_mask_p:
    .long logo_mask_no_adr

logo_data_shifted_p:
    .long logo_data_shifted_no_adr

logo_mask_shifted_p:
    .long logo_mask_shifted_no_adr

logo_data_shift_table:
    .skip 8*4

logo_mask_shift_table:
    .skip 8*4

logo_x_rads:
    .long 0

logo_y_rads:
    .long 0

logo_x_delta:
    .long 3<<7      ; period << 8

logo_y_delta:
    .long 2<<7      ; period << 8

logo_x_radius:
    .long 20

plot_logo:
    str lr, [sp, #-4]!

    ; Update x position
    ldr r0, logo_x_rads
    ldr r1, logo_x_delta
    add r0, r0, r1
    str r0, logo_x_rads

    bl sine
    ; R0=sin(x_rads)
    ldr r8, logo_x_radius
    mul r8, r0, r8
    mov r8, r8, asr #16
    mov r1, #Logo_Centre_Left
    add r8, r8, r1

    ; Update y position
    ldr r0, logo_y_rads
    ldr r1, logo_y_delta
    add r0, r0, r1
    str r0, logo_y_rads
    bl cosine
    ; R0=cos(y_rads)
    mov r1, #Logo_Y_Radius

    mul r1, r0, r1
    mov r1, r1, asr #16
    add r1, r1, #Logo_Centre_Top

    mov r0, r8

    ; Fall through!

; R0=x
; R1=y
; R12=screen address
;plot_logo_at_xy:
    mov r10, #Logo_Height
    mov r11, r12

    .1:
    ldmia r9!, {r0-r7}      ; 8 words = 64 pixels.
    stmia r11!, {r0-r7}
    ldmia r9!, {r0-r7}      ; 8 words = 64 pixels.
    stmia r11!, {r0-r7}
    ldmia r9!, {r0-r7}      ; 8 words = 64 pixels.
    stmia r11!, {r0-r7}
    ldmia r9!, {r0-r7}      ; 8 words = 64 pixels.
    stmia r11!, {r0-r7}
    ldmia r9!, {r0-r7}      ; 8 words = 64 pixels.
    stmia r11!, {r0-r7}
    subs r10, r10, #1
    bne .1

    ldr pc, [sp], #4

.macro logo_shift_right_by_pixels
    mov r8, r8, lsl r10
    orr r8, r8, r7, lsr r11
    mov r7, r7, lsl r10
    orr r7, r7, r6, lsr r11
    mov r6, r6, lsl r10
    orr r6, r6, r5, lsr r11
    mov r5, r5, lsl r10
    orr r5, r5, r4, lsr r11
    mov r4, r4, lsl r10
    orr r4, r4, r3, lsr r11
    mov r3, r3, lsl r10
    orr r3, r3, r2, lsr r11
    mov r2, r2, lsl r10
    orr r2, r2, r1, lsr r11
    mov r1, r1, lsl r10
    orr r1, r1, r0, lsr r11
.endm

; R9=logo_addr, R12=screen_addr
; Assume plotting at top of the screen.
plot_logo_glitched:
    str lr, [sp, #-4]!
    mov r14, #Logo_Height

    .1:
    ldr r0, rnd_seed
    mov r1, #1              ; need a spare bit!
    RND R0, R1, R2
    str r0, rnd_seed

    ; Pixel offset shift.
    and r0, r0, #0x03
    mov r10, r0, lsl #2     ; pixel shift (4*n)
    rsb r11, r10, #32       ; reverse pixel shift (32-4*n)

    add r9, r9, #124        ; 4th chunk.
    add r12, r12, #128      ; 4th chunk.
    ldmia r9, {r0-r8}       ; 9 words = 68 pixels.
    logo_shift_right_by_pixels
    stmia r12, {r1-r8}      ; 8 words = 64 pixels.

    sub r9, r9, #32         ; 3rd chunk.
    sub r12, r12, #32       ; 3rd chunk.
    ldmia r9, {r0-r8}       ; 9 words = 68 pixels.
    logo_shift_right_by_pixels
    stmia r12, {r1-r8}      ; 8 words = 64 pixels.

    sub r9, r9, #32         ; 2nd chunk.
    sub r12, r12, #32       ; 2nd chunk.
    ldmia r9, {r0-r8}       ; 9 words = 68 pixels.
    logo_shift_right_by_pixels
    stmia r12, {r1-r8}      ; 8 words = 64 pixels.

    sub r9, r9, #32         ; 1st chunk.
    sub r12, r12, #32       ; 1st chunk.
    ldmia r9, {r0-r8}       ; 9 words = 68 pixels.
    logo_shift_right_by_pixels
    stmia r12, {r1-r8}      ; 8 words = 64 pixels.

    sub r9, r9, #28         ; 0th chunk.
    sub r12, r12, #32       ; 0th chunk.
    mov r0, #0
    ldmia r9, {r1-r8}       ; 9 words = 68 pixels.
    logo_shift_right_by_pixels
    stmia r12, {r1-r8}      ; 8 words = 64 pixels.

    add r9, r9, #Screen_Stride
    add r12, r12, #Screen_Stride

    subs r14, r14, #1
    bne .1

	ldr pc, [sp], #4
