Class {
	#name : #PhoneGrammar,
	#superclass : #BaseGrammar,
	#instVars : [
		'ntPhoneNumber',
		'ntBlock'
	],
	#category : #Gnocco
}

{ #category : #initialization }
PhoneGrammar >> defineGrammar [ 
	super defineGrammar.
	
	ntPhoneNumber --> ntBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock.
	ntBlock --> ntDigit, ntDigit.
]

{ #category : #accessing }
PhoneGrammar >> start [

	^ ntPhoneNumber 
]
