Class {
	#name : #GncTerminalLiteral,
	#superclass : #GncTerminal,
	#instVars : [
		'literal'
	],
	#category : #'Gnocco-Grammar'
}

{ #category : #translating }
GncTerminalLiteral class >> generateInto: aWriteStream [ 
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
GncTerminalLiteral class >> newWithLiteral: literal [

	^ self new literal: literal
]

{ #category : #accessing }
GncTerminalLiteral >> formatName: stream [

	stream
		<< '''';
		<< literal;
		<< ''''
]

{ #category : #translating }
GncTerminalLiteral >> generateAstWithMaxCost: cost [

	^ GncLeaf withToken: literal
]

{ #category : #translating }
GncTerminalLiteral >> generateInto: stream [
	
	stream << literal 
]

{ #category : #accessing }
GncTerminalLiteral >> literal: data [

	literal := data
]
