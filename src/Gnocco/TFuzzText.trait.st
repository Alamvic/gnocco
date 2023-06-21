Trait {
	#name : #TFuzzText,
	#category : #Gnocco
}

{ #category : #translating }
TFuzzText >> generate [

	^ String streamContents: [ :stream | self generateInto: stream ]
]

{ #category : #translating }
TFuzzText >> generateInto: stream [
	^ self explicitRequirement 
]
