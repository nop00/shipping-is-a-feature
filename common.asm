whitepalette: .defpal $777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777
blackpalette: .defpal $000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
transparentpalette: .defpal $707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707,$707
transitiontileblack:	.defpal $707,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
transitiontilegreen:	.defpal $707,$021,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000

transitiontilebat: .dw BATVAL(1, TRANSITION_TILE_START)


buenzli_bg_text01: .db "HAPPY BIRTHDAY!", 0
buenzli_bg_text02: .db "TO CELEBRATE", 0
buenzli_bg_text03: .db "LET'S DEMO", 0
buenzli_bg_text04: .db "OLDSCHOOL STYLE", 0
buenzli_bg_text05: .db "ON PC ENGINE", 0

buenzli_bg_text_satb_lengths: .db SATB_ITEM_SIZE * 15
                              .db SATB_ITEM_SIZE * 12
                              .db SATB_ITEM_SIZE * 10
                              .db SATB_ITEM_SIZE * 15
                              .db SATB_ITEM_SIZE * 12

buenzli_bg_text_lengths: .db 15
                         .db 12
                         .db 10
                         .db 15
                         .db 12


transitiontile:	.defchr $4000, $0,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$11111111

wazza_index: .db $01,$01,$01,$01,$01,$01,$02,$03,$04,$05,$05,$05,$05,$05,$05,$04
             .db $03,$02,$01,$01,$01,$01,$01,$01,$01,$02,$03,$04,$05,$05,$05,$05
             .db $05,$05,$05,$04,$03,$02,$01,$01,$01,$01,$01,$01,$01,$02,$03,$04
             .db $05,$05,$05,$05,$05,$05,$05,$04,$03,$02,$01,$01,$01,$01,$01,$01
             .db $01,$02,$03,$04,$05,$05,$05,$05,$05,$05,$05,$04,$03,$02,$01,$01
             .db $01,$01,$01,$01,$01,$02,$03,$04,$05,$05,$05,$05,$05,$05,$05,$04
             .db $03,$02,$01,$01,$01,$01,$01,$01,$01,$02,$03,$04,$05,$05,$05,$05
             .db $05,$05,$05,$04,$03,$02,$01,$01,$01,$01,$01,$01,$01,$02,$03,$04
             .db $05,$05,$05,$05,$05,$05,$05,$04,$03,$02,$01,$01,$01,$01,$01,$01
             .db $01,$02,$03,$04,$05,$05,$05,$05,$05,$05,$05,$04,$03,$02,$01,$01
             .db $01,$01,$01,$01,$01,$02,$03,$04,$05,$05,$05,$05,$05,$05,$05,$04
             .db $03,$02,$01,$01,$01,$01,$01,$01,$01,$02,$03,$04,$05,$05,$05,$05
             .db $05,$05,$05,$04,$03,$02,$01,$01,$01,$01,$01,$01,$01,$02,$03,$04
             .db $05,$05,$05,$05,$05,$05,$05,$04,$03,$02,$01,$01,$01,$01,$01,$01
             .db $01,$02,$03,$04,$05,$05,$05,$05,$05,$05,$05,$04,$03,$02,$01,$01
             .db $01,$01,$01,$01,$01,$02,$03,$04,$05,$05,$05,$05,$05,$05,$05,$04

; x, y, x, y, x, y, ...
in_wazza_offsets:    .db $f0, $f0, $e1, $e1, $d1, $d1, $c1, $c1, $b1, $b1, $a1, $a1, $91, $91, $81, $81
                     .db $71, $71, $61, $61, $51, $51, $41, $41, $31, $31, $21, $21, $11, $11, $01, $01
in_wazza_increments: .db $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1
                     .db $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1


; x, y, x, y, x, y, ...
out_wazza_offsets:    .db $01, $01, $11, $11, $21, $21, $31, $31, $41, $41, $51, $51, $61, $61, $71, $71
                      .db $81, $81, $91, $91, $a1, $a1, $b1, $b1, $c1, $c1, $d1, $d1, $e1, $e1, $f0, $f0
out_wazza_increments: .db $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0
                      .db $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0


; empty scanline interrupt handler, it just schedules itself
; for next scanline and goes away
dummy_scanline:
    pha
    phx

    lda #$04    ; mask timer interrupt so we
    sta $1402   ; can work without being... INTerrupted :]
    cli
 
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

.end:
    plx
    pla

    stz $1402   ; allo timer interrupt

    rti



