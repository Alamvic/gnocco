Class {
	#name : #GrammarTestCase,
	#superclass : #TestCase,
	#category : #'Gnocco-Tests-Grammar'
}

{ #category : #tests }
GrammarTestCase >> testCanGenerateCost [

	{
		GncPhoneGrammar.
		GncExpressionGrammar.
		GncWeightedExpressionGrammar } do: [ :grammarClass |
		| grammar generator minimumTreeHeight ast |
		generator := GncGrammarGenerator newMinimal
			             seed: 17;
			             yourself.
		grammar := grammarClass new.
		minimumTreeHeight := grammar minHeight.
		self assert: minimumTreeHeight isFinite. "the grammar can produce a tree"
		ast := grammar generateAst: generator.
		self assert: ast minHeight equals: minimumTreeHeight ]
]

{ #category : #tests }
GrammarTestCase >> testCode [

	| grammar |
	grammar := GncCodeGrammar new.
	self assert: grammar generateWithMinCost equals: 'oui'
]

{ #category : #tests }
GrammarTestCase >> testConcat [

	| grammar |
	grammar := GncConcatGrammar new.
	self assert: grammar generateWithMinCost equals: 'ouinon'
]

{ #category : #tests }
GrammarTestCase >> testDisjunctionNon [

	| grammar generator |
	grammar := GncDisjunctionGrammar new.
	generator := GncGrammarGenerator newMinimal
		             seed: 42;
		             yourself.
	self assert: (grammar generate: generator) equals: 'non'
]

{ #category : #tests }
GrammarTestCase >> testDisjunctionOui [

	| grammar generator |
	grammar := GncDisjunctionGrammar new.
	generator := GncGrammarGenerator newMinimal
		             seed: 3;
		             yourself.
	self assert: (grammar generate: generator) equals: 'oui'
]

{ #category : #tests }
GrammarTestCase >> testGrammarWithUndefinedNonTerminals [

	self
		should: [ GncUndefinedNonTerminalGrammar new ]
		raise: UndefinedNonTerminal
]

{ #category : #tests }
GrammarTestCase >> testLiteral [

	| grammar |
	grammar := GncLiteralGrammar new.
	self assert: grammar generateWithMinCost equals: 'oui'
]

{ #category : #tests }
GrammarTestCase >> testNonProductiveGrammar [

	self
		should: [ GncNonProductiveGrammar new ]
		raise: GrammarIsNotProductive
]

{ #category : #tests }
GrammarTestCase >> testPhoneNumbers [

	| grammar phoneNumber |
	grammar := GncPhoneGrammar new.
	phoneNumber := grammar generateWithMinCost.
	self assert:
		(phoneNumber matchesRegex: '0[1-7] \d{2} \d{2} \d{2} \d{2}')
]

{ #category : #tests }
GrammarTestCase >> testRange1 [

	| grammar generator |
	grammar := GncRangeGrammar new.
	generator := GncGrammarGenerator newMinimal seed: 3; yourself.
	self assert: (grammar generate: generator) equals: '4'
]

{ #category : #tests }
GrammarTestCase >> testRange2 [

	| grammar generator |
	grammar := GncRangeGrammar new.
	generator := GncGrammarGenerator newMinimal seed: 2; yourself.
	self assert: (grammar generate: generator) equals: '3'
]

{ #category : #tests }
GrammarTestCase >> testRange3 [

	| grammar generator |
	grammar := GncRangeGrammar new.
	generator := GncGrammarGenerator newMinimal seed: 1; yourself.
	self assert: (grammar generate: generator) equals: '5'
]

{ #category : #tests }
GrammarTestCase >> testWeightsNon [

	| grammar generator |
	grammar := GncDisjunctionGrammar new.
	generator := GncGrammarGenerator newMinimal
		             seed: 17;
		             yourself.
	(grammar parameters at: 1) set: 0.
	self assert: (grammar generate: generator) equals: 'non'.
]

{ #category : #tests }
GrammarTestCase >> testWeightsOui [

	| grammar generator |
	grammar := GncDisjunctionGrammar new.
	generator := GncGrammarGenerator newMinimal
		             seed: 17;
		             yourself.
	(grammar parameters at: 3) set: 0.
	self assert: (grammar generate: generator) equals: 'oui'.
]
