Class {
	#name : #GncRule,
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
	#category : #'Gnocco-Private'
}

{ #category : #'instance creation' }
GncRule class >> newWithFragments: fragments [

	^ self new fragments:
		  (fragments collect: [ :fragment | fragment asFragment ])
]

{ #category : #translating }
GncRule >> addFragment: fragment [

	fragments add: fragment asFragment
]

{ #category : #translating }
GncRule >> computeCost [

	| minCost |
	minCost := 0.
	fragments do: [ :fragment |
		fragment computeCost.
		minCost := minCost max: fragment cost ].
	cost := minCost
]

{ #category : #translating }
GncRule >> cost [

	^ cost
]

{ #category : #translating }
GncRule >> format: stream [

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
GncRule >> fragments: rule [

	fragments := rule
]

{ #category : #translating }
GncRule >> generateAstWithMaxCost: maxCost [

	| result |
	preHook ifNotNil: [
		result := preHook value.
		result ifNotNil: [ ^ result ] ].
	result := fragments collect: [ :fragment |
		          fragment generateAstWithMaxCost: maxCost ].
	postHook ifNotNil: [ postHook value: result ].
	^ GncInnerNode with: result
]

{ #category : #initialization }
GncRule >> initialize [

	fragments := OrderedCollection new.
	weight := 1
]

{ #category : #translating }
GncRule >> post: postCallback [

	postHook := postCallback
]

{ #category : #translating }
GncRule >> pre: preCallback [

	preHook := preCallback
]

{ #category : #translating }
GncRule >> reset [

	fragments do: [ :fragment | fragment reset ]
]

{ #category : #translating }
GncRule >> seal [

	fragments := fragments asArray
]

{ #category : #accessing }
GncRule >> weight [

	^ (weight isKindOf: BlockClosure)
		  ifTrue: [ weight value ]
		  ifFalse: [ weight ]
]

{ #category : #accessing }
GncRule >> weight: aWeight [

	weight := aWeight 
]
