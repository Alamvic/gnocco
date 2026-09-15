Class {
	#name : 'GncAST',
	#superclass : 'Object',
	#traits : 'TFuzzText',
	#classTraits : 'TFuzzText classTrait',
	#instVars : [
		'grammarRule',
		'inputSize',
		'parent'
	],
	#category : 'Gnocco-AST',
	#package : 'Gnocco',
	#tag : 'AST'
}

{ #category : 'accessing' }
GncAST >> aLeaf [

	"TODO: Delete me later"
	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> allChildAtLevel: level currentLevel: currentLevel [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> allChildren [

	self subclassResponsibility
]

{ #category : 'translating' }
GncAST >> allNodes [

	self subclassResponsibility
]

{ #category : 'accessing' }
GncAST >> asInput [

	^ self asStringInput
]

{ #category : 'accessing' }
GncAST >> asLabel [
	
	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> asPharoObject [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> asPrimitiveObject [

	^ [ Object readFrom: self asStringInput ]
		  on: Error
		  do: [ :ex | self asStringInput ]
]

{ #category : 'accessing' }
GncAST >> asStringInput [

	^ String streamContents: [ :stream | self generateInto: stream ]
]

{ #category : 'accessing' }
GncAST >> at: index [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> backPropagate: reward [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward ].
]

{ #category : 'accessing' }
GncAST >> backPropagateRecursive: reward [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward ].
	self backPropagateToChildren: reward.
]

{ #category : 'accessing' }
GncAST >> backPropagateRecursive: reward level: level [

	grammarRule ifNotNil: [ grammarRule backPropagate: reward level: level. "grammarRule visitIn: level" ].

	self backPropagateToChildren: reward level: level + 1.
]

{ #category : 'accessing' }
GncAST >> backPropagateToChildren: reward [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> backPropagateToChildren: reward level: level [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> canReplace: aNode [

	"Return true if I can replace aNode in the AST. 
	 Basic rule: same grammar type/tag."
	
	^ self grammarRule = aNode grammarRule
]

{ #category : 'translating' }
GncAST >> children [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
GncAST >> doCopy [

	^ self class new
		  inputSize: inputSize;
		  grammarRule: grammarRule
]

{ #category : 'accessing' }
GncAST >> emptyTree [

	^ GncInnerNode new tag: self tag; grammarRule: grammarRule; children: {}.
]

{ #category : 'translating' }
GncAST >> generateInto: stream [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
GncAST >> grammarRule [

	^ grammarRule
]

{ #category : 'as yet unclassified' }
GncAST >> grammarRule: gncRule [

	grammarRule := gncRule.
]

{ #category : 'accessing' }
GncAST >> inputSize [

	inputSize ifNil: [ inputSize := self generate size ].

	^ inputSize
]

{ #category : 'inspecting' }
GncAST >> inspectorTreeBuilder [

	<inspectorPresentationOrder: 1 title: 'Tree'>
	^ SpTreePresenter new
		  roots: { self };
		  children: #children;
		  display: [ :each | each printString ];
		  yourself
]

{ #category : 'testing' }
GncAST >> isLeaf [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> isTypeVariable [

	^ false
]

{ #category : 'accessing' }
GncAST >> minimumTree [

	^ GncInnerNode new tag: self tag; grammarRule: grammarRule; children: grammarRule minimumTree.
]

{ #category : 'accessing' }
GncAST >> parent [

	^ parent
]

{ #category : 'accessing' }
GncAST >> parent: myParent [

	parent := myParent
]

{ #category : 'rendering' }
GncAST >> render [

	| canvas shapes |
	shapes := self shapes.
	canvas := RSCanvas new.
	canvas addAll: shapes.
	
	"shapes do: [ :e | e translateBy: 0 @ 0 ]."

	RSLineBuilder arrowedLine withBorderAttachPoint; canvas: canvas; connectFrom: #parent.
	RSTreeLayout on: canvas nodes.
	
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : 'as yet unclassified' }
GncAST >> repairChildren [
	self subclassResponsibility.
]

{ #category : 'accessing' }
GncAST >> reward: grammarInstance root: astRoot [

	| level |
	level := (astRoot treeHeight) - self treeHeight.
	
	^ self grammarRule rewardBy: level
]

{ #category : 'accessing' }
GncAST >> root [
	
	^ parent ifNil: [ self ] ifNotNil: [ parent root ].
]

{ #category : 'accessing' }
GncAST >> shape [

	| label circle color |
	label := self asLabel.
	color := RSColorPalette sequential blues3 range first.
	circle := RSEllipse new extent: label extent + 10; color: color.
	^ RSComposite new draggable; model: self; shapes: (RSGroup with: circle with: label)
]

{ #category : 'rendering' }
GncAST >> shapes [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> tag [

	^ nil
]

{ #category : 'translating' }
GncAST >> treeHeight [

	^ self subclassResponsibility
]

{ #category : 'translating' }
GncAST >> treeSize [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
GncAST >> updateWeightRecursive: reward [

	grammarRule ifNotNil: [ grammarRule updateWeightWith: reward ].
	
	self updateWeightToChildren: reward.
]

{ #category : 'as yet unclassified' }
GncAST >> updateWeightToChildren: reward [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncAST >> visited [
	
	^ false 
]
