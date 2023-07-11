Class {
	#name : #GncAST,
	#superclass : #Object,
	#traits : 'TFuzzText',
	#classTraits : 'TFuzzText classTrait',
	#category : #'Gnocco-AST'
}

{ #category : #translating }
GncAST >> children [

	self subclassResponsibility
]

{ #category : #translating }
GncAST >> generateInto: stream [

	^ self subclassResponsibility
]

{ #category : #inspecting }
GncAST >> inspectorTreeBuilder [

	<inspectorPresentationOrder: 1 title: 'Tree'>
	^ SpTreePresenter new
		  roots: { self };
		  children: #children;
		  display: [ :each | each printString ];
		  yourself
]

{ #category : #translating }
GncAST >> treeHeight [

	^ self subclassResponsibility
]

{ #category : #translating }
GncAST >> treeSize [

	^ self subclassResponsibility
]
