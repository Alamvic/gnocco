Class {
	#name : 'GncLiteralGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntLiteral'
	],
	#category : 'Gnocco-Tests-Grammar',
	#package : 'Gnocco-Tests',
	#tag : 'Grammar'
}

{ #category : 'initialization' }
GncLiteralGrammar >> defineGrammar [

	ntLiteral --> 'oui'.
	
	^ ntLiteral
]
