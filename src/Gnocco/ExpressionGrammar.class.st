Class {
	#name : #ExpressionGrammar,
	#superclass : #BaseGrammar,
	#instVars : [
		'ntExpression',
		'ntFactor',
		'ntTerm'
	],
	#category : #Gnocco
}

{ #category : #initialization }
ExpressionGrammar >> defineGrammar [

	super defineGrammar.
	ntExpression --> ntTerm, '+', ntExpression
		| ntTerm, '-', ntExpression 
		| ntTerm.

	ntTerm --> ntFactor, '*', ntTerm
		| ntFactor, '/', ntTerm 
		| ntFactor.

	ntFactor --> '+', ntFactor
		| '-', ntFactor 
		| '(', ntExpression, ')'
		| ntNumber, '.', ntNumber
		| ntNumber.
]

{ #category : #accessing }
ExpressionGrammar >> start [

	^ ntExpression
]
