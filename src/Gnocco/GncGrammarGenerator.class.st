Class {
	#name : #GncGrammarGenerator,
	#superclass : #GncVisitor,
	#instVars : [
		'maxHeightCost',
		'randomGenerator'
	],
	#category : #'Gnocco-Visitors'
}

{ #category : #initialization }
GncGrammarGenerator >> initialize [

	randomGenerator := PMFishmanMooreRandomGenerator new.
	maxHeightCost := 0.
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> maxHeightCost: cost [

	maxHeightCost := cost
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> offsetHeightCost: offset [

	^ self clone
		  maxHeightCost: maxHeightCost + offset;
		  yourself
]

{ #category : #private }
GncGrammarGenerator >> random [

	^ randomGenerator
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> seed: seed [

	randomGenerator := randomGenerator class new
		                   seed: seed;
		                   yourself
]

{ #category : #private }
GncGrammarGenerator >> selectRule: rules [

	| totalWeight selected rulesWithWeight |
	totalWeight := 0.
	"Accessing the weight can trigger (expensive) computation, and not be deterministic.
	For this reason, we compute the weight only once, and we store the result alongside the rule."
	rulesWithWeight := rules
		                   select: [ :rule |
		                   rule minHeight < maxHeightCost ]
		                   thenCollect: [ :rule | rule -> rule weight ].
	self assert: rulesWithWeight isNotEmpty.
	rulesWithWeight
		do: [ :ruleAndWeight |
		totalWeight := totalWeight + ruleAndWeight value ].
	selected := totalWeight atRandom: self random.
	rulesWithWeight
		do: [ :ruleAndWeight |
			ruleAndWeight value >= selected
				ifTrue: [ ^ ruleAndWeight key ]
				ifFalse: [ selected := selected - ruleAndWeight value ] ].
	Error signal: 'what?'
]

{ #category : #visiting }
GncGrammarGenerator >> visitNonTerminal: nonTerminal [

	| result rule |
	nonTerminal preHook ifNotNil: [ :hook |
		hook value ifNotNil: [ :value | ^ value ] ].

	rule := self selectRule: nonTerminal rules.
	result := rule visit: self withSubLevel.
	nonTerminal postHook ifNotNil: [ :hook | hook value: result ].
	^ result
]

{ #category : #visiting }
GncGrammarGenerator >> visitRule: rule [

	| result |
	rule preHook ifNotNil: [ :hook | ^ hook value ].
	result := rule fragments collect: [ :fragment | fragment visit: self ].
	rule postHook ifNotNil: [ :hook | hook cull: result ].
	^ GncInnerNode with: result
]

{ #category : #visiting }
GncGrammarGenerator >> visitTerminal: terminal [

	^ terminal generateAst: self
]

{ #category : #private }
GncGrammarGenerator >> withSubLevel [

	^ self clone
		  maxHeightCost: maxHeightCost - 1;
		  yourself
]
