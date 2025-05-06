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

{ #category : #translating }
GncFragment >> generateAst: generator [

	^ self subclassResponsibility
]

{ #category : #accessing }
GncFragment >> minHeight [

	^ self subclassResponsibility
]

{ #category : #accessing }
GncFragment >> minSize [

	^ self subclassResponsibility
]

{ #category : #printing }
GncFragment >> printNameOn: stream [

	^ self subclassResponsibility 
]

{ #category : #accessing }
GncFragment >> visit: visitor [

	^ self subclassResponsibility
]
