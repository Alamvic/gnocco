Class {
	#name : #FuzzyClass,
	#superclass : #Array,
	#type : #variable,
	#category : #Gnocco
}

{ #category : #accessing }
FuzzyClass >> className [
	"^ self class name allButFirst: super class name size"
	"Why this doesn't work????"

	^ self class name allButFirst: self class superclass name size
]

{ #category : #comparing }
FuzzyClass >> hash [ 
	
	^ self identityHash
]
