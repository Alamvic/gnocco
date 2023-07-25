Class {
	#name : #GncRegexGrammarIndividual,
	#superclass : #GncIndividual,
	#instVars : [
		'grammar',
		'regex'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'instance creation' }
GncRegexGrammarIndividual class >> newFrom: other [

	^ self new
		grammar: other grammar veryDeepCopy;
		generator: other generator.
]

{ #category : #accessing }
GncRegexGrammarIndividual >> computeScore [

	| match regexCore regexGnocco coreScore gnoccoScore |
	regex := grammar generate: generator.
	match := regex smallestStringMatching.
	regexCore := regex asRegex.
	regexGnocco := regex asFastRegex.
	coreScore := GncProfiler countMessageSentIn: [
		             regexCore matches: match ].
	gnoccoScore := GncProfiler countMessageSentIn: [
		               regexGnocco matches: match ].
	^ coreScore / gnoccoScore
]

{ #category : #accessing }
GncRegexGrammarIndividual >> grammar [
	
	^ grammar
]

{ #category : #accessing }
GncRegexGrammarIndividual >> grammar: newGrammar [

	grammar := newGrammar
]

{ #category : #accessing }
GncRegexGrammarIndividual >> parameters [

	^ grammar parameters
]
