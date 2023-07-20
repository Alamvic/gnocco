Class {
	#name : #GncStringPopulation,
	#superclass : #GncPopulation,
	#instVars : [
		'target'
	],
	#category : #'Gnocco-Tests-Genetic Optimization'
}

{ #category : #'instance creation' }
GncStringPopulation class >> newWithGenerator: generator andTarget: target [

	^ self basicNew
		  generator: generator;
		  target: target;
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
GncStringPopulation >> newRandomIndividual [

	^ GncStringIndividual
		  newWithTargetString: target
		  andGenerator: generator
]

{ #category : #'as yet unclassified' }
GncStringPopulation >> target: newTarget [

	target := newTarget
]
