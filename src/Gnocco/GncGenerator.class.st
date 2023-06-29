Class {
	#name : #GncGenerator,
	#superclass : #GncVisitor,
	#instVars : [
		'maxHeightCost',
		'randomGenerator'
	],
	#category : #'Gnocco-Visitors'
}

{ #category : #initialization }
GncGenerator >> initialize [

	randomGenerator := Random new.
	maxHeightCost := 0.
]

{ #category : #'accessing - attributes' }
GncGenerator >> maxHeightCost: cost [

	maxHeightCost := cost
]

{ #category : #'accessing - attributes' }
GncGenerator >> offsetHeightCost: offset [

	maxHeightCost := maxHeightCost + offset.
]

{ #category : #private }
GncGenerator >> random [

	^ randomGenerator
]

{ #category : #'accessing - attributes' }
GncGenerator >> seed: seed [

	randomGenerator := Random seed: seed
]

{ #category : #private }
GncGenerator >> selectRule: rules [

	| totalWeight selected rulesWithWeight |
	totalWeight := 0.
	"Accessing the weight can trigger (expensive) computation, and not be deterministic.
	For this reason, we compute the weight only once, and we store the result alongside the rule."
	rulesWithWeight := rules
		                   select: [ :rule |
		                   rule minHeight <= maxHeightCost ]
		                   thenCollect: [ :rule | rule -> rule weight ].
	self assert: rulesWithWeight isNotEmpty.
	rulesWithWeight
		do: [ :ruleAndWeight |
		totalWeight := totalWeight + ruleAndWeight value ].
	selected := totalWeight atRandom.
	rulesWithWeight
		do: [ :ruleAndWeight |
			ruleAndWeight value >= selected
				ifTrue: [ ^ ruleAndWeight key ]
				ifFalse: [ selected := selected - ruleAndWeight value ] ].
	Error signal: 'what?'
]

{ #category : #visiting }
GncGenerator >> visitNonTerminal: nonTerminal [

	| result rule |
	nonTerminal preHook ifNotNil: [ :hook | hook value ifNotNil: [ :value | ^ value ] ].

	rule := self selectRule: nonTerminal rules.
	result := rule visit: self withSubLevel.
	nonTerminal postHook ifNotNil: [ :hook | hook value: result ].
	^ result.
	
]

{ #category : #visiting }
GncGenerator >> visitRule: rule [

	| result |
	rule preHook ifNotNil: [ :hook | ^ hook value ].
	result := rule fragments collect: [ :fragment | fragment visit: self ].
	rule postHook ifNotNil: [ :hook | hook cull: result ].
	^ GncInnerNode with: result
]

{ #category : #visiting }
GncGenerator >> visitTerminal: terminal [

	^ terminal generateToken: self
]

{ #category : #private }
GncGenerator >> withSubLevel [

	^ self clone
		  maxHeightCost: maxHeightCost - 1;
		  yourself
]
