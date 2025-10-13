Class {
	#name : 'GncFragmentTest',
	#superclass : 'TestCase',
	#category : 'Gnocco-Tests',
	#package : 'Gnocco-Tests'
}

{ #category : 'tests' }
GncFragmentTest >> testAcceptString01 [

	| node |
	node := JSONGrammar new start.

	{ '""' . '{}' . '[]' . '42' . 'null' . 'true' . 'false' } do: [ :str |
		self assert: (node accept: str)
	]
]

{ #category : 'tests' }
GncFragmentTest >> testConsumeString01 [

	| node |
	node := JSONGrammar new start.

	{ '""' . '{}' . '[]' . '42' . 'null' . 'true' . 'false' } do: [ :str |
		self assert: (node consume: str) equals: ''
	]
]

{ #category : 'tests' }
GncFragmentTest >> testConsumeString02 [

	| node |
	node := JSONGrammar new start.

	self assert: (node consume: '"""') equals: '"'.
	self assert: (node consume: '{a}') equals: 'a}'.
	
]
