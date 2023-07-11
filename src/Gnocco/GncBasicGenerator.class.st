Class {
	#name : #GncBasicGenerator,
	#superclass : #Object,
	#instVars : [
		'randomStream'
	],
	#category : #'Gnocco-Genetic Optimization'
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
