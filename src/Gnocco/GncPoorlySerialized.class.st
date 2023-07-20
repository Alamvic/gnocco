Class {
	#name : #GncPoorlySerialized,
	#superclass : #Object,
	#traits : 'TBenchmarkable',
	#classTraits : 'TBenchmarkable classTrait',
	#instVars : [
		'data'
	],
	#category : #Gnocco
}

{ #category : #benchmarking }
GncPoorlySerialized class >> benchFor: sizes with: data [

	| result |
	result := Array new: sizes size.
	(1 to: sizes size)
		do: [ :i |
			| ps |
			ps := self new: (sizes at: i) with: data.
			result at: i put: ps benchmark ]
		displayingProgress: [ :i |
			'Benchmarking {1} ({2}/{3})' format: {
					(sizes at: i).
					(i - 1).
					sizes size } ].
	^ GncFullBenchmarkResult new given: sizes itProduces: result
]

{ #category : #'instance creation' }
GncPoorlySerialized class >> new: size with: content [

	| data |
	data := (1 to: size) collect: [ :i | content clone ].
	^ self new
		  data: data;
		  yourself
]

{ #category : #accessing }
GncPoorlySerialized >> data: givenData [
	data := givenData.
]

{ #category : #accessing }
GncPoorlySerialized >> dataSize [

	^ data size
]

{ #category : #'accessing - parameters' }
GncPoorlySerialized >> minBenchTime [

	^ 5
]

{ #category : #'accessing - parameters' }
GncPoorlySerialized >> minNumberOfRuns [

	^ 3
]

{ #category : #'instance creation' }
GncPoorlySerialized >> serializeIntoStream: stream [

	FLSerializer serialize: self on: stream
]
