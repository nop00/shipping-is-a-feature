transition .macro ; #1 tile address, #2 palette, line #, tile count
    ; we suppose the BAT is 32x32 in size

    st0 #$00

    lda \3
    asl a
    asl a
    asl a
    asl a
    asl a
    sta $0002

    lda \3
    lsr a
    lsr a
    lsr a
    sta $0003

    st0 #$02

    phx
    ldx \4
    cpx #32
    bcc .copytile
    ldx #32
.copytile:
    st1 #LOW(BATVAL(\2, \1))
    st2 #HIGH(BATVAL(\2, \1))
    dex
    bne .copytile
    plx

    .endm


