Class {
	#name : #GncWeight,
	#superclass : #GncParameter,
	#category : #'Gnocco-Weight'
}

{ #category : #'instance creation' }
GncWeight class >> newWithWeight: weight [

	self subclassResponsibility
]

{ #category : #converting }
GncWeight >> asWeight [

	^ self
]

{ #category : #'as yet unclassified' }
GncWeight >> atRandom: generator [

	self set: (1000 atRandom: generator random)
]

{ #category : #'as yet unclassified' }
GncWeight >> generate [

	^ self subclassResponsibility 
]
