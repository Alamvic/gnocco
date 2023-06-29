Class {
	#name : #GncAST,
	#superclass : #Object,
	#traits : 'TFuzzText',
	#classTraits : 'TFuzzText classTrait',
	#category : #'Gnocco-AST'
}

{ #category : #translating }
GncAST >> generateInto: stream [

	^ self subclassResponsibility
]

{ #category : #translating }
GncAST >> treeHeight [

	^ self subclassResponsibility
]

{ #category : #translating }
GncAST >> treeSize [

	^ self subclassResponsibility
]
