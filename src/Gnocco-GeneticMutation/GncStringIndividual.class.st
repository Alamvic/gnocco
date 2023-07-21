Class {
	#name : #GncStringIndividual,
	#superclass : #GncIndividual,
	#instVars : [
		'parameters',
		'target'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'instance creation' }
GncStringIndividual class >> newFrom: individual [

	^ individual copy
		  parameters: individual parameters deepCopy;
		  score: nil;
		  yourself
]

{ #category : #'instance creation' }
GncStringIndividual class >> newWithTargetString: targetString andGenerator: generator [

	| parameters |
	parameters := Array new: targetString size.
	1 to: targetString size do: [ :i |
		parameters at: i put: (GncCharParameter newAtRandom: generator) ].
	^ self basicNew
		  generator: generator;
		  parameters: parameters;
		  target: targetString;
		  initialize;
		  yourself
]

{ #category : #accessing }
GncStringIndividual >> computeScore [

	| finalScore |
	finalScore := 0.
	1 to: parameters size do: [ :i |
		(parameters at: i) get = (target at: i) charCode ifTrue: [
			finalScore := finalScore + 1 ] ].
	^ finalScore
]

{ #category : #accessing }
GncStringIndividual >> parameters [

	^ parameters
]

{ #category : #accessing }
GncStringIndividual >> parameters: newParameters [

	parameters := newParameters
]

{ #category : #printing }
GncStringIndividual >> printOn: stream [

	stream << self class name; << '('.
	parameters do: [ :each |
		stream << each char ].
	stream << ')'
]

{ #category : #printing }
GncStringIndividual >> printString [

	^ '{1}({2})' format: {
			  self class name.
			  ('' join: (parameters collect: [ :each | each char ])) }
]

{ #category : #accessing }
GncStringIndividual >> score: newScore [

	score := newScore
]

{ #category : #accessing }
GncStringIndividual >> target: newTarget [

	target := newTarget
]
