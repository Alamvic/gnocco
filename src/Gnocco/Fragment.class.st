Class {
	#name : #Fragment,
	#superclass : #Object,
	#traits : 'TFuzzAst',
	#classTraits : 'TFuzzAst classTrait',
	#category : #Gnocco
}

{ #category : #accessing }
Fragment >> asFragment [

	^ self
]

{ #category : #accessing }
Fragment >> computeCost [

	^ self subclassResponsibility
]

{ #category : #accessing }
Fragment >> cost [

	^ self subclassResponsibility
]

{ #category : #accessing }
Fragment >> formatName: stream [

	^ self subclassResponsibility 
]

{ #category : #translating }
Fragment >> generateAstWithMaxCost: cost [

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Fragment >> reset [

	^ self subclassResponsibility
]
