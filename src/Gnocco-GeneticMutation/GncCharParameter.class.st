Class {
	#name : #GncCharParameter,
	#superclass : #GncParameter,
	#instVars : [
		'char'
	],
	#category : #'Gnocco-GeneticMutation'
}

{ #category : #'instance creation' }
GncCharParameter class >> newAtRandom: generator [

	^ self new char: ((9 asCharacter to: 126 asCharacter) atRandom: generator random)
]

{ #category : #'as yet unclassified' }
GncCharParameter >> atRandom: generator [

	char := (9 asCharacter to: 126 asCharacter) atRandom:
		        generator random
]

{ #category : #accessing }
GncCharParameter >> char [

	^ char
]

{ #category : #accessing }
GncCharParameter >> char: newChar [

	char := newChar
]

{ #category : #'as yet unclassified' }
GncCharParameter >> get [

	^ char charCode
]

{ #category : #'as yet unclassified' }
GncCharParameter >> set: charCode [

	charCode < 9 ifTrue: [
		char := 9 asCharacter.
		^ self ].
	charCode > 126 ifTrue: [
		char := 126 asCharacter.
		^ self ].
	char := charCode asCharacter
]
