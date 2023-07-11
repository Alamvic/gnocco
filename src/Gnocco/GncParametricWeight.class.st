Class {
	#name : #GncParametricWeight,
	#superclass : #GncWeight,
	#instVars : [
		'weight'
	],
	#category : #'Gnocco-Weight'
}

{ #category : #'instance creation' }
GncParametricWeight class >> newWithWeight: weight [

	^ self new
		  set: weight;
		  yourself
]

{ #category : #'as yet unclassified' }
GncParametricWeight >> generate [

	^ self get
]

{ #category : #'as yet unclassified' }
GncParametricWeight >> get [

	^ weight
]

{ #category : #printing }
GncParametricWeight >> printOn: stream [

	stream print: weight
]

{ #category : #'as yet unclassified' }
GncParametricWeight >> set: newWeight [

	weight := newWeight
]
