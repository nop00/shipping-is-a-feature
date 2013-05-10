greets_load:

    loadasteroidfont

    lda #bank(greets_data)
    tam #page(greets_data)

    ; create a table pointing to each greet text
    clx
    lda LOW_BYTE #greetee01
    sta greetees, x
    inx
    lda HIGH_BYTE #greetee01
    sta greetees, x
    inx

    lda LOW_BYTE #greetee02
    sta greetees, x
    inx
    lda HIGH_BYTE #greetee02
    sta greetees, x
    inx

    lda LOW_BYTE #greetee03
    sta greetees, x
    inx
    lda HIGH_BYTE #greetee03
    sta greetees, x
    inx

    lda LOW_BYTE #greetee04
    sta greetees, x
    inx
    lda HIGH_BYTE #greetee04
    sta greetees, x
    inx

    lda #LOW(greetee05)
    sta greetees, x
    inx
    lda #HIGH(greetee05)
    sta greetees, x
    inx

    lda #LOW(greetee06)
    sta greetees, x
    inx
    lda #HIGH(greetee06)
    sta greetees, x
    inx

    lda #LOW(greetee07)
    sta greetees, x
    inx
    lda #HIGH(greetee07)
    sta greetees, x
    inx

    lda #LOW(greetee08)
    sta greetees, x
    inx
    lda #HIGH(greetee08)
    sta greetees, x
    inx

    lda #LOW(greetee09)
    sta greetees, x
    inx
    lda #HIGH(greetee09)
    sta greetees, x
    inx

    lda #LOW(greetee10)
    sta greetees, x
    inx
    lda #HIGH(greetee10)
    sta greetees, x
    inx

    lda #LOW(greetee11)
    sta greetees, x
    inx
    lda #HIGH(greetee11)
    sta greetees, x
    inx

    lda #LOW(greetee12)
    sta greetees, x
    inx
    lda #HIGH(greetee12)
    sta greetees, x
    inx

    lda #LOW(greetee13)
    sta greetees, x
    inx
    lda #HIGH(greetee13)
    sta greetees, x
    inx

    ldx #NB_GREETS
.setactive:
    stz greetees_active, x
    dex
    bne .setactive

    ldx #NB_GREETS
.setoffsets:
    lda greetees_offsets_original, x
    sta greetees_offsets, x
    dex
    bne .setoffsets



    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #wegreettoppalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #wegreettoppalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #01
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #wegreetbottompalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #wegreetbottompalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette


	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(wegreettop0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(wegreettop0)
    sta HIGH_BYTE <data_ptr

    lda #LOW(211)
    sta LOW_BYTE <R0
    lda #HIGH(211)
    sta HIGH_BYTE <R0

    jsr loadtiles


    lda #bank(greets_data2)
    tam #page(greets_data2)

	lda #LOW(TILE_START + TILE_SIZE * 211)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + TILE_SIZE * 211)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(wegreetbottom64)
    sta LOW_BYTE <data_ptr
    lda #HIGH(wegreetbottom64)
    sta HIGH_BYTE <data_ptr

    lda #LOW(179)
    sta LOW_BYTE <R0
    lda #HIGH(179)
    sta HIGH_BYTE <R0

    jsr loadtiles


    lda #bank(greets_data3)
    tam #page(greets_data3)

	lda #LOW(TILE_START + TILE_SIZE * 391)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + TILE_SIZE * 391)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(starfield0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(starfield0)
    sta HIGH_BYTE <data_ptr

    lda #LOW(45)
    sta LOW_BYTE <R0
    lda #HIGH(45)
    sta HIGH_BYTE <R0

    jsr loadtiles

    lda #02
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #starfieldpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #starfieldpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette



    lda #bank(greets_data2)
    tam #page(greets_data2)

;fill the bat
    lda LOW_BYTE #wegreetbat
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #wegreetbat
    sta HIGH_BYTE <data_ptr

    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02

    ldy #$08
.load01:
    ldx #128
.load02:
    lda [data_ptr]
    sta $0002
    incw <data_ptr
    lda [data_ptr]
    sta $0003
    incw <data_ptr

    dex
    bne .load02

    dey
    bne .load01

; init starfield_offsets
    ldx #STARFIELD_SCREEN_HEIGHT
.initStarfieldOffsets:
    stz starfield_offsets, x
    dex
    bne .initStarfieldOffsets



    rts


greets:

    ; clear any leftover x bat scroll
    st0 #$07
    st1 #$00
    st2 #$00
    ; clear any leftover y bat scroll
    st0 #$08
    st1 #$00
    st2 #$00
 
    jsr greets_load

    lda #bank(greets_data)
    tam #page(greets_data)

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    jsr clearsatb

    ; <R10 = pointer to first free satb slot
    lda LOW_BYTE <satb_ptr
    sta LOW_BYTE <R10
    lda HIGH_BYTE <satb_ptr
    sta HIGH_BYTE <R10



    lda LOW_BYTE #greets_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #greets_scanline
    sta HIGH_BYTE <scanline_handler

    stz <vdc_current_scanline
     ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00

    stz <frame_skip_counter


.wait:
    jsr wait_vsync

    jsr copysatb


    clx
.foreachgreetinit:
    txa
    asl a
    tay
    cmpw <frame_counter, greetees_timing, y
    bne .noinit

    lda #$01
    sta greetees_active, x

    lda LOW_BYTE greetees, y
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE greetees, y
    sta HIGH_BYTE <data_ptr

    lda LOW_BYTE greetees_start_x, y
    sta LOW_BYTE <R1
    lda HIGH_BYTE greetees_start_x, y
    sta HIGH_BYTE <R1

    lda greetees_y, x
    sta LOW_BYTE <R2
    stz HIGH_BYTE <R2

    lda LOW_BYTE <R10
    sta LOW_BYTE <satb_ptr
    sta LOW_BYTE greetees_satb, y
    lda HIGH_BYTE <R10
    sta HIGH_BYTE <satb_ptr
    sta HIGH_BYTE greetees_satb, y

    lda #$01
    sta <R0
    jsr maketextsatb

    lda LOW_BYTE <satb_ptr
    sta LOW_BYTE <R10
    lda HIGH_BYTE <satb_ptr
    sta HIGH_BYTE <R10


.noinit:

    inx
    cpx #NB_GREETS
    bne .foreachgreetinit


    clx
.foreachgreetmove:
    lda greetees_active, x
    beq .nomove

    txa
    asl a
    tay

    ; update x in satb
    lda LOW_BYTE #GREETS_SPEED
    sta LOW_BYTE <R0
    lda HIGH_BYTE #GREETS_SPEED
    sta HIGH_BYTE <R0

    lda greetees_increment, x
    sta <R1

    lda greetees_lengths, x
    sta <R2

    lda greetees_offsets, x
    sta <R3

    jsr satbshiftx


.nomove:
    inx
    cpx #NB_GREETS
    lbne .foreachgreetmove



    clx
.foreachgreetuninit:

    ;jmp .nouninit

    lda greetees_active, x
    lbeq .nouninit

    txa
    asl a
    tay
    ; decide if offscreen :
    ; if its increment is 1, it's scrolling right, so check if first element's offscreen
    lda greetees_increment, x
    lbeq .movingleft

    lda LOW_BYTE greetees_satb, y
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE greetees_satb, y
    sta HIGH_BYTE <satb_ptr

    jsr getsatbx ; writes x in <R0

    cmpw #$152e, <R0
    lbne .nouninit

    stz greetees_active, x

    lda LOW_BYTE greetees_satb, y
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE greetees_satb, y
    sta HIGH_BYTE <satb_ptr

    lda greetees_lengths, x
    sta <R0
    stz <R0 +1

    lda greetees_offsets, x
    sta <R1
    stz <R1 +1

.compote1:
    jsr defragmentsatb
    jsr updatesatbpointers
.compote2:

    jmp .nouninit


    ; if its increment is 0, go to last satb item of text and check if last element's offscreen
.movingleft:
    lda LOW_BYTE greetees_satb, y
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE greetees_satb, y
    sta HIGH_BYTE <satb_ptr

    lda greetees_lengths, x
    sta <R0
    dec <R0
.plusoneitem:
    beq .afterplusoneitem
    addw #SATB_ITEM_SIZE, <satb_ptr
    dec <R0
    bra .plusoneitem
.afterplusoneitem:
    jsr getsatbx ; writes x in <R0

    cmpw #$0010, <R0
    lbne .nouninit

    stz greetees_active, x

    lda LOW_BYTE greetees_satb, y
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE greetees_satb, y
    sta HIGH_BYTE <satb_ptr

    lda greetees_lengths, x
    sta <R0
    stz <R0 +1

    lda greetees_offsets, x
    sta <R1
    stz <R1 +1

.compote3:
    jsr defragmentsatb
    jsr updatesatbpointers
.compote4:


    jmp .nouninit

.nouninit:
    inx
    cpx #NB_GREETS
    lbne .foreachgreetuninit

    lda <frame_skip_counter
    cmp #$04
    bne .end

    stz <frame_skip_counter

    clx
.updateStarfield:
    lda starfield_offsets, x
    clc
    adc starfield_increments, x
    sta starfield_offsets, x
    inx
    cpx #STARFIELD_SCREEN_HEIGHT
    bne .updateStarfield

.end:
    inc <frame_skip_counter


    incw <frame_counter
    cmpw #1270, <frame_counter
    lbne .wait


    ; clear scanline interrupt
    st0 #$06
    st1 #$00
    st2 #$00

    ; clear any leftover x bat scroll
    st0 #$07
    st1 #$00
    st2 #$00


    rts


updatesatbpointers:
    phx
    phy

    lda greetees_lengths, x
    sta <R0

    stz <R1
    stz <R1 + 1
.add:
    addw #SATB_ITEM_SIZE, <R1
    dec <R0
    bne .add

    lda greetees_lengths, x
    sta <R0

    inx

.updatepointer:
    cpx #NB_GREETS
    beq .afterupdatepointer
    txa
    asl a
    tay

    subw <R1, greetees_satb, y

    lda greetees_offsets, x
    sec
    sbc <R0
    sta greetees_offsets, x
    clc

    inx
    bra .updatepointer
.afterupdatepointer:

    ; update pointer to first free satb item
    subw <R1, <R10

    ply
    plx
    rts


greets_scanline:
    pha
    phx
    phy

    ;lda #$04
    ;sta $1402
    ;cli

    ; set next scanline interrupt
    inc <vdc_current_scanline

    ; we reset the scanline counter if it's == $f2
    lda <vdc_current_scanline
    cmp #$f2
    bne .set_scanline_int

    stz <vdc_current_scanline

.set_scanline_int:
    clc
    lda <vdc_current_scanline
    adc #$40
    st0 #$06
    sta $0002
    cla
    adc #$00
    sta $0003


    ldx <vdc_current_scanline
    lda starfield_offsets, x

    st0 #$07
    sta $0002
    st2 #$00

.end:
    ;stz $1402

    ply
    plx
    pla

    rti

