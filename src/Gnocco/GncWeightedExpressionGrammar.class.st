"
I am an example grammar that produces arithmetic expressions. I am weighted to produce more seemingly natural arithmetic expression than my non-weighted counterpart, `GncExpressionGrammar`.
"
Class {
	#name : #GncWeightedExpressionGrammar,
	#superclass : #GncBaseGrammar,
	#instVars : [
		'ntExpression',
		'ntFactor',
		'ntTerm'
	],
	#category : #'Gnocco-Grammar Library'
}

{ #category : #initialization }
GncWeightedExpressionGrammar >> defineGrammar [

	super defineGrammar.
	ntExpression --> ntTerm, '+', ntExpression
		| ntTerm, '-', ntExpression
		| ntTerm.

	"ntExpression post: [ :result | Transcript show: 'hello'. ]."
	
	ntTerm --> ntFactor, '*', ntTerm
		| ntFactor, '/', ntTerm 
		| ntFactor.

	ntFactor --> '+', ntFactor @ 1
		| '-', ntFactor @ 5
		| '(', ntExpression, ')' @ 50
		| ntNumber, '.', ntNumber @ 50
		| ntNumber @ 50.
]

{ #category : #accessing }
GncWeightedExpressionGrammar >> start [

	^ ntExpression
]
