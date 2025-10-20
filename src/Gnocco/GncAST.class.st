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
GncAST >> at: index [

	self subclassResponsibility 
]

{ #category : 'translating' }
GncAST >> children [

	self subclassResponsibility
]

{ #category : 'translating' }
GncAST >> generateInto: stream [

	^ self subclassResponsibility
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
GncAST >> parent [

	^ parent
]

{ #category : 'accessing' }
GncAST >> parent: myParent [

	parent := myParent
]

{ #category : 'translating' }
GncAST >> treeHeight [

	^ self subclassResponsibility
]

{ #category : 'translating' }
GncAST >> treeSize [

	^ self subclassResponsibility
]
