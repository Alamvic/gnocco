"
I am an example grammar to produce syntactically valid (more or less) French phone numbers.
"
Class {
	#name : #GncPhoneGrammar,
	#superclass : #GncBaseGrammar,
	#instVars : [
		'ntPhoneNumber',
		'ntBlock'
	],
	#category : #'Gnocco-Grammar Library'
}

{ #category : #initialization }
GncPhoneGrammar >> defineGrammar [ 
	super defineGrammar.
	
	ntPhoneNumber --> ntBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock.
	ntBlock --> ntDigit, ntDigit.
]

{ #category : #accessing }
GncPhoneGrammar >> start [

	^ ntPhoneNumber 
]
