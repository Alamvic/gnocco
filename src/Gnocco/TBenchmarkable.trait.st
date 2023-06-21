"
I represent the capacity of being benchmarked (by serialization).

Classes that use me should be data whose serialization is to be benchmarked. To do so, users must implement the following methods:

- `dataSize` should answer an (arbitrary) measure of the underlying data to be benchmarked. This will be used to plot the result of the benchmark.
- `serializeInto: file`: should perform a single serialization step. This is the method that will be benchmarked, so it is important that it does nothing but what you want to be measured. In particular, any setup should be performed during class initialization.
"
Trait {
	#name : #TBenchmarkable,
	#category : #'Gnocco-Fuzzing Artifact'
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

{ #category : #accessing }
TBenchmarkable >> dataSize [

	^ self explicitRequirement
]

{ #category : #'accessing - parameters' }
TBenchmarkable >> minBenchTime [

	^ 5
]

{ #category : #'accessing - parameters' }
TBenchmarkable >> minNumberOfRuns [

	^ 3
]

{ #category : #'instance creation' }
TBenchmarkable >> serializeInto: file [

	self explicitRequirement
]
