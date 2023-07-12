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
	result := sizes collect: [ :size | | ps |
		ps := self new: size with: data.
		ps benchmark ].
	^GncFullBenchmarkResult new given: sizes itProduces: result.
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
