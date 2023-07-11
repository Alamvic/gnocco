Class {
	#name : #GncIndividual,
	#superclass : #Object,
	#instVars : [
		'score',
		'generator'
	],
	#category : #'Gnocco-Genetic Optimization'
}

{ #category : #'instance creation' }
GncIndividual class >> newFrom: individual [

	self subclassResponsibility
]

{ #category : #accessing }
GncIndividual >> combine: other withCrossoverRate: rate [

	| child |
	child := self class newFrom: self.
	child parameters doWithIndex: [ :parameter :i |
		rate >= (100 atRandom: generator random)
			ifTrue: [
				((2 atRandom: generator random) = 1) ifTrue: [
					parameter set: (other parameters at: i) get ] ]
			ifFalse: [ parameter atRandom: generator ] ].
	^ child
]

{ #category : #accessing }
GncIndividual >> computeScore [

	^ self subclassResponsibility
]

{ #category : #accessing }
GncIndividual >> crossover: other [

	1 to: (self parameters size atRandom: generator random) do: [ :i |
		| temp leftParameter rightParameter |
		leftParameter := self parameters at: i.
		rightParameter := other parameters at: i.
		temp := leftParameter get.
		leftParameter set: rightParameter get.
		rightParameter set: temp ]
]

{ #category : #accessing }
GncIndividual >> generator [

	^ generator
]

{ #category : #accessing }
GncIndividual >> generator: newGenerator [

	generator := newGenerator
]

{ #category : #accessing }
GncIndividual >> mutate: mutationRate [

	self parameters do: [ :parameter |
		mutationRate >= (100 atRandom: generator random) ifTrue: [ 
			| curr tweak |
			curr := parameter get.
			tweak := (1 - curr to: curr) atRandom: generator random.
			parameter set: curr + tweak ] ]

]

{ #category : #accessing }
GncIndividual >> parameters [

	self subclassResponsibility
]

{ #category : #accessing }
GncIndividual >> score [

	^ score ifNil: [ score := self computeScore ]
]
