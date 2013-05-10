warning_load:
    lda #bank(warning_data)
    tam #page(warning_data)

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #warning_palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #warning_palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #bank(warning_data2)
    tam #page(warning_data2)

	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(warning_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(warning_0)
    sta HIGH_BYTE <data_ptr

    lda #LOW(256)
    sta LOW_BYTE <R0
    lda #HIGH(256)
    sta HIGH_BYTE <R0

    jsr loadtiles

    lda #bank(warning_data3)
    tam #page(warning_data3)

	lda #LOW(TILE_START + TILE_SIZE * 256 )
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + TILE_SIZE * 256)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(warning_256)
    sta LOW_BYTE <data_ptr
    lda #HIGH(warning_256)
    sta HIGH_BYTE <data_ptr

    lda #LOW(236)
    sta LOW_BYTE <R0
    lda #HIGH(236)
    sta HIGH_BYTE <R0

    jsr loadtiles

    lda #bank(warning_data)
    tam #page(warning_data)
;fill the bat
    lda LOW_BYTE #warning_bat
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #warning_bat
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


warning:
    jsr warning_load
    copypalette #warning_palette, palette

    stz <frame_counter
    stz <frame_counter + 1
    stz <frame_skip_counter

.wait:
    jsr wait_vsync
    incw <frame_counter

    cmpw #300, <frame_counter
    lblo .wait

    ; fade palette
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



    cmpw #360, <frame_counter
    bne .wait

    jsr clearsatb

    st0 #$00
    lda LOW_BYTE #LOW(TILE_START)
    sta $0002
    lda HIGH_BYTE #HIGH(TILE_START)
    sta $0003
    st0 #$02

    jsr wait_vsync
    tia satb, $0002, 512
    tia satb, $0002, 512
    tia satb, $0002, 512
    tia satb, $0002, 512
    tia satb, $0002, 512
    tia satb, $0002, 512
    tia satb, $0002, 512
    tia satb, $0002, 512



    rts



