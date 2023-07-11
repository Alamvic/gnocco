Class {
	#name : #GncTerminalBlock,
	#superclass : #GncTerminal,
	#instVars : [
		'block'
	],
	#category : #'Gnocco-Grammar'
}

{ #category : #accessing }
GncTerminalBlock >> block: anObject [

	block := anObject
]

{ #category : #translating }
GncTerminalBlock >> generateAst: generator [

	^ GncLeaf withToken: (block cull: generator)
]

{ #category : #printing }
GncTerminalBlock >> printNameOn: stream [

	stream << '<fun>'
]
