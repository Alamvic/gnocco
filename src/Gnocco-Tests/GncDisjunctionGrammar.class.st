Class {
	#name : 'GncDisjunctionGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntStart',
		'ntLiteral1',
		'ntLiteral2'
	],
	#category : 'Gnocco-Tests-Grammar',
	#package : 'Gnocco-Tests',
	#tag : 'Grammar'
}

{ #category : 'initialization' }
GncDisjunctionGrammar >> defineGrammar [

	ntStart --> ntLiteral1 | ntLiteral2.
	ntLiteral1 --> 'oui'.
	ntLiteral2 --> 'non'.
	
	^ ntStart
]
