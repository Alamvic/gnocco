Class {
	#name : #TerminalLiteral,
	#superclass : #Terminal,
	#instVars : [
		'literal'
	],
	#category : #Gnocco
}

{ #category : #translating }
TerminalLiteral class >> generateInto: aWriteStream [ 
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
TerminalLiteral class >> newWithLiteral: literal [

	^ self new literal: literal
]

{ #category : #accessing }
TerminalLiteral >> formatName: stream [

	stream
		<< '''';
		<< literal;
		<< ''''
]

{ #category : #translating }
TerminalLiteral >> generateAstWithMaxCost: cost [

	^ Leaf with: literal
]

{ #category : #translating }
TerminalLiteral >> generateInto: stream [
	
	stream << literal 
]

{ #category : #accessing }
TerminalLiteral >> literal: data [

	literal := data
]
