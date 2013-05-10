demo_logo_load:

    lda #bank(demo_logo_data)
    tam #page(demo_logo_data)

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #logoblankpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #logoblankpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(logo0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(logo0)
    sta HIGH_BYTE <data_ptr

    lda #LOW(190)
    sta LOW_BYTE <R0
    lda #HIGH(190)
    sta HIGH_BYTE <R0

    jsr loadtiles

;fill the bat
    lda LOW_BYTE #logobat
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #logobat
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

    lda #bank(demo_logo_data2)
    tam #page(demo_logo_data2)

	lda #LOW(TILE_START + TILE_SIZE * 190)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + TILE_SIZE * 190)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(demo_logo_data2)
    sta LOW_BYTE <data_ptr
    lda #HIGH(demo_logo_data2)
    sta HIGH_BYTE <data_ptr

    lda #LOW(256)
    sta LOW_BYTE <R0
    lda #HIGH(256)
    sta HIGH_BYTE <R0

    jsr loadtiles


    lda #bank(demo_logo_data3)
    tam #page(demo_logo_data3)

	lda #LOW(TILE_START + TILE_SIZE * (191 + 255))
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + TILE_SIZE * (191 + 255))
    sta HIGH_BYTE <vram_ptr
    lda #LOW(demo_logo_data3)
    sta LOW_BYTE <data_ptr
    lda #HIGH(demo_logo_data3)
    sta HIGH_BYTE <data_ptr

    lda #LOW(100)
    sta LOW_BYTE <R0
    lda #HIGH(100)
    sta HIGH_BYTE <R0

    jsr loadtiles



    lda #01
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #transitiontileblack
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #transitiontileblack
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

	lda #LOW(TRANSITION_TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TRANSITION_TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #transitiontile
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #transitiontile
    sta HIGH_BYTE <data_ptr

    lda #1
    sta <R0

    jsr loadtiles


    rts


demo_logo:

    ; clear any leftover x bat scroll
    st0 #$07
    st1 #$00
    st2 #$00
 
    jsr demo_logo_load

    lda LOW_BYTE #demo_logo_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #demo_logo_scanline
    sta HIGH_BYTE <scanline_handler

    stz <vdc_current_scanline
    lda #113
    sta LOW_BYTE  <R1
    sta HIGH_BYTE <R1

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00

    stz LOW_BYTE <R2
    stz HIGH_BYTE <R2

    lda #bank(demo_logo_data)
    tam #page(demo_logo_data)

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

.wait:
    jsr wait_vsync

    inc LOW_BYTE <R2
    lda LOW_BYTE <R2
    cmp #3
    bne .nochange

    inc HIGH_BYTE <R2
    lda HIGH_BYTE <R2
    cmp #1
    bne .paletteloaded
    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #logopalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #logopalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #1
    sta HIGH_BYTE <R2

.paletteloaded:
    stz LOW_BYTE <R2

    dec LOW_BYTE <R1
    lda LOW_BYTE <R1
    cmp #$ff ; -1
    bne .inclowerlimit
    stz LOW_BYTE <R1
.inclowerlimit:
    inc HIGH_BYTE <R1
    lda HIGH_BYTE <R1
    cmp #243
    bne .nochange
    lda #242
    sta HIGH_BYTE <R1
.nochange:

 
    incw <frame_counter
    cmpw #600, <frame_counter
    lbne .wait

    ; clear scanline interrupt
    st0 #$06
    st1 #$00
    st2 #$00

    ; clear any leftover y bat scroll
    st0 #$08
    st1 #$00
    st2 #$00

 
    rts


demo_logo_scanline:
    pha
    phx

    ; set next scanline interrupt
    inc <vdc_current_scanline

    ; we reset the scanline counter if it's == $f3
    lda <vdc_current_scanline
    cmp #$f3
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


    lda <vdc_current_scanline
    cmp LOW_BYTE <R1
    bcc .smeartop
    cmp HIGH_BYTE <R1
    bcs .smearbottom

    st0 #$08
    sta $0002
    st2 #$00
    bra .end

.smeartop:
    lda LOW_BYTE <R1
    st0 #$08
    sta $0002
    st2 #$00
    bra .end

.smearbottom:
    lda HIGH_BYTE <R1
    st0 #$08
    sta $0002
    st2 #$00


.end:
    plx
    pla
    rti


