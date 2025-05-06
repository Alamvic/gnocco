"
I am an example grammar to produce arithmetic expressions.
"
Class {
	#name : #GncExpressionGrammar,
	#superclass : #GncBaseGrammar,
	#instVars : [
		'ntExpression',
		'ntFactor',
		'ntTerm'
	],
	#category : #'Gnocco-Grammar Library'
}

{ #category : #initialization }
GncExpressionGrammar >> defineGrammar [

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
		
	^ ntExpression
]
