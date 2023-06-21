"
I am a non-terminal in a generative grammar.

I am responsible for generating all nodes of a certain kind in the generated AST.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	name:		<Object>
	rules:		<Object>


    Implementation Points
"
Class {
	#name : #GncNonTerminal,
	#superclass : #GncFragment,
	#instVars : [
		'name',
		'rules',
		'cost',
		'computed',
		'preHook',
		'postHook'
	],
	#category : #'Gnocco-Grammar'
}

{ #category : #construction }
GncNonTerminal class >> withName: aName [

	^ self new name: aName
]

{ #category : #accessing }
GncNonTerminal >> --> fragment [
	"Add a new definition of a non terminal, keeping the old ones."

	| currentRule |
	currentRule := self newRule.
	currentRule addFragment: fragment.
	^ GncRuleMaker with: currentRule in: self
]

{ #category : #accessing }
GncNonTerminal >> ->> fragment [
	"Add new definition of a non terminal, overwriting the previous ones."

	rules := OrderedCollection new.
	^ self --> fragment
]

{ #category : #accessing }
GncNonTerminal >> computeCost [
	"While we are computing the cost for this non terminal, it's set to infinity, so that if"
	"the cost is asked again before this computation has ended, it means that we have encountered"
	"a cycle, and therefore:"
	" * either this non terminal is co-reachable, in which case there is a strictly shorter"
	"   derivation, and so returning infinity for the cost of that expansion is fine"
	" * or this non terminal is not co-reachable, and therefore its cost is infinity"
	| minCost |
	computed ifTrue: [ ^ self ].
	computed := true.
	cost ifNil: [ cost := Float infinity ].
	minCost := Float infinity.
	rules do: [ :rule | rule computeCost. minCost := minCost min: rule cost ].
	cost := 1 + minCost.
]

{ #category : #accessing }
GncNonTerminal >> cost [

	cost ifNotNil: [ ^ cost ].
	"While we are computing the cost for this non terminal, it's set to infinity, so that if"
	"the cost is asked again before this computation has ended, it means that we have encountered"
	"a cycle, and therefore:"
	" * either this non terminal is co-reachable, in which case there is a strictly shorter"
	"   derivation, and so returning infinity for the cost of that expansion is fine"
	" * or this non terminal is not co-reachable, and therefore its cost is infinity"
	cost := Float infinity.
	self computeCost.
	^ cost
]

{ #category : #accessing }
GncNonTerminal >> format: stream [

	| first |
	stream
		<< name;
		<< ' (';
		<< self cost printString;
		<< ')';
		<< OSPlatform current lineEnding.
	first := true.
	rules do: [ :rule |
		stream << '  '.
		first
			ifTrue: [ stream << '--> ' ]
			ifFalse: [ stream << '  | ' ].
		first := false.
		rule format: stream.
		stream << OSPlatform current lineEnding ]
]

{ #category : #accessing }
GncNonTerminal >> formatName: stream [

	^ stream << name
]

{ #category : #translating }
GncNonTerminal >> generateAstWithMaxCost: maxCost [

	| totalWeight selected result |
	self cost > maxCost ifTrue: [
		CostIsTooLow new signal:
			'There is no such cheap derivation, the minimum is '
			, self cost printString , '.' ].

	preHook ifNotNil: [
		result := preHook value.
		result ifNotNil: [ ^ result ] ].

	totalWeight := 0.
	rules
		select: [ :rule | rule cost < maxCost ]
		thenDo: [ :rule | totalWeight := totalWeight + rule weight ].
	selected := totalWeight atRandom.
	rules select: [ :rule | rule cost < maxCost ] thenDo: [ :rule |
		rule weight >= selected
			ifTrue: [
				result := rule generateAstWithMaxCost: maxCost - 1.
				postHook ifNotNil: [ postHook value: result ].
				^ result ]
			ifFalse: [ selected := selected - rule weight ] ]
]

{ #category : #initialization }
GncNonTerminal >> initialize [
	rules := OrderedCollection new.
	computed := false.
]

{ #category : #accessing }
GncNonTerminal >> name [

	^ name
]

{ #category : #accessing }
GncNonTerminal >> name: string [

	name := string
]

{ #category : #accessing }
GncNonTerminal >> newRule [

	| rule |
	rule := GncRule new.
	rules add: rule.
	^ rule
]

{ #category : #accessing }
GncNonTerminal >> post: postBlock [

	postHook := postBlock
]

{ #category : #accessing }
GncNonTerminal >> pre: preBlock [

	preHook := preBlock
]

{ #category : #private }
GncNonTerminal >> reset [

	computed ifFalse: [ ^ self ].
	computed := false.
	rules do: [ :rule | rule reset ]
]

{ #category : #accessing }
GncNonTerminal >> rule: rule [
	rules add: (GncRule newWithFragments: rule)
]

{ #category : #private }
GncNonTerminal >> rules [

	^ rules
]

{ #category : #private }
GncNonTerminal >> seal [

	rules do: [ :rule | rule seal ]
]
