Class {
	#name : 'GncUndefinedNonTerminalGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntStart',
		'ntNonProductive'
	],
	#category : 'Gnocco-Tests-Grammar',
	#package : 'Gnocco-Tests',
	#tag : 'Grammar'
}

{ #category : 'initialization' }
GncUndefinedNonTerminalGrammar >> defineGrammar [

	ntStart --> 'a'.
	
	^ ntStart
]
