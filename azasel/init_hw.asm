;Initialise hardware

;#sub
init_vdc:
	
	VDC_REG MAWR , $0000
	VDC_REG MARR , $0000
	VDC_REG CR , $0000
	VDC_REG RCR , $0000
	VDC_REG BXR , $0000
	VDC_REG BYR , $0000
	VDC_REG MWR , $0010
	VDC_REG VSR , $0F02
	VDC_REG VDR , $00EF
	VDC_REG VDE , $0003	
	VDC_REG DCR , $0000
	VDC_REG HSR , $0303
	VDC_REG HDR , $062b
	
	clx
	ldy #$80
	st0 #$00
	st1 #$00
	st2 #$00
	st0 #$02
.loop
	stz $0002
	stz $0003
	inx
	bne .loop
	iny
	bne .loop		
	
	rts

;#end sub



;#sub
init_system:
	
	lda #$ff		;setup I/o & ram banks
	tam #$00
	lda #$f8
	tam #$01	

	lda #START_BANK+1		;set bank 1 of rom to MPR2 
	tam #$02		;$4000
	lda #START_BANK+2		;set bank 2 of rom to MPR3 
	tam #$03		;$6000
	lda #START_BANK+3		;set bank 3 of rom to MPR4 
	tam #$04		;$8000
	lda #START_BANK+4		;set bank 4 of rom to MPR5
	tam #$05		;$A000
	lda #START_BANK+5		;set bank 5 of rom to MPR6
	tam #$06		;$c000


				;init ram & setup stack
	ldx #$ff		;setup stack
	txs
	
	stz $2000		;init ram to $00
	tii $2000,$2001,$1fff
				;init interrupts
	stz     $0C00   	
        lda     #$07    
        sta     $1402   	
        stz     $1403   	;noted from doc(?) - acknowledge int
	
	jmp main

;#end sub



;#sub
init_set_res:
	
	lda #L_RES		;setup horizontal res
	sta $400
	
	rts

;#end sub




