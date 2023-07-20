Class {
	#name : #GncLiteralGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntLiteral'
	],
	#category : #'Gnocco-Tests-Grammar'
}

{ #category : #initialization }
GncLiteralGrammar >> defineGrammar [

	ntLiteral --> 'oui'.
	
	^ ntLiteral
]
