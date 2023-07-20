Class {
	#name : #GncStupidStream,
	#superclass : #Stream,
	#category : #'Gnocco-Fuzzing Artifact'
}

{ #category : #'instance creation' }
GncStupidStream class >> new [

	^ self basicNew
		  initialize;
		  yourself
]

{ #category : #testing }
GncStupidStream >> atEnd [
	"Answer whether the receiver can access any more objects."

	^ true
]

{ #category : #accessing }
GncStupidStream >> contents [
	"Answer all of the contents of the receiver."

	^ #(  )
]

{ #category : #accessing }
GncStupidStream >> isBinary [ 

	^ true
]

{ #category : #accessing }
GncStupidStream >> next [
	"Answer the next object accessible by the receiver."

	Error new signal: 'no content!'
]

{ #category : #accessing }
GncStupidStream >> nextPut: anObject [

	
]
