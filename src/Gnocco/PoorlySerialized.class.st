Class {
	#name : #PoorlySerialized,
	#superclass : #Object,
	#traits : 'TBenchmarkable',
	#classTraits : 'TBenchmarkable classTrait',
	#instVars : [
		'data'
	],
	#category : #Gnocco
}

{ #category : #benchmarking }
PoorlySerialized class >> benchFor: sizes [

	| result |
	result := sizes collect: [ :size |
		          | ps res |
		          ps := self new: size.
		          res := ps benchIntoFile: 'hello2.fuel'.
		          res ].
	^ BenchResult new given: sizes itProduces: result
]

{ #category : #benchmarking }
PoorlySerialized class >> benchFor: sizes with: data [
	| result |
	result := sizes collect: [ :size | | ps |
		ps := self new: size with: data.
		ps benchIntoFile: 'hello2.fuel' ].
	^BenchResult new given: sizes itProduces: result.
]

{ #category : #'instance creation' }
PoorlySerialized class >> new: size [

	| data s |
	s := SingletonFactory new.
	data := (1 to: size) collect: [ :i | s getSingleton ].
	^ self new
		  data: data;
		  yourself
]

{ #category : #'instance creation' }
PoorlySerialized class >> new: size with: content [

	| data |
	data := (1 to: size) collect: [ :i | content clone ].
	^ self new
		  data: data;
		  yourself
]

{ #category : #accessing }
PoorlySerialized >> data: givenData [
	data := givenData.
]

{ #category : #accessing }
PoorlySerialized >> dataSize [

	^ data size
]

{ #category : #accessing }
PoorlySerialized >> serializeInto: file [

	FLSerializer serialize: self toFileNamed: file
]
