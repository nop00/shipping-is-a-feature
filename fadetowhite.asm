fadetowhite:
    ; TODO: clean BAT and palette to #0
    stz <r
    stz <g
    stz <b
    stz <R0
    stz <R0 + 1
    stz <R1

.loop:
    jsr wait_vsync
    jsr wait_vsync
    jsr wait_vsync
    jsr wait_vsync

    inc <r
    inc <g
    inc <b
    jsr setpalettecolor

    lda <r
    cmp #7
    bne .loop

    rts

