    .db set_tempo,15,  detune,0,0
    .db set_chan,DDA_mode,  pan_vol,$00,$00,  tremolo_sub,00

    .db cntr0,44 ; 32 + 12
.drumwait01:
    .db rest+50
	.db loop_0,low(.drumwait01),high(.drumwait01)
    .db rest+25

    .db pan_vol,$0f,$0f
    .db C1x,25, C1.,50, C1x,50, C1x,25, C1x,25
    .db cntr0,5
.drumsloop01:
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
    .db C1.,50,  D1.,50,  C1x,50, D1.,50

    .db C1.,50,  D1.,50,  C1x,50, D1.,50
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
    .db C1.,50,  D1.,50,  C1x,50, D1.,25, C1x,25
	.db loop_0,low(.drumsloop01),high(.drumsloop01)

    .db cntr0,8
.drumsloop01b:
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
	.db loop_0,low(.drumsloop01b),high(.drumsloop01b)


    .db pan_vol,$00,$00
    .db cntr0,28 ; 16 + 12
.drumwait02:
    .db rest+50
	.db loop_0,low(.drumwait02),high(.drumwait02)
    .db rest+25

    .db pan_vol,$0f,$0f
    .db C1x,25, C1.,50, C1x,50, C1x,25, C1x,25

    .db cntr0,7
.drumsloop03:
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
	.db loop_0,low(.drumsloop03),high(.drumsloop03)
    .db C1.,25, C1x,25, C1.,50, C1x,50, D1.,50

    .db cntr0,7
.drumsloop04:
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
	.db loop_0,low(.drumsloop04),high(.drumsloop04)
    .db C1.,25, C1x,25, C1.,50, C1x,50, C1x,25, C1x,25

    .db cntr0,7
.drumsloop05:
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
	.db loop_0,low(.drumsloop05),high(.drumsloop05)
    .db C1.,25, C1x,25, C1.,50, C1x,50, D1.,50

    .db cntr0,4
.drumsloop06:
    .db C1.,50,  D1.,50,  C1x,50, D1.,50
	.db loop_0,low(.drumsloop06),high(.drumsloop06)

