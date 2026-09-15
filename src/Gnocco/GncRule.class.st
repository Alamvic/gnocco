Class {
	#name : 'GncRule',
	#superclass : 'Object',
	#traits : 'TFuzzAst',
	#classTraits : 'TFuzzAst classTrait',
	#instVars : [
		'fragments',
		'weight',
		'preHook',
		'postHook',
		'minHeight',
		'minSize',
		'visits',
		'rewards'
	],
	#category : 'Gnocco-Private',
	#package : 'Gnocco',
	#tag : 'Private'
}

{ #category : 'instance creation' }
GncRule class >> newWithFragments: fragments [

	^ self new fragments:
		  (fragments collect: [ :fragment | fragment asFragment ])
]

{ #category : 'visiting' }
GncRule >> accept: word [

	^ (self consume: word) isEmpty
]

{ #category : 'translating' }
GncRule >> addFragment: fragment [

	fragments add: fragment asFragment
]

{ #category : 'accessing' }
GncRule >> backPropagate: reward level: level [

	rewards at: level ifAbsentPut: [ 1 ].
	 
	rewards at: level update: [ :v | (v + reward) max: 1 ]
]

{ #category : 'translating' }
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

{ #category : 'as yet unclassified' }
GncRule >> consume: word [
1 halt.
	^ fragments inject: { word } into: [ :options :fragment |
		options flatCollectAsSet: [ :currWord |
			fragment consume: currWord.
		]
	]
]

{ #category : 'translating' }
GncRule >> fragments [

	^ fragments
]

{ #category : 'translating' }
GncRule >> fragments: rule [

	fragments := rule
]

{ #category : 'translating' }
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

{ #category : 'initialization' }
GncRule >> initialize [

	fragments := OrderedCollection new.
	weight := 1 asWeight.
	minHeight := Float infinity.
	minSize := Float infinity.
	visits := Dictionary new.
	rewards := Dictionary new.
]

{ #category : 'translating' }
GncRule >> minHeight [

	^ minHeight
]

{ #category : 'translating' }
GncRule >> minHeight: cost [

	minHeight := cost
]

{ #category : 'translating' }
GncRule >> minSize [

	^ minSize
]

{ #category : 'translating' }
GncRule >> minSize: newSize [

	minSize := newSize
]

{ #category : 'accessing' }
GncRule >> minimumTree [

	^ fragments collect: [ :fragment | | node |
		node := fragment minimumTree grammarRule: self.
		node 
	]

]

{ #category : 'translating' }
GncRule >> post: postCallback [

	postHook := postCallback
]

{ #category : 'translating' }
GncRule >> postHook [

	^ postHook
]

{ #category : 'translating' }
GncRule >> pre: preCallback [

	preHook := preCallback
]

{ #category : 'translating' }
GncRule >> preHook [

	^ preHook
]

{ #category : 'printing' }
GncRule >> printOn: stream [

	fragments do: [ :fragment |
		fragment printNameOn: stream.
		stream << ' ' ].
	stream
		<< '(';
		print: self minHeight;
		<< '/';
		print: self minSize;
		<< ') [';
		print: weight;
		<< ']'
]

{ #category : 'translating' }
GncRule >> reset [

	fragments do: [ :fragment | fragment reset ]
]

{ #category : 'accessing' }
GncRule >> rewardBy: level [
	
	rewards at: level ifAbsent: [ ^0 ].
	
	^ rewards at: level
]

{ #category : 'accessing' }
GncRule >> rewards [

	^ rewards 
]

{ #category : 'translating' }
GncRule >> seal [

	fragments := fragments asArray
]

{ #category : 'as yet unclassified' }
GncRule >> terminals [

	^ self fragments select: #isTerminal
]

{ #category : 'accessing' }
GncRule >> updateWeightWith: reward [

	weight set: ((weight get + reward) max: 1)
]

{ #category : 'accessing' }
GncRule >> utc: totalVisits by: c level: level [
	 
	"UCT = (reward(rule) / visits(rule)) + C * sqrt(log(total_visits) / visits(rule)))"
	| levelReward levelVisits |
	
	levelReward := self rewardBy: level.
	levelVisits := self visitsBy: level.
	
	^ (levelReward / levelVisits) + (c * ((totalVisits log / levelVisits) sqrt))
]

{ #category : 'translating' }
GncRule >> visit: visitor [

	^ visitor visitRule: self
]

{ #category : 'accessing' }
GncRule >> visit: visitor level: level [

	self visitIn: level. "visit"
	
	^ visitor visitRule: self level: level
]

{ #category : 'accessing' }
GncRule >> visitIn: level [

	visits at: level ifAbsentPut: [ 0 ].
	
	visits at: level update: [ :visit | visit + 1 ]
]

{ #category : 'accessing' }
GncRule >> visitedIn: level [

	visits at: level ifPresent: [ ^ true ].
	
	^ false
]

{ #category : 'accessing' }
GncRule >> visitsBy: level [
	
	visits at: level ifAbsent: [ ^0 ].
	
	^ visits at: level
]

{ #category : 'accessing' }
GncRule >> weight [

	^ weight generate
]

{ #category : 'accessing' }
GncRule >> weight: aWeight [

	weight := aWeight asWeight
]

{ #category : 'accessing' }
GncRule >> weightAt: level [
	
	rewards at: level ifAbsent: [ ^ weight get max: 1 ].
	
	^ ((rewards at: level) + weight get) max: 1 
]

{ #category : 'accessing' }
GncRule >> weightBox [

	^ weight
]
