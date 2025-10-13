Class {
	#name : 'GncCodeGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntStart'
	],
	#category : 'Gnocco-Tests-Grammar',
	#package : 'Gnocco-Tests',
	#tag : 'Grammar'
}

{ #category : 'initialization' }
GncCodeGrammar >> defineGrammar [

	ntStart --> [ 'oui' ].
	^ ntStart
]
