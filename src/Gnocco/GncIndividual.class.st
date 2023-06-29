Class {
	#name : #GncIndividual,
	#superclass : #Object,
	#instVars : [
		'grammar',
		'score',
		'generator'
	],
	#category : #'Gnocco-Genetic Optimization'
}

{ #category : #'instance creation' }
GncIndividual class >> newFrom: other [

	^ self new
		grammar: other grammar veryDeepCopy;
		generator: other generator.
]

{ #category : #accessing }
GncIndividual >> combine: other withCrossoverRate: crossoverRate [

	| left right |
	left := self class newFrom: self.
	right := self class newFrom: other.
	crossoverRate <= (100 atRandom: generator random) ifTrue: [
		left crossover: right ].
	
	^ left @ right
]

{ #category : #accessing }
GncIndividual >> computeScore [

	| data |
	data := GncObjectGraph with: (grammar generate: generator).
	^ (data benchIntoFile: 'hello.fuel') value
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
GncIndividual >> generator: aGenerator [

	generator := aGenerator
]

{ #category : #accessing }
GncIndividual >> grammar [

	^ grammar
]

{ #category : #accessing }
GncIndividual >> grammar: aGrammar [

	grammar := aGrammar
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

	^ grammar parameters
]

{ #category : #accessing }
GncIndividual >> score [

	^ score ifNil: [ score := self computeScore ]
]
