"
I am a leaf of a randomly generated AST.

I correspond to a concrete token, and, when fuzzing text, I will generate one.

I am a child of a `GncInnerNode` and, all in all, we are a full `GncAST`.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	literal:		<Object>


    Implementation Points
"
Class {
	#name : #GncLeaf,
	#superclass : #GncAST,
	#instVars : [
		'token'
	],
	#category : #'Gnocco-AST'
}

{ #category : #'instance creation' }
GncLeaf class >> withToken: token [

	^ self new token: token
]

{ #category : #translating }
GncLeaf >> children [

	#(  )
]

{ #category : #translating }
GncLeaf >> generateInto: stream [

	stream << token
]

{ #category : #'accessing - attributes' }
GncLeaf >> token: aLiteral [

	token := aLiteral
]

{ #category : #translating }
GncLeaf >> treeHeight [

	^ 0
]

{ #category : #translating }
GncLeaf >> treeSize [

	^ 1
]
