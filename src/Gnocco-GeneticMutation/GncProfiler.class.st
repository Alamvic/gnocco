Class {
	#name : #GncProfiler,
	#superclass : #Object,
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'primitives - access' }
GncProfiler class >> blop [

	<primitive: 520>
	self primitiveFailed: #blop
]

{ #category : #'primitives - access' }
GncProfiler class >> countMessageSentIn: block [
	"Return the number of message sent in the block."

	^ [
	  self blop.
	  block value.
	  self blop - 1 "Do no take into account the `blop` message" ]
		  valueUnpreemptively
]
