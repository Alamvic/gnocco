Class {
	#name : #GncFragment,
	#superclass : #Object,
	#traits : 'TFuzzAst',
	#classTraits : 'TFuzzAst classTrait',
	#category : #'Gnocco-Grammar'
}

{ #category : #accessing }
GncFragment >> asFragment [

	^ self
]

{ #category : #accessing }
GncFragment >> computeCost [

	^ self subclassResponsibility
]

{ #category : #accessing }
GncFragment >> cost [

	^ self subclassResponsibility
]

{ #category : #accessing }
GncFragment >> formatName: stream [

	^ self subclassResponsibility 
]

{ #category : #translating }
GncFragment >> generateAstWithMaxCost: cost [

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GncFragment >> reset [

	^ self subclassResponsibility
]
