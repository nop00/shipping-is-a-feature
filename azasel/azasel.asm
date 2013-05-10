;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;
; Azasel music engine for PC-Engine
;
; Ver: 2.0
;
; History:
; -------
;
; 3/15/09 v2.0 - Public release.
;
;
;







;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Channel parse and DDA playback routine                                                                  /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;#int_routine
Azasel:
    pha      
    phy

    lda <sample_end
    bne .dda_off
    lda chn_dda+5     
    beq .dda_off        
    lda #$05
    sta $800

    tma #$03
    pha
    lda <dda_bank
    tam #$03
    lda [_R2]
    cmp #$2e
    beq .end_sample
.store_sample    
    tay 
    ;lsr a
    ;lsr a
    ;lsr a
    ;lsr a
    ;lsr a
    ;sec
    ;sbc #$1f
    ;eor #$3f
    ;inc a
    lda #$df ; all the commented code above always puts $df in a
    sta $804
    sty $806
.inc_ptr    
    inc <_R2
    bne .pull_bank
    lda <_R2+1
    inc a
    sta <_R2+1
    cmp #$80
    bcc .pull_bank
    lda #$60
    sta <_R2+1
    lda <dda_bank
    inc a
    sta <dda_bank
.pull_bank    
    pla
    tam #$03
    bra .dda_off

        
.end_sample
    inc <sample_end
    bra .pull_bank

    
.dda_off
    
    lda <tempo_cntr     
    inc a               
    sta <tempo_cntr     
    cmp <tempo          
    beq .cmd_string     
    ply                 
    pla                 
  rts                   

.cmd_string
    stz <tempo_cntr
    phx
    tma #$03
    pha
    tma #$04
    pha
    tma #$05
    pha
    ldy current_song
    lda song_bank,y
    tam #$03
    inc a
    tam #$04
    inc a
    tam #$05
    jsr read_tracks
    pla 
    tam #$05
    pla
    tam #$04
    pla
    tam #$03
    plx
    ply
    pla
  rts 
    
;#end int





;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Love'n in the envelope oven                                                                             /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
do_env:
    lda chn_dda,x
    bne .out
    jsr .process_env
    jsr .update_vol
.out
    rts
    
.update_vol
    lda env_vol,x
    lsr a
    lsr a
    lsr a
    ora #$80
    stx $800
    sta $804
    rts
    
    
.process_env
    lda env_phase,x
    bne .att_set
    rts                     ;0

.att_set
    dec a
    bne .att_inc
    lda env_att_strt,x      ;1
    sta env_vol,x
    inc env_phase,x
    rts

.att_inc
    dec a
    bne .sus_set
    lda env_vol,x           ;2
    clc
    adc env_att_rate,x
    bcc .skp0
    lda #$ff
.skp0
    sta env_vol,x
    cmp #$ff
    bcc .skp1
    inc env_phase,x
.skp1
    rts

.sus_set
    dec a
    bne .sus_dec
    lda env_sus_strt,x      ;3
    sta env_vol,x
    lda env_phase_jmp,x
    sta env_phase,x
    rts

.sus_dec
    dec a
    bne .sus_inc
    lda env_vol,x           ;4
    sec
    sbc env_sus_rate,x
    bcs .skp2
    cla
.skp2
    sta env_vol,x
    cmp #$00
    bne .skp3
    stz env_phase,x
.skp3
    rts

.sus_inc
    dec a
    bne .rls_dec
    lda env_vol,x           ;5
    clc
    adc env_sus_rate,x
    bcs .skp4
    lda #$ff
.skp4
    sta env_vol,x
    cmp #$ff
    bne .skp5
    stz env_phase,x
.skp5
    rts

.rls_dec
    lda env_vol,x           ;6
    sec
    sbc env_rls_rate,x
    bcs .skp6
    cla
.skp6
    sta env_vol,x
    cmp #$00
    bne .skp7
    stz env_phase,x
.skp7
    rts
    






;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Portamento (frequency slide)                                                                            /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
do_prtm:
    lda chn_dda,x
    bne .out
    jsr .process_portamento
.out
    rts

.process_portamento
    lda chn_mode,x
    and #$04
    beq .prtm_disabled    
    dec prtm_cntr,x
    bne .prtm_disabled
    lda prtm_reload,x
    sta prtm_cntr,x
    lda chn_frq.l,x
    clc
    adc prtm_frq.l,x
    sta chn_frq.l,x
    lda chn_frq.h,x
    adc prtm_frq.h,x
    sta chn_frq.h,x
      
.prtm_disabled    
    rts


;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Update channel frequency                                                                                /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
do_frq_update:
    stx $800
    lda chn_frq.l,x
    clc
    adc vbr_delta.l,x
    sta $802
    lda chn_frq.h,x
    adc vbr_delta.h,x
    sta $803
    rts




;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Vibrato FX                                                                                              /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
do_vbr:
    lda chn_dda,x
    bne .out
    jsr .process_vibrato
.out
    rts

.process_vibrato
    lda vbr_mode,x
    lsr a
    bcs .cont
    rts
.cont
    lsr a
    bcc .update_regs
.reset_regs.
    lda vbr_st_dly,x
    sta sh_vbr_st_dly,x
    lda vbr_dly,x
    sta sh_vbr_dly,x
    lda vbr_inc.l,x
    sta sh_vbr_inc.l,x
    lda vbr_inc.h,x
    sta sh_vbr_inc.h,x
    lda vbr_ph_len,x
    lsr a
    sta sh_vbr_ph_len,x
    stz vbr_delta.l,x
    stz vbr_delta.h,x
    lda #$01
    sta vbr_mode,x
    rts
.update_regs
    lda sh_vbr_st_dly,x
    beq .cont0
    dec sh_vbr_st_dly,x
    rts
.cont0
    dec sh_vbr_dly,x
    beq .cont1
    rts
.cont1
    lda vbr_dly,x
    sta sh_vbr_dly,x
    lda sh_vbr_ph_len,x
    bne .cont2
    sec
    lda #$00
    sbc sh_vbr_inc.l,x
    sta sh_vbr_inc.l,x
    lda #$00
    sbc sh_vbr_inc.h,x
    sta sh_vbr_inc.h,x
    lda vbr_ph_len,x
    sta sh_vbr_ph_len,x
.cont2
    dec sh_vbr_ph_len,x
    clc
    lda vbr_delta.l,x         ;2360 and 236c
    adc sh_vbr_inc.l,x
    sta vbr_delta.l,x
    lda vbr_delta.h,x
    adc sh_vbr_inc.h,x
    sta vbr_delta.h,x
    rts
    
    


;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//parse track strings                                                                                      /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
read_tracks:

    ldx #$ff
.ll01
    inx
    cpx #$06
    bcs .out
    dec chn_dly,x
    lda chn_mode,x
    and #$02
    bne .skp_rls
    lda chn_dly,x
    cmp key_rls_pnt,x
    bne .skp_rls
    lda #$06
    sta env_phase,x
    
.skp_rls
    lda chn_dly,x
    bne .fx
    lda trk_ptr.l,x
    sta <_R0
    lda trk_ptr.h,x
    sta <_R0+1
    cly
    jsr channel_prep
    

    lda <_R0
    sta trk_ptr.l,x
    lda <_R0+1
    sta trk_ptr.h,x
.fx
    jsr do_vbr
    jsr do_prtm
    jsr do_frq_update
    jsr do_env
    bra .ll01
   
.out
    rts
    



;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Channel parser                                                                                                        /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
channel_prep:
     lda chn_mode,x
     sta tmp_mode
     and #$f1               ;reset key release state (enable)
     sta chn_mode,x


    
read_string:
    lda [_R0],y
    bmi .rest
    cmp #$5f
    bcs .func
.note
    iny
    sta chn_note,x
    asl a
    phy
    tay
    lda note_tbl,y
    sta chn_frq.l,x
    lda note_tbl+1,y
    sta chn_frq.h,x
    ply
    lda [_R0],y
    iny
    sta chn_dly,x
    lda chn_dda,x
    bne .dda_mode
    lda chn_frq.l,x
    clc
    adc detune.l,x
    sta chn_frq.l,x
    lda chn_frq.h,x
    adc detune.h,x
    sta chn_frq.h,x
    lda tmp_mode
    and #$02
    bne .end_chn_parse
    stx $800
    stz $804
    lda #$01
    sta env_phase,x
    lda vbr_mode,x
    and #$01
    beq .end_chn_parse
    lda #$03
    sta vbr_mode,x
    
    
      
.end_chn_parse
    tya
    clc
    adc <_R0
    sta <_R0
    lda <_R0+1
    adc #$00
    sta <_R0+1
    rts 
    
.dda_mode
    jsr prep_dda_chn     
    jmp .end_chn_parse
    
    
.rest
    iny
    and #$7f
    sta chn_dly,x
    lda tmp_mode               
    and #$02
    bne .skp_rls
    lda #$06
    sta env_phase,x
.skp_rls    
    jmp .end_chn_parse
        
    
    
    
.func
    iny
    sec
    sbc #$60
    asl a
    phx
    tax
    jmp [func_tbl,x]
    


;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Magic                                                                                                   /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
dis_key:
    plx
    lda chn_mode,x
    ora #$02
    sta chn_mode,x
    jmp read_string

trem_sub:
    plx
    lda [_R0],y
    iny
    sta trml_sub,x
    jsr update_chan_pan
    jmp read_string

trem_dn:
    plx
    inc trml_sub,x
    jsr update_chan_pan
    jmp read_string

trem_up:
    plx
    dec trml_sub,x
    jsr update_chan_pan
    jmp read_string

_key_release:
    plx
    lda [_R0],y
    iny
    sta key_rls_pnt,x
    jmp read_string

ld_waveform:
    plx
    lda [_R0],y
    iny
    sta <_R1
    lda [_R0],y
    iny
    sta <_R1+1
    lda chn_dda,x
    bne .out
    phy
    cly
    stx $800
    stz $804
.ll01
    lda [_R1],y
    sta $806
    iny
    cpy #$20
    bcc .ll01
    ply
     ;lda #$9f
     ;sta $804   
.out               
    jmp read_string   

_detune:
    plx
    lda [_R0],y
    iny
    sta detune.l,x
    lda [_R0],y
    iny
    sta detune.h,x
    jmp read_string

_portamento:
    plx
    lda [_R0],y
    iny
    sta prtm_reload,x
    inc a
    sta prtm_cntr,x
    lda [_R0],y
    iny
    sta prtm_frq.l,x
    lda [_R0],y
    iny
    sta prtm_frq.h,x
    lda chn_mode,x
    ora #$04
    sta chn_mode,x
    jmp read_string

null:
    plx
    jmp read_string

_vol_env:
    plx
    lda [_R0],y
    iny
    sta env_att_strt,x
    sta env_vol,x
    lda [_R0],y
    iny
    sta env_att_rate,x
    lda [_R0],y
    iny
    sta env_dcy_rate,x
    lda [_R0],y
    iny
    sta env_sus_strt,x
    lda [_R0],y
    iny
    sta env_phase_jmp,x
    lda [_R0],y
    iny
    sta env_sus_rate,x
    lda [_R0],y
    iny
    sta env_rls_rate,x
    jmp read_string       

_vibrato:
    plx
    lda [_R0],y
    iny
    sta vbr_st_dly,x
    lda [_R0],y
    iny
    sta vbr_dly,x
    lda [_R0],y
    iny
    sta vbr_inc.l,x
    lda [_R0],y
    iny
    sta vbr_inc.h,x
    lda [_R0],y
    iny
    sta vbr_ph_len,x
    stz vbr_phase,x
    lda #$03
    sta vbr_mode,x
    jmp read_string

vibrato_cmd:
    plx
    lda [_R0],y
    beq .disable
    iny
    lda #$03
    sta vbr_mode,x
    jmp read_string
.disable
    iny
    stz vbr_mode,x
    stz vbr_delta.l,x
    stz vbr_delta.h,x
    jmp read_string

null1:
    plx
    lda [_R0],y
    iny
    ;???
    jmp read_string

pan_set:
    plx
    lda [_R0],y
    iny
    sta chn_left,x
    lda [_R0],y
    iny
    sta chn_right,x
    jsr update_chan_pan
    jmp read_string

load_tempo:
    plx
    lda [_R0],y
    iny
    asl a
    sta tempo_org
    stz tempo_cntr
    lda tempo_override
    bne .alt_tempo
    lda tempo_org
    sta tempo
    jmp read_string

.alt_tempo
    lda tempo_alt
    sta tempo    
    jmp read_string

direct_jmp:
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    stx <_R0
    sta <_R0+1
    cly
    plx
    jmp read_string

_stop_song:
    clx
.ll01
    stx $800
    stz $804
    stz env_vol,x
    inx
    cpx #$06
    bne .ll01
    lda #$01
    sta <sample_end
    stz $c01
    plx
    ldx #$05
    rts
    ;jmp read_string

ld_cntr0:
    plx
    lda [_R0],y
    iny
    sta _cntr0,x
    jmp read_string

loop0:
    plx
    dec _cntr0,x
    beq .lp_0
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string
.lp_0
    iny
    iny
    jmp read_string

exit0:
    plx
    lda _cntr0,x
    cmp #$01
    beq .ex_0
    iny
    iny
    jmp read_string
.ex_0
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string   

ld_cntr1:
    plx
    lda [_R0],y
    iny
    sta _cntr1,x
    jmp read_string

loop1:
    plx
    dec _cntr1,x
    beq .lp_1
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string
.lp_1
    iny
    iny
    jmp read_string

exit1:
    plx
    lda _cntr1,x
    cmp #$01
    beq .ex_1
    iny
    iny
    jmp read_string
.ex_1
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string   

ld_cntr2:
    plx
    lda [_R0],y
    iny
    sta _cntr2,x
    jmp read_string

loop2:
    plx
    dec _cntr2,x
    beq .lp_2
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string
.lp_2
    iny
    iny
    jmp read_string

exit2:
    plx
    lda _cntr2,x
    cmp #$01
    beq .ex_2
    iny
    iny
    jmp read_string
.ex_2
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string   

ld_cntr3:
    plx
    lda [_R0],y
    iny
    sta _cntr3,x
    jmp read_string

loop3:
    plx
    dec _cntr3,x
    beq .lp_3
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string
.lp_3
    iny
    iny
    jmp read_string

exit3:
    plx
    lda _cntr3,x
    cmp #$01
    beq .ex_3
    iny
    iny
    jmp read_string
.ex_3
    phx
    lda [_R0],y
    iny
    tax
    lda [_R0],y
    cly
    stx <_R0
    sta <_R0+1
    plx
    jmp read_string   

ld_chn_mode:
    plx
    lda [_R0],y
    iny
    sta chn_dda,x
    jmp read_string

null2:
    plx
    jmp read_string

null3:
    plx
    lda [_R0],y
    iny
    ;???
    jmp read_string




;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Update channel balance                                                                                  /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
update_chan_pan:
    lda chn_right,x
    sec
    sbc trml_sub,x
    bcs .skp0
    cla
.skp0
    sta <_R1
    lda chn_left,x
    sec
    sbc trml_sub,x
    bcs .skp1
    cla
.skp1
    asl a
    asl a
    asl a
    asl a
    ora <_R1
    stx $800
    sta $805
  rts


;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//                                                                                                         /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
prep_dda_chn
    phy
    phx
    stx $800
    lda #$40
    sta $804
    lda #$10
    sta $806
    lda #$ff
    sta $804
    stz <sample_end
    lda chn_note,x
    tay
    tma #$03
    pha
    lda #bank(sample_bank)
    tam #$03
    lda sample_bank,y
    sta <dda_bank
    tya
    asl a
    tay
    lda sample_addr,y
    sta <_R2
    lda sample_addr+1,y
    and #$1f
    ora #$60
    sta <_R2+1
    pla
    tam #$03
    plx
    ply
  rts


;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// Data and variables                                                                                      /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////


  ;DATA
  
note_tbl:
    .incbin "azasel/note_lut.bin"

func_tbl:
    .dw dis_key,trem_sub,trem_dn,trem_up,_key_release,ld_waveform,_detune,_portamento,null
    .dw _vol_env,_vibrato,vibrato_cmd,null,pan_set,load_tempo,direct_jmp,_stop_song,null3
    .dw ld_cntr0,loop0,exit0,ld_cntr1,loop1,exit1,ld_cntr2,loop2,exit2,ld_cntr3,loop3,exit3
    .dw ld_chn_mode,null
    
    

  ;Vars

  .zp 
       tempo:           .ds 1
       tempo_cntr:      .ds 1
       dda_bank:        .ds 1
       sample_end:      .ds 1
       _R0:             .ds 2
       _R1:             .ds 2   
       _R2:             .ds 2
  .bss
  
      current_song:   .ds 1*6

      vbr_st_dly:     .ds 1*6
      sh_vbr_st_dly:  .ds 1*6
      vbr_dly:        .ds 1*6
      sh_vbr_dly:     .ds 1*6
      vbr_inc.l:      .ds 1*6
      sh_vbr_inc.l:   .ds 1*6
      vbr_inc.h:      .ds 1*6
      sh_vbr_inc.h:   .ds 1*6
      vbr_ph_len:     .ds 1*6 
      sh_vbr_ph_len:  .ds 1*6 
      vbr_phase:      .ds 1*6
      vbr_mode:       .ds 1*6    
      vbr_delta.l:    .ds 1*6
      vbr_delta.h:    .ds 1*6
      
      key_rls_pnt:    .ds 1*6

      trml_sub:       .ds 1*6
      
      env_att_strt:   .ds 1*6
      env_att_rate:   .ds 1*6
      env_dcy_rate:   .ds 1*6
      env_sus_strt:   .ds 1*6
      env_phase_jmp:  .ds 1*6
      env_sus_rate:   .ds 1*6
      env_rls_rate:   .ds 1*6
      env_vol:        .ds 1*6
      env_phase:      .ds 1*6                                    
            
      chn_left:       .ds 1*6
      chn_right:      .ds 1*6
      
      _cntr0:          .ds 1*6       ; All three are used for loops
      _cntr1:          .ds 1*6
      _cntr2:          .ds 1*6
      _cntr3:          .ds 1*6

      chn_dly:        .ds 1*6       
      
      chn_dda:        .ds 1*6
      
      chn_mode:       .ds 1*6       ; internal

      tmp_mode:       .ds 1
                                                                                    
      prtm_reload:    .ds 1*6
                                    ; B0 = delay rate in tempo tick before applyed frequency slide
      prtm_cntr:      .ds 1*6
                                    ; internal
      prtm_frq.l:     .ds 1*6
                                    ; B2 = (LSB) Signed value to add to frequency
      prtm_frq.h:     .ds 1*6
      
      detune.l:       .ds 1*6
      detune.h:       .ds 1*6
      
      trk_ptr.l:      .ds 1*6
      trk_ptr.h:      .ds 1*6
                                    
      chn_frq.l:      .ds 1*6
      chn_frq.h:      .ds 1*6
                            
      chn_note:       .ds 1*6
                                    
      chn_note_dly:   .ds 1*6

      tempo_override: .ds 1
      tempo_alt:      .ds 1
      tempo_org:      .ds 1
  
      song_bank:      .ds 128
      song_ptr.l:     .ds 128
      song_ptr.h:     .ds 128


  .code



;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
;// End of File                                                                                             /
;////////////////////////////////////////////////////////////////////////////////////////////////////////////
