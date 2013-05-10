    .db set_tempo,15,  detune,0,0
    .db vibrato,20,1,254,255,4,  key_release,1,  vol_env,255,255,1,255,3,4,10
    .db   pan_vol,$0f,$0f,  tremolo_sub,00
    .db  tremolo_sub,6,  load_waveform,low(bass),high(bass)
.setupbasspattern1
    .db cntr1,6
.basspattern1:
    .db C2.,50, C3.,50, C2.,50, C3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db F2.,50, F3.,50, F2.,50, F3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db loop_1,low(.basspattern1),high(.basspattern1)

    .db C2.,50, C3.,50, C2.,50, C3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db F2.,50, F3.,50, F2.,50, F3.,50
    .db D2x,50, D3x,50, D2x,50, G3.,50

    .db C2.,50, C3.,50, C2.,50, C3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db F2.,50, F3.,50, F2.,50, F3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50

    .db C2.,50, C3.,50, C2.,50, C3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db F2.,50, F3.,50, F2.,50, F3.,50
    .db D2x,50, D3x,50, D2x,50, G3.,50

    .db cntr1,8
.basspattern2:
    .db C2.,50, C3.,50, C2.,50, C3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db F2.,50, F3.,50, F2.,50, F3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db loop_1,low(.basspattern2),high(.basspattern2)

    .db cntr1,6
.basspattern3:
    .db C2.,50, C3.,50, C2.,50, C3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db F2.,50, F3.,50, F2.,50, F3.,50
    .db D2x,50, D3x,50, D2x,50, G3.,50
    .db loop_1,low(.basspattern3),high(.basspattern3)

    .db C2.,50, C3.,50, C2.,50, C3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db F2.,50, F3.,50, F2.,50, F3.,50
    .db D2x,50, D3x,50, D2x,50, D3x,50
    .db C2.,50
    .db pan_vol,$00,$00
 

