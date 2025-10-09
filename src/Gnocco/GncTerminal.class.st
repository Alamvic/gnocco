Class {
	#name : 'GncTerminal',
	#superclass : 'GncFragment',
	#category : 'Gnocco-Grammar',
	#package : 'Gnocco',
	#tag : 'Grammar'
}

{ #category : 'accessing' }
GncTerminal >> minHeight [

	^ 0
]

{ #category : 'accessing' }
GncTerminal >> minSize [

	^ GncLeaf treeSize
]

{ #category : 'as yet unclassified' }
GncTerminal >> terminals [ 

	^ { self }
]

{ #category : 'accessing' }
GncTerminal >> visit: visitor [

	^ visitor visitTerminal: self
]
