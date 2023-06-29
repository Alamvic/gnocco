"
I am an example grammar to produce syntactically valid (more or less) French phone numbers.
"
Class {
	#name : #GncPhoneGrammar,
	#superclass : #GncBaseGrammar,
	#instVars : [
		'ntPhoneNumber',
		'ntBlock',
		'ntStartBlock'
	],
	#category : #'Gnocco-Grammar Library'
}

{ #category : #initialization }
GncPhoneGrammar >> defineGrammar [

	super defineGrammar.

	ntPhoneNumber 
		--> ntStartBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock.
	ntStartBlock --> '0' , ($1 - $7).
	ntBlock --> ntDigit , ntDigit
]

{ #category : #accessing }
GncPhoneGrammar >> start [

	^ ntPhoneNumber 
]
