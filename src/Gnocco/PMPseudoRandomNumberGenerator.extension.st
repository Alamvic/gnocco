Extension { #name : #PMPseudoRandomNumberGenerator }

{ #category : #'*Gnocco' }
PMPseudoRandomNumberGenerator >> nextInteger: anInteger [

	^ (self next * anInteger) truncated + 1
]
