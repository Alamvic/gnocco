Class {
	#name : #GncAST,
	#superclass : #Object,
	#traits : 'TFuzzText',
	#classTraits : 'TFuzzText classTrait',
	#category : #'Gnocco-AST'
}

{ #category : #translating }
GncAST >> cost [

	^ self subclassResponsibility
]

{ #category : #translating }
GncAST >> generateInto: stream [

	^ self subclassResponsibility
]
