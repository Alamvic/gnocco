"
I am an abstract grammar. I provide two non terminals, `ntDigit` and `ntNumber`, that produce,
respectively, a base 10 digit and a base 10 integer.
"
Class {
	#name : #GncBaseGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntNumber',
		'ntDigit'
	],
	#category : #'Gnocco-Grammar Library'
}

{ #category : #initialization }
GncBaseGrammar >> defineGrammar [ 

	ntNumber --> ntDigit, ntNumber | ntDigit.
	ntDigit --> ($0 - $9).
]
