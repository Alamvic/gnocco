Class {
	#name : 'GncTerminalBlock',
	#superclass : 'GncTerminal',
	#instVars : [
		'block'
	],
	#category : 'Gnocco-Grammar',
	#package : 'Gnocco',
	#tag : 'Grammar'
}

{ #category : 'visiting' }
GncTerminalBlock >> accept: string [

	1 halt.
]

{ #category : 'accessing' }
GncTerminalBlock >> block: anObject [

	block := anObject
]

{ #category : 'as yet unclassified' }
GncTerminalBlock >> consume: word [

	1 halt.
]

{ #category : 'translating' }
GncTerminalBlock >> generateAst: generator [

	^ GncLeaf withToken: (block cull: generator)
]

{ #category : 'printing' }
GncTerminalBlock >> printNameOn: stream [

	stream << '<fun>'
]
