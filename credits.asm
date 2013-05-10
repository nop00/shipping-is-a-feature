;
; !!!
; bg is 631 tiles long so we can't use SPRITES_START (which only allows 592 tiles in vram)
; hence we define a CREDITS_SPRITES_START to be used only here
; same goes for the satb
; !!!
;
CREDITS_SPRITE_START .equ $4400
CREDITS_SATB_START .equ $4200




credits_load:

    lda #bank(credits_data_03)
    tam #page(credits_data_03)

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #creditsbg_palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #creditsbg_palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette


    lda #bank(credits_data_01)
    tam #page(credits_data_01)

	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(creditsbg_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(creditsbg_0)
    sta HIGH_BYTE <data_ptr

    lda #LOW(256)
    sta LOW_BYTE <R0
    lda #HIGH(256)
    sta HIGH_BYTE <R0

    jsr loadtiles


    lda #bank(credits_data_02)
    tam #page(credits_data_02)

	lda #LOW(TILE_START + TILE_SIZE * 256)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + TILE_SIZE * 256)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(creditsbg_256)
    sta LOW_BYTE <data_ptr
    lda #HIGH(creditsbg_256)
    sta HIGH_BYTE <data_ptr

    lda #LOW(256)
    sta LOW_BYTE <R0
    lda #HIGH(256)
    sta HIGH_BYTE <R0

    jsr loadtiles


    lda #bank(credits_data_03)
    tam #page(credits_data_03)

	lda #LOW(TILE_START + TILE_SIZE * 256 + TILE_SIZE * 256)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START + TILE_SIZE * 256 + TILE_SIZE * 256)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(creditsbg_512)
    sta LOW_BYTE <data_ptr
    lda #HIGH(creditsbg_512)
    sta HIGH_BYTE <data_ptr

    lda #LOW(119)
    sta LOW_BYTE <R0
    lda #HIGH(119)
    sta HIGH_BYTE <R0

    jsr loadtiles


;fill the bat
    lda LOW_BYTE #creditsbg_bat
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #creditsbg_bat
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


    lda #bank(credits_data_04)
    tam #page(credits_data_04)

;
; left diver
;

	lda #LOW(CREDITS_SPRITE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(CREDITS_SPRITE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(leftdiver_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(leftdiver_0)
    sta HIGH_BYTE <data_ptr

    lda #18
    sta <R0
    stz <R0 + 1

    jsr loadsprites

    lda #18
    sta <R0
    sta <R1
    lda LOW_BYTE #leftdiver_satb
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #leftdiver_satb
    sta HIGH_BYTE <data_ptr

    jsr copytosatb


    lda #$20
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #18
    sta <R2
    sta <R3
    jsr satbshiftx

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr
    lda #$A2
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #18
    sta <R2
    jsr satbshifty

    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #leftdiver_palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #leftdiver_palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette



;
; right diver
;

	lda #LOW(CREDITS_SPRITE_START + RIGHTDIVER_OFFSET)
    sta LOW_BYTE <vram_ptr
	lda #HIGH(CREDITS_SPRITE_START + RIGHTDIVER_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(rightdiver_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(rightdiver_0)
    sta HIGH_BYTE <data_ptr

    lda #18
    sta <R0
    stz <R0 + 1

    jsr loadsprites

    lda #36
    sta <R0
    sta <R1
    lda LOW_BYTE #rightdiver_satb
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rightdiver_satb
    sta HIGH_BYTE <data_ptr

    jsr copytosatb
 

    lda #$F0
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #18
    sta <R2
    lda #36
    sta <R3
    jsr satbshiftx

    lda #$A2
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #18
    sta <R2
    lda #36
    sta <R3
    jsr satbshifty

    lda #17
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #rightdiver_palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rightdiver_palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette


;
; brushes
;


	lda #LOW(CREDITS_SPRITE_START + BRUSHES_OFFSET)
    sta LOW_BYTE <vram_ptr
	lda #HIGH(CREDITS_SPRITE_START + BRUSHES_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(brushes_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(brushes_0)
    sta HIGH_BYTE <data_ptr

    lda #4
    sta <R0
    stz <R0 + 1

    jsr loadsprites

    lda #54
    sta <R0
    lda #4
    sta <R1
    lda LOW_BYTE #brushes_satb
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #brushes_satb
    sta HIGH_BYTE <data_ptr

    jsr copytosatb
 

    lda #$F0
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #4
    sta <R2
    lda #54
    sta <R3
    jsr satbshiftx

    lda #$4A
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #4
    sta <R2
    lda #54
    sta <R3
    jsr satbshifty

    lda #18
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #brushes_palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #brushes_palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette


;
; keyboards
;


	lda #LOW(CREDITS_SPRITE_START + KEYBOARDS_OFFSET)
    sta LOW_BYTE <vram_ptr
	lda #HIGH(CREDITS_SPRITE_START + KEYBOARDS_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(keyboards_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(keyboards_0)
    sta HIGH_BYTE <data_ptr

    lda #5
    sta <R0
    stz <R0 + 1

    jsr loadsprites

    lda #58
    sta <R0
    lda #5
    sta <R1
    lda LOW_BYTE #keyboards_satb
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #keyboards_satb
    sta HIGH_BYTE <data_ptr

    jsr copytosatb
 
    lda #$40
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #5
    sta <R2
    lda #58
    sta <R3
    jsr satbshiftx

    lda #$4A
    sta <R0
    stz <R0 + 1
    lda #$01
    sta <R1
    lda #5
    sta <R2
    lda #58
    sta <R3
    jsr satbshifty

;
; poulpe
;

    lda #bank(credits_data_05)
    tam #page(credits_data_05)

	lda #LOW(CREDITS_SPRITE_START + POULPE_OFFSET)
    sta LOW_BYTE <vram_ptr
	lda #HIGH(CREDITS_SPRITE_START + POULPE_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(poulpe0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(poulpe0)
    sta HIGH_BYTE <data_ptr

    lda #2
    sta <R0
    stz <R0 + 1

    jsr loadsprites

    lda #$30
    sta <R10 ; y offset
    lda #$01
    sta <R10 + 1
    clc
    clx
.loadpoulpe:
    txa
    adc #POULPE_SATB_START
    sta <R0
    sta <R3 ; for later
    lda #1
    sta <R1
    lda LOW_BYTE #poulpe1satb
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #poulpe1satb
    sta HIGH_BYTE <data_ptr
    jsr copytosatb


    txa
    asl a
    tay

    lda <R10
    sta <R0
    sta poulpe_y, y
    lda <R10 + 1
    sta <R0  + 1
    iny
    sta poulpe_y, y
    jsr setsatby


    addw #18, <R10


    inx

    txa
    adc #POULPE_SATB_START
    sta <R0
    sta <R3 ; for later
    lda #1
    sta <R1
    lda LOW_BYTE #poulpe2satb
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #poulpe2satb
    sta HIGH_BYTE <data_ptr
    jsr copytosatb

    txa
    asl a
    tay

    lda <R10
    sta <R0
    sta poulpe_y, y
    lda <R10 + 1
    sta <R0  + 1
    iny
    sta poulpe_y, y
    jsr setsatby

    

    addw #18, <R10

    inx
    cpx #POULPE_COUNT
    bne .loadpoulpe


    lda #19
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #poulpepalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #poulpepalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    cla
    clx
.initpoulpeoffsets:
    sta poulpe_offsets, x
    inx
    adc #14
    sta poulpe_offsets, x
    inx
    adc #14

    cpx #POULPE_COUNT
    bne .initpoulpeoffsets

    rts


credits:

    jsr credits_load

    st0 #$08
    st1 #$00
    st2 #$00


    stz <vdc_current_scanline

    lda LOW_BYTE #credits_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #credits_scanline
    sta HIGH_BYTE <scanline_handler

    stz LOW_BYTE <R11    ; wave_base
    stz HIGH_BYTE <R11   ; wave_idx

    stz LOW_BYTE <R12
    stz HIGH_BYTE <R12

    stz <frame_counter
    stz <frame_counter + 1
    stz <frame_skip_counter

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00


.wait:
    inc <frame_skip_counter
    lda <frame_skip_counter
    cmp #1
    bne .nopoulpemove
    stz <frame_skip_counter

    clx
.poulpemovey:
    txa
    asl a
    tay
    cmpw #$10, poulpe_y, y
    bne .noyreset
    
    lda #$30
    sta poulpe_y, y
    iny
    lda #$01
    sta poulpe_y, y
    dey

.noyreset:    
    clc
    txa
    adc #POULPE_SATB_START
    sta <R3

    subw #1, poulpe_y, y
    lda poulpe_y, y
    sta <R0
    iny
    lda poulpe_y, y
    sta <R0 + 1

    jsr setsatby
    inx
    cpx #POULPE_COUNT
    bne .poulpemovey


    clx
.poulpemovex:
    clc
    txa
    adc #POULPE_SATB_START
    sta <R3
    ldy poulpe_offsets, x
    lda poulpe_track1, y
    sta <R0
    stz <R0 + 1
    jsr setsatbx

    inc poulpe_offsets, x
    inx

    txa
    adc #POULPE_SATB_START
    sta <R3
    ldy poulpe_offsets, x
    lda poulpe_track2, y
    sta <R0
    stz <R0 + 1
    jsr setsatbx

    inc poulpe_offsets, x
    inx
    cpx #POULPE_COUNT
    bne .poulpemovex


.nopoulpemove:
    jsr wait_vsync

    jsr copysatbcredits

    clc
    lda LOW_BYTE <R11
    adc #$02
    sta LOW_BYTE <R11
    sta HIGH_BYTE <R11


    incw <frame_counter
    cmpw #820, <frame_counter
    lbne .wait

    ; no more scanline
    st0 #$06
    st1 #$00
    st2 #$00

    jsr clearsatb
    jsr copysatb

    rts


credits_scanline:
    pha
    phx

    ; set next scanline interrupt
    inc <vdc_current_scanline

    ; we reset the scanline counter if it's == $f0
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
    lda credits_deformationY,x
    ldx <vdc_current_scanline
    cpx #$c3
    lblo .reallySetXScroll
    cla
.reallySetXScroll:
    st0 #$07
    sta $0002
    st2 #$00

    inc HIGH_BYTE <R11

.end:
    plx
    pla
    rti


