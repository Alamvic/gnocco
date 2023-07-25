Class {
	#name : #GncStonGrammarTestCase,
	#superclass : #TestCase,
	#category : #'Gnocco-Benchmarks-Tests'
}

{ #category : #tests }
GncStonGrammarTestCase >> setUp [

	super setUp.
	GncFuzzyClass setupFuzzyClasses: 9
]

{ #category : #tests }
GncStonGrammarTestCase >> tearDown [

	GncFuzzyClass removeFuzzyClasses: 9.
	super tearDown
]

{ #category : #tests }
GncStonGrammarTestCase >> testCanGenerateCost [

	| grammar generator minimumTreeHeight ast |
	generator := GncGrammarGenerator newMinimal
		             seed: 17;
		             yourself.
	grammar := GncStonGrammar new.
	minimumTreeHeight := grammar minHeight.
	self assert: minimumTreeHeight isFinite. "the grammar can produce a tree"
	ast := grammar generateAst: generator.
	self assert: ast minHeight equals: minimumTreeHeight
]

{ #category : #tests }
GncStonGrammarTestCase >> testStonSyntax [

	| grammar |
	grammar := GncStonGrammar new.
	1 to: 100 do: [ :j |
		| result |
		result := STON reader
			          on: (grammar generate: (GncGrammarGenerator newUnbounded
							            maxHeight: 20;
							            yourself)) readStream;
			          next.
		self assert: (result class name beginsWith: 'GncFuzzyClass') ]
]
