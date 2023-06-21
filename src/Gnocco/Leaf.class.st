Class {
	#name : #Leaf,
	#superclass : #AST,
	#instVars : [
		'literal'
	],
	#category : #Gnocco
}

{ #category : #'instance creation' }
Leaf class >> with: literal [

	^ self new literal: literal
]

{ #category : #translating }
Leaf >> generateInto: stream [

	stream << literal
]

{ #category : #translating }
Leaf >> literal: aLiteral [

	literal := aLiteral
]
