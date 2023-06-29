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

	^ 1
]

{ #category : #accessing }
GncTerminal >> visit: visitor [

	^ visitor visitTerminal: self
]
