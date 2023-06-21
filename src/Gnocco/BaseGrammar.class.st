Class {
	#name : #BaseGrammar,
	#superclass : #Grammar,
	#instVars : [
		'ntNumber',
		'ntDigit'
	],
	#category : #Gnocco
}

{ #category : #initialization }
BaseGrammar >> defineGrammar [ 

	ntNumber --> ntDigit, ntNumber | ntDigit.
	ntDigit --> ($0 - $9).
]
