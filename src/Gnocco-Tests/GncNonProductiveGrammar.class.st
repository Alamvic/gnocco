Class {
	#name : 'GncNonProductiveGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntStart',
		'ntSomething'
	],
	#category : 'Gnocco-Tests-Grammar',
	#package : 'Gnocco-Tests',
	#tag : 'Grammar'
}

{ #category : 'initialization' }
GncNonProductiveGrammar >> defineGrammar [

	ntStart --> ntSomething.
	ntSomething --> ntStart.
	
	^ ntStart
]
