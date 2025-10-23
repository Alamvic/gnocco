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

{ #category : 'parsing' }
GncTerminal >> parse: input from: currentIndex with: generator rule: rule [

	^ generator parseTerminal: self on: input from: currentIndex rule: rule
]

{ #category : 'parsing' }
GncTerminal >> parse: string with: generator [

	^ generator parseTerminal: string from: self
]

{ #category : 'as yet unclassified' }
GncTerminal >> terminals [ 

	^ { self }
]

{ #category : 'accessing' }
GncTerminal >> visit: visitor [

	^ visitor visitTerminal: self
]
