Class {
	#name : 'GncTerminalLiteral',
	#superclass : 'GncTerminal',
	#instVars : [
		'literal'
	],
	#category : 'Gnocco-Grammar',
	#package : 'Gnocco',
	#tag : 'Grammar'
}

{ #category : 'translating' }
GncTerminalLiteral class >> generateInto: aWriteStream [ 
	self shouldBeImplemented.
]

{ #category : 'instance creation' }
GncTerminalLiteral class >> newWithLiteral: literal [

	^ self new literal: literal
]

{ #category : 'comparing' }
GncTerminalLiteral >> = anotherTerminal [

	anotherTerminal class = self class ifFalse: [ ^ false ].
	^ literal = anotherTerminal literal
]

{ #category : 'visiting' }
GncTerminalLiteral >> accept: string [

	1 halt.
]

{ #category : 'as yet unclassified' }
GncTerminalLiteral >> consume: word [
	"TODO: return the character that could consume from the input"

	word size < literal size ifTrue: [ ^ nil ].
	
	^ literal = (word first: literal size) ifTrue: [ literal ]
]

{ #category : 'as yet unclassified' }
GncTerminalLiteral >> consume: input from: index [
	"TODO: return the character that could consume from the input"

	| word |

	word := input allButFirst: index.
	word size < literal size ifTrue: [ ^ nil ].
	
	^ literal = (word first: literal size) ifTrue: [ literal ]
]

{ #category : 'translating' }
GncTerminalLiteral >> generateAst: generator [

	^ GncLeaf withToken: literal
]

{ #category : 'translating' }
GncTerminalLiteral >> generateInto: stream [
	
	stream << literal 
]

{ #category : 'comparing' }
GncTerminalLiteral >> hash [

	^ literal hash
]

{ #category : 'accessing' }
GncTerminalLiteral >> literal [

	^ literal
]

{ #category : 'accessing' }
GncTerminalLiteral >> literal: data [

	literal := data
]

{ #category : 'printing' }
GncTerminalLiteral >> printNameOn: stream [

	stream
		<< '''';
		<< literal;
		<< ''''
]
