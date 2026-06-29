Class {
	#name : 'GncInnerNode',
	#superclass : 'GncAST',
	#instVars : [
		'children',
		'treeHeight',
		'treeSize',
		'tag'
	],
	#category : 'Gnocco-AST',
	#package : 'Gnocco',
	#tag : 'AST'
}

{ #category : 'instance creation' }
GncInnerNode class >> with: children [

	^ self new children: children
]

{ #category : 'accessing' }
GncInnerNode >> aLeaf [

	^ children atRandom aLeaf 
]

{ #category : 'rendering' }
GncInnerNode >> allNodes [

	^ { self }, (children flatCollect: #allNodes)
]

{ #category : 'rendering' }
GncInnerNode >> asLabel [
	
	| color |
	
	color := RSColorPalette sequential blues3 range third.
	^ RSLabel new text: tag; color: color.
]

{ #category : 'accessing' }
GncInnerNode >> at: index [

	| remaining |
	
	index = 1 ifTrue: [ ^ self ].
	
	remaining := index - 1.
	children do: [ :child |
		(remaining <= child treeSize) ifTrue: [ ^ child at: remaining ].
		remaining := remaining - child treeSize.
	].
]

{ #category : 'translating' }
GncInnerNode >> children [

	^ children
]

{ #category : 'accessing - attributes' }
GncInnerNode >> children: someChildren [

	inputSize := nil.
	
	children := someChildren.

	treeHeight := 0.
	children do: [ :child |
		treeHeight := treeHeight max: child treeHeight ].
	treeHeight := treeHeight + 1.

	treeSize := 1.
	children do: [ :child |
		treeSize := treeSize + child treeSize.
		child parent: self.
	]
]

{ #category : 'translating' }
GncInnerNode >> generateInto: stream [

	children do: [ :child | child generateInto: stream ]
]

{ #category : 'testing' }
GncInnerNode >> isLeaf [

	^ false
]

{ #category : 'translating' }
GncInnerNode >> minHeight [

	| minCost |
	minCost := 0.
	children do: [ :child | minCost := minCost max: child treeHeight ].
	^ minCost + 1
]

{ #category : 'translating' }
GncInnerNode >> minSize [

	^ ((children collect: [ :child | child minSize ]) fold: [ :i :j |
		   i + j ]) + 1
]

{ #category : 'as yet unclassified' }
GncInnerNode >> repairChildren [

	children do: [ :child | child parent: self . child repairChildren ]
	
]

{ #category : 'rendering' }
GncInnerNode >> shapes [

	^ { self shape }, (children flatCollect: #shapes)
]

{ #category : 'accessing' }
GncInnerNode >> tag [

	^ tag
]

{ #category : 'accessing' }
GncInnerNode >> tag: anObject [

	tag := anObject
]

{ #category : 'translating' }
GncInnerNode >> treeHeight [

	^ treeHeight
]

{ #category : 'translating' }
GncInnerNode >> treeSize [

	^ treeSize
]

{ #category : 'as yet unclassified' }
GncInnerNode >> updateWeightToChildren: reward [ 

	self children do: [ :child | child updateWeightRecursive: reward ]
]
