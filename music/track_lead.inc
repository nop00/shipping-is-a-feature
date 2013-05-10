    .db set_tempo,15,  detune,0,0
    ;.db vibrato,20,1,254,255,4,  key_release,1,  vol_env,255,255,1,255,3,1,10
    .db  key_release,1,  vol_env,255,255,1,255,3,1,10
    .db  tremolo_sub,0,  load_waveform,low(lead),high(lead)
    .db pan_vol,$00,$00

    .db cntr3,144 
.leadwait01:
    .db rest+50
	.db loop_3,low(.leadwait01),high(.leadwait01)

    .db pan_vol,$0d,$0d

    .db C5.,75, rest+25
    .db C5.,50, rest+25
    .db G4.,25
    .db A4x,25
    .db C5.,25, rest+25
    .db C5.,75, rest+50
    .db C5., 50
    .db A4x,25
    .db C5.,75, rest+50
    .db D5x,25, rest+50
    .db D5.,25, rest+50
    .db C5.,25, rest+25

    .db G5.,25, rest+25
    .db G5.,25, rest+25
    .db F5.,25
    .db D5x,25
    .db C5.,25, rest+25
    .db F5.,50, rest+25
    .db C5.,75, rest+50
    .db G5.,25, rest+25
    .db G5.,25, rest+25
    .db F5.,25
    .db D5x,25
    .db C5.,25, rest+25
    .db F5.,50
    .db F5x,25
    .db G5.,75, rest+50

    .db G5.,25, rest+25
    .db G5.,25, rest+25
    .db F5.,25
    .db D5x,25
    .db C5.,25, rest+25
    .db F5.,50, rest+25
    .db C5.,200, C5.,75, rest+100
    .db A4x,25, rest+25
    .db C5.,25, rest+25
    .db A4x,25
    .db C5.,25

    .db G5.,25, rest+25
    .db G5.,25, rest+25
    .db F5.,25
    .db D5x,25
    .db C5.,25, rest+25
    .db F5.,50, rest+25
    .db C5.,75, rest+50
    .db G5.,25, rest+25
    .db G5.,25, rest+25
    .db F5.,25
    .db D5x,25
    .db C5.,25, rest+25
    .db F5.,50
    .db F5x,25
    .db G5.,75, rest+50


    .db C4.,50, rest+25
    .db C4.,50
    .db C5.,25
    .db C4.,50
    .db C4.,50, rest+25
    .db C4.,50
    .db C5.,25
    .db C4.,50
    .db C4.,50, rest+25
    .db C4.,50
    .db C5.,25
    .db C4.,50
    .db C4.,50, rest+25
    .db C4.,50
    .db C5.,25
    .db C4.,50


    .db C4.,50, rest+25
    .db C4.,50
    .db C5.,25
    .db C4.,50
    .db C4.,50, rest+25
    .db C4.,50
    .db C5.,25
    .db C4.,50
    .db C4.,50, rest+25
    .db C4.,50
    .db C5.,25
    .db C4.,50
    .db D5x,25, rest+50
    .db D5.,25, rest+50
    .db C5.,25, rest+50

    .db pan_vol,$00,$00
    .db cntr3,31
.leadwait02:
    .db rest+50
	.db loop_3,low(.leadwait02),high(.leadwait02)
    .db rest+25

    .db pan_vol,$0d,$0d

    .db C4., 100
    .db C4., 100
    .db C4., 100
    .db C4., 75
    .db portamento, 5, 250, 255
    .db C4., 175
    .db portamento, 0, 0, 0
    .db C5., 250

    .db portamento, 5, 5, 0
    .db C5., 175
    .db portamento, 0, 0, 0
    .db C4., 100
    .db C4., 100
    .db C4., 100
    .db C4., 100
    .db C4., 100
    .db C4., 100
    .db C4., 25

    .db C4., 100
    .db C4., 100
    .db C4., 100
    .db C4., 75
    .db portamento, 5, 250, 255
    .db C4., 175
    .db portamento, 0, 0, 0
    .db C5., 250

    .db C5., 100
    .db C5., 100
    .db C5., 100
    .db C5., 75
    .db portamento, 5, 253, 255
    .db C5., 175
    .db portamento, 0, 0, 0
    .db C6., 250

    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25
    .db C6.,25, rest+25
    .db C6.,25, rest+25

    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25, rest+25
    .db C6.,25
    .db C6.,25, rest+25
    .db C6.,50

    .db portamento, 5, 3, 0
    .db C6., 200
    .db portamento, 5, 3, 0
    .db B4., 200
    .db portamento, 5, 3, 0
    .db D4x, 90
    .db portamento, 0, 0, 0
    .db C4., 210
    .db C4., 200
    .db C4., 200
    .db C4., 125

    .db C3.,100
    .db pan_vol,$00,$00
