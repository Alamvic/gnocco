Class {
	#name : #GncInnerNode,
	#superclass : #GncAST,
	#instVars : [
		'children',
		'treeHeight',
		'treeSize'
	],
	#category : #'Gnocco-AST'
}

{ #category : #'instance creation' }
GncInnerNode class >> with: children [

	^ self new children: children
]

{ #category : #'accessing - attributes' }
GncInnerNode >> children: someChildren [

	children := someChildren.

	treeHeight := 0.
	children do: [ :child |
		treeHeight := treeHeight max: child treeHeight ].
	treeHeight := treeHeight + 1.

	treeSize := 1.
	children do: [ :child | treeSize := treeSize + child treeSize ]
]

{ #category : #translating }
GncInnerNode >> generateInto: stream [

	children do: [ :child | child generateInto: stream ]
]

{ #category : #translating }
GncInnerNode >> minHeight [

	| minCost |
	minCost := 0.
	children do: [ :child | minCost := minCost max: child treeHeight ].
	^ minCost + 1
]

{ #category : #translating }
GncInnerNode >> minSize [

	^ ((children collect: [ :child | child minSize ]) fold: [ :i :j |
		   i + j ]) + 1
]

{ #category : #translating }
GncInnerNode >> treeHeight [

	^ treeHeight
]

{ #category : #translating }
GncInnerNode >> treeSize [

	^ treeSize
]
