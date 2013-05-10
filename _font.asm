    ;lda #LOW(SPR_VRAM(SPRITE_START + SPRITE_SIZE * 48))
    ;lda #HIGH(SPR_VRAM(SPRITE_START + SPRITE_SIZE * 48))

    .macro getcharaddress ; param #1 = char ascii code, param 2 = where to write the address (somewhere in zp would be nice :) )
    pha
    phx

    lda \1
    sec             ; set the carry flag before a subtraction (similar to clearing it before an add, it just "works in reverse" when you sub)
    sbc #$20
    tax             ; save a copy of a in x

    ; multiply by 64 by shifting left 6 times
    ; we do it in two parts, since we will have a 16bits result
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    clc
    adc #LOW(SPRITE_START)
    sta LOW_BYTE \2

    txa
    lsr a
    lsr a
    clc
    adc #HIGH(SPRITE_START)
    sta HIGH_BYTE \2

    plx
    pla
    .endm

    .macro getcharvramaddress ; param #1 = char ascii code, param 2 = where to write the address (somewhere in zp would be nice :) )

    getcharaddress \1, \2

    ; now, shift right 5 bits to get the vram address

    ; first, shift the lower byte
    lda LOW_BYTE \2
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    sta LOW_BYTE \2

    ; then, shift the upper byte, taking into account the bits the shift to the lower byte
    lda HIGH_BYTE \2
    asl a
    asl a
    asl a
    ora LOW_BYTE \2
    sta LOW_BYTE \2

    lda HIGH_BYTE \2
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    sta HIGH_BYTE \2
    .endm


copytovram .macro
    ; setup write pointer
    st0 #$00
    lda LOW_BYTE \1
    sta $0002
    lda HIGH_BYTE \1
    sta $0003

    st0 #$02

    tia $2000, $0002, #SPRITE_SIZE
    ;tia <_composespriteoutput, $0002, #SPRITE_SIZE

    .endm
 
maketextsatb: ; <data_ptr = text, <satb_ptr = satb, <R0 = letter spacing; <R1 = X start position, <R2 = Y position // uses <R3, <R4

    lda <R1
    sta <R3
    lda <R1 + 1
    sta <R3 + 1
.satb:
    lda [data_ptr]
    lbeq .end
    sta LOW_BYTE <R4
    getcharvramaddress LOW_BYTE <R4, <vram_ptr

    ; y position
    lda <R2
    sta [satb_ptr]
    incw <satb_ptr
    lda <R2 + 1
    sta [satb_ptr]
    incw <satb_ptr

    ; x position
    clc
    lda LOW_BYTE <R3
    sta [satb_ptr]
    adc #$10
    sta LOW_BYTE <R3
    incw <satb_ptr
    lda HIGH_BYTE <R3
    sta [satb_ptr]
    adc #$00
    sta HIGH_BYTE <R3
    incw <satb_ptr

    ;lda LOW_BYTE <R3
    ;adc <R0
    ;sta LOW_BYTE <R3
    ;lda HIGH_BYTE <R3
    ;adc #$00
    ;sta HIGH_BYTE <R3

    ; sprite address in VRAM
    lda LOW_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr

    ; sprite attributes
    lda #%10000000
    sta [satb_ptr]
    incw <satb_ptr
    cla
    sta [satb_ptr]
    incw <satb_ptr

    incw <data_ptr
    
    jmp .satb

.end:

    rts
 
clearsatb:
    stz satb       ; set first byte of satb to 0
    tii satb, satb + 1, 511 ; copy this byte in the whole satb (i.e zero out the satb)

    rts


copysatbcredits:
    st0 #$00
    st1 #LOW(CREDITS_SATB_START)
    st2 #HIGH(CREDITS_SATB_START)
    st0 #$02

    tia satb, $0002, 512

    st0 #$13
    lda #LOW(CREDITS_SATB_START)
    sta $0002
    lda #HIGH(CREDITS_SATB_START)
    sta $0003

    rts


copysatb:
    st0 #$00
    st1 #LOW(SATB_START)
    st2 #HIGH(SATB_START)
    st0 #$02

    tia satb, $0002, 512

    st0 #$13
    lda #LOW(SATB_START)
    sta $0002
    lda #HIGH(SATB_START)
    sta $0003

    rts

copysatbslice: ; <R0 = offset (in items), <R1 = length (in items)
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:

    st0 #$00
    st1 #LOW(SATB_START)
    st2 #HIGH(SATB_START)
    st0 #$02

    ldx <R1
.copy:
    lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr
    lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr
     lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr
    lda [satb_ptr]
    sta $0002
    incw <satb_ptr
    lda [satb_ptr]
    sta $0003
    incw <satb_ptr

    dex
    bne .copy
     
    st0 #$13
    lda #LOW(SATB_START)
    sta $0002
    lda #HIGH(SATB_START)
    sta $0003

    rts


copytosatb: ; R0 = offset in satb (in items) / R1 = item count / data_ptr
    pha
    phx
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:

    ldx <R1
.copy:
    ; y
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; x
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; pointer
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    ; attributes
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr
    dex
    lbne .copy

    plx
    pla
    rts

    rts


getsatbx:
    incw <satb_ptr
    incw <satb_ptr
    lda [satb_ptr]
    sta LOW_BYTE <R0
    incw <satb_ptr
    lda [satb_ptr]
    sta HIGH_BYTE <R0

    rts

setsatbpalette: ; <R0 element #; <R1 palette #
    phx
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift
.aftershift:

    ; advance 3 words
    addw #6, <satb_ptr

    lda [satb_ptr]
    and #%11110000
    ora <R1
    sta [satb_ptr]

    plx
    rts



setsatbbg: ; <R0 element #; <R1 1 = foreground, 0 = background
    phx
    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    lda <R1
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    sta <R1

    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift
.aftershift:

    ; advance 3 words
    addw #6, <satb_ptr

    lda [satb_ptr]
    and #%01111111
    ora <R1
    sta [satb_ptr]

    plx
    rts



defragmentsatb: ; <satb_ptr = where to copy, <R0 = items to overwrite, <R1 = offset
    phx
    lda LOW_BYTE <satb_ptr
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <satb_ptr
    sta HIGH_BYTE <data_ptr


    ldx <R0
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <data_ptr
    dex
    bra .shift
.aftershift:

    ; copy from <data_ptr to 512 in <satb_ptr
    ; copy length = 512 - offset + count * item_size
    addw <R1, <R0
 
    stz <R4
    stz <R4 + 1

    ldx <R0
.add:
    beq .afteradd
    addw #SATB_ITEM_SIZE, <R4
    dex
    bra .add
.afteradd:

    lda #LOW(512)
    sta LOW_BYTE <R3
    lda #HIGH(512)
    sta HIGH_BYTE <R3

    subw <R4, <R3

    ; <R3 = byte count to copy
.copy:
    lda [data_ptr]
    sta [satb_ptr]
    incw <data_ptr
    incw <satb_ptr

    decw <R3
    cmpw #0, <R3
    bne .copy

    plx
    rts


writesatbitem: ; <satb_ptr = where to write, <R0 = x, <R1 = y, <vram_ptr = pixels
    ; y position
    lda LOW_BYTE <R1
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <R1
    sta [satb_ptr]
    incw <satb_ptr

    ; x position
    lda LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr

    ; sprite address in VRAM
    lda LOW_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr
    lda HIGH_BYTE <vram_ptr
    sta [satb_ptr]
    incw <satb_ptr

    ; sprite attributes
    lda #%10000000
    sta [satb_ptr]
    incw <satb_ptr
    cla
    sta [satb_ptr]
    incw <satb_ptr

    rts


satbshiftx: ; <R3 = which item to begin with, <R0 = amount, <R1 = 1 increment, 0 decrement, <R2 item count
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:


    incw <satb_ptr ; advance the pointer to the x coordinate slot
    incw <satb_ptr ; advance the pointer to the x coordinate slot

    ldx <R2
.loop:
    lda <R1
    beq .decrement
.increment:
    clc
    lda [satb_ptr]
    adc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    adc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    bra .end
.decrement:
    sec
    lda [satb_ptr]
    sbc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    sbc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
 

.end:
    addw #6, <satb_ptr

    dex
    bne .loop

    plx
    pla
    rts

setsatby: ; <R3 = item to begin with, <R0 = value
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:
    lda <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda <R0 + 1
    sta [satb_ptr]

    plx
    pla
    rts

setsatbx: ; <R3 = item to begin with, <R0 = value
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    incw <satb_ptr
    incw <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:
    lda <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda <R0 + 1
    sta [satb_ptr]

    plx
    pla
    rts


satbshifty: ; <R3 = which item to begin with, <R0 = amount, <R1 = 1 increment, 0 decrement, <R2 item count
    pha
    phx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    ldx <R3
.shift:
    beq .aftershift
    addw #SATB_ITEM_SIZE, <satb_ptr
    dex
    jmp .shift

.aftershift:


    ldx <R2
.loop:
    lda <R1
    beq .decrement
.increment:
    clc
    lda [satb_ptr]
    adc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    adc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    bra .end
.decrement:
    sec
    lda [satb_ptr]
    sbc LOW_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
    lda [satb_ptr]
    sbc HIGH_BYTE <R0
    sta [satb_ptr]
    incw <satb_ptr
 

.end:
    addw #6, <satb_ptr

    dex
    bne .loop

    plx
    pla
    rts




loadfirefont .macro
    lda #bank(font02)
    tam #page(font02)

    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #firefontpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefontpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #LOW(SPRITE_START + SPRITE_SIZE *  0)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  0)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont3     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont3     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite                                          ; SPACE 

    lda #LOW(SPRITE_START + SPRITE_SIZE * 16)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 16)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont4    ; 0
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont4    ; 0
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 17)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 17)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont5    ; 1
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont5    ; 1
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 18)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 18)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont6    ; 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont6    ; 2
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 19)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 19)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont7    ; 3
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont7    ; 3
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 20)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 20)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont8    ; 4
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont8    ; 4
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 21)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 21)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont9    ; 5
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont9    ; 5
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 22)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 22)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont10    ; 6
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont10    ; 6
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 23)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 23)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont11    ; 7
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont11    ; 7
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 24)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 24)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont12    ; 8
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont12    ; 8
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 25)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 25)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont13    ; 9
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont13    ; 9
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 33)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 33)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont14    ; A
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont14    ; A
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 34)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 34)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont15    ; B
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont15    ; B
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 35)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 35)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont16    ; C
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont16    ; C
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 36)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 36)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont17    ; D
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont17    ; D
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 37)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 37)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont18    ; E
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont18    ; E
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 38)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 38)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont19    ; F
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont19    ; F
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 39)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 39)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont20    ; G
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont20    ; G
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 40)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 40)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont21    ; H
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont21    ; H
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 41)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 41)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont22    ; I
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont22    ; I
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 42)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 42)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont23    ; J
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont23    ; J
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 43)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 43)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont24    ; K
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont24    ; K
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 44)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 44)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont25    ; L
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont25    ; L
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 45)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 45)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont26    ; M
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont26    ; M
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 46)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 46)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont27    ; N
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont27    ; N
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 47)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 47)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont28    ; O
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont28    ; O
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 48)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 48)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont29    ; P
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont29    ; P
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 49)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 49)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont30    ; Q
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont30    ; Q
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 50)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 50)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont31    ; R
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont31    ; R
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 51)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 51)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont32    ; S
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont32    ; S
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 52)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 52)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont33    ; T
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont33    ; T
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 53)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 53)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont34    ; U
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont34    ; U
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 54)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 54)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont35    ; V
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont35    ; V
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 55)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 55)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont36    ; W
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont36    ; W
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 56)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 56)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont37    ; X
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont37    ; X
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 57)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 57)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont38    ; Y
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont38    ; Y
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 58)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 58)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #firefont39    ; Z
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #firefont39    ; Z
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    .endm

loadasteroidfont .macro
    lda #bank(fontasteroids)
    tam #page(fontasteroids)

    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #fontasteroidspalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroidspalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette



    lda #LOW(SPRITE_START + SPRITE_SIZE *  0)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  0)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids3     ; SPACE
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids3     ; SPACE
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE *  1)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  1)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids1     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids1     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; !
 
    lda #LOW(SPRITE_START + SPRITE_SIZE * 16)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 16)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids4    ; 0
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids4    ; 0
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 17)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 17)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids5    ; 1
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids5    ; 1
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 18)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 18)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids6    ; 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids6    ; 2
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 19)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 19)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids7    ; 3
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids7    ; 3
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 20)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 20)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids8    ; 4
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids8    ; 4
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 21)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 21)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids9    ; 5
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids9    ; 5
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 22)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 22)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids10    ; 6
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids10    ; 6
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 23)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 23)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids11    ; 7
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids11    ; 7
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 24)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 24)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids12    ; 8
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids12    ; 8
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 25)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 25)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids13    ; 9
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids13    ; 9
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 33)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 33)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids14    ; A
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids14    ; A
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 34)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 34)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids15    ; B
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids15    ; B
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 35)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 35)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids16    ; C
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids16    ; C
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 36)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 36)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids17    ; D
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids17    ; D
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 37)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 37)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids18    ; E
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids18    ; E
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 38)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 38)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids19    ; F
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids19    ; F
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 39)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 39)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids20    ; G
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids20    ; G
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 40)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 40)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids21    ; H
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids21    ; H
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 41)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 41)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids22    ; I
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids22    ; I
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 42)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 42)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids23    ; J
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids23    ; J
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 43)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 43)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids24    ; K
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids24    ; K
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 44)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 44)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids25    ; L
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids25    ; L
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 45)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 45)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids26    ; M
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids26    ; M
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 46)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 46)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids27    ; N
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids27    ; N
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 47)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 47)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids28    ; O
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids28    ; O
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 48)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 48)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids29    ; P
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids29    ; P
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 49)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 49)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids30    ; Q
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids30    ; Q
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 50)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 50)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids31    ; R
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids31    ; R
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 51)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 51)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids32    ; S
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids32    ; S
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 52)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 52)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids33    ; T
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids33    ; T
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 53)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 53)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids34    ; U
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids34    ; U
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 54)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 54)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids35    ; V
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids35    ; V
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 55)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 55)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids36    ; W
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids36    ; W
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 56)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 56)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids37    ; X
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids37    ; X
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 57)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 57)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids38    ; Y
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids38    ; Y
    sta HIGH_BYTE <data_ptr
    jsr loadsprite

    lda #LOW(SPRITE_START + SPRITE_SIZE * 58)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 58)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontasteroids39    ; Z
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontasteroids39    ; Z
    sta HIGH_BYTE <data_ptr
    jsr loadsprite



    .endm

