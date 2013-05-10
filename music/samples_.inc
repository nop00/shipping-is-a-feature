


;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
sample_bank:
	.db bank(sample0),bank(sample1),bank(sample2)

sample_addr:
	.db low(sample0),high(sample0),low(sample1),high(sample1),low(sample2),high(sample2)
	
sample0:
	.incbin "music/boum.pcm"
sample1:
	.incbin "music/tchac.pcm"
sample2:
	.incbin "music/tic.pcm"






