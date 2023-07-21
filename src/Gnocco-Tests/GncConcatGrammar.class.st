Class {
	#name : #GncConcatGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntStart',
		'ntLiteral1',
		'ntLiteral2'
	],
	#category : #'Gnocco-Tests-Grammar'
}

{ #category : #initialization }
GncConcatGrammar >> defineGrammar [

	ntStart --> ntLiteral1 , ntLiteral2.
	ntLiteral1 --> 'oui'.
	ntLiteral2 --> 'non'.
	
	^ ntStart
]
