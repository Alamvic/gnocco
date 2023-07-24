Class {
	#name : #GncGrammarGenerator,
	#superclass : #GncVisitor,
	#instVars : [
		'maxSize',
		'randomGenerator',
		'maxHeight'
	],
	#category : #'Gnocco-Visitors'
}

{ #category : #'instance creation' }
GncGrammarGenerator class >> newMinimal [

	^ self new
		  maxHeight: 0;
		  maxSize: 0;
		  yourself
]

{ #category : #'instance creation' }
GncGrammarGenerator class >> newUnbounded [

	^ self new
		  maxHeight: Float infinity;
		  maxSize: Float infinity;
		  yourself
]

{ #category : #initialization }
GncGrammarGenerator >> initialize [

	super initialize.
	randomGenerator := GncPCGRandomGenerator new.
	maxHeightCost := 0
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> maxHeight: cost [

	maxHeight := cost
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> maxSize: cost [

	maxSize := cost
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> offsetHeightCost: offset [

	^ self clone
		  maxHeight: maxHeight + offset;
		  yourself
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> offsetHeightCost: offset andSizeCost: size [

	^ self clone
		  maxHeight: maxHeight + offset;
		  maxSize: maxSize + size;
		  yourself
]

{ #category : #'accessing - attributes' }
GncGrammarGenerator >> offsetSizeCost: offset [

	^ self clone
		  maxSize: maxSize + offset;
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
		                   rule minHeight < maxHeight and: [
			                   rule minSize < maxSize ] ]
		                   thenCollect: [ :rule | rule -> rule weight ].
	self assert: rulesWithWeight isNotEmpty.
	
	rulesWithWeight do: [ :ruleAndWeight |
		totalWeight := totalWeight + ruleAndWeight value ].
	selected := totalWeight atRandom: self random.
	rulesWithWeight do: [ :ruleAndWeight |
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

	| result availableSize |
	rule preHook ifNotNil: [ :hook | ^ hook value ].
	"The total size of the children is bounded by the total size of this subtree
	minus the size of the root, which is 1."
	availableSize := maxSize - 1.

	"Remove from `availableSize` the incompressible size, so that when generating
	a subtree, we don't eat away the space required for other subtrees."
	rule fragments do: [ :fragment |
		availableSize := availableSize - fragment minSize ].

	result := rule fragments collect: [ :fragment |
		          | node |
		          "in addition to the remaining space for generation, there is
		the incompressible size, which is only available for *this* subtree."
		          availableSize := availableSize + fragment minSize.
		          node := fragment visit: (self withSize: availableSize).
		          availableSize := availableSize - node treeSize.
		          node ].
	rule postHook ifNotNil: [ :hook | hook cull: result ].
	^ GncInnerNode with: result
]

{ #category : #visiting }
GncGrammarGenerator >> visitTerminal: terminal [

	maxSize update: [ :size | size - 1 ].
	^ terminal generateAst: self
]

{ #category : #private }
GncGrammarGenerator >> withSize: size [

	^ self clone
		  maxSize: size;
		  yourself
]

{ #category : #private }
GncGrammarGenerator >> withSubLevel [

	^ self clone
		  maxHeight: maxHeight - 1;
		  yourself
]
