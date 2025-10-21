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
GncAST >> asLabel [
	
	self subclassResponsibility 
]

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

{ #category : 'rendering' }
GncAST >> render [

	| canvas shapes eb |
	shapes := self shapes.
	canvas := RSCanvas new.
	canvas edges do: #withBorder.
	canvas addAll: shapes.
	eb := RSLineBuilder line.
	eb canvas: canvas.
	eb connectFrom: #parent.
	RSTreeLayout on: shapes.
	shapes do: [ :e | e translateBy: 0 @ 0 ].
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : 'accessing' }
GncAST >> shape [

	| label box |
	label := self asLabel.

	box := RSBox new extent: label extent + 10; color: Color lightBlue .
	^ RSComposite new draggable; model: self; shapes: (RSGroup with: box with: label)
]

{ #category : 'rendering' }
GncAST >> shapes [

	self subclassResponsibility 
]

{ #category : 'translating' }
GncAST >> treeHeight [

	^ self subclassResponsibility
]

{ #category : 'translating' }
GncAST >> treeSize [

	^ self subclassResponsibility
]
