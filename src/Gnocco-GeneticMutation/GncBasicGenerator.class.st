Class {
	#name : #GncBasicGenerator,
	#superclass : #Object,
	#instVars : [
		'randomStream'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #initialization }
GncBasicGenerator >> initialize [

	randomStream := PMFishmanMooreRandomGenerator new
]

{ #category : #accessing }
GncBasicGenerator >> random [

	^ randomStream 
]

{ #category : #accessing }
GncBasicGenerator >> seed: seed [

	randomStream := randomStream class new
		                seed: seed;
		                yourself
]
