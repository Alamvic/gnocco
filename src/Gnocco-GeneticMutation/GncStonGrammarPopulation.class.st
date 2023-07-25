Class {
	#name : #GncStonGrammarPopulation,
	#superclass : #GncPopulation,
	#instVars : [
		'grammarClass'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'instance creation' }
GncStonGrammarPopulation class >> default [

	^ self newWithGrammar: GncStonGrammar andMaxHeight: 30
]

{ #category : #'instance creation' }
GncStonGrammarPopulation class >> defaultWithSeed: seed [

	| this |
	this := self default.
	this generator seed: seed.
	^ this
]

{ #category : #'instance creation' }
GncStonGrammarPopulation class >> newWithGrammar: grammarClass andGenerator: generator [

	^ self basicNew
		  generator: generator;
		  grammarClass: grammarClass;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
GncStonGrammarPopulation class >> newWithGrammar: grammarClass andMaxHeight: maxHeight [

	^ self newWithGrammar: grammarClass andGenerator: (GncGrammarGenerator new
			   maxHeight: maxHeight;
			   yourself)
]

{ #category : #accessing }
GncStonGrammarPopulation >> grammarClass: initGrammarClass [

	grammarClass := initGrammarClass
]

{ #category : #initialization }
GncStonGrammarPopulation >> initialize [

	super initialize.
	GncFuzzyClass setupFuzzyClasses: 9
]

{ #category : #'as yet unclassified' }
GncStonGrammarPopulation >> newRandomIndividual [

	| grammar |
	grammar := grammarClass new.
	grammar parameters do: [ :parameter |
		parameter set: (100 atRandom: generator random) ].
	^ GncStonGrammarIndividual new
		  grammar: grammar;
		  generator: generator;
		  yourself
]
