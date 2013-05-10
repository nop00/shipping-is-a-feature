loadpalette: ; <R0 = palette #, <data_ptr = label where the 16-color palette is
    pha
    phx
    aslw <R0
    aslw <R0
    aslw <R0
    aslw <R0
    lda LOW_BYTE <R0
    sta $402        ; select color
    lda HIGH_BYTE <R0
    sta $403        ; select color

    ldx #16
.loadcolor:
    lda [data_ptr]
    sta $404
    incw <data_ptr
    lda [data_ptr]
    sta $405
    incw <data_ptr
    dex
    bne .loadcolor
    plx
    pla
    rts

copypalette .macro ; source address, destination address
    tii \1, \2, #32
    .endm


    .macro setbackgroundcolor ; param #1, #2, #3 = r, g ,b of the color to set
    lda #LOW(#16 << 4)
    sta $402   
    lda #HIGH(#16 << 4)
    sta $403  
    lda #LOW(\2 << 6 | \1 << 3 | \3)
    sta $404
    lda #HIGH(\2 << 6 | \1 << 3 | \3)
    sta $405
    .endm


setpalettecolor: ; <R0 = palette #, <R1 = color #, <r, <g, <b of the color to set
    aslw <R0
    aslw <R0
    aslw <R0
    aslw <R0
    addw <R1, <R0

    lda LOW_BYTE <R0
    sta $402   
    lda HIGH_BYTE <R0
    sta $403  

    lda <r
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    tax

    lda <g
    asl a
    asl a
    asl a

    ora <b
    sta <MR0
    txa
    ora <MR0

    sta $404

    lda <r
    lsr a
    lsr a
    sta $405
    rts


getcolorlowbyte: ; r, g ,b of the color to set // outputs in reg. a
    lda <g
    asl a
    asl a
    asl a
    asl a
    asl a
    asl a
    tax

    lda <r
    asl a
    asl a
    asl a

    ora <b
    sta <MR0
    txa
    ora <MR0

    rts


getcolorhighbyte: ; r, g ,b of the color to set // outputs in reg. a
    lda <g
    lsr a
    lsr a

    rts


getpaletter .macro ; <R2 palette value low byte, palette value high byte
    lda \1
    lsr a
    lsr a
    lsr a
    and #%00000111
    .endm

getpaletteg: ; <R2 palette value low byte, palette value high byte
    clc
    lda <R2 + 1
    lsr a
    lda <R2
    ror a

    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    and #%00000111
    rts

getpaletteb .macro; ; <R2 palette value low byte, palette value high byte
    lda \1
    and #%00000111
    .endm




loadsprite: ; vram_ptr = VRAM address to load to, data_ptr = label where the tile is
    phy
    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02
    cly
.x:
    lda [data_ptr],y
    sta $0002
    iny
    lda [data_ptr],y
    sta $0003
    iny
    cpy #128
    bne .x
    ply
    rts


    .macro vramtovram ; param #1 = source address, param #2 = destination address, param #3 = length in words
    ; setup read pointer
    st0 #$01
    lda LOW_BYTE \1
    sta $0002
    lda HIGH_BYTE \1
    sta $0003
    ; setup write pointer
    st0 #$00
    lda LOW_BYTE \2
    sta $0002
    lda HIGH_BYTE \2
    sta $0003

    st0 #$02

    ldx \3
.x\@:
    lda $0002
    sta $0002
    lda $0003
    sta $0003
    dex
    bne .x\@
    .endm


loadtilesmacro .macro ; <vram_ptr = VRAM address to load to, \1 = label where the tile is, \2 tile count
    pha

    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02

    jsr wait_vsync
    tia \1, $0002, \2

    pla
    .endm

loadtiles: ; <vram_ptr = VRAM address to load to, <data_ptr = label where the tile is, <R0 tile count
    pha
    phy
    phx
    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02

.loadtiles:
    cly
.loadtile:
    lda [data_ptr],y
    sta $0002
    iny
    lda [data_ptr],y
    sta $0003
    iny
    cpy #32
    bne .loadtile

    clc
    lda LOW_BYTE <data_ptr
    adc #TILE_SIZE * 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <data_ptr
    adc #$00
    sta HIGH_BYTE <data_ptr

    decw <R0
    cmpw <R0, #0
    bne .loadtiles

    plx
    ply
    pla
    rts


loadsprites: ; <vram_ptr = VRAM address to load to, <data_ptr = label where the sprites are, <R0 = sprite count
    pha
    phy
    phx
    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02

.loadsprites:
    cly
.loadsprite:
    lda [data_ptr],y
    sta $0002
    iny
    lda [data_ptr],y
    sta $0003
    iny
    cpy #128
    bne .loadsprite

    clc
    lda LOW_BYTE <data_ptr
    adc #SPRITE_SIZE * 2
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE <data_ptr
    adc #$00
    sta HIGH_BYTE <data_ptr

    decw <R0
    cmpw <R0, #0
    bne .loadsprites

    plx
    ply
    pla
    rts

fadepalette: ; <R0 = from palette, <R1 = to palette // uses <R2 // writes the resulting palette back into \1
    phy
    phx
    cly
.x:
    lda [R0], y
    sta LOW_BYTE <MR1
    lda [R1], y
    sta LOW_BYTE <MR2
    iny
    lda [R0], y
    sta HIGH_BYTE <MR1
    lda [R1], y
    sta HIGH_BYTE <MR2

    dey

    getpaletter <MR1
    sta LOW_BYTE <MR3
    getpaletter <MR2
    sta HIGH_BYTE <MR3
    jsr interpol
    sta <r
.xg:
    lda LOW_BYTE <MR1
    sta LOW_BYTE <R2
    lda HIGH_BYTE <MR1
    sta HIGH_BYTE <R2
    jsr getpaletteg
    sta LOW_BYTE <MR3
    lda LOW_BYTE <MR2
    sta LOW_BYTE <R2
    lda HIGH_BYTE <MR2
    sta HIGH_BYTE <R2
    jsr getpaletteg
    sta HIGH_BYTE <MR3
    jsr interpol
    sta <g
.xb:
    getpaletteb <MR1
    sta LOW_BYTE <MR3
    getpaletteb <MR2
    sta HIGH_BYTE <MR3
    jsr interpol
    sta <b
.xend:
    jsr getcolorlowbyte
    sta [R0], y
    iny
    jsr getcolorhighbyte
    sta [R0], y
    iny
    cpy #$20
    lbne .x
    plx
    ply

    rts

interpol: ; <MR3 = from, <MR3 + 1 = to // result is output in reg. a
    clc
    lda <MR3
    cmp <MR3 + 1
    beq .end
    bpl .dec
    inc a
    bra .end
.dec:
    dec a
.end:
    rts


transition1:    ; <R0 = line #
    cmpw #32, <R0
    lblo .go
    lda #32
    sta <R0

.go:
    stz <vram_ptr
    stz <vram_ptr + 1
    lda LOW_BYTE #transition1_bat
    sta <data_ptr
    lda HIGH_BYTE #transition1_bat
    sta <data_ptr + 1
    
    clx
.ptr:
    cpx <R0
    beq .afterptr
    addw #32, <vram_ptr
    addw #32 * #2, <data_ptr
    inx
    jmp .ptr

.afterptr
    st0 #$00
    lda LOW_BYTE <vram_ptr
    sta $0002
    lda HIGH_BYTE <vram_ptr
    sta $0003
    st0 #$02

 
    clx
.copylines:
    ldy #32 ; une ligne de bat
.copyline:
    lda [data_ptr]
    sta <R1
    incw <data_ptr
    lda [data_ptr]
    sta <R1 + 1
    incw <data_ptr

    cmpw #$ffff, <R1
    beq .advancepointer

    lda <R1
    sta $0002
    lda <R1 + 1
    sta $0003
    bra .endcopyline

.advancepointer:
    lda $0002
    sta $0002
    lda $0003
    sta $0003

.endcopyline:
    dey
    bne .copyline

    inx
    cpx <R0
    bne .copylines

    rts

