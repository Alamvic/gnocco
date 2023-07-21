Class {
	#name : #GncRangeGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntStart'
	],
	#category : #'Gnocco-Tests-Grammar'
}

{ #category : #initialization }
GncRangeGrammar >> defineGrammar [

	ntStart --> ($3 - $5).
	
	^ ntStart
]
