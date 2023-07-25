Class {
	#name : #GncStonGrammarIndividual,
	#superclass : #GncIndividual,
	#instVars : [
		'grammar'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'instance creation' }
GncStonGrammarIndividual class >> newFrom: other [

	^ self new
		grammar: other grammar veryDeepCopy;
		generator: other generator.
]

{ #category : #accessing }
GncStonGrammarIndividual >> computeScore [

	| "profiler" result data |
	"profiler := PrfMethodProfiler new.
	profiler addPackage: #'Fuel-Core' asPackage."
	data := GncObjectGraph with: (STON reader
			         on: (grammar generate: generator) readStream;
			         next).

	"Time-based score"
	"result := Time millisecondClockValue.
	data serializeInto: 'hello.fuel'.
	result := Time millisecondsSince: result."

	"Fully-featured profiler-based score"
	"profiler profile: [ data serializeInto: 'hello.fuel' ].
	profiler nodes valuesDo: [ :method |
		result := result + method timesCalled ].
	profiler destroy."

	"Custom profiled based score"
	result := GncProfiler countMessageSentIn: [
		          data serializeIntoStream: GncStupidStream new ].
	^ result
]

{ #category : #accessing }
GncStonGrammarIndividual >> grammar [

	^ grammar
]

{ #category : #accessing }
GncStonGrammarIndividual >> grammar: aGrammar [

	grammar := aGrammar
]

{ #category : #accessing }
GncStonGrammarIndividual >> parameters [

	^ grammar parameters
]
