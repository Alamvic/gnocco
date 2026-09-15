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

{ #category : 'accessing' }
GncLeaf >> allChildAtLevel: level currentLevel: currentLevel [

	^ ( level = currentLevel ) ifTrue: [ OrderedCollection with: self ] ifFalse: [ {} ]
]

{ #category : 'accessing' }
GncLeaf >> allChildren [

	^ #(  )
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
GncLeaf >> asPharoObject [

	^ self asPrimitiveObject 
]

{ #category : 'accessing' }
GncLeaf >> at: index [

	(index ~= 1) ifTrue: [ 1 halt. ].

	^ self
]

{ #category : 'accessing' }
GncLeaf >> backPropagateToChildren: reward [

	"Do nothing, it's a leaf"
]

{ #category : 'accessing' }
GncLeaf >> backPropagateToChildren: reward level: level [

	"Do nothing, it's a leaf"
]

{ #category : 'translating' }
GncLeaf >> children [

	#(  )
]

{ #category : 'as yet unclassified' }
GncLeaf >> doCopy [

	^ super copy token: token
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
GncLeaf >> isTypeVariable [

	^ token class = ByteString and: [ token last = $: ]
]

{ #category : 'as yet unclassified' }
GncLeaf >> repairChildren [

	"do nothing"
]

{ #category : 'accessing' }
GncLeaf >> shape [

	^ RSComposite new draggable; model: self; shapes: { self asLabel }
]

{ #category : 'rendering' }
GncLeaf >> shapes [

	^ { self shape }
]

{ #category : 'accessing' }
GncLeaf >> token [

	^ token
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

{ #category : 'accessing' }
GncLeaf >> varName [

	^ token allButLast
]
