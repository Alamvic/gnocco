Class {
	#name : 'GncRegexGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntRegex',
		'ntBranch',
		'ntConcat',
		'ntModifier',
		'ntPure',
		'ntNonEmptyPure',
		'ntNonEmptyRegex',
		'ntNonEmptyBranch',
		'ntNonEmptyConcat'
	],
	#category : 'Gnocco-Benchmarks-Grammar',
	#package : 'Gnocco-Benchmarks',
	#tag : 'Grammar'
}

{ #category : 'initialization' }
GncRegexGrammar >> defineGrammar [

	ntRegex --> ntBranch | ntBranch , '|' , ntRegex.

	ntBranch --> '' | ntConcat.

	ntConcat --> ntModifier | ntModifier , ntConcat.

	ntModifier --> ntPure | ntNonEmptyPure , '?' | ntNonEmptyPure , '*'
	| ntNonEmptyPure , '+'.

	ntPure --> 'a' | 'b' | 'c' | '.' | '(' , ntRegex , ')'.

	ntNonEmptyPure --> 'a' | 'b' | 'c' | '.' | '(' , ntNonEmptyRegex
	, ')'.

	ntNonEmptyRegex --> ntNonEmptyBranch | ntNonEmptyBranch , '|'
	, ntRegex | ntBranch , '|' , ntNonEmptyRegex.

	ntNonEmptyBranch --> ntNonEmptyConcat.

	ntNonEmptyConcat --> ntNonEmptyPure | ntNonEmptyPure , ntConcat
	| ntModifier , ntNonEmptyConcat.

	^ ntRegex
]
