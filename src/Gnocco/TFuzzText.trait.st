"
I'm not sure what my purpose in life is. Maybe I'm useless, in which case I'll probably be deleted
soon :(
"
Trait {
	#name : #TFuzzText,
	#category : #'Gnocco-Fuzzing Artifact'
}

{ #category : #translating }
TFuzzText >> generate [

	^ String streamContents: [ :stream | self generateInto: stream ]
]

{ #category : #translating }
TFuzzText >> generateInto: stream [
	^ self explicitRequirement 
]
