punkfloyd_logo_load:

    lda #bank(punkfloyd_logo_data)
    tam #page(punkfloyd_logo_data)

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #whitepalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #whitepalette
    sta HIGH_BYTE <data_ptr

    jsr loadpalette

	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(punkfloydlogo0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(punkfloydlogo0)
    sta HIGH_BYTE <data_ptr

    lda #138
    sta <R0
	
    jsr loadtiles


   	lda #LOW(TRANSITION_TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TRANSITION_TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(transitiontile)
    sta LOW_BYTE <data_ptr
    lda #HIGH(transitiontile)
    sta HIGH_BYTE <data_ptr

    lda #1
    sta <R0
    jsr loadtiles

    lda #1
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #transitiontileblack
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #transitiontileblack
    sta HIGH_BYTE <data_ptr

    jsr loadpalette



; fill the BAT
    lda LOW_BYTE #punkfloydbat
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #punkfloydbat
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

    rts


punkfloyd_logo:
    lda #bank(punkfloydlogopalette)
    tam #page(punkfloydlogopalette)

    ;; init
    stz <vdc_current_scanline

    lda LOW_BYTE #punkfloyd_logo_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #punkfloyd_logo_scanline
    sta HIGH_BYTE <scanline_handler

    stz LOW_BYTE <R11    ; wave_base
    stz HIGH_BYTE <R11   ; wave_idx


    jsr punkfloyd_logo_load
    copypalette whitepalette, palette

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00

    stz LOW_BYTE <R12
    stz HIGH_BYTE <R12

    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    stz <R13

    stz <R14
    stz <R14 + 1

    stz <R4 ; line counter for end transition

    clx
.wait:
    lda <frame_counter
    cmp #40
    lbpl .nopaleffect
    inc <R13
    lda <R13
    cmp #4
    lbne .nopaleffect
    stz <R13

    lda LOW_BYTE #palette
    sta <R0
    lda HIGH_BYTE #palette
    sta <R0 + 1
    lda LOW_BYTE #punkfloydlogopalette
    sta <R1
    lda HIGH_BYTE #punkfloydlogopalette
    sta <R1 + 1

    jsr fadepalette 


    lda #00
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

.nopaleffect:
    clc
    lda LOW_BYTE <R11
    adc #$02
    sta LOW_BYTE <R11
    sta HIGH_BYTE <R11

;    jsr wait_vsync
;    jsr wait_vsync
    jsr wait_vsync
    incw <frame_counter


.next01:
    cmpw #500, <frame_counter
    ;cmpw #1, <frame_counter
    lbne .wait

    ; no more scanline
    st0 #$06
    st1 #$00
    st2 #$00


    rts

punkfloyd_logo_scanline:
    pha
    phx
    phy

    ; set next scanline interrupt
    inc <vdc_current_scanline

    ; we reset the scanline counter if it's == $f3
    lda <vdc_current_scanline
    cmp #$f0
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

    lda HIGH_BYTE <R11
    lsr a
    lsr a
    tax
    lda deformationY,x
    cmp HIGH_BYTE <R12
    bpl .subtractY
    lda <vdc_current_scanline
    bra .setYScroll
.subtractY:
    sec
    sbc HIGH_BYTE <R12
    clc
    adc <vdc_current_scanline
.setYScroll:
    st0 #$08
    sta $0002
    st2 #$00

    lda HIGH_BYTE <R11
    lsr a
    lsr a
    tax
    lda deformationX,x
    cmp HIGH_BYTE <R12
    bpl .subtractX
    cla
    bra .setXScroll
.subtractX:
    sec
    sbc HIGH_BYTE <R12
    clc
.setXScroll:
    ;st0 #$07
    ;sta $0002
    ;st2 #$00

    inc HIGH_BYTE <R11

.end:
    ply
    plx
    pla
    rti

