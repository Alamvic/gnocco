Class {
	#name : #GncCodeGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntStart'
	],
	#category : #'Gnocco-Tests-Grammar'
}

{ #category : #initialization }
GncCodeGrammar >> defineGrammar [

	ntStart --> [ 'oui' ]
]

{ #category : #accessing }
GncCodeGrammar >> start [

	^ ntStart
]
