Class {
	#name : 'GncRegexGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntRegex',
		'ntBranch',
		'ntConcat',
		'ntModifier',
		'ntPure'
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

	ntModifier --> ntPure | ntPure , '?' | ntPure , '*' | ntPure , '+'.

	ntPure --> '.' | 'a' | 'b' | 'c' | '(' , ntRegex , ')'.

	^ ntRegex
]
