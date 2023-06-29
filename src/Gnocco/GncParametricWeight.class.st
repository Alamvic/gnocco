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

{ #category : #'actions api' }
GncParametricWeight >> generate [

	^ self get
]

{ #category : #'actions api' }
GncParametricWeight >> get [

	^ weight
]

{ #category : #printing }
GncParametricWeight >> printOn: stream [

	stream print: weight
]

{ #category : #'actions api' }
GncParametricWeight >> set: newWeight [

	weight := newWeight
]
