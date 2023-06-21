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
	#name : #NonTerminal,
	#superclass : #Fragment,
	#instVars : [
		'name',
		'rules',
		'cost',
		'computed',
		'preHook',
		'postHook'
	],
	#category : #Gnocco
}

{ #category : #construction }
NonTerminal class >> withName: aName [

	^ self new name: aName
]

{ #category : #accessing }
NonTerminal >> --> fragment [
	"Add a new definition of a non terminal, keeping the old ones."

	| currentRule |
	currentRule := self newRule.
	currentRule addFragment: fragment.
	^ RuleMaker with: currentRule in: self
]

{ #category : #accessing }
NonTerminal >> ->> fragment [
	"Add new definition of a non terminal, overwriting the previous ones."

	rules := OrderedCollection new.
	^ self --> fragment
]

{ #category : #accessing }
NonTerminal >> computeCost [
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
NonTerminal >> cost [

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
NonTerminal >> format: stream [

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
NonTerminal >> formatName: stream [

	^ stream << name
]

{ #category : #translating }
NonTerminal >> generateAstWithMaxCost: maxCost [

	| totalWeight selected result |
	self cost > maxCost ifTrue: [
		Error new signal:
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
NonTerminal >> initialize [
	rules := OrderedCollection new.
	computed := false.
]

{ #category : #accessing }
NonTerminal >> name [

	^ name
]

{ #category : #accessing }
NonTerminal >> name: string [

	name := string
]

{ #category : #accessing }
NonTerminal >> newRule [

	| rule |
	rule := Rule new.
	rules add: rule.
	^ rule
]

{ #category : #accessing }
NonTerminal >> post: postBlock [

	postHook := postBlock
]

{ #category : #accessing }
NonTerminal >> pre: preBlock [

	preHook := preBlock
]

{ #category : #private }
NonTerminal >> reset [

	computed ifFalse: [ ^ self ].
	computed := false.
	rules do: [ :rule | rule reset ]
]

{ #category : #accessing }
NonTerminal >> rule: rule [
	rules add: (Rule newWithFragments: rule)
]

{ #category : #private }
NonTerminal >> rules [

	^ rules
]

{ #category : #private }
NonTerminal >> seal [

	rules do: [ :rule | rule seal ]
]
