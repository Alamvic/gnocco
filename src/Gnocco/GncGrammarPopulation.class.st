Class {
	#name : #GncGrammarPopulation,
	#superclass : #GncPopulation,
	#instVars : [
		'grammarClass'
	],
	#category : #'Gnocco-Genetic Optimization'
}

{ #category : #'instance creation' }
GncGrammarPopulation class >> default [

	^ self newWithGrammar: GncStonGrammar andMaxHeight: 30
]

{ #category : #'instance creation' }
GncGrammarPopulation class >> defaultWithSeed: seed [

	| this |
	this := self default.
	this generator seed: seed.
	^ this
]

{ #category : #'instance creation' }
GncGrammarPopulation class >> newWithGrammar: grammarClass andGenerator: generator [

	^ self basicNew
		  generator: generator;
		  grammarClass: grammarClass;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
GncGrammarPopulation class >> newWithGrammar: grammarClass andMaxHeight: maxHeight [

	^ self newWithGrammar: grammarClass andGenerator: (GncGrammarGenerator new
			   maxHeightCost: maxHeight;
			   yourself)
]

{ #category : #accessing }
GncGrammarPopulation >> grammarClass: initGrammarClass [

	grammarClass := initGrammarClass
]

{ #category : #initialization }
GncGrammarPopulation >> initialize [

	super initialize.
	GncFuzzyClass setupFuzzyClasses: 9
]

{ #category : #'as yet unclassified' }
GncGrammarPopulation >> newRandomIndividual [

	| grammar |
	grammar := grammarClass new.
	grammar parameters do: [ :parameter |
		parameter set: (100 atRandom: generator random) ].
	^ GncGrammarIndividual new
		  grammar: grammar;
		  generator: generator;
		  yourself
]
