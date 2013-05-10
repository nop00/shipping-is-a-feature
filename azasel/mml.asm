;///////////////////////////////////////////////////////////////////////////////
;
; PCE music player using Azasel format  
; 
;
;
;
  .list
  .mlist
  
START_BANK .EQU 0
CODE_BANK  .EQU START_BANK+$01  
DATA_BANK  .EQU START_BANK+$10



  .bank START_BANK             
    .include "equ.asm"
    .include "macro.asm"
    .include "_startup.asm"
  



;*******************************************************************************
;///////////////////////////////////////////////////////////////////////////////*
;//MAIN                                                                       //*
;///////////////////////////////////////////////////////////////////////////////*
;.
main:                             

      jsr init_vdc

      VCE_REG MID_RES|H_FILTER
      VDC_REG DCR , AUTO_SATB_ON          
      VDC_REG CR , $0000
      IRQ_CNTR IRQ2_ON|VIRQ_ON|TIRQ_ON
      VDC_REG SATB , $7F00
      VDC_REG MWR , SCR64_32
      jsr load_font

      VDC_REG CR, $00CC
      cli                                       

      lda #bank(intrn_dat)
      tam #$02

      jsr wait_vblank
    
      lda #low(strng1)
      sta <R0
      lda #high(strng1)
      sta <R0+1
      lda #$88
      ldx #$00
      jsr print_str
    
      lda #low(strng2)
      sta <R0
      lda #high(strng2)
      sta <R0+1
      lda #$88
      ldx #$03
      jsr print_str


      lda #low(strng3)
      sta <R0
      lda #high(strng3)
      sta <R0+1
      lda #$c8
      ldx #$02
      jsr print_str

      lda #low(strng4)
      sta <R0
      lda #high(strng4)
      sta <R0+1
      lda #$c8
      ldx #$01
      jsr print_str

      lda #low(strng5)
      sta <R0
      lda #high(strng5)
      sta <R0+1
      lda #$08
      ldx #$04
      jsr print_str

      lda #low(strng6)
      sta <R0
      lda #high(strng6)
      sta <R0+1
      lda #$48
      ldx #$04
      jsr print_str

      lda #low(strng7)
      sta <R0
      lda #high(strng7)
      sta <R0+1
      lda #$88
      ldx #$04
      jsr print_str

     
      ldx #$01
      stz $402
      stz $403
      stz $404
      stz $405
      lda #$22
      sta $404
      stx $405
      lda #$35
      sta $404
      stx $405
      lda #$77
      sta $404
      stx $405
      lda #$77
      sta $404
      stx $405
      lda #$ff
.pal_write
      sta $404
      sta $405
      inx
      cpx #$0c
      bne .pal_write
      
      stz tempo_override
      lda #$74
      sta tempo_alt

      cly
      lda #bank(song_1)
      sta song_bank,y
      lda #low(song_1)
      sta song_ptr.l,y
      lda #high(song_1)
      sta song_ptr.h,y
      
      
            
      lda #$00
      sta current_song
      lda #low(Azasel)
      sta TMR_indirect
      lda #high(Azasel)
      sta TMR_indirect+1
      jsr load_song
    
           
      lda #$01
      stz $c00
      sta $c01
      
main_loop: 
      jsr wait_vblank
      jsr READ_IO
      jsr disp_notes
      jsr disp_tune
      jsr disp_key
      jsr disp_tempo
      
      
      
      lda rh_sts
      beq .next
      stz lf_dly
      lda rh_dly
      inc a
      and #$07
      sta rh_dly
      bne .out
      lda current_song
      cmp #$17
      bcs .out
      inc a
      sta current_song
      stz $c01
      jsr load_song
      lda #$01
      sta $c01
      bra .out
.next
      lda lf_sts
      beq .out
      stz rh_dly
      lda lf_dly
      inc a
      and #$07
      sta lf_dly
      bne .out
      lda current_song
      beq .out
      dec a
      sta current_song
      stz $c01
      jsr load_song
      lda #$01
      sta $c01
.out
      
      lda sl_sts
      beq .skp0
      lda sl_dly
      inc a
      and #$0f
      sta sl_dly
      bne .skp0
      lda tempo_override
      eor #$01
      sta tempo_override
      beq .disable
.enable
      lda tempo_alt
      sta tempo
      bra .skp0
.disable
      lda tempo_org
      sta tempo
.skp0

      lda b2_sts
      beq .skp1
      lda b2_dly
      inc a
      and #$03
      sta b2_dly
      bne .out2
      lda tempo_alt
      cmp #$ff
      beq .skp1
      inc a
      sta tempo_alt
      ldx tempo_override
      beq .out2
      sta tempo
      bra .out2
.skp1
      lda b1_sts
      beq .out2
      lda b1_dly
      inc a
      and #$03
      sta b1_dly
      bne .out2
      lda tempo_alt
      cmp #$00
      beq .out2
      dec a
      sta tempo_alt
      ldx tempo_override
      beq .out2
      sta tempo
.out2
      
      jmp main_loop                       ;An infinite loop is always fun :D
;...............................................................................
;End MAIN






;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Hardware initialize code                                                   //.
;///////////////////////////////////////////////////////////////////////////////.
;.

    .include "init_hw.asm"
;...............................................................................
;End include




;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Subroutines.                                                               //.
;///////////////////////////////////////////////////////////////////////////////.
;.


;//gamepad code
  .include "gamepad.asm"


;//wait for vblank. Not much else to say about it.
wait_vblank:
      pha
      lda #$01
      sta <__vblank
.loop
      lda <__vblank
      bne .loop
      pla
    rts
;#end

 ;//load the track pointers
load_song:
      ldy current_song
      lda song_bank,y
      tam #$03
      inc a
      tam #$04
      inc a
      tam #$05
      lda song_ptr.l,y
      clc
      adc #$01
      sta <R0
      lda song_ptr.h,y
      adc #$00
      sta <R0+1
      cly
      
      clx
.ll00
      lda [R0],y
      iny
      sta trk_ptr.l,x
      lda [R0],y
      iny
      sta trk_ptr.h,x
      inx
      cpx #$06
      bcc .ll00
      
      lda tempo_alt
      sta tempo

      ldx #$05
      lda #$01
.ll01
      stx $800
      ldy #$ff
      stz $805            ;**
      stz $802
      stz $803
      sta chn_dly,x
      stz env_vol,x
      stz vbr_mode,x
      stz vbr_delta.l,x
      stz vbr_delta.h,x
      stz chn_frq.l,x
      stz chn_frq.h,x
      lda #$55
      sta chn_note,x
      lda #$01
      stz $804
      stz chn_dda,x
      dex
      bpl .ll01
      
      lda #$ff  ;**
      sta $801
      sta tempo_cntr
      
      ldx #$20
      lda #$05
      sta $800
      stz $804
.ll02
      stz $806
      dex
      bne .ll02

      ldx #$05       
.ll03            
      lda #$0f
      sta chn_left,x
      sta chn_right,x
      lda #$03
      sta trml_sub,x
      stx $800
      stz $804
      stz $807
      lda #$06
      sta env_phase,x
      stz env_vol,x
      stz detune.l,x
      stz detune.h,x
      stz chn_mode,x
      dex
      bpl .ll03     

      lda current_song
      inc a
      tay
      lda #$8f
      ldx #$03
      clc
      jsr print_byte
      
    rts


;//load the font tiles <_<;
load_font:
    
    st0 #$00
    st1 #$00
    st2 #$10
    st0 #$02
    
    lda #bank(font)
    tam #$02
    inc a
    tam #$03
    
    tia (font & $1fff)+ $4000,$0002,$c00
  rts
    
    
;// the frak'n display
disp_notes:   
    clx
    stz <vdc_reg
    st0 #$00
    st1 #$07
    st2 #$01
    lda #$02
    sta <vdc_reg
    st0 #$02

.ll01
    st1 #$00
    st2 #$00
    lda env_vol,x
    beq .blank
.cont   
    lda chn_note,x
    sta <R1
    stz <R1+1
    asl <R1
    rol <R1+1
    asl <R1
    rol <R1+1
    lda <R1
    clc
    adc #low(ascii_notes)
    sta <R1
    lda <R1+1
    adc #high(ascii_notes)
    sta <R1+1
    cly
.ll02
    lda [R1],y
    beq .out
    sec
    sbc #$20
    sta $0002
    st2 #$01
    iny
    cpy #$03
    bne .ll02
.out
    inx
    cpx #$05
    bne .ll01
    st1 #$00
    st2 #$00
    st1 #$00
    st2 #$00
    lda <sample_end
    beq .skp0
    st1 #$00
    st2 #$00    
    st1 #$00
    st2 #$00    
    st1 #$00
    st2 #$00    
    bra .exit   
.skp0       
    lda chn_note,x
    lsr a
    lsr a
    lsr a
    lsr a
    tay
    lda hex_conv,y
    sec
    sbc #$20
    sta $0002
    st2 #$01
    lda chn_note,x
    and #$0f
    tay
    lda hex_conv,y
    sec
    sbc #$20
    sta $0002
    st2 #$01
.exit   
  rts       
.blank
    st1 #$00
    st2 #$00    
    st1 #$00
    st2 #$00    
    st1 #$00
    st2 #$00    
    bra .out

    
;//Print chan detune values
;
disp_tune:
    stz <vdc_reg
    st0 #$00
    st1 #$08
    st2 #$03
    lda #$02
    sta <vdc_reg
    st0 #$02
    
    clx
.ll01
    lda detune.h,x
    beq .plus
.minus
    lda detune.l,x
    eor #$ff
    inc a
    tay
    st1 #$0d
    st2 #$01
    sec
    bra .show
.plus
    lda detune.l,x
    tay
    st1 #$0b
    st2 #$01    
    sec
        
.show   
    phx
    jsr print_byte
    plx
    st1 #$00
    st2 #$00
    inx
    cpx #$06
    bne .ll01
  rts
    
;//display key presses
disp_key:
    stz <vdc_reg
    st0 #$00
    st1 #$08
    st2 #$02
    lda #$02
    sta <vdc_reg
    st0 #$02
    clx
.ll01

    lda env_vol,x
    beq .off
    
    
    lda chn_mode,x
    and #$02
    beq .no_rls
    lda env_phase,x
    cmp #$06
    beq .off    
    bra .key_on
.no_rls
    lda env_phase,x
    cmp #$04
    beq .off
    cmp #$05
    beq .off
    cmp #$06
    beq .off
    
    
.key_on       
    st1 #$00
    st2 #$00
    st1 #$2f
    st2 #$01
    st1 #$2e
    st2 #$01
    st1 #$00
    st2 #$00
    bra .inc
.rls
    st1 #$32
    st2 #$01
    st1 #$2c
    st2 #$01
    st1 #$33
    st2 #$01
    st1 #$00
    st2 #$00
    bra .inc
.off
    st1 #$00
    st2 #$00
    st1 #$00
    st2 #$00
    st1 #$00
    st2 #$00
    st1 #$00
    st2 #$00
        

.inc
    inx
    cpx #$05
    bne .ll01
    
    lda <sample_end
    bne .s_off
    st1 #$00
    st2 #$00
    st1 #$2f
    st2 #$01
    st1 #$2e
    st2 #$01
    st1 #$00
    st2 #$00
  rts     
.s_off
    st1 #$00
    st2 #$00
    st1 #$00
    st2 #$00
    st1 #$00
    st2 #$00
    st1 #$00
    st2 #$00
  rts   
       
;//Tempo        
disp_tempo:
    lda #$0f
    ldx #$04
    ldy tempo_org
    clc
    jsr print_byte
    lda #$55
    ldx #$04
    ldy tempo_override
    clc
    jsr print_byte
    lda #$93
    ldx #$04
    ldy tempo_alt
    clc
    jsr print_byte
  rts
    
    
;//Print string ascii string
;///////////////////////////
; vram addr in X:A
; string addr in R0
;
print_str:
    stz <vdc_reg
    st0 #$00
    sta $0002
    stx $0003
    lda #$02
    sta <vdc_reg
    st0 #$02
    cly

.ll01
    lda [R0],y
    beq .out
    sec
    sbc #$20
    sta $0002
    st2 #$01
    iny
    bra .ll01
.out
  rts
  
  
;//Print variable to x,y location
;/ X:A vram addr
;/ y=value
;/ Carry; 1=append last location, 0=location in X:A
print_byte:
    bcs .skip
    stz <vdc_reg
    st0 #$00
    sta $0002
    stx $0003
    lda #$02
    sta <vdc_reg
    st0 #$02
.skip   
    tya
    tax
    lsr a
    lsr a
    lsr a
    lsr a
    tay
    lda hex_conv,y
    sec
    sbc #$20
    sta $0002
    st2 #$01
    txa
    and #$0f
    tay
    lda hex_conv,y
    sec
    sbc #$20
    sta $0002
    st2 #$01
  rts 

print_lo_nibble:
    bcs .skip
    stz <vdc_reg
    st0 #$00
    sta $0002
    stx $0003
    lda #$02
    sta <vdc_reg
    st0 #$02
.skip   
    tay
    and #$0f
    tay
    lda hex_conv,y
    sec
    sbc #$20
    sta $0002
    st2 #$01
  rts 

print_hi_nibble:
    bcs .skip
    stz <vdc_reg
    st0 #$00
    sta $0002
    stx $0003
    lda #$02
    sta <vdc_reg
    st0 #$02
.skip   
    tay
    lsr a
    lsr a
    lsr a
    lsr a
    tay
    lda hex_conv,y
    sec
    sbc #$20
    sta $0002
    st2 #$01
  rts 

print_indent:
.ll01
    st1 #$00
    st2 #$00
    dey
    bne .ll01
    rts



;...............................................................................
;End MAIN SUB



;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Azasel                                                                     //.
;///////////////////////////////////////////////////////////////////////////////.
;.

    .include "azasel.asm"




;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Interrupt handlers.                                                        //.
;///////////////////////////////////////////////////////////////////////////////.
;.


;#int
IRQ_2:

    rti
;#end int


;#int
TIMER:                  ;8 for call
    stz $1403           ;5
    jsr Azasel  ;
    rti
  
;#end int


;#int
NMI:

    rti
;#end int


;#int
VDC_INT:
      pha
      lda vdc_status
      and #$20
      bne .vsync
      bra .hsync
  
.vsync
      st0 #$05
      st1 #$cc
      lda <__BXR
      st0 #$07
      sta $0002
      lda <__BXR+1
      sta $0003
    
      lda <__BYR
      st0 #$08
      sta $0002
      lda <__BYR+1
      sta $0003
      lda <vdc_reg
      sta $0000
      st0 #$06
      lda <RCR_start
      sta $0002
      lda <RCR_start+1
      sta $0003
      bra .exit 

.hsync
      st0 #$05
      st1 #$8c
      st0 #BXR
      st1 #$00
      st2 #$00
      st0 #BYR
      st1 #$f0
      st2 #$00

      ;jsr READ_IO

          
    
      lda <vdc_reg
      sta $0000
  
    
  
.exit 
      lda <vdc_reg
      sta $0000
      stz <__vblank
      pla
    rti
;#end int
;...............................................................................
;End INT

.4343


;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Interrupt Vector Table                                                     //.
;///////////////////////////////////////////////////////////////////////////////.
;.
  .data

    
    .org $FFF6    ;reset vector pointing to _startup
    .dw IRQ_2
    .dw VDC_INT
    .dw TIMER
    .dw NMI
    .dw _startup
;...............................................................................
;End VECTOR
  





;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Data (far/near)                                                            //.
;///////////////////////////////////////////////////////////////////////////////.
;.

  .bank DATA_BANK

    .bank $01
    .org $4000
intrn_dat:


    ;.org $4300

ascii_notes:

    .db "C-1",0,"C#1",0,"D-1",0,"D#1",0,"E-1",0,"F-1",0,"F#1",0,"G-1",0,"G#1",0,"A-1",0,"A#1",0,"B-1",0
    .db "C-2",0,"C#2",0,"D-2",0,"D#2",0,"E-2",0,"F-2",0,"F#2",0,"G-2",0,"G#2",0,"A-2",0,"A#2",0,"B-2",0
    .db "C-3",0,"C#3",0,"D-3",0,"D#3",0,"E-3",0,"F-3",0,"F#3",0,"G-3",0,"G#3",0,"A-3",0,"A#3",0,"B-3",0
    .db "C-4",0,"C#4",0,"D-4",0,"D#4",0,"E-4",0,"F-4",0,"F#4",0,"G-4",0,"G#4",0,"A-4",0,"A#4",0,"B-4",0
    .db "C-5",0,"C#5",0,"D-5",0,"D#5",0,"E-5",0,"F-5",0,"F#5",0,"G-5",0,"G#5",0,"A-5",0,"A#5",0,"B-5",0
    .db "C-6",0,"C#6",0,"D-6",0,"D#6",0,"E-6",0,"F-6",0,"F#6",0,"G-6",0,"G#6",0,"A-6",0,"A#6",0,"B-6",0
    .db "C-7",0,"C#7",0,"D-7",0,"D#7",0,"E-7",0,"F-7",0,"F#7",0,"G-7",0,"G#7",0,"A-7",0,"A#7",0,"B-7",0
    .db "C-8",0,"   ",0,"nul",0,"nul",0,"nul",0,"nul",0,"nul",0,"nul",0,"nul",0,"nul",0,"nul",0,"nul",0

hex_conv:
    .db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'

strng1:   
    .db "ch1 ch2 ch3 ch4 ch5 ch6",0
strng2:     
    .db "Song #",0
strng3:
    .db "Detune:",0 
strng4:
    .db "Key:",0
strng5:
    .db "Tempo:",0
strng6:
    .db "alt enabled:",0
strng7:
    .db "alt tempo:",0

    .bank $7f
    .org $a000
font:
    .incbin "8x8.fnt"
    

    .bank $02
    .org $6000
  .include "Air_zonk_song2.azl"
; .include "sample_play_test.azl"
; .include "my_test.azl"
    .bank $06
    .org $6000
  .include "samples_.inc"

  



EOF:

  .if !(CDROM)
  .bank $7F   ;Force assembler to create 512k rom image. It basically pads the rom image.
  .endif
;...............................................................................
;End DATA




  
  
;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Variables                                                                  //.
;///////////////////////////////////////////////////////////////////////////////.
;.

  .zp
  
        test_var: .ds 1 ;defines a byte in zeropage. You can use .ds 2 for word size and .ds n where
                        ; n= any value, for small arrays.
        
        __vblank: .ds 1
        vdc_reg: .ds 1
       _counter: .ds 1
       R0:        .ds 2
       R1:        .ds 2
       R2:        .ds 2
       R3:        .ds 2
       R4:        .ds 2
       R5:        .ds 2
       R6:        .ds 2
       R7:        .ds 2
       R8:        .ds 2
       A0:        .ds 2   
       A1:        .ds 2
       A2:        .ds 2
       A3:        .ds 2
       A4:        .ds 2
       A5:        .ds 2
       A6:        .ds 2
       A7:        .ds 2
       A8:        .ds 2
       D0:        .ds 2
       D1:        .ds 2
       D2:        .ds 2
       D3:        .ds 2
       D4:        .ds 2
       D5:        .ds 2
       D6:        .ds 2
       D7:        .ds 2
       D8:        .ds 2
       M0:        .ds 1     ;MPR 2
       M1:        .ds 1     ;MPR 3
       M2:        .ds 1     ;MPR 4
       M3:        .ds 1     ;MPR 5
       M4:        .ds 1     ;MPR 6
       M5:        .ds 1     ;MPR 7
       spr_idx:   .ds 2
       RCR_start: .ds 2
       cloud_mem: .ds 16
       cloud_bnk: .ds 8
       __BYR:     .ds 2
       __BXR:     .ds 2
       vram_cntr: .ds 1
       vram_cntr2:    .ds 1
       _delay:        .ds 1
               
             
  
  .BSS
  
        test_var2:  .ds 1  ;define byte type
        test_var3:  .ds 2  ;define word type
        PC0:        .DS 2
        PC1:        .DS 2
        PC2:        .DS 2
        PC3:        .DS 2
        PC4:        .DS 2
        PC5:        .DS 2
        PC6:        .DS 2
        PC7:        .DS 2
        A_B1:       .ds 2
        A_B2:       .ds 2
        A_ST:       .ds 2
        A_SL:       .ds 2
        A_UP:       .ds 2
        A_DN:       .ds 2
        A_LF:       .ds 2
        A_RH:       .ds 2
        TMR_indirect:   .ds 2





          
        
        ;// Gamepad variables
                                ;//Adds a delay inbetween I/O process on that button.
                                ;//Divides the button response by half. Less touch control ;)
        b1_dly:     .ds 1
        b2_dly:     .ds 1
        sl_dly:     .ds 1
        st_dly:     .ds 1
        up_dly:     .ds 1
        dn_dly:     .ds 1
        lf_dly:     .ds 1
        rh_dly:     .ds 1
                                ;//Indicates that the button was held on the previous read
        b1_hld:     .ds 1
        b2_hld:     .ds 1
        sl_hld:     .ds 1
        st_hld:     .ds 1
        up_hld:     .ds 1
        dn_hld:     .ds 1
        lf_hld:     .ds 1
        rh_hld:     .ds 1
        
                                ;//The current button state.
        b1_sts:     .ds 1
        b2_sts:     .ds 1
        sl_sts:     .ds 1
        st_sts:     .ds 1
        up_sts:     .ds 1
        dn_sts:     .ds 1
        lf_sts:     .ds 1
        rh_sts:     .ds 1
                                ;//The number of frames the button has been held down for.
                                ;//This is used for a charge and then release system.
        b1_cntr:    .ds 1
        b2_cntr:    .ds 1
        sl_cntr:    .ds 1
        st_cntr:    .ds 1
        up_cntr:    .ds 1
        dn_cntr:    .ds 1
        lf_cntr:    .ds 1
        rh_cntr:    .ds 1
                                ;//Soft reset: is start+select. Uses a 3 variable XOR to activate the
                                ;// process, but I still need a detect 'START' button held on reset to
                                ;// avoid rapid reset.
                                ;//Pause: self explanatory
                                ;//Dpad_diag: is needed when a diagonal action should not cancel out an
                                ;;// upward/downward frame position.
        soft_reset: .ds 3
        pause:      .ds 1
        dpad_diag:  .ds 1

;...............................................................................
;End LOCAL
        
        
        
        
;...............................................................................
;///////////////////////////////////////////////////////////////////////////////.
;///////////////////////////////////////////////////////////////////////////////.
;//Notes                                                                      //.
;///////////////////////////////////////////////////////////////////////////////.
;.

;   Memory layout
;
;       0 $0000 ff:hardware       Fixed 
;       1 $2000 f8:ram            Fixed  
;       2 $4000 sub code/data     Loose / far data/tables 
;       3 $6000 far data          Loose / data only
;       4 $8000 far data          Loose / data only
;       5 $a000 far data          Loose / data only
;       6 $c000 sub code          Semi  / Sub code, lib, small near data
;       7 $e000 main code         Fixed / Main code, small subroutines, and small near data










