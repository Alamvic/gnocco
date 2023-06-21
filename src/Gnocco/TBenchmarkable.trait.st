Trait {
	#name : #TBenchmarkable,
	#category : #Gnocco
}

{ #category : #'instance creation' }
TBenchmarkable >> benchIntoFile: file [

	| result timesBenched |
	result := 0.
	timesBenched := 0.
	[
	timesBenched < self minNumberOfRuns
	| (result / 1000 asFloat < self minBenchTime) ] whileTrue: [
		| instantBenchStarted delta |
		instantBenchStarted := Time millisecondClockValue.
		self serializeInto: file.
		delta := Time millisecondsSince: instantBenchStarted.
		result := result + delta.
		timesBenched := timesBenched + 1 ].
	^ self dataSize -> (result / timesBenched) asFloat
]

{ #category : #'instance creation' }
TBenchmarkable >> dataSize [

	^ self explicitRequirement
]

{ #category : #'instance creation' }
TBenchmarkable >> minBenchTime [

	^ 5
]

{ #category : #'instance creation' }
TBenchmarkable >> minNumberOfRuns [

	^ 3
]

{ #category : #'instance creation' }
TBenchmarkable >> serializeInto: file [

	self explicitRequirement
]
