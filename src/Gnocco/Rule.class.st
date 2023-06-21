Class {
	#name : #Rule,
	#superclass : #Object,
	#traits : 'TFuzzAst',
	#classTraits : 'TFuzzAst classTrait',
	#instVars : [
		'fragments',
		'cost',
		'weight',
		'preHook',
		'postHook'
	],
	#category : #Gnocco
}

{ #category : #'instance creation' }
Rule class >> newWithFragments: fragments [

	^ self new fragments:
		  (fragments collect: [ :fragment | fragment asFragment ])
]

{ #category : #translating }
Rule >> addFragment: fragment [

	fragments add: fragment asFragment
]

{ #category : #translating }
Rule >> computeCost [

	| minCost |
	minCost := 0.
	fragments do: [ :fragment |
		fragment computeCost.
		minCost := minCost max: fragment cost ].
	cost := minCost
]

{ #category : #translating }
Rule >> cost [

	^ cost
]

{ #category : #translating }
Rule >> format: stream [

	fragments do: [ :fragment |
		fragment formatName: stream.
		stream << ' ' ].
	stream
		<< '(';
		<< self cost printString;
		<< ') [';
		<< weight printString;
		<< ']'
]

{ #category : #translating }
Rule >> fragments: rule [

	fragments := rule
]

{ #category : #translating }
Rule >> generateAstWithMaxCost: maxCost [

	| result |
	preHook ifNotNil: [
		result := preHook value.
		result ifNotNil: [ ^ result ] ].
	result := fragments collect: [ :fragment |
		          fragment generateAstWithMaxCost: maxCost ].
	postHook ifNotNil: [ postHook value: result ].
	^ InnerNode with: result
]

{ #category : #initialization }
Rule >> initialize [

	fragments := OrderedCollection new.
	weight := 1
]

{ #category : #translating }
Rule >> post: postCallback [

	postHook := postCallback
]

{ #category : #translating }
Rule >> pre: preCallback [

	preHook := preCallback
]

{ #category : #translating }
Rule >> reset [

	fragments do: [ :fragment | fragment reset ]
]

{ #category : #translating }
Rule >> seal [

	fragments := fragments asArray
]

{ #category : #accessing }
Rule >> weight [

	^ (weight isKindOf: BlockClosure)
		  ifTrue: [ weight value ]
		  ifFalse: [ weight ]
]

{ #category : #accessing }
Rule >> weight: aWeight [

	weight := aWeight 
]
