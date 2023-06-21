Trait {
	#name : #TFuzzAst,
	#traits : 'TFuzzText',
	#classTraits : 'TFuzzText classTrait',
	#category : #Gnocco
}

{ #category : #translating }
TFuzzAst >> generateAstWithMaxCost: cost [

	^ self explicitRequirement 
]

{ #category : #translating }
TFuzzAst >> generateInto: stream [

	self generateAst generateInto: stream
]

{ #category : #translating }
TFuzzAst >> generateWithMaxCost: cost [

	^ String streamContents: [ :stream |
		  (self generateAstWithMaxCost: cost) generateInto: stream ]
]
