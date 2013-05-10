rasters_load:

    lda #bank(rasters_data)
    tam #page(rasters_data)

   	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr

    loadtilesmacro #rasters0, #17 * TILE_SIZE * 2

;fill the bat
    
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02

    tia rastersbat, $0002, 1024 * 2

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #rasterbleupalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rasterbleupalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #$01
    sta <R0
    lda LOW_BYTE #rastergrispalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rastergrispalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #$02
    sta <R0
    lda LOW_BYTE #rastercyanpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rastercyanpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #$03
    sta <R0
    lda LOW_BYTE #rastergrisfoncepalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rastergrisfoncepalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #$04
    sta <R0
    lda LOW_BYTE #rasterjaunepalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rasterjaunepalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #$05
    sta <R0
    lda LOW_BYTE #rasterrosepalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rasterrosepalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #$06
    sta <R0
    lda LOW_BYTE #rasterrougepalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rasterrougepalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda #$07
    sta <R0
    lda LOW_BYTE #rastervertpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #rastervertpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette


; copy raster offsets table
    clx
.copyoffsets:
    lda rasters_start_offsets, x
    sta rasters_offsets, x
    inx
    cpx #RASTER_COUNT
    bne .copyoffsets


    rts


rasters:

    ; clear any leftover y bat scroll
    st0 #$08
    st1 #$00
    st2 #$00

    jsr rasters_load

    stz <frame_counter
    stz <frame_counter + 1

    lda LOW_BYTE #rasters_scanline
    sta LOW_BYTE <scanline_handler
    lda HIGH_BYTE #rasters_scanline
    sta HIGH_BYTE <scanline_handler

    ; set first scanline interrupt
    st0 #$06
    st1 #$40
    st2 #$00

    stz <R11


.wait:

    clx
    lda #$1C
    sta <R1 ; last raster's index
.move:
    lda rasters_started, x
    bne .gomove
    lda <R1
    cmp #$1B
    lblo .endmove
    lda #$01
    sta rasters_started, x

.gomove:
    ldy rasters_index, x
    lda rasters_samere, y
    sta rasters_offsets, x

;   lda rasters_increment, y
;   bne .increment
;   lda rasters_movement, y
;   sta <R0
;   lda rasters_offsets, x
;   sec
;   sbc <R0
;   clc
;   sta rasters_offsets, x
;   bra .endmove

;.increment:
;   lda rasters_movement, y
;   sta <R0
;   lda rasters_offsets, x
;   clc
;   adc <R0
;   clc
;   sta rasters_offsets, x

.endmove:
    lda rasters_index, x
    sta <R1
    inx
    cpx #RASTER_COUNT
    bne .move


    clx
    lda #$0C
    sta <R0 ; last raster's index
.incindexes:
    lda rasters_started, x
    bne .goinc
    lda <R0
    cmp #$0B
    lblo .endincindexes
    lda #$01
    sta rasters_started, x

.goinc:
    inc rasters_index, x

.endincindexes:
    lda rasters_index, x
    sta <R0
    inx
    cpx #RASTER_COUNT
    bne .incindexes

    clc
    
    jsr wait_vsync


;    ;
;    ; update rasters table with twister information
;    ;
;    lda <R11
;    ;adc #$02
;    sta <R11
;    sta <R11 + 1
;
;    lda <R12
;    adc #$02
;    sta <R12
;    sta <R12 + 1
;
;
;    clx
;    cly
;.writetwister:
;    inc <R11 + 1
;    lda <R11 + 1
;;    lsr a
;    lsr a
;;    phy
;    tay
;    lda twisters_deformationY, y
;    sta <R1
;
;    inc <R12 + 1
;    lda <R12 + 1
;;    lsr a
;    lsr a
;    tay
;    lda twisters_deformationY, y
;;    ply
;    adc <R1
;    sta <R1
;; 
;    lda twisters_coords, x
;    ;sty <R0
;    adc <R1
;    adc #TWISTER_START
;
;.modulo:
;    cmp #TWISTER_START + 30
;    lbmi .settwistervalue
;    sec
;    sbc #30
;    jmp .modulo
;;
;;
;.settwistervalue:
;;    sta rasters_table, x
;    sta rasters_table, x
;
;;
;;    iny
;;    cpy #31
;;    bne .okfoo
;;    cly
;;.okfoo:
;    inx
;    cpx #RASTER_SCREEN_HEIGHT
;    bne .writetwister
;

    ;
    ; update rasters table
    ;

    ; clear the table
    stz rasters_table
    tii rasters_table, rasters_table + 1, RASTER_SCREEN_HEIGHT - 1

    
    clx
.writeraster:
    ldy rasters_offsets, x
    
    lda rasters_texcoords, x
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y

    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y
    inc a
    iny
    sta rasters_table, y


    inx
    cpx #RASTER_COUNT
    bne .writeraster



.end:
    incw <frame_counter
    cmpw #1060, <frame_counter
    lbne .wait

    ; no more scanline
    st0 #$06
    st1 #$00
    st2 #$00

    jsr clearsatb
    jsr copysatb

    rts


rasters_scanline:
    pha
    phx

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
    lda rasters_table, x
.setYScroll:
    st0 #$08
    sta $0002
    st2 #$00

.end:
    plx
    pla
    rti


