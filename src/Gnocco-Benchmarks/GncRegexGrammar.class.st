Class {
	#name : #GncRegexGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntRegex',
		'ntConcat',
		'ntModifier',
		'ntPure',
		'ntNonEmptyPure',
		'ntNonEmptyRegex',
		'ntNonEmptyConcat'
	],
	#category : #'Gnocco-Benchmarks-Grammar'
}

{ #category : #initialization }
GncRegexGrammar >> defineGrammar [

	ntRegex --> ntConcat
				 | ntConcat, '|', ntRegex @ 0.
	ntConcat --> ntModifier
	           | ntModifier, ntConcat @ 100.
	ntModifier --> ntPure
	             | ntNonEmptyPure, '?'
	             | ntNonEmptyPure, '*' @ 0
	             | ntNonEmptyPure, '+' @ 0.
	ntPure --> 'a'
	         | 'b' @ 0
	         | 'c' @ 0
	         | '.' @ 0 
	         | '(', ntRegex, ')' @ 0.
	ntNonEmptyPure --> 'a'
	                 | 'b'
	                 | 'c'
	                 | '(', ntNonEmptyRegex, ')'.
	ntNonEmptyRegex --> ntNonEmptyConcat
	                  | ntNonEmptyConcat, '|', ntNonEmptyRegex.
	ntNonEmptyConcat --> ntNonEmptyPure
	                   | ntNonEmptyPure, ntConcat
	                   | ntModifier, ntNonEmptyConcat.
	^ ntRegex
]
