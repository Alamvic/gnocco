Class {
	#name : #GncMinSizeComputer,
	#superclass : #GncOnceVisitor,
	#category : #'Gnocco-Visitors'
}

{ #category : #visiting }
GncMinSizeComputer >> temporaryValueFor: nonTerminal [

	^ nonTerminal minSize
]

{ #category : #visiting }
GncMinSizeComputer >> visitNonTerminalOnce: nonTerminal [

	| minSize |
	minSize := Float infinity.
	nonTerminal rules do: [ :rule |
		minSize := minSize min: ((rule visit: self) + 1) ].
	nonTerminal minSize: (nonTerminal minSize min: minSize).
	^ nonTerminal minSize
]

{ #category : #visiting }
GncMinSizeComputer >> visitRule: rule [

	| minSize |
	minSize := 0.
	rule fragments do: [ :fragment |
		minSize := minSize + (fragment visit: self) ].
	rule minSize: (rule minSize min: minSize).
	^ rule minSize
]

{ #category : #visiting }
GncMinSizeComputer >> visitTerminal: terminal [

	^ terminal minSize
]
