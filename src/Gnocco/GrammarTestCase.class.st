Class {
	#name : #GrammarTestCase,
	#superclass : #TestCase,
	#category : #'Gnocco-Tests'
}

{ #category : #tests }
GrammarTestCase >> testCanGenerateCost [

	{
		GncPhoneGrammar.
		GncExpressionGrammar.
		GncWeightedExpressionGrammar.
		GncStonGrammar } do: [ :grammarClass |
		| grammar generator cost ast |
		generator := GncGenerator new maxHeightCost: 0; seed: 17.
		grammar := grammarClass new.
		cost := grammar minHeight.
		self assert: cost isFinite.
		ast := grammar generateAst: generator.
		self assert: ast minHeight equals: cost. ]
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
GrammarTestCase >> testStonSyntax [

	| grammar |
	GncFuzzyClass setupFuzzyClasses: 9.
	grammar := GncStonGrammar new.
	1 to: 100 do: [ :j |
		| result |
		result := STON reader
			          on: (grammar generate: (GncGenerator new maxHeightCost: 20; yourself)) readStream;
			          next.
		self assert: (result class name beginsWith: 'GncFuzzyClass') ].
	GncFuzzyClass removeFuzzyClasses: 9
]
