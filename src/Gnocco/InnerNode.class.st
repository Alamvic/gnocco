Class {
	#name : #InnerNode,
	#superclass : #AST,
	#instVars : [
		'children'
	],
	#category : #Gnocco
}

{ #category : #'instance creation' }
InnerNode class >> with: children [

	^ self new children: children
]

{ #category : #accessing }
InnerNode >> children: someChildren [

	children := someChildren
]

{ #category : #translating }
InnerNode >> generateInto: stream [

	children do: [ :child | child generateInto: stream ]
]
