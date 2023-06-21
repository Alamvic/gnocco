Class {
	#name : #AST,
	#superclass : #Object,
	#traits : 'TFuzzText',
	#classTraits : 'TFuzzText classTrait',
	#category : #Gnocco
}

{ #category : #translating }
AST >> generateInto: stream [

	^ self subclassResponsibility
]
