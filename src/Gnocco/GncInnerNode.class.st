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

{ #category : 'accessing' }
GncInnerNode >> allChildAtLevel: level currentLevel: currentLevel [

	^ ( level = currentLevel ) ifTrue: [ OrderedCollection with: self ] ifFalse: [
		children flatCollect: [ :child | child allChildAtLevel: level currentLevel: currentLevel + 1 ]
	].
	
	

]

{ #category : 'rendering' }
GncInnerNode >> allNodes [

	^ { self }, (children flatCollect: #allNodes)
]

{ #category : 'accessing' }
GncInnerNode >> allNodesAtLevel: level [

	^ self allChildAtLevel: level currentLevel: 0
]

{ #category : 'accessing' }
GncInnerNode >> asClassInstanceObject [

	| objectClass |

	objectClass := self objectClass.

	^ (1 to: children size by: 2) inject: objectClass basicNew into: [ :inst :index | | value |
		value := (children at: index + 1) asPharoObject.
		inst instVarNamed: (children at: index) varName put: value.
		inst
	]
]

{ #category : 'rendering' }
GncInnerNode >> asLabel [
	
	| color |
	
	color := RSColorPalette sequential blues3 range third.
	^ RSLabel new text: tag; color: color.
]

{ #category : 'accessing' }
GncInnerNode >> asPharoObject [

	^ self isClassObject
		  ifTrue: [ self asClassInstanceObject ]
		  ifFalse: [ self asPrimitiveObject ]
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

{ #category : 'accessing' }
GncInnerNode >> backPropagateToChildren: reward [

	self children do: [ :child | child backPropagateRecursive: reward ]
]

{ #category : 'accessing' }
GncInnerNode >> backPropagateToChildren: reward level: level [

	self children do: [ :child | child backPropagateRecursive: reward level: level ]
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

{ #category : 'accessing' }
GncInnerNode >> decreaseTreeSizeBy: aSize [

    treeSize := treeSize - aSize.
    parent ifNotNil: [ :p | p decreaseTreeSizeBy: aSize ].
]

{ #category : 'as yet unclassified' }
GncInnerNode >> doCopy [

	^ super doCopy
		  treeHeight: treeHeight;
		  treeSize: treeSize;
		  tag: tag;
		  children: (children collect: #doCopy)
]

{ #category : 'translating' }
GncInnerNode >> generateInto: stream [

	children do: [ :child | child generateInto: stream ]
]

{ #category : 'accessing' }
GncInnerNode >> increaseTreeSizeBy: aSize [

    treeSize := treeSize + aSize.
    parent ifNotNil: [ :p | p increaseTreeSizeBy: aSize ].
]

{ #category : 'accessing' }
GncInnerNode >> indexOf: aNode [

	^ children indexOf: aNode
]

{ #category : 'accessing' }
GncInnerNode >> inputSize: size [

	inputSize := size
]

{ #category : 'accessing' }
GncInnerNode >> isClassObject [

	^ children first isTypeVariable
]

{ #category : 'testing' }
GncInnerNode >> isLeaf [

	^ false
]

{ #category : 'accessing' }
GncInnerNode >> levelOf: subTree [

	^ ( self treeHeight - subTree treeHeight )
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

{ #category : 'accessing' }
GncInnerNode >> objectClass [

	^ tag asClassInEnvironment: self class environment
]

{ #category : 'accessing' }
GncInnerNode >> removeChild: child [

	| childSize|

	childSize := child treeSize.
	children remove: child ifAbsent: [  Error signal: 'Trying to remove a wrong child' ].
	child parent: nil. 
	self decreaseTreeSizeBy: childSize.
]

{ #category : 'accessing' }
GncInnerNode >> removeChildAt: index [ 

	| childSize |
	
	childSize := (children at: index) treeSize. 
	children removeAt: index.
	self decreaseTreeSizeBy: childSize.
]

{ #category : 'as yet unclassified' }
GncInnerNode >> repairChildren [

	children do: [ :child | child parent: self . child repairChildren ]
	
]

{ #category : 'accessing' }
GncInnerNode >> replaceChild: child by: newChild [

	| index |

	index := children indexOf: child.
	self replaceChildAt: index with: newChild
]

{ #category : 'accessing' }
GncInnerNode >> replaceChildAt: index with: newNode [

	| previousNode previousSize newSize delta |
	
	previousNode := children at: index. 
	previousSize := previousNode treeSize.
	newSize := newNode treeSize.

	children at: index put: newNode.
	previousNode parent: nil. 
	newNode parent: self.
	
	delta := newSize - previousSize.
	( delta ~= 0 ) ifTrue: [ 
		self increaseTreeSizeBy: delta ]

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

{ #category : 'as yet unclassified' }
GncInnerNode >> treeHeight: height [

	treeHeight := height 
]

{ #category : 'translating' }
GncInnerNode >> treeSize [

	^ treeSize
]

{ #category : 'accessing' }
GncInnerNode >> treeSize: size [

	treeSize := size 
]

{ #category : 'as yet unclassified' }
GncInnerNode >> updateWeightToChildren: reward [ 

	self children do: [ :child | child updateWeightRecursive: reward ]
]
