Class {
	#name : #ArrayDequeueTestCase,
	#superclass : #TestCase,
	#category : #'Gnocco-Tests'
}

{ #category : #tests }
ArrayDequeueTestCase >> testAsOrderedCollection [

	| vector |
	vector := ArrayDequeue new.
	self assert: vector isEmpty.
	51 to: 100 do: [ :i | vector addLast: i ].
	self assert: vector size equals: 50.
	1 to: 50 do: [ :i | vector addLast: i ].
	self assert: vector size equals: 100.
	1 to: 50 do: [ :i | self assert: vector removeFirst equals: 50 + i ].
	1 to: 50 do: [ :i | self assert: (vector at: i) equals: i ].
	self assert: vector size equals: 50.
	1 to: 50 do: [ :i | vector at: i put: 2 * i ].
	1 to: 50 do: [ :i | self assert: (vector at: i) equals: 2 * i ]
]

{ #category : #tests }
ArrayDequeueTestCase >> testAsQueue [

	| queue |
	queue := ArrayDequeue new.
	self assert: queue isEmpty.
	5 to: 50 do: [ :i | queue addLast: i ].
	5 to: 50 do: [ :i | self assert: queue removeFirst equals: i ].
	self assert: queue isEmpty.
	5 to: 50 do: [ :i | queue addFirst: i ].
	5 to: 50 do: [ :i | self assert: queue removeLast equals: i ].
	self assert: queue isEmpty.
]

{ #category : #tests }
ArrayDequeueTestCase >> testAsStack [

	| stack |
	stack := ArrayDequeue new.
	self assert: stack isEmpty.
	5 to: 50 do: [ :i | stack addLast: i ].
	(5 to: 50) reverseDo: [ :i | self assert: stack removeLast equals: i ].
	self assert: stack isEmpty.
	5 to: 50 do: [ :i | stack addFirst: i ].
	(5 to: 50) reverseDo: [ :i |
		self assert: stack removeFirst equals: i ].
	self assert: stack isEmpty
]
