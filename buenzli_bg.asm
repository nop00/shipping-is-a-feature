
buenzli_bg_load:

    lda #bank(buenzli_bg_data)
    tam #page(buenzli_bg_data)

	lda #LOW(TILE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(TILE_START)
    sta HIGH_BYTE <vram_ptr

    loadtilesmacro #bnzpixels0, #110 * TILE_SIZE * 2

;fill the bat
    
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02

    tia bnzbat, $0002, 1024 * 2

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #bnzpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #bnzpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette


    lda #bank(commondata)
    tam #page(commondata)

    lda #01
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #transitiontilegreen
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #transitiontilegreen
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


buenzli_bg_load_text:

    lda #bank(font01)
    tam #page(font01)

    lda #16
    sta <R0
    stz <R0 + 1
    ;lda LOW_BYTE #transparentpalette
    lda LOW_BYTE #fontpalette0
    sta LOW_BYTE <data_ptr
    ;lda HIGH_BYTE #transparentpalette
    lda HIGH_BYTE #fontpalette0
    sta HIGH_BYTE <data_ptr
    jsr loadpalette


    lda #LOW(SPRITE_START + SPRITE_SIZE *  0)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  0)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels0     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels0     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; SPACE
    lda #LOW(SPRITE_START + SPRITE_SIZE *  1)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  1)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels1     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels1     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; !
    lda #LOW(SPRITE_START + SPRITE_SIZE *  2)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  2)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels2     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels2     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; "
    lda #LOW(SPRITE_START + SPRITE_SIZE *  7)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  7)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels3     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels3     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; '
    lda #LOW(SPRITE_START + SPRITE_SIZE *  8)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  8)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels4     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels4     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; (
    lda #LOW(SPRITE_START + SPRITE_SIZE *  9)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE *  9)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels5     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels5     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; )
    lda #LOW(SPRITE_START + SPRITE_SIZE * 11)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 11)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels6     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels6     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; +
    lda #LOW(SPRITE_START + SPRITE_SIZE * 12)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 12)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels7     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels7     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; ,
    lda #LOW(SPRITE_START + SPRITE_SIZE * 13)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 13)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels8     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels8     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; -
    lda #LOW(SPRITE_START + SPRITE_SIZE * 14)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 14)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels9     
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels9     
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; .
    lda #LOW(SPRITE_START + SPRITE_SIZE * 16)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 16)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels10    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels10    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 0
    lda #LOW(SPRITE_START + SPRITE_SIZE * 17)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 17)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels11    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels11    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 1
    lda #LOW(SPRITE_START + SPRITE_SIZE * 18)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 18)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels12    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels12    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 2
    lda #LOW(SPRITE_START + SPRITE_SIZE * 19)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 19)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels13    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels13    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 3
    lda #LOW(SPRITE_START + SPRITE_SIZE * 20)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 20)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels14    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels14    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 4
    lda #LOW(SPRITE_START + SPRITE_SIZE * 21)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 21)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels15    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels15    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 5
    lda #LOW(SPRITE_START + SPRITE_SIZE * 22)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 22)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels16    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels16    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 6
    lda #LOW(SPRITE_START + SPRITE_SIZE * 23)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 23)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels17    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels17    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 7
    lda #LOW(SPRITE_START + SPRITE_SIZE * 24)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 24)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels18    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels18    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 8
    lda #LOW(SPRITE_START + SPRITE_SIZE * 25)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 25)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels19    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels19    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; 9
    lda #LOW(SPRITE_START + SPRITE_SIZE * 26)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 26)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels20    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels20    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; :
    lda #LOW(SPRITE_START + SPRITE_SIZE * 27)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 27)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels21    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels21    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; ;
    lda #LOW(SPRITE_START + SPRITE_SIZE * 31)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 31)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels22    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels22    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; ?
    lda #LOW(SPRITE_START + SPRITE_SIZE * 33)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 33)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels23    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels23    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; A
    lda #LOW(SPRITE_START + SPRITE_SIZE * 34)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 34)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels24    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels24    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; B
    lda #LOW(SPRITE_START + SPRITE_SIZE * 35)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 35)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels25    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels25    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; C
    lda #LOW(SPRITE_START + SPRITE_SIZE * 36)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 36)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels26    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels26    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; D
    lda #LOW(SPRITE_START + SPRITE_SIZE * 37)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 37)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels27    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels27    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; E
    lda #LOW(SPRITE_START + SPRITE_SIZE * 38)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 38)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels28    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels28    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; F
    lda #LOW(SPRITE_START + SPRITE_SIZE * 39)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 39)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels29    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels29    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; G
    lda #LOW(SPRITE_START + SPRITE_SIZE * 40)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 40)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels30    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels30    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; H
    lda #LOW(SPRITE_START + SPRITE_SIZE * 41)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 41)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels31    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels31    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; I
    lda #LOW(SPRITE_START + SPRITE_SIZE * 42)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 42)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels32    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels32    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; J
    lda #LOW(SPRITE_START + SPRITE_SIZE * 43)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 43)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels33    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels33    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; K
    lda #LOW(SPRITE_START + SPRITE_SIZE * 44)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 44)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels34    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels34    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; L
    lda #LOW(SPRITE_START + SPRITE_SIZE * 45)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 45)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels35    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels35    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; M
    lda #LOW(SPRITE_START + SPRITE_SIZE * 46)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 46)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels36    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels36    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; N
    lda #LOW(SPRITE_START + SPRITE_SIZE * 47)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 47)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels37    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels37    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; O
    lda #LOW(SPRITE_START + SPRITE_SIZE * 48)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 48)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels38    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels38    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; P
    lda #LOW(SPRITE_START + SPRITE_SIZE * 49)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 49)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels39    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels39    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; Q
    lda #LOW(SPRITE_START + SPRITE_SIZE * 50)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 50)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels40    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels40    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; R
    lda #LOW(SPRITE_START + SPRITE_SIZE * 51)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 51)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels41    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels41    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; S
    lda #LOW(SPRITE_START + SPRITE_SIZE * 52)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 52)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels42    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels42    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; T
    lda #LOW(SPRITE_START + SPRITE_SIZE * 53)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 53)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels43    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels43    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; U
    lda #LOW(SPRITE_START + SPRITE_SIZE * 54)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 54)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels44    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels44    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; V
    lda #LOW(SPRITE_START + SPRITE_SIZE * 55)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 55)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels45    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels45    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; W
    lda #LOW(SPRITE_START + SPRITE_SIZE * 56)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 56)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels46    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels46    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; X
    lda #LOW(SPRITE_START + SPRITE_SIZE * 57)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 57)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels47    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels47    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; Y
    lda #LOW(SPRITE_START + SPRITE_SIZE * 58)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + SPRITE_SIZE * 58)
    sta HIGH_BYTE <vram_ptr
    lda LOW_BYTE #fontpixels48    
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #fontpixels48    
    sta HIGH_BYTE <data_ptr
    jsr loadsprite; Z

    stz <R0
    stz <R0 + 1

    ; prepare satb for texts
    lda LOW_BYTE #buenzli_bg_text01
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #buenzli_bg_text01
    sta HIGH_BYTE <data_ptr

    lda LOW_BYTE #satb
    sta LOW_BYTE <satb_ptr
    lda HIGH_BYTE #satb
    sta HIGH_BYTE <satb_ptr

    lda #$28
    sta LOW_BYTE <R1
    stz HIGH_BYTE <R1

    lda #$50
    sta LOW_BYTE <R2
    stz HIGH_BYTE <R2

    jsr maketextsatb

    ; text02
    incw <data_ptr
    lda #$40
    sta LOW_BYTE <R1
    stz HIGH_BYTE <R1

    lda #$90
    sta LOW_BYTE <R2
    stz HIGH_BYTE <R2

    jsr maketextsatb


    ; text03
    incw <data_ptr
    lda #$50
    sta LOW_BYTE <R1
    stz HIGH_BYTE <R1

    lda #$B0
    sta LOW_BYTE <R2
    stz HIGH_BYTE <R2

    jsr maketextsatb


    ; text04
    incw <data_ptr
    lda #$28
    sta LOW_BYTE <R1
    stz HIGH_BYTE <R1

    lda #$D0
    sta LOW_BYTE <R2
    stz HIGH_BYTE <R2

    jsr maketextsatb


    ; text05
    incw <data_ptr
    lda #$40
    sta LOW_BYTE <R1
    stz HIGH_BYTE <R1

    lda #$F0
    sta LOW_BYTE <R2
    stz HIGH_BYTE <R2

    jsr maketextsatb




    copypalette whitepalette, palette


    rts



wazza_buenzli_load:
    lda #bank(wazza_data_01)
    tam #page(wazza_data_01)

	lda #LOW(SPRITE_START)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(wazza01_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(wazza01_0)
    sta HIGH_BYTE <data_ptr

    lda #54
    sta <R0
    stz <R0 + 1

    jsr loadsprites


    lda #bank(wazza_data_02)
    tam #page(wazza_data_02)

	lda #LOW(SPRITE_START + WAZZA02_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + WAZZA02_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(wazza02_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(wazza02_0)
    sta HIGH_BYTE <data_ptr

    lda #51
    sta <R0
    stz <R0 + 1

    jsr loadsprites


    lda #bank(wazza_data_03)
    tam #page(wazza_data_03)

	lda #LOW(SPRITE_START + WAZZA03_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + WAZZA03_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(wazza03_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(wazza03_0)
    sta HIGH_BYTE <data_ptr

    lda #54
    sta <R0
    stz <R0 + 1

    jsr loadsprites


    lda #bank(wazza_data_04)
    tam #page(wazza_data_04)

	lda #LOW(SPRITE_START + WAZZA04_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + WAZZA04_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(wazza04_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(wazza04_0)
    sta HIGH_BYTE <data_ptr

    lda #52
    sta <R0
    stz <R0 + 1

    jsr loadsprites


    lda #bank(wazza_data_05)
    tam #page(wazza_data_05)

	lda #LOW(SPRITE_START + WAZZA05_OFFSET)
    sta LOW_BYTE <vram_ptr
    lda #HIGH(SPRITE_START + WAZZA05_OFFSET)
    sta HIGH_BYTE <vram_ptr
    lda #LOW(wazza05_0)
    sta LOW_BYTE <data_ptr
    lda #HIGH(wazza05_0)
    sta HIGH_BYTE <data_ptr

    lda #54
    sta <R0
    stz <R0 + 1

    jsr loadsprites




    rts

    
	
buenzli_bg:
    stz LOW_BYTE <frame_counter
    stz HIGH_BYTE <frame_counter

    jsr buenzli_bg_load
    jsr wazza_buenzli_load

    stz <R14

    stz <R10 ; wazza offset table
    stz <R10 + 1
    stz <R11 ; wazza offset table increments
    stz <R11 + 1
    stz <R12 ; wazza offset table index

    stz <R13 ; wazza table index
    stz <frame_skip_counter




    clx
.wait:

    jsr wait_vsync

;
; !!! scroll the bg
;
    st0 #$08
    lda <R14
    sta $0002
    lda <R14 + 1
    sta $0003

    st0 #$07
    lda <R14
    sta $0002
    lda <R14 + 1
    sta $0003

;
; !!! scroll the bg
;

    
    cmpw #556, <frame_counter
    lbeq .cleanupwazza
    lbhs .displaytext


;
; !!! display wazza bnz
;
    lda #16
    sta <R0
    stz <R0 + 1
    lda LOW_BYTE #wazza01_palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #wazza01_palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    ldx <R13
    lda wazza_index, x
    cmp #01
    lbeq .wazza01
    cmp #02
    lbeq .wazza02
    cmp #03
    lbeq .wazza03
    cmp #04
    lbeq .wazza04
    cmp #05
    lbeq .wazza05

    jmp .afterwazza

.wazza01:
    lda #bank(wazza_data_01)
    tam #page(wazza_data_01)
    tii wazza01_satb, satb, 504
    jmp .afterwazza

.wazza02:
    lda #bank(wazza_data_02)
    tam #page(wazza_data_02)
    tii wazza02_satb, satb, 504
    jmp .afterwazza

.wazza03:
    lda #bank(wazza_data_03)
    tam #page(wazza_data_03)
    tii wazza03_satb, satb, 504
    jmp .afterwazza

.wazza04:
    lda #bank(wazza_data_04)
    tam #page(wazza_data_04)
    tii wazza04_satb, satb, 504
    jmp .afterwazza

.wazza05:
    lda #bank(wazza_data_05)
    tam #page(wazza_data_05)
    tii wazza05_satb, satb, 504
    jmp .afterwazza
;
; !!! display wazza bnz
;

.afterwazza:
    lda LOW_BYTE #in_wazza_offsets
    sta LOW_BYTE <R10
    lda HIGH_BYTE #in_wazza_offsets
    sta HIGH_BYTE <R10
    lda LOW_BYTE #in_wazza_increments
    sta LOW_BYTE <R11
    lda HIGH_BYTE #in_wazza_increments
    sta HIGH_BYTE <R11

.setoutwazzaoffsets:
    cmpw #506, <frame_counter
    lblo .movewazza
    lda LOW_BYTE #out_wazza_offsets
    sta LOW_BYTE <R10
    lda HIGH_BYTE #out_wazza_offsets
    sta HIGH_BYTE <R10
    lda LOW_BYTE #out_wazza_increments
    sta LOW_BYTE <R11
    lda HIGH_BYTE #out_wazza_increments
    sta HIGH_BYTE <R11
    cmpw #506, <frame_counter
    lbne .movewazza

    stz <R12

.movewazza:
    stz <R0 + 1
    ldy <R12
    cpy #32
    lblo .domovewazza
    ldy #31
    sty <R12
.domovewazza:
    lda [R10], y
    sta <R0
    lda [R11], y
    sta <R1
    lda #63
    sta <R2
    stz <R3
    jsr satbshiftx

    iny
    lda [R10], y
    sta <R0
    lda [R11], y
    sta <R1
    lda #63
    sta <R2
    stz <R3
    jsr satbshifty

    inc <R12
    inc <R12

.copywazza:
    jsr copysatb
    inc <frame_skip_counter
    lda <frame_skip_counter
    cmp #6
    lbne .end

    stz <frame_skip_counter
    inc <R13

    jmp .end

.cleanupwazza:
    jsr clearsatb
    jsr copysatb

    jsr buenzli_bg_load_text
    stz <frame_skip_counter

    ; precalc each palette between whitepalette (#0) and fontpalette0 (#6)
    copypalette #whitepalette, palette
   
    clx
.calcpalette:
    txa
    adc #16
    sta <R0
    lda LOW_BYTE #palette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #palette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    lda LOW_BYTE #palette
    sta LOW_BYTE <R0
    lda HIGH_BYTE #palette
    sta HIGH_BYTE <R0

    lda LOW_BYTE #fontpalette0
    sta LOW_BYTE <R1
    lda HIGH_BYTE #fontpalette0
    sta HIGH_BYTE <R1

    jsr fadepalette

    inx
    cpx #7
    bne .calcpalette
    

    stz <R10 + 1 ; letter counter

.displaytext:
    inc <frame_skip_counter
    lda <frame_skip_counter
    cmp #01
    lbne .end
    stz <frame_skip_counter


    lda #$04
    sta <R10 ; previous letter's index

    lda #bank(buenzli_bg_data)
    tam #page(buenzli_bg_data)
    clx
.displayletter:
    lda letters_index, x
    bne .processletter
    
    ; letters's offset is 0, but is it time to process it ?
    ; check if previous letter's offset is higher than 4 to decide
    lda <R10
    cmp #$04
    lblo .nextletter

.processletter:
    ldy letters_index, x
    beq .initletter
    cpy #BNZ_OFFSETS_LENGTH
    beq .nextletter
    jmp .moveletter

.initletter:
    lda <R10 + 1 ; pause for 1 sec after 15th letter
    cmp #15
    bne .goinitletter
    cmpw #706, <frame_counter
    lblo .nopaleffect


.goinitletter:
    inc <R10 + 1 ; one more letter to display

.moveletter:
    stx <R3
    lda letters_y_offsets, y
    sta <R0
    lda letters_y_increments, y
    sta <R1
    lda #$01
    sta <R2
    jsr satbshifty ; <R3 = which item to begin with, <R0 = amount, <R1 = 1 increment, 0 decrement, <R2 item count

    lda letters_index, x
    cmp #7
    lbhs .nopalette

    stx <R0
    sta <R1
    jsr setsatbpalette


.nopalette:
    lda letters_index, x
    inc a
    sta letters_index, x

    
.nextletter: 
    lda letters_index, x
    sta <R10
    inx
    cpx #BNZ_TEXT_LENGTH
    bne .displayletter

    
.nopaleffect:

    stz <R0
    lda <R10 + 1
    sta <R1
    jsr copysatbslice

    cmpw #1056, <frame_counter
    lblo .end
    lbne .outtheletters
    stz <R13 ; reset letters movement index
.outtheletters:
    ; todo : bouger les lettres suivants 
    ; letters_out_offsets et letters_out_increments
    ; en inversant les incréments à chaque ligne
    lda <R13
    cmp #91
    lbhs .end

    stz <R3
    ldx <R13
    lda letters_out_offsets, x
    sta <R0
    lda letters_out_increments, x
    sta <R1
    clx
    lda buenzli_bg_text_lengths, x
    sta <R2
    jsr satbshiftx



    lda #15 ; ça me saoule de faire une table pour les offsets ^_^
    sta <R3
    ldx <R13
    lda letters_out_offsets, x
    sta <R0
    lda letters_out_increments, x
    eor #$01
    sta <R1
    ldx #$01
    lda buenzli_bg_text_lengths, x
    sta <R2
    jsr satbshiftx



    lda #27
    sta <R3
    ldx <R13
    lda letters_out_offsets, x
    sta <R0
    lda letters_out_increments, x
    sta <R1
    ldx #$02
    lda buenzli_bg_text_lengths, x
    sta <R2
    jsr satbshiftx



    lda #37
    sta <R3
    ldx <R13
    lda letters_out_offsets, x
    sta <R0
    lda letters_out_increments, x
    eor #$01
    sta <R1
    ldx #$03
    lda buenzli_bg_text_lengths, x
    sta <R2
    jsr satbshiftx


    lda #52
    sta <R3
    ldx <R13
    lda letters_out_offsets, x
    sta <R0
    lda letters_out_increments, x
    sta <R1
    ldx #$04
    lda buenzli_bg_text_lengths, x
    sta <R2
    jsr satbshiftx




.end:
    cmpw #1024, <frame_counter ; must be a 256 multiple
    lblo .incr14
    lbne .incwr14

    jsr wait_vsync

    st0 #$09        ; set the BAT size to 64x64 (tiles, not pixels :) )
    st1 #%01010000
    st2 #$00

;fill the bat
    st0 #$00
    st1 #$00
    st2 #$00
    st0 #$02

    lda #bank(buenzli_bg_data2)
    tam #page(buenzli_bg_data2)
    tia bnzendbat, $0002, 2 * 64 * 64


.incwr14:
    ; double speed when going offscreen
    incw <R14
    incw <R14
    inc <R13 ; letter offscreen movement index
    bra .incframecounter
.incr14:
    inc <R14

.incframecounter:
    incw <frame_counter

    cmpw #1152, <frame_counter
    lbne .wait
    ;jmp .wait

    jsr clearsatb
    jsr copysatb

    st0 #$09        ; set the BAT size to 32x32 (tiles, not pixels :) )
    st1 #$00
    st2 #$00

    rts

