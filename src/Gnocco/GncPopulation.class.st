Class {
	#name : #GncPopulation,
	#superclass : #Object,
	#instVars : [
		'generator',
		'population',
		'populationSize',
		'mutationRate',
		'crossoverRate'
	],
	#category : #'Gnocco-Genetic Optimization'
}

{ #category : #'as yet unclassified' }
GncPopulation class >> ofGrammar: grammarClass [

	^ self new setupWithGrammar: grammarClass
]

{ #category : #accessing }
GncPopulation >> addIndividual: individual [

	population addLast: individual
]

{ #category : #accessing }
GncPopulation >> crossoverRate [

	^ crossoverRate
]

{ #category : #accessing }
GncPopulation >> crossoverRate: anObject [

	crossoverRate := anObject
]

{ #category : #accessing }
GncPopulation >> generator [

	^ generator
]

{ #category : #accessing }
GncPopulation >> generator: anObject [

	generator := anObject
]

{ #category : #accessing }
GncPopulation >> mutationRate [

	^ mutationRate
]

{ #category : #accessing }
GncPopulation >> mutationRate: anObject [

	mutationRate := anObject
]

{ #category : #accessing }
GncPopulation >> population [

	^ population
]

{ #category : #accessing }
GncPopulation >> population: anObject [

	population := anObject
]

{ #category : #accessing }
GncPopulation >> populationSize [

	^ populationSize
]

{ #category : #accessing }
GncPopulation >> populationSize: anObject [

	populationSize := anObject
]

{ #category : #accessing }
GncPopulation >> selectParent: k [

	| candidates parent |
	candidates := (1 to: k) collect: [ :i | population atRandom ].
	parent := candidates first.
	candidates do: [ :candidate |
		candidate score > parent score ifTrue: [ parent := candidate ] ].
	^ parent
]

{ #category : #'as yet unclassified' }
GncPopulation >> setupWithGrammar: grammarClass [

	crossoverRate ifNil: [ crossoverRate := 90 ].
	populationSize ifNil: [ populationSize := 100 ].
	population := LinkedList new.
	populationSize//4 timesRepeat: [
		| grammar |
		grammar := grammarClass new.
		grammar parameters do: [ :parameter |
			parameter set: (100 atRandom: generator random) ].
		population addLast: (GncIndividual new
				 grammar: grammar;
				 generator: generator;
				 yourself) ].
	mutationRate ifNil: [
		mutationRate := population first parameters size ]
]

{ #category : #'as yet unclassified' }
GncPopulation >> stepGeneration [

	| parent1 parent2 children |
	(populationSize // 2 atRandom: generator random) timesRepeat: [
		parent1 := self selectParent: 10.
		parent2 := self selectParent: 10.
		children := parent1
			            combine: parent2
			            withCrossoverRate: crossoverRate.
		 ]
]
