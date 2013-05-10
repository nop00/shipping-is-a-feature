goodbye_load:
    lda #bank(goodbye_data)
    tam #page(goodbye_data)

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #goodbye_palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #goodbye_palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(goodbye_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(goodbye_0)
    sta HIGH_BYTE <data_ptr

    lda #LOW(155)
    sta LOW_BYTE <R0
    lda #HIGH(155)
    sta HIGH_BYTE <R0

    jsr loadtiles

;fill the bat
    lda LOW_BYTE #goodbye_bat
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #goodbye_bat
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



goodbye:
    ; cleanup any potential leftover x/y bg scan offsets
    st0 #$07
    stz $0002
    st2 #$00

    st0 #$08
    stz $0002
    st2 #$00

    jsr goodbye_load

    copypalette #goodbye_palette, palette

    stz <frame_skip_counter
    stz <frame_counter
    stz <frame_counter + 1

.wait:
    jsr wait_vsync


    cmpw #300, <frame_counter
    lblo .end

                lda #$00
                sta $800
                stz $804
                inc a
                sta $800
                stz $804
                 inc a
                sta $800
                stz $804
                 inc a
                sta $800
                stz $804
                 inc a
                sta $800
                stz $804
                 inc a
                sta $800
                stz $804
                lda     #$00
                sta     $0801


    lda <frame_skip_counter
    cmp #4
    bne .nopal
    stz <frame_skip_counter

    lda LOW_BYTE #palette
    sta <R0
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #palette
    sta <R0 + 1
    sta HIGH_BYTE <data_ptr

    lda LOW_BYTE #blackpalette
    sta <R1
    lda HIGH_BYTE #blackpalette
    sta <R1 + 1

    jsr fadepalette


    stz <R0
    jsr loadpalette

.nopal:
    inc <frame_skip_counter

    ; todo: message ' you may turn off your console now '


.end:
    incw <frame_counter

    jmp .wait

    rts

