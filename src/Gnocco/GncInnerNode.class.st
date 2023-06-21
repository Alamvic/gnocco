Class {
	#name : #GncInnerNode,
	#superclass : #GncAST,
	#instVars : [
		'children'
	],
	#category : #'Gnocco-AST'
}

{ #category : #'instance creation' }
GncInnerNode class >> with: children [

	^ self new children: children
]

{ #category : #'accessing - attributes' }
GncInnerNode >> children: someChildren [

	children := someChildren
]

{ #category : #translating }
GncInnerNode >> cost [

	| minCost |
	minCost := 0.
	children do: [ :child | minCost := minCost max: child cost ].
	^ minCost + 1
]

{ #category : #translating }
GncInnerNode >> generateInto: stream [

	children do: [ :child | child generateInto: stream ]
]
