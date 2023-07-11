Class {
	#name : #GncParameter,
	#superclass : #Object,
	#category : #'Gnocco-Genetic Optimization'
}

{ #category : #'as yet unclassified' }
GncParameter >> atRandom: generator [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
GncParameter >> get [

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GncParameter >> set: parameter [

	^ self subclassResponsibility 
]
