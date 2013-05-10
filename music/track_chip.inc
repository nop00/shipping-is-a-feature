    .db set_tempo,15,  detune,0,0
    ;.db vibrato,20,1,254,255,4,  key_release,1,  vol_env,255,255,1,255,3,1,10
    .db  key_release,1,  vol_env,255,255,1,255,3,1,10
    .db  tremolo_sub,0,  load_waveform,low(chip),high(chip)
    .db pan_vol,$00,$00


    .db cntr2,80 ; 
.chipwait01:
    .db rest+50
	.db loop_2,low(.chipwait01),high(.chipwait01)

    .db pan_vol,$0c,$0c

    .db cntr2,10
.chippattern01:
    ;.db C4.,24
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db rest+23
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db rest+96, rest+100, rest+100
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db rest+23
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db rest+96, rest+100, rest+100
	.db loop_2,low(.chippattern01),high(.chippattern01)


    .db pan_vol,$00,$00
    .db cntr2,32 ; 
.chipwait02:
    .db rest+50
	.db loop_2,low(.chipwait02),high(.chipwait02)

    .db pan_vol,$0c,$0c

    .db cntr2,7
.chippattern02:
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db rest+23
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db C4.,3, D4x,3, D4x,3
    .db rest+96, rest+100, rest+100
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db rest+23
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db D4.,3, F4.,3, F4.,3
    .db rest+96, rest+100, rest+100
	.db loop_2,low(.chippattern02),high(.chippattern02)



