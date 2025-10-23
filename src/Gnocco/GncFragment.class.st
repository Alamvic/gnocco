Class {
	#name : 'GncFragment',
	#superclass : 'Object',
	#traits : 'TFuzzAst',
	#classTraits : 'TFuzzAst classTrait',
	#category : 'Gnocco-Grammar',
	#package : 'Gnocco',
	#tag : 'Grammar'
}

{ #category : 'visiting' }
GncFragment >> accept: string [

	self subclassResponsibility 
]

{ #category : 'accessing' }
GncFragment >> asFragment [

	^ self
]

{ #category : 'as yet unclassified' }
GncFragment >> consume: word [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
GncFragment >> consume: word from: index [

	self subclassResponsibility 
]

{ #category : 'translating' }
GncFragment >> generateAst: generator [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
GncFragment >> minHeight [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
GncFragment >> minSize [

	^ self subclassResponsibility
]

{ #category : 'parsing' }
GncFragment >> parse: input from: currentIndex with: generator rule: rule [

	self subclassResponsibility 
]

{ #category : 'parsing' }
GncFragment >> parse: string with: generator [

	self subclassResponsibility 
]

{ #category : 'printing' }
GncFragment >> printNameOn: stream [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
GncFragment >> visit: visitor [

	^ self subclassResponsibility
]
