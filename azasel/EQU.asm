; VDC REG equates 

MAWR	.equ	$00		;Memory Access Write Reg
MARR	.equ	$01		;Memory Access Read Reg
VRWR	.equ	$02		;Vram Read/Write reg
VWR	.equ	$02		;Vram Read/Write reg
VRR	.equ	$02		;Vram Read/Write reg
CR	.equ	$05		;Control Reg
RCR	.equ	$06		;Raster Control Reg
BXR	.equ	$07		;Background X(scroll) Reg
BYR	.equ	$08		;Background Y(scroll) Reg
MWR	.equ	$09		;Memory Access Width Reg
HSR	.equ	$0a		;Horizontal Synchro Reg
HDR	.equ	$0b		;Horizontal Display Reg
VSR	.equ	$0c		;Vertical Synchro Reg
VDR	.equ	$0d		;Vertical Display Reg
VDE	.equ	$0e		;Vertical Display End Reg
DCR	.equ	$0f		;DMA Control Reg
DSR	.equ	$10		;DMA Source Address Reg
DDR	.equ	$11		;DMA Destination Address Reg
DBR	.equ	$12		;DMA Block Length Reg
SATB	.equ	$13		;VRAM-SATB Source Address Reg 
L_RES	.equ	$04		;(5.37mhz) 256
M_RES	.equ	$05		;(7.1mhz) 352
H_RES	.equ	$06		;(10.5mhz) 512

;VDC ports
vdc_status	 = $0000
vreg_port    = $0000
vdata_port   = $0002
vdata_port.l = $0002
vdata_port.h = $0003

;VDC vram increment
INC_1	  = %00000000
INC_32  = %00001000
INC_64  = %00010000
INC_128 = %00011000

;VDC map sizes
SCR32_32  = %00000000 
SCR32_64  = %01000000
SCR64_32  = %00010000
SCR64_64  = %01010000
SCR128_32 = %00100000
SCR128_64 = %01100000

;VDC DMA control
AUTO_SATB_ON =  $0010
AUTO_SATB_OFF = $0000

;VDC sprite attributes
V_FLIP    = %1000000000000000
H_LFIP    = %0000100000000000
SIZE16_16 = %0000000000000000
SIZE16_32 = %0000100000000000
SIZE16_64 = %0001100000000000
SIZE32_16 = %0000000100000000
SIZE32_32 = %0000100100000000
SIZE32_64 = %0001100100000000
PRIOR_L   = %0000000000000000
PRIOR_H   = %0000000010000000
SPAL1     = %0000000000000000
SPAL2     = %0000000000000001
SPAL3     = %0000000000000010
SPAL4     = %0000000000000011
SPAL5     = %0000000000000100
SPAL6     = %0000000000000101
SPAL7     = %0000000000000110
SPAL8     = %0000000000000111
SPAL9     = %0000000000001000
SPAL10    = %0000000000001001
SPAL11    = %0000000000001010
SPAL12    = %0000000000001011
SPAL13    = %0000000000001100
SPAL14    = %0000000000001101
SPAL15    = %0000000000001110
SPAL16    = %0000000000001111



; VCE resolution
LO_RES   = %00000000		;5.369mhz
MID_RES  = %00000100		;7.159mhz
HI_RES   = %00000110		;10.739mhz
H_FILTER = %00000001

;VCE ports
vce_cntrl  = $400
vce_clr	   = $402
vce_clr.l  = $402
vce_clr.h  = $403
vce_data   = $404
vce_data.l = $404
vce_data.h = $405


; IRQ mask 
IRQ2_ON =  %00000000
VIRQ_ON =  %00000000
TIRQ_ON =  %00000000
IRQ2_OFF = %00000001
VIRQ_OFF = %00000010
TIRQ_OFF = %00000100


; CD 

EX_MEMOPEN	.equ	$E0DE	;SCD version check
CD_READ	.equ	$E009	;CD sector read

AD_CPLAY	.equ	$E03F ;ADPCM streaming 

_al .equ $20f8
_ah .equ $20f9
_bl .equ $20fa
_bh .equ $20fb
_cl .equ $20fc
_ch .equ $20fd
_dl .equ $20fe
_dh .equ $20ff



