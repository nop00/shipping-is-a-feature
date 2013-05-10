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
      
    rts


