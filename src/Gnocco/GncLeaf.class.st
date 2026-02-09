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
	#name : 'GncLeaf',
	#superclass : 'GncAST',
	#instVars : [
		'token'
	],
	#category : 'Gnocco-AST',
	#package : 'Gnocco',
	#tag : 'AST'
}

{ #category : 'instance creation' }
GncLeaf class >> treeSize [

	^ 1
]

{ #category : 'instance creation' }
GncLeaf class >> withToken: token [

	^ self new token: token
]

{ #category : 'accessing' }
GncLeaf >> aLeaf [

	^ self
]

{ #category : 'rendering' }
GncLeaf >> allNodes [

	^ { self }
]

{ #category : 'converting' }
GncLeaf >> asLabel [
	
	^ RSLabel new text: token; color: Color black.
]

{ #category : 'accessing' }
GncLeaf >> at: index [

	(index ~= 1) ifTrue: [ 1 halt. ].

	^ self
]

{ #category : 'translating' }
GncLeaf >> children [

	#(  )
]

{ #category : 'translating' }
GncLeaf >> generateInto: stream [

	stream << token
]

{ #category : 'testing' }
GncLeaf >> isLeaf [

	^ true
]

{ #category : 'accessing' }
GncLeaf >> shape [

	^ RSComposite new draggable; model: self; shapes: { self asLabel }
]

{ #category : 'rendering' }
GncLeaf >> shapes [

	^ { self shape }
]

{ #category : 'accessing - attributes' }
GncLeaf >> token: aLiteral [

	inputSize := nil.
	token := aLiteral
]

{ #category : 'translating' }
GncLeaf >> treeHeight [

	^ 0
]

{ #category : 'translating' }
GncLeaf >> treeSize [

	^ self class treeSize
]

{ #category : 'as yet unclassified' }
GncLeaf >> updateWeightToChildren: reward [ 

	"Do nothing, it's a leaf"
]
