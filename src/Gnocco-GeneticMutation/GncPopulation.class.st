Class {
	#name : #GncPopulation,
	#superclass : #Object,
	#instVars : [
		'generator',
		'population',
		'populationSize',
		'mutationRate',
		'crossoverRate',
		'scores'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #configuration }
GncPopulation class >> k [

	^ 30
]

{ #category : #'instance creation' }
GncPopulation class >> new [

	Error new signal: 'Use an appropriate constructor'
]

{ #category : #'instance creation' }
GncPopulation class >> newWithGenerator: generator [

	^ self basicNew
		generator: generator;
		initialize;
		yourself
]

{ #category : #adding }
GncPopulation >> addIndividual: individual [

	population addLast: individual
]

{ #category : #'as yet unclassified' }
GncPopulation >> advanceGenerations: n [

	(1 to: n)
		do: [ :i | self stepGeneration ]
		displayingProgress: [ :each |
			String streamContents: [ :stream |
				stream
					<< 'Generation ';
					print: each;
					<< '/';
					print: n ] ]
]

{ #category : #accessing }
GncPopulation >> bestIndividual [

	| individual |
	individual := population first.
	population
		do: [ :each |
			each score > individual score ifTrue: [ individual := each ] ]
		displayingProgress: 'Computing the best individual...'.
	^ individual
]

{ #category : #accessing }
GncPopulation >> crossoverRate [

	^ crossoverRate
]

{ #category : #accessing }
GncPopulation >> crossoverRate: newRate [

	crossoverRate := newRate
]

{ #category : #accessing }
GncPopulation >> generator [
	
	^ generator
]

{ #category : #accessing }
GncPopulation >> generator: newGenerator [

	generator := newGenerator
]

{ #category : #initialization }
GncPopulation >> initialize [

	crossoverRate := 90.
	populationSize := 100.
	population := OrderedCollection new.
	populationSize timesRepeat: [
		self addIndividual: self newRandomIndividual ].
	scores := OrderedCollection new.
	mutationRate := 100 // population first parameters size
]

{ #category : #inspecting }
GncPopulation >> inspectorTreeBuilder [

	<inspectorPresentationOrder: 1 title: 'Visualization'>
	^ GncPopulationVisualization new
		  population: self;
		  asPresenter
]

{ #category : #inspecting }
GncPopulation >> inspectorTreeBuilderContext: aContext [

	aContext withoutEvaluator
]

{ #category : #accessing }
GncPopulation >> mutationRate [

	^ mutationRate
]

{ #category : #accessing }
GncPopulation >> mutationRate: newRate [

	mutationRate := newRate
]

{ #category : #'as yet unclassified' }
GncPopulation >> newRandomIndividual [

	^ self subclassResponsibility
]

{ #category : #accessing }
GncPopulation >> population [

	^ population
]

{ #category : #removing }
GncPopulation >> removeIndividual [

	population removeFirst
]

{ #category : #accessing }
GncPopulation >> scores [

	^ scores
]

{ #category : #'as yet unclassified' }
GncPopulation >> selectParent: k [

	| candidates parent |
	candidates := (1 to: k) collect: [ :i |
		              population atRandom: generator random ].
	parent := candidates first.
	candidates
		do: [ :candidate |
			candidate score > parent score ifTrue: [ parent := candidate ] ]
		displayingProgress: (String streamContents: [ :stream |
				 stream
					 << 'Selecting parents with ';
					 print: k;
					 << '-tournament...' ]).
	^ parent
]

{ #category : #'as yet unclassified' }
GncPopulation >> stepGeneration [

	| parent1 parent2 child newGeneration elitismPart nextScoreBatch |
	(1 to: population size)
		do: [ :i | (population at: i) score ]
		displayingProgress: [ :i |
			'Assessing population {1}/{2}' format: {
					(i - 1).
					population size } ].
	elitismPart := 10.
	newGeneration := OrderedCollection new: populationSize.
	population sort: [ :left :right | left score > right score ].
	(1 to: elitismPart)
		do: [ :i | newGeneration add: (population at: i) ]
		displayingProgress: [ :each |
			'Picking best individuals {1}/{2}' format: {
					each.
					elitismPart } ].
	(1 to: populationSize - elitismPart)
		do: [ :each |
			parent1 := population at:
				           (populationSize // 2 atRandom: generator random).
			parent2 := population at:
				           (populationSize // 2 atRandom: generator random).
			child := parent1 combine: parent1 withCrossoverRate: crossoverRate.
			newGeneration add: child ]
		displayingProgress: [ :each |
			'Producing new offsprings {1}/{2}' format: {
					each.
					(populationSize - elitismPart) } ].
	population := newGeneration.
	nextScoreBatch := Array new: population size.
	(1 to: population size)
		do: [ :i | nextScoreBatch at: i put: (population at: i) score ]
		displayingProgress: [ :i |
			'Assessing population {1}/{2}' format: {
					(i - 1).
					population size } ].
	scores add: nextScoreBatch
]
