Class {
	#name : #GncRegexGrammarPopulation,
	#superclass : #GncPopulation,
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'as yet unclassified' }
GncRegexGrammarPopulation >> newRandomIndividual [

	| grammar |
	grammar := GncRegexGrammar new.
	grammar parameters do: [ :parameter |
		parameter set: (500 atRandom: generator random) ].
	^ GncRegexGrammarIndividual new
		  grammar: grammar;
		  generator: generator;
		  yourself
]
