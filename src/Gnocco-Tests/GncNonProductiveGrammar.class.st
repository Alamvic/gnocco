Class {
	#name : #GncNonProductiveGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntStart',
		'ntSomething'
	],
	#category : #'Gnocco-Tests-Grammar'
}

{ #category : #initialization }
GncNonProductiveGrammar >> defineGrammar [

	ntStart --> ntSomething.
	ntSomething --> ntStart
]

{ #category : #accessing }
GncNonProductiveGrammar >> start [

	^ ntStart 
]
