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
		| grammar cost ast |
		grammar := grammarClass new.
		cost := grammar cost.
		self assert: cost isFinite.
		self
			should: [ grammar generateAstWithMaxCost: cost - 1 ]
			raise: CostIsTooLow.
		ast := grammar generateAstWithMaxCost: cost.
		self assert: ast cost equals: cost. ]
]

{ #category : #tests }
GrammarTestCase >> testPhoneNumbers [

	| grammar phoneNumber |
	grammar := GncPhoneGrammar new.
	phoneNumber := grammar generateWithMinCost.
	self assert:
		(phoneNumber matchesRegex: '\d{2} \d{2} \d{2} \d{2} \d{2}')
]

{ #category : #tests }
GrammarTestCase >> testStonSyntax [

	| grammar |
	GncFuzzyClass setupFuzzyClasses: 9.
	grammar := GncStonGrammar new.
	1 to: 100 do: [ :i |
		| result |
		result := STON reader
			          on:
				          (grammar generateWithMaxCost: grammar cost + 20)
					          readStream;
			          next.
		self assert: (result class name beginsWith: 'GncFuzzyClass') ].
	GncFuzzyClass removeFuzzyClasses: 9
]
