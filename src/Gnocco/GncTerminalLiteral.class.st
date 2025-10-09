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
