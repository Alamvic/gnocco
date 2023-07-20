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

	ntStart --> 'a'
]

{ #category : #accessing }
GncUndefinedNonTerminalGrammar >> start [

	^ ntStart
]
