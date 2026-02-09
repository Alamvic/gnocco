Class {
	#name : 'GncBPGrammarGenerator',
	#superclass : 'Object',
	#instVars : [
		'grammar',
		'generator',
		'lastInput'
	],
	#category : 'Gnocco-Grammar',
	#package : 'Gnocco',
	#tag : 'Grammar'
}

{ #category : 'accessing' }
GncBPGrammarGenerator >> derivationTree: input [

	^ GncGenericGrammarParser parse: input from: grammar
]

{ #category : 'accessing' }
GncBPGrammarGenerator >> feed: feedback [
	
	feedback ifNotNil: [ | ast |
		[ ast := self derivationTree: (feedback case) ] on: Error do: [ ^ nil ].
		
		ast ifNil: [ ^ nil ].
		
		"Increase/Decrease the weight of each production based on the feedback"
		ast updateWeightToChildren: ((feedback isPositive) ifTrue: [ 1 ] ifFalse: [ -1 ]).
	]
]

{ #category : 'accessing' }
GncBPGrammarGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable grammar"
	lastInput := grammar generate: generator.
	^ lastInput
	
]

{ #category : 'accessing' }
GncBPGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar.
]

{ #category : 'accessing' }
GncBPGrammarGenerator >> initialize [ 

	super initialize.
	generator := GncGrammarGenerator newUnbounded maxHeight: SmallInteger maxVal; maxSize: 20
]

{ #category : 'accessing' }
GncBPGrammarGenerator >> maxHeight: aHeight [

	generator maxHeight: aHeight
]

{ #category : 'accessing' }
GncBPGrammarGenerator >> maxSize: aSize [

	generator maxSize: aSize 
]
