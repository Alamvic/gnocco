Class {
	#name : #GncTerminal,
	#superclass : #GncFragment,
	#category : #'Gnocco-Grammar'
}

{ #category : #accessing }
GncTerminal >> minHeight [

	^ 0
]

{ #category : #accessing }
GncTerminal >> minSize [

	^ GncLeaf treeSize
]

{ #category : #accessing }
GncTerminal >> visit: visitor [

	^ visitor visitTerminal: self
]
