DEBUG .equ 0
TILE_START .equ $1000 ; $2500 words for tiles = 592 tiles max
TRANSITION_TILE_START .equ $34e0
TILE_SIZE .equ $10
SPRITE_START .equ $3700 ; $48FF word for sprites = 291 sprites max
SPRITE_SIZE .equ $40 ; in words
SATB_START .equ $3500
SATB_ITEM_SIZE .equ $08 ; in bytes

NB_GREETS .equ $0D
GREETS_SPEED .equ $02
BNZ_TEXT_LENGTH .equ $40
BNZ_OFFSETS_LENGTH .equ $13

RASTER_COUNT .equ $08;$0D
RASTER_SCREEN_HEIGHT .equ $f2
STARFIELD_SCREEN_HEIGHT .equ $f3 ; en vrai c'est $80 mais comme ça c'est plus pratique
RASTER_MOVEMENT_LENGTH .equ $80
RASTER_MAGIC_VALUE .equ $f2 ; TODO: make this a black line in the bg

POULPE_SATB_START .equ $00 ;$2D ; in items
POULPE_COUNT .equ $12

    .zp
vdc_status_register: .ds 1
vdc_current_scanline:.ds 1
frame_counter:.ds 2
frame_skip_counter:.ds 1
in_timer_int:   .ds 1
timer_counter:  .ds 2
MR0: .ds 2 ; comme R0, mais réservé à l'usage des macros
MR1: .ds 2 ; comme R1, mais réservé à l'usage des macros
MR2: .ds 2 ; comme R2, mais réservé à l'usage des macros
MR3: .ds 2 ; comme R3, mais réservé à l'usage des macros
r: .ds 1
g: .ds 1
b: .ds 1
R0: .ds 2
R1: .ds 2
R2: .ds 2
R3: .ds 2
R4: .ds 2

R10: .ds 2
R11: .ds 2
R12: .ds 2
R13: .ds 2
R14: .ds 2

data_ptr:   .ds 2
vram_ptr:   .ds 2
satb_ptr:   .ds 2

scanline_handler:   .ds 2

        .bss
satb:          .ds 512
palette:       .ds 16; * 2
greetees:      .ds NB_GREETS * 2
greetees_satb: .ds NB_GREETS * 2
greetees_active: .ds NB_GREETS
greetees_offsets: .ds NB_GREETS
letters_index: .ds BNZ_TEXT_LENGTH
letters_palette: .ds BNZ_TEXT_LENGTH
rasters_table: .ds RASTER_SCREEN_HEIGHT
rasters_offsets: .ds RASTER_COUNT
rasters_index: .ds RASTER_COUNT
rasters_started: .ds RASTER_COUNT
starfield_offsets: .ds STARFIELD_SCREEN_HEIGHT
poulpe_offsets: .ds POULPE_COUNT
poulpe_y: .ds POULPE_COUNT * 2



    .code
    .bank $00
    .org $e000
    .include "_funcs.asm"
    .include "_macrosbase.asm"
    .include "_macros.asm"
    .include "_font.asm"
    .include "_transition.asm"
    .include "_sound.asm"
    .include "azasel/azasel.asm"
    .include "fadetowhite.asm"
    .include "punkfloyd_logo.asm"
    .include "buenzli_bg.asm"
    .include "demo_logo.asm"
   
startup:
    sei             ; disable interrupts
    csh             ; set cpu to 7.16Mhz ultra turbo mode :)
	cld 			; clear the decimal flag 
    ldx #$ff
    txs             ; initialise the stack
    lda #$ff
    tam #$00        ; map hardware bank ($ff) to MPR0
    lda #$f8
    tam #$01        ; map ram bank ($f8) to MPR1

    stz $2000       ; set first byte of ram to 0
    tii $2000, $2001, $1fff ; copy this byte in the whole ram (i.e zero out the ram)

    st0 #$05        ; activate bg and sprite planes, and vertical and horizontal blanking
    lda #%11001100
    sta $0002
    st2 #$00

    st0 #$09        ; set the BAT size to 32x32 (tiles, not pixels :) )
    st1 #$00
    st2 #$00

    ; setup 256x242 display mode (values are shamelessly ripped from Bonk's Revenge)
    st0 #$0A
    st1 #$02
    st2 #$02

    st0 #$0B
    .if (DEBUG)
    st1 #$1e ; 1f
    st2 #$01 ; 04
    .else
    st1 #$1f
    st2 #$04
    .endif

    st0 #$0C
    st1 #$02
    st2 #$0F

    st0 #$0D
    st1 #$ef
    st2 #$00

    st0 #$0E
    st1 #$04
    st2 #$00

    st0 #$0f
    st1 #$00
    st2 #$00

    lda #$04
    sta $400

    cly
    lda #bank(song_1)
    sta song_bank,y
    lda #low(song_1)
    sta song_ptr.l,y
    lda #high(song_1)
    sta song_ptr.h,y

    stz current_song
    jsr load_song


    ; timer setup (uncomment for sound)
    lda #$00 ; bonk puts d0 oO
    sta $c00
    lda #$01 ; bonk puts 03 oO
    sta $c01

    ; map the memory location of our data
    lda #bank(commondata)
    tam #page(commondata)

    stz <R0
    stz <R0 + 1
    lda LOW_BYTE #blackpalette
    sta LOW_BYTE <data_ptr
    lda HIGH_BYTE #blackpalette
    sta HIGH_BYTE <data_ptr
    jsr loadpalette

    ; we don't use irq2 int so we mask it
    lda #$00000001
    sta $1402


    cli
main:

    ldx #120
.wait01:
    jsr wait_vsync
    dex
    bne .wait01

    jsr clearsatb
    jsr copysatb
    ;jsr warning
    jsr fadetowhite
    jsr punkfloyd_logo
    jsr buenzli_bg
    jsr demo_logo
    jsr rasters
    jsr greets
    jsr credits
    jsr goodbye



    jmp startup


_timer:
    pha
    phx
    phy
    stz $1403 ; during a timer interrupt, we HAVE to write to this register to acknowledge the interrupt

    cmpw #$0067, <timer_counter
    bcs ._endtimer
    lda <in_timer_int
    bne ._endtimer
    inc <in_timer_int
    cli

    incw <timer_counter
    jsr Azasel

    stz <in_timer_int

._endtimer:
    ply
    plx
    pla
    rti

_irq2:
    rti

_vdc:
    pha
    lda $0000 ; during a VDC interrupt, we HAVE to read this register (the VDC status register) to acknowledge the interrupt, else we'll be stuck here forever
    sta <vdc_status_register
    bbr5 <vdc_status_register, .noresetscanlinecount
    stz <vdc_current_scanline
    stz <timer_counter
    stz <timer_counter + 1
.noresetscanlinecount:
    pla
    bbs2 <vdc_status_register, _vdc_scanline
    rti

_vdc_scanline:
    pha
    lda LOW_BYTE <scanline_handler
    bne .goscanline
    lda HIGH_BYTE <scanline_handler
    beq ._default_scanline
.goscanline:
    pla
    jmp [scanline_handler]
._default_scanline
    pla
    jmp dummy_scanline

    ; no rti here since it's done in either [scanline_handler] or dummy_scanline
    ;rti

_nmi:
    rti

.data
; set interrupt handlers
    .org $fff6
    .dw _irq2
    .dw _vdc
    .dw _timer
    .dw _nmi
    .dw startup     ; RESET, which is called when the console boots, so this must map to our startup code

     .code

   .bank $50
    .org $c000
commondata:
    .include "common.asm"
    .include "rasters.asm"
    .include "greets.asm"
    .include "credits.asm"
    .include "goodbye.asm"
    .include "warning.asm"
 
    .bank $10
    .org $4000
punkfloyd_logo_data:
    .include "punkfloyd_logo_data.asm"

    .bank $11
    .org $4000
buenzli_bg_data:
    .include "buenzli_bg_data.asm"

    .bank $12
    .org $4000
buenzli_bg_data2:
    .include "buenzli_bg_data2.asm"


    .bank $13
    .org $4000
font01:
    .include "font01.asm"

    .bank $14
    .org $4000
font02:
    .include "font02.asm"

    .bank $15
    .org $4000
fontasteroids:
    .include "fontasteroids.asm"



    .bank $16
    .org $4000
demo_logo_data:
    .include "demo_logo_data.asm"
    .bank $17
    .org $4000
demo_logo_data2:
    .include "demo_logo_data2.asm"
    .bank $18
    .org $4000
demo_logo_data3:
    .include "demo_logo_data3.asm"

    .bank $19
    .org $4000
greets_data:
    .include "greets_data.asm"

    .bank $1a
    .org $4000
greets_data2:
    .include "greets_data2.asm"


    .bank $1b
    .org $4000
wazza_data_01:
    .include "wazza_data1.asm"

    .bank $1c
    .org $4000
wazza_data_02:
    .include "wazza_data2.asm"

    .bank $1d
    .org $4000
wazza_data_03:
    .include "wazza_data3.asm"

    .bank $1e
    .org $4000
wazza_data_04:
    .include "wazza_data4.asm"

    .bank $1f
    .org $4000
wazza_data_05:
    .include "wazza_data5.asm"

    .bank $20
    .org $4000
credits_data_01:
    .include "credits_data1.asm"

    .bank $21
    .org $4000
credits_data_02:
    .include "credits_data2.asm"

    .bank $22
    .org $4000
credits_data_03:
    .include "credits_data3.asm"

    .bank $23
    .org $4000
credits_data_04:
    .include "credits_data4.asm"

    .bank $24
    .org $4000
goodbye_data:
    .include "goodbye_data.asm"

    .bank $25
    .org $4000
rasters_data:
    .include "rasters_data.asm"

    .bank $26
    .org $4000
transitions_data:
    .include "transitions.asm"

    .bank $27
    .org $4000
greets_data3:
    .include "greets_data3.asm"

    .bank $28
    .org $4000
credits_data_05:
    .include "credits_data5.asm"

    .bank $29
    .org $4000
warning_data:
    .include "warning_data.asm"

    .bank $2a
    .org $4000
warning_data2:
    .include "warning_data2.asm"

    .bank $2b
    .org $4000
warning_data3:
    .include "warning_data3.asm"


    .bank $02
    .org $6000
  .include "music/newmusic.azl"

    .bank $06
    .org $6000
  .include "music/samples_.inc"

