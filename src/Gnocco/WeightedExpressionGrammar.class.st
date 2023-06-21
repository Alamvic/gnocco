Class {
	#name : #WeightedExpressionGrammar,
	#superclass : #BaseGrammar,
	#instVars : [
		'ntExpression',
		'ntFactor',
		'ntTerm'
	],
	#category : #Gnocco
}

{ #category : #initialization }
WeightedExpressionGrammar >> defineGrammar [

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
WeightedExpressionGrammar >> start [

	^ ntExpression
]
