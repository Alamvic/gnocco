Class {
	#name : #GncGrammarIndividual,
	#superclass : #GncIndividual,
	#instVars : [
		'grammar'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'instance creation' }
GncGrammarIndividual class >> newFrom: other [

	^ self new
		grammar: other grammar veryDeepCopy;
		generator: other generator.
]

{ #category : #accessing }
GncGrammarIndividual >> computeScore [

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
GncGrammarIndividual >> grammar [

	^ grammar
]

{ #category : #accessing }
GncGrammarIndividual >> grammar: aGrammar [

	grammar := aGrammar
]

{ #category : #accessing }
GncGrammarIndividual >> parameters [

	^ grammar parameters
]
