greetee01: .db "CALODOX",0
greetee02: .db "VITALMOTION",0
greetee03: .db "ADINPSZ",0
greetee04: .db "FREQUENCY",0
greetee05: .db "DFR",0
greetee06: .db "SECTOR ONE",0
greetee07: .db "XMEN",0
greetee08: .db "ASD",0
greetee09: .db "CONTROLALTTEST",0
greetee10: .db "RAZOR1911",0
greetee11: .db "EQUINOX",0
greetee12: .db "!!M",0
greetee13: .db "ZUUL",0

greetees_lengths: .db $07, $0B, $07, $09, $03, $0A, $04, $03, $0E, $09, $07, $03, $04
greetees_offsets_original: .db $00, $07, $12, $19, $22, $25, $2f, $33, $36, $44, $4D, $54, $57

greetees_y: .db $70, $A0, $d0, $B0, $80
            .db $C0, $70, $A0, $D0, $90
            .db $B0, $80, $c0

greetees_start_x:  .db $30, $13
                   .db $30, $01
                   .db $30, $13
                   .db $30, $01
                   .db $30, $13
                   .db $30, $01
                   .db $30, $13
                   .db $30, $01
                   .db $30, $13
                   .db $30, $01
                   .db $30, $13
                   .db $30, $01
                   .db $30, $13

greetees_timing:   .db $3D, $01
                   .db $78, $01
                   .db $B4, $01
                   .db $F0, $01
                   .db $2C, $02
                   .db $68, $02
                   .db $A4, $02
                   .db $E0, $02
                   .db $1C, $03
                   .db $58, $03
                   .db $94, $03
                   .db $D0, $03
                   .db $f0, $03

greetees_increment:.db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01

starfield_increments: .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $02, $00, $00, $02, $00, $00, $01, $00, $00
                      .db $02, $00, $03, $00, $02, $00, $00, $00, $00, $01
                      .db $00, $03, $00, $00, $02, $00, $00, $00, $03, $00
                      .db $00, $03, $00, $02, $00, $01, $00, $00, $03, $00
                      .db $01, $00, $00, $00, $01, $00, $03, $00, $01, $00
                      .db $00, $00, $00, $00, $02, $00, $03, $00, $01, $03
                      .db $00, $00, $03, $00, $02, $00, $01, $00, $01, $02
                      .db $00, $03, $00, $00, $00, $00, $02, $00, $03, $01
                      .db $00, $00, $00, $00, $00, $00, $03, $00, $02, $00
                      .db $00, $02, $01, $02, $00, $00, $03, $00, $01, $01
                      .db $00, $00, $01, $00, $03, $00, $00, $01, $03, $00
                      .db $03, $00, $00, $02, $00, $01, $00, $02, $00, $00
                      .db $02, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
                      .db $00, $00, $00, $00, $00, $00
;                      .db $02, $00, $00, $02, $00, $00, $01, $00, $00, $02
;                      .db $00, $03, $00, $02, $00, $00, $00, $00, $01, $00
;                      .db $03, $00, $00, $02, $00, $00, $00, $03, $00, $00
;                      .db $03, $00, $02, $00, $01, $00, $00, $03, $00, $01
;                      .db $00, $00, $00, $01, $00, $03, $00, $01, $00, $00
;                      .db $00, $00, $00, $02, $00, $03, $00, $01, $03, $00
;                      .db $00, $03, $00, $02, $00, $01, $00, $01, $02, $00
;                      .db $03, $00, $00, $00, $00, $02, $00, $03, $01, $00
;                      .db $00, $00, $00, $00, $00, $03, $00, $02, $00, $00
;                      .db $02, $01, $02, $00, $00, $03, $00, $01, $01, $00
;                      .db $00, $01, $00, $03, $00, $00, $01, $03, $00, $03
;                      .db $00, $00, $02, $00, $01, $00, $02, $00, $00, $02
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;                      .db $00, $00, $00, $00, $00, $00

wegreettoppalette:	.defpal $000,$001,$111,$112,$222,$223,$333,$444,$555,$777,$000,$000,$000,$000,$000,$000
wegreetbottompalette:	.defpal $000,$001,$111,$122,$123,$222,$333,$334,$443,$444,$455,$554,$665,$777,$000,$000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop0:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop1:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00078999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop2:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$70003999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop3:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$98400000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop4:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00377777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop5:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$77777773

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop6:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00017889

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop7:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$99999999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop8:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$97100002

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop9:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$79999999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop10:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$99999710

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop11:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop12:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$77777777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop13:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$77000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop14:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$07777777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop15:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$77777700

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop16:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00699999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop17:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$97000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop18:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000002,\
$00000122,\
$00001320,\
$00013200,\
$00341000,\
$14310000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop19:	.defchr $4000, $0,\
$01100000,\
$11000000,\
$10000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop20:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000002

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop21:	.defchr $4000, $0,\
$01897426,\
$07941110,\
$39711121,\
$78212222,\
$87212133,\
$94122222,\
$93232333,\
$91223332

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop22:	.defchr $4000, $0,\
$93007832,\
$87009611,\
$77009312,\
$78019122,\
$68049122,\
$68048133,\
$48048233,\
$68048233

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop23:	.defchr $4000, $0,\
$68960000,\
$21793000,\
$32188006,\
$33249208,\
$23229609,\
$33338739,\
$33337768,\
$33337878

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop24:	.defchr $4000, $0,\
$18987777,\
$89622222,\
$94222222,\
$72122333,\
$60233333,\
$32333333,\
$23233233,\
$63356323

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop25:	.defchr $4000, $0,\
$77777789,\
$33321227,\
$23223222,\
$25333332,\
$33333323,\
$33333333,\
$36333333,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop26:	.defchr $4000, $0,\
$70000000,\
$96000000,\
$88000000,\
$69000000,\
$39100000,\
$39200000,\
$39200000,\
$39200001

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop27:	.defchr $4000, $0,\
$00399754,\
$01983332,\
$07932222,\
$08722333,\
$09422333,\
$49223336,\
$68333353,\
$78153333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop28:	.defchr $4000, $0,\
$22332234,\
$22222144,\
$33335388,\
$33333366,\
$73333333,\
$33333333,\
$33333333,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop29:	.defchr $4000, $0,\
$79810049,\
$24970198,\
$42780793,\
$33690872,\
$33391952,\
$33394923,\
$33387823,\
$33387723

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop30:	.defchr $4000, $0,\
$96322232,\
$32222222,\
$22533323,\
$23333333,\
$33333333,\
$33333333,\
$33333333,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop31:	.defchr $4000, $0,\
$22337980,\
$22121596,\
$23332278,\
$33333369,\
$37333339,\
$33333359,\
$33333339,\
$73333338

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop32:	.defchr $4000, $0,\
$00069977,\
$00698222,\
$00982212,\
$03932323,\
$07822333,\
$28723373,\
$48623333,\
$49423333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop33:	.defchr $4000, $0,\
$77777777,\
$22222222,\
$22222222,\
$32333333,\
$33333333,\
$33333333,\
$33333333,\
$33335333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop34:	.defchr $4000, $0,\
$79930006,\
$23880069,\
$21493098,\
$33287393,\
$33377782,\
$33377872,\
$33378862,\
$33389963

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop35:	.defchr $4000, $0,\
$99777777,\
$83222262,\
$22122237,\
$22333369,\
$23333336,\
$25333333,\
$33333383,\
$53333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop36:	.defchr $4000, $0,\
$77777993,\
$13122388,\
$52312149,\
$83232228,\
$63323327,\
$33333337,\
$35233336,\
$33333336

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop37:	.defchr $4000, $0,\
$04973222,\
$08832122,\
$39612323,\
$79313333,\
$78123332,\
$77233333,\
$87433333,\
$86333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop38:	.defchr $4000, $0,\
$23222222,\
$12222221,\
$22222332,\
$33335333,\
$33333333,\
$33333333,\
$33333333,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop39:	.defchr $4000, $0,\
$79700000,\
$27910000,\
$23960000,\
$35870000,\
$36780000,\
$33680000,\
$33690000,\
$33390000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop40:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000001,\
$00000146,\
$00014773

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop41:	.defchr $4000, $0,\
$00000002,\
$00000044,\
$00002442,\
$00134410,\
$12443000,\
$46410000,\
$63000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop42:	.defchr $4000, $0,\
$43100000,\
$20000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop43:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000330,\
$00004872,\
$00004883,\
$00002761,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop44:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000012,\
$00012344,\
$12344431

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop45:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00001244,\
$01244664,\
$34444310,\
$44200000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop46:	.defchr $4000, $0,\
$00000000,\
$00000122,\
$13466677,\
$66644433,\
$43210000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop47:	.defchr $4000, $0,\
$00000004,\
$33332104,\
$77777777,\
$33344448,\
$00000007,\
$00000007,\
$00000007,\
$00000007

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop48:	.defchr $4000, $0,\
$91138223,\
$81213323,\
$82233333,\
$82233332,\
$72233363,\
$72333333,\
$72233333,\
$72333373

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop49:	.defchr $4000, $0,\
$69048133,\
$39048233,\
$39048233,\
$39048223,\
$29368233,\
$39678233,\
$49478235,\
$68778233

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop50:	.defchr $4000, $0,\
$33336877,\
$33336877,\
$33336986,\
$33333984,\
$33333984,\
$33233994,\
$32353993,\
$33333994

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop51:	.defchr $4000, $0,\
$22335333,\
$23333333,\
$23333333,\
$33333333,\
$23333333,\
$33333333,\
$33333333,\
$33563333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop52:	.defchr $4000, $0,\
$63373333,\
$33323733,\
$33333333,\
$33333333,\
$33333333,\
$33333333,\
$33333333,\
$33333633

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop53:	.defchr $4000, $0,\
$39201478,\
$39468998,\
$39788877,\
$39767777,\
$39667764,\
$39666310,\
$39320000,\
$59000001

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop54:	.defchr $4000, $0,\
$98233333,\
$98238333,\
$96233333,\
$96233333,\
$86333333,\
$86333333,\
$86335337,\
$86353335

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop55:	.defchr $4000, $0,\
$33333333,\
$33333333,\
$33333333,\
$33333333,\
$33336333,\
$33333333,\
$73333333,\
$63353333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop56:	.defchr $4000, $0,\
$33387733,\
$33399733,\
$33399623,\
$33388663,\
$33398633,\
$33398633,\
$36699633,\
$37899333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop57:	.defchr $4000, $0,\
$33333338,\
$33333338,\
$33333353,\
$33333335,\
$33333333,\
$33333333,\
$33333533,\
$73333335

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop58:	.defchr $4000, $0,\
$83333338,\
$83333338,\
$33333338,\
$33333339,\
$33733339,\
$33333359,\
$33333369,\
$33633368

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop59:	.defchr $4000, $0,\
$49323333,\
$49323333,\
$79337333,\
$88233333,\
$88323333,\
$78233333,\
$67333333,\
$67333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop60:	.defchr $4000, $0,\
$33353533,\
$33323655,\
$33333333,\
$33333333,\
$53333333,\
$33633333,\
$33333333,\
$33333353

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop61:	.defchr $4000, $0,\
$33378932,\
$33377912,\
$33367913,\
$33367823,\
$37367823,\
$33377823,\
$33377723,\
$53377723

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop62:	.defchr $4000, $0,\
$33773332,\
$33333333,\
$33333333,\
$33333333,\
$33333333,\
$33336533,\
$33356632,\
$33333332

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop63:	.defchr $4000, $0,\
$33333336,\
$33333337,\
$33323337,\
$33333337,\
$33333337,\
$63332337,\
$32233337,\
$33333337

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop64:	.defchr $4000, $0,\
$86337333,\
$86232373,\
$96323333,\
$96333333,\
$86333333,\
$86333333,\
$86333333,\
$85333363

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop65:	.defchr $4000, $0,\
$33337333,\
$33333333,\
$33333333,\
$33333333,\
$33333333,\
$33533633,\
$33333333,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop66:	.defchr $4000, $0,\
$38390000,\
$33390036,\
$33394677,\
$33394443,\
$35391000,\
$33390000,\
$33390000,\
$33391110

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop67:	.defchr $4000, $0,\
$03677410,\
$77641000,\
$63200000,\
$10000064,\
$00000066,\
$00000011,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop68:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$10000000,\
$10000000,\
$00000000,\
$00000011,\
$01122210

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop69:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$01110000,\
$11000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop70:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$01000000,\
$01000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop71:	.defchr $4000, $0,\
$00011111,\
$00000011,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop72:	.defchr $4000, $0,\
$11122344,\
$12221110,\
$00000000,\
$00000010,\
$00000010,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop73:	.defchr $4000, $0,\
$44310000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop74:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000011,\
$00001110,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop75:	.defchr $4000, $0,\
$00000000,\
$00001123,\
$01222110,\
$11000000,\
$00000000,\
$00000001,\
$00000001,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop76:	.defchr $4000, $0,\
$00011107,\
$44444447,\
$00000007,\
$00000007,\
$11000007,\
$66000006,\
$46000004,\
$00000237

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop77:	.defchr $4000, $0,\
$72333323,\
$72333333,\
$72233333,\
$72333533,\
$72333333,\
$82333333,\
$82333333,\
$82333363

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop78:	.defchr $4000, $0,\
$59688233,\
$69268333,\
$68138233,\
$64237233,\
$33223233,\
$33333333,\
$33333333,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop79:	.defchr $4000, $0,\
$33533993,\
$33333993,\
$33333993,\
$33373994,\
$33353986,\
$33336986,\
$53357987,\
$63356887

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop80:	.defchr $4000, $0,\
$33333333,\
$33333333,\
$33333333,\
$33333333,\
$33365353,\
$33333337,\
$33363359,\
$33535363

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop81:	.defchr $4000, $0,\
$33333333,\
$33333333,\
$33333333,\
$33333336,\
$36777799,\
$99877770,\
$99999999,\
$33222337

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop82:	.defchr $4000, $0,\
$59012444,\
$78111100,\
$77000000,\
$96000000,\
$80000034,\
$00000046,\
$60000023,\
$70000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop83:	.defchr $4000, $0,\
$86333333,\
$86333333,\
$86333333,\
$86333333,\
$86333333,\
$86333335,\
$86333333,\
$87373353

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop84:	.defchr $4000, $0,\
$33353333,\
$33333353,\
$33333353,\
$33333333,\
$33678899,\
$37999899,\
$39953322,\
$39822332

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop85:	.defchr $4000, $0,\
$33799223,\
$33789433,\
$33889633,\
$68988635,\
$99878633,\
$99748635,\
$48808636,\
$26808633

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop86:	.defchr $4000, $0,\
$33333336,\
$33533333,\
$33333333,\
$35333333,\
$33333688,\
$33333999,\
$35533899,\
$35333332

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop87:	.defchr $4000, $0,\
$33333377,\
$33353387,\
$33333394,\
$33333896,\
$66353983,\
$83337920,\
$83339811,\
$23379866

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop88:	.defchr $4000, $0,\
$67363333,\
$67235333,\
$78333333,\
$88333533,\
$78333333,\
$48333333,\
$49533335,\
$69333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop89:	.defchr $4000, $0,\
$33333376,\
$63333333,\
$33333333,\
$33733333,\
$33337777,\
$33999777,\
$37999999,\
$33321123

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop90:	.defchr $4000, $0,\
$33386723,\
$33396723,\
$38596733,\
$33896833,\
$89967833,\
$77646823,\
$99947923,\
$24978932

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop91:	.defchr $4000, $0,\
$33333333,\
$33335532,\
$33333333,\
$33336333,\
$33533533,\
$33333599,\
$33333699,\
$33333332

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop92:	.defchr $4000, $0,\
$33323338,\
$33332339,\
$33333359,\
$33333389,\
$77779994,\
$97778400,\
$99999990,\
$11111392

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop93:	.defchr $4000, $0,\
$87333333,\
$78333333,\
$89233333,\
$49833333,\
$06998888,\
$00244448,\
$00000008,\
$00000008

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop94:	.defchr $4000, $0,\
$33763333,\
$33365335,\
$33333333,\
$33333333,\
$63339998,\
$63339777,\
$63339001,\
$63339000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop95:	.defchr $4000, $0,\
$33692444,\
$33780000,\
$33870000,\
$37940000,\
$99800000,\
$77644432,\
$23447776,\
$00002466

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop96:	.defchr $4000, $0,\
$44444444,\
$00111000,\
$00000000,\
$00000000,\
$00000000,\
$10000000,\
$64444333,\
$77777777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop97:	.defchr $4000, $0,\
$32110000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00001234,\
$33444666,\
$77666431

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop98:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000244,\
$01344443,\
$46644210,\
$44210000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop99:	.defchr $4000, $0,\
$00000000,\
$00001344,\
$13444321,\
$44321000,\
$21000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop100:	.defchr $4000, $0,\
$01112221,\
$44322111,\
$00000000,\
$16720000,\
$38840000,\
$27840000,\
$03300000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop101:	.defchr $4000, $0,\
$11000000,\
$11111000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop102:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000036,\
$00001464,\
$00034421,\
$01443100,\
$24420000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop103:	.defchr $4000, $0,\
$00014677,\
$01477631,\
$37741000,\
$64100000,\
$10000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop104:	.defchr $4000, $0,\
$92333333,\
$92333333,\
$93233333,\
$94333333,\
$87233333,\
$78333333,\
$69236333,\
$19733333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop105:	.defchr $4000, $0,\
$33333333,\
$33753333,\
$33863353,\
$35973333,\
$36993333,\
$38794333,\
$69687353,\
$79069433

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop106:	.defchr $4000, $0,\
$53336877,\
$33557877,\
$33337768,\
$33338768,\
$33559439,\
$35369209,\
$53569008,\
$53688007

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop107:	.defchr $4000, $0,\
$35357353,\
$33333535,\
$33333559,\
$67555356,\
$53555533,\
$63666557,\
$75337555,\
$83557755

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop108:	.defchr $4000, $0,\
$32222337,\
$53333338,\
$99999999,\
$87777799,\
$53233337,\
$33333334,\
$53535357,\
$77555837

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop109:	.defchr $4000, $0,\
$82222222,\
$87888888,\
$88999999,\
$73667777,\
$80011111,\
$80000000,\
$80000000,\
$80000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop110:	.defchr $4000, $0,\
$77333373,\
$88333335,\
$99333353,\
$89333333,\
$49333353,\
$09633533,\
$08755353,\
$07855535

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop111:	.defchr $4000, $0,\
$59823333,\
$59963333,\
$38998333,\
$35776365,\
$53322333,\
$35533333,\
$33333575,\
$35635333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop112:	.defchr $4000, $0,\
$36907735,\
$33907735,\
$33907835,\
$33906833,\
$96904933,\
$36800953,\
$37800863,\
$58700795

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop113:	.defchr $4000, $0,\
$33335333,\
$35335333,\
$58333733,\
$55353973,\
$33536993,\
$55357896,\
$35358787,\
$33559677

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop114:	.defchr $4000, $0,\
$23338978,\
$33633988,\
$35353784,\
$55553690,\
$33535590,\
$35373590,\
$35535690,\
$33353880

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop115:	.defchr $4000, $0,\
$99333353,\
$99533333,\
$79635333,\
$18635335,\
$08733333,\
$07833333,\
$06935633,\
$01963335

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop116:	.defchr $4000, $0,\
$33322222,\
$53778733,\
$38999999,\
$35777777,\
$53332333,\
$53333333,\
$36533333,\
$36333353

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop117:	.defchr $4000, $0,\
$22977963,\
$35930933,\
$99910943,\
$79910863,\
$23960873,\
$32860783,\
$33860693,\
$56960197

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop118:	.defchr $4000, $0,\
$63333332,\
$33373333,\
$33333799,\
$33333377,\
$36553312,\
$33633632,\
$33333333,\
$63333353

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop119:	.defchr $4000, $0,\
$11112192,\
$23222392,\
$99999991,\
$77777991,\
$21122396,\
$22222386,\
$33233386,\
$35333396

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop120:	.defchr $4000, $0,\
$00000008,\
$00000008,\
$00000679,\
$00002987,\
$00004933,\
$00004833,\
$00004833,\
$00004873

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop121:	.defchr $4000, $0,\
$63559000,\
$63559023,\
$65539773,\
$33557797,\
$33555377,\
$33553377,\
$77555577,\
$55756677

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop122:	.defchr $4000, $0,\
$00123333,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop123:	.defchr $4000, $0,\
$22100000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop124:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000001

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop125:	.defchr $4000, $0,\
$00000002,\
$00000134,\
$00001341,\
$00014300,\
$00231000,\
$02310000,\
$22100000,\
$20000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop126:	.defchr $4000, $0,\
$44000000,\
$20000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop127:	.defchr $4000, $0,\
$06997666,\
$00278999,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop128:	.defchr $4000, $0,\
$96009856,\
$70003999,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop129:	.defchr $4000, $0,\
$78983003,\
$88600000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop130:	.defchr $4000, $0,\
$99755553,\
$17999999,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop131:	.defchr $4000, $0,\
$75865789,\
$99999976,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop132:	.defchr $4000, $0,\
$70000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop133:	.defchr $4000, $0,\
$03897653,\
$00068999,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop134:	.defchr $4000, $0,\
$35653567,\
$99999998,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop135:	.defchr $4000, $0,\
$99400189,\
$72000006,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop136:	.defchr $4000, $0,\
$87669278,\
$78999039,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop137:	.defchr $4000, $0,\
$55568960,\
$99998600,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop138:	.defchr $4000, $0,\
$00798633,\
$00068999,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop139:	.defchr $4000, $0,\
$35533335,\
$99999999,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop140:	.defchr $4000, $0,\
$79910079,\
$87200006,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop141:	.defchr $4000, $0,\
$86333335,\
$89999999,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop142:	.defchr $4000, $0,\
$33357991,\
$99998720,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop143:	.defchr $4000, $0,\
$00003976,\
$00000788,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop144:	.defchr $4000, $0,\
$86666797,\
$88888882,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop145:	.defchr $4000, $0,\
$00000011,\
$00000110,\
$00000100,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreettop146:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$20000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000



; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom0:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom1:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00001111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom2:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$11111111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom3:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000011,\
$11111111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom4:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$11111111,\
$11111111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom5:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$11000000,\
$11111111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom6:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$11111100

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom7:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000111,\
$01111111,\
$11122222

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom8:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00111111,\
$11111122,\
$22222233,\
$23122222

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom9:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000111,\
$11111111,\
$11112222,\
$22211122,\
$33222333,\
$23544467

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom10:	.defchr $4000, $0,\
$00000000,\
$00000111,\
$11111111,\
$11222222,\
$22223333,\
$22223333,\
$34477799,\
$77999999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom11:	.defchr $4000, $0,\
$00001111,\
$11111111,\
$11122222,\
$22222111,\
$32222333,\
$56777777,\
$97779999,\
$77777777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom12:	.defchr $4000, $0,\
$11111111,\
$11122222,\
$22211111,\
$22222222,\
$55667779,\
$79999999,\
$99977777,\
$77777799

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom13:	.defchr $4000, $0,\
$11111111,\
$22222222,\
$22222222,\
$33355546,\
$99999777,\
$97777777,\
$77777977,\
$a9977777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom14:	.defchr $4000, $0,\
$11222222,\
$22111111,\
$22222223,\
$67777777,\
$77777777,\
$77764443,\
$77774444,\
$77767799

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom15:	.defchr $4000, $0,\
$22222222,\
$11111111,\
$33333333,\
$77777777,\
$77646777,\
$33467999,\
$67777777,\
$99999977

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom16:	.defchr $4000, $0,\
$22222222,\
$11111111,\
$33333333,\
$77777776,\
$77777777,\
$99777666,\
$79777666,\
$77777799

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom17:	.defchr $4000, $0,\
$22222111,\
$11111112,\
$33333333,\
$66666666,\
$77777666,\
$67777777,\
$77777777,\
$97776555

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom18:	.defchr $4000, $0,\
$11111111,\
$22222222,\
$32222222,\
$66555555,\
$66666666,\
$76677777,\
$76667777,\
$67777777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom19:	.defchr $4000, $0,\
$11111111,\
$22222111,\
$22211111,\
$55533333,\
$66665555,\
$77766666,\
$77776666,\
$77766666

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom20:	.defchr $4000, $0,\
$11111100,\
$11111111,\
$11222211,\
$32222222,\
$55555533,\
$55555555,\
$66666666,\
$66666666

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom21:	.defchr $4000, $0,\
$00000000,\
$11111000,\
$11111111,\
$22222111,\
$33222222,\
$55533333,\
$66665555,\
$66666555

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom22:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$11100000,\
$11111111,\
$22211111,\
$32222221,\
$55553222,\
$55555333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom23:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$10000000,\
$11111111,\
$11111111,\
$22222221,\
$33333222

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom24:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$11110000,\
$11111111,\
$21111111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom25:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$11110000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom26:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000001,\
$00001111,\
$01111112

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom27:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000001,\
$00011111,\
$11111122,\
$11122223,\
$22112333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom28:	.defchr $4000, $0,\
$00000000,\
$00000111,\
$00111112,\
$11112222,\
$12222122,\
$22333344,\
$33333479,\
$35677999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom29:	.defchr $4000, $0,\
$11111112,\
$11122222,\
$22223322,\
$31223355,\
$22356799,\
$6799aaaa,\
$9999aacc,\
$accddcca

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom30:	.defchr $4000, $0,\
$22223332,\
$33233223,\
$33335679,\
$557aaaaa,\
$aaaaaccc,\
$aacccccc,\
$cccccaaa,\
$acaaaa99

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom31:	.defchr $4000, $0,\
$23333447,\
$46799999,\
$aa99999a,\
$9999aacc,\
$ccccaaaa,\
$aaaaaaac,\
$aaaaaaac,\
$9799aaaa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom32:	.defchr $4000, $0,\
$77777999,\
$99aaaa99,\
$aaaaaaaa,\
$ccaacccc,\
$accccccc,\
$cca99aaa,\
$ccca9aaa,\
$aaa99acc

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom33:	.defchr $4000, $0,\
$99999977,\
$99999999,\
$aaaaa999,\
$cccaaaac,\
$ccccaaaa,\
$aaaa9999,\
$9aaaaaaa,\
$acccccaa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom34:	.defchr $4000, $0,\
$77777777,\
$97777777,\
$99999777,\
$a9777777,\
$a9774347,\
$97999999,\
$aca99aaa,\
$aaa99999

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom35:	.defchr $4000, $0,\
$77777779,\
$77777777,\
$44447799,\
$7777799a,\
$99997779,\
$777aaaaa,\
$aaa99999,\
$99aaaa99

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom36:	.defchr $4000, $0,\
$99999776,\
$77777799,\
$99999999,\
$a9999aaa,\
$9a99aa99,\
$a99aaa99,\
$aaaa99aa,\
$aaaaaaaa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom37:	.defchr $4000, $0,\
$77999776,\
$99976555,\
$99976555,\
$999999aa,\
$aaaaaaaa,\
$aaaaaaaa,\
$acaccaaa,\
$aaaccccc

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom38:	.defchr $4000, $0,\
$65666677,\
$55335679,\
$56779999,\
$99999999,\
$aaaaaaaa,\
$aaaaaaa9,\
$aaaaaaaa,\
$cccccccc

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom39:	.defchr $4000, $0,\
$99999977,\
$aaaaaaaa,\
$99999999,\
$99776667,\
$99976667,\
$99999999,\
$aaaa999a,\
$caaa99aa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom40:	.defchr $4000, $0,\
$77997799,\
$99999999,\
$9999aaa9,\
$77777999,\
$799aaaa9,\
$aaaaaaaa,\
$aaaaaaaa,\
$aaaaaaaa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom41:	.defchr $4000, $0,\
$97776677,\
$99999977,\
$99977777,\
$99997766,\
$99999976,\
$a9999999,\
$a9996655,\
$a9966555

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom42:	.defchr $4000, $0,\
$77766666,\
$77777766,\
$77777776,\
$77777777,\
$65567997,\
$76677777,\
$55555666,\
$55333335

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom43:	.defchr $4000, $0,\
$66666666,\
$66666666,\
$66655667,\
$76665556,\
$76655555,\
$66666555,\
$65555555,\
$55333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom44:	.defchr $4000, $0,\
$55555555,\
$66655566,\
$76665666,\
$66655556,\
$66665356,\
$66665566,\
$56666666,\
$55555655

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom45:	.defchr $4000, $0,\
$53333333,\
$65533333,\
$66655553,\
$66555555,\
$66665555,\
$76666666,\
$76699666,\
$66999666

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom46:	.defchr $4000, $0,\
$33333332,\
$33333332,\
$33222222,\
$33333222,\
$55555333,\
$66666533,\
$55553333,\
$53322222

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom47:	.defchr $4000, $0,\
$22222211,\
$22222222,\
$22222222,\
$22222222,\
$33333333,\
$32233333,\
$33333333,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom48:	.defchr $4000, $0,\
$11111110,\
$21111111,\
$22211111,\
$22222111,\
$33222222,\
$33222222,\
$33332222,\
$33333333

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom49:	.defchr $4000, $0,\
$00000000,\
$11100000,\
$11111111,\
$11111111,\
$11111111,\
$11111111,\
$22222211,\
$33222222

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom50:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$11110000,\
$11111110,\
$11111111,\
$11111111,\
$11111111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom51:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$11100000,\
$11111100,\
$11111111

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom52:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$00000000,\
$10000000

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom53:	.defchr $4000, $0,\
$00000000,\
$00000000,\
$00000000,\
$00000001,\
$00000111,\
$00011111,\
$01111211,\
$11122112

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom54:	.defchr $4000, $0,\
$00000001,\
$00001111,\
$00111112,\
$11111222,\
$11222222,\
$11123444,\
$22333477,\
$34447799

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom55:	.defchr $4000, $0,\
$11111201,\
$11221123,\
$22122334,\
$22233477,\
$34447999,\
$479a9799,\
$9a997779,\
$97777777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom56:	.defchr $4000, $0,\
$12344444,\
$33444777,\
$4777779a,\
$79799aaa,\
$99999777,\
$99977777,\
$99997777,\
$77777747

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom57:	.defchr $4000, $0,\
$77779acc,\
$79aacccc,\
$ccca9999,\
$aa977777,\
$77777777,\
$99977779,\
$777799aa,\
$77799aaa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom58:	.defchr $4000, $0,\
$cccccca9,\
$aaaa9777,\
$77777777,\
$77777774,\
$77777774,\
$99777776,\
$aa977776,\
$99977777

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom59:	.defchr $4000, $0,\
$74677779,\
$79aa9799,\
$77997799,\
$4777779a,\
$67777999,\
$77777677,\
$77776666,\
$67777766

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom60:	.defchr $4000, $0,\
$999aaa99,\
$9aaaaaac,\
$aaaaaa99,\
$aa99aaa9,\
$9999aaaa,\
$99999999,\
$799a999a,\
$5679999a

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom61:	.defchr $4000, $0,\
$99999aaa,\
$ccaaaaaa,\
$9accccaa,\
$99999999,\
$aaa99979,\
$9aaaa999,\
$aaaaa966,\
$aaccaaaa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom62:	.defchr $4000, $0,\
$aaaaa999,\
$a99999aa,\
$a99999aa,\
$97776777,\
$99976777,\
$9aa96666,\
$9acaa999,\
$ccccaaaa

; TODO: change the vram address (1st number) and palette number (2nd number)
wegreetbottom63:	.defchr $4000, $0,\
$aa997677,\
$a9999977,\
$a99999aa,\
$79999996,\
$76666666,\
$999999aa,\
$aaccaacc,\
$aaaaaaaa

