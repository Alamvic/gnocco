Class {
	#name : #GncWeight,
	#superclass : #Object,
	#category : #'Gnocco-Weight'
}

{ #category : #converting }
GncWeight >> asWeight [

	^ self
]

{ #category : #'actions api' }
GncWeight >> generate [

	^ self subclassResponsibility 
]

{ #category : #'actions api' }
GncWeight >> get [

	^ self subclassResponsibility 
]

{ #category : #'actions api' }
GncWeight >> set: weight [

	^ self subclassResponsibility 
]
