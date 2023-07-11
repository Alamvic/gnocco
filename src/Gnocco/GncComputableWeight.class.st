Class {
	#name : #GncComputableWeight,
	#superclass : #GncWeight,
	#instVars : [
		'parameter',
		'block'
	],
	#category : #'Gnocco-Weight'
}

{ #category : #'instance creation' }
GncComputableWeight class >> newWithWeight: block [

	^ self new
		  block: block;
		  yourself
]

{ #category : #'as yet unclassified' }
GncComputableWeight >> block: newBlock [

	block := newBlock
]

{ #category : #'as yet unclassified' }
GncComputableWeight >> generate [

	^ block cull: parameter
]

{ #category : #'as yet unclassified' }
GncComputableWeight >> get [

	^ parameter
]

{ #category : #initialization }
GncComputableWeight >> initialize [ 

	self set: 1
]

{ #category : #printing }
GncComputableWeight >> printOn: stream [

	stream
		<< '<fun>:';
		print: parameter
]

{ #category : #'as yet unclassified' }
GncComputableWeight >> set: weight [

	parameter := weight
]
