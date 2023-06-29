Class {
	#name : #GncMinSizeComputer,
	#superclass : #GncOnceVisitor,
	#category : #'Gnocco-Visitors'
}

{ #category : #visiting }
GncMinSizeComputer >> temporaryValue [

	^ Float infinity
	 "if we detect a cycle, then it cannot be the smallest derivation tree"
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

	| minHeight |
	minHeight := 0.
	rule fragments do: [ :fragment |
		minHeight := minHeight + (fragment visit: self) ].
	rule minHeight: (rule minHeight min: minHeight).
	^ rule minHeight
]

{ #category : #visiting }
GncMinSizeComputer >> visitTerminal: terminal [

	^ terminal minHeight
]
