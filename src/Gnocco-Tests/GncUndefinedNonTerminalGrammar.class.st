Class {
	#name : #GncUndefinedNonTerminalGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntStart',
		'ntNonProductive'
	],
	#category : #'Gnocco-Tests-Grammar'
}

{ #category : #initialization }
GncUndefinedNonTerminalGrammar >> defineGrammar [

	ntStart --> 'a'.
	
	^ ntStart
]
