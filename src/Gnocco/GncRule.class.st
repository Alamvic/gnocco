Class {
	#name : #GncRule,
	#superclass : #Object,
	#traits : 'TFuzzAst',
	#classTraits : 'TFuzzAst classTrait',
	#instVars : [
		'fragments',
		'weight',
		'preHook',
		'postHook',
		'minHeight',
		'minSize'
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

	| minHeightCost minSizeCost |
	minHeightCost := 0.
	minSizeCost := 0.
	fragments do: [ :fragment |
		fragment computeCost.
		minHeightCost := minHeightCost max: fragment minHeight.
		minSizeCost := minSizeCost + fragment minSize ].
	minHeight := minHeightCost.
	minSize := minSizeCost
]

{ #category : #translating }
GncRule >> fragments [

	^ fragments
]

{ #category : #translating }
GncRule >> fragments: rule [

	fragments := rule
]

{ #category : #translating }
GncRule >> generateAst: generator [

	| result |
	preHook ifNotNil: [
		result := preHook value.
		result ifNotNil: [ ^ result ] ].
	result := fragments collect: [ :fragment |
		          fragment generateAst: generator ].
	postHook ifNotNil: [ postHook value: result ].
	^ GncInnerNode with: result
]

{ #category : #initialization }
GncRule >> initialize [

	fragments := OrderedCollection new.
	weight := 1 asWeight.
	minHeight := Float infinity.
	minSize := Float infinity
]

{ #category : #translating }
GncRule >> minHeight [

	^ minHeight
]

{ #category : #translating }
GncRule >> minHeight: cost [

	minHeight := cost
]

{ #category : #translating }
GncRule >> minSize [

	^ minSize
]

{ #category : #translating }
GncRule >> post: postCallback [

	postHook := postCallback
]

{ #category : #translating }
GncRule >> postHook [

	^ postHook
]

{ #category : #translating }
GncRule >> pre: preCallback [

	preHook := preCallback
]

{ #category : #translating }
GncRule >> preHook [

	^ preHook
]

{ #category : #printing }
GncRule >> printOn: stream [

	fragments do: [ :fragment |
		fragment printNameOn: stream.
		stream << ' ' ].
	stream
		<< '(';
		print: self minHeight;
		<< ') [';
		print: weight;
		<< ']'
]

{ #category : #translating }
GncRule >> reset [

	fragments do: [ :fragment | fragment reset ]
]

{ #category : #translating }
GncRule >> seal [

	fragments := fragments asArray
]

{ #category : #translating }
GncRule >> visit: visitor [

	^ visitor visitRule: self
]

{ #category : #accessing }
GncRule >> weight [

	^ weight generate
]

{ #category : #accessing }
GncRule >> weight: aWeight [

	weight := aWeight asWeight
]

{ #category : #accessing }
GncRule >> weightBox [

	^ weight
]
