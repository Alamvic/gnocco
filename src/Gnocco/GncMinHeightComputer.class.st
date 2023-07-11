Class {
	#name : #GncMinHeightComputer,
	#superclass : #GncOnceVisitor,
	#category : #'Gnocco-Visitors'
}

{ #category : #visiting }
GncMinHeightComputer >> temporaryValueFor: nonTerminal [

	^ nonTerminal minHeight ifNil: [ "if we detect a cycle, then it cannot be the smallest derivation tree"
		  Float infinity ]
]

{ #category : #visiting }
GncMinHeightComputer >> visitNonTerminalOnce: nonTerminal [

	| heightCost |
	heightCost := Float infinity.
	nonTerminal rules do: [ :rule |
		heightCost := heightCost min: ((rule visit: self) + 1) ].
	nonTerminal minHeight: (nonTerminal minHeight min: heightCost).
	^ nonTerminal minHeight
]

{ #category : #visiting }
GncMinHeightComputer >> visitRule: rule [

	| minHeight |
	minHeight := 0.
	rule fragments do: [ :fragment |
		minHeight := minHeight max: (fragment visit: self) ].
	rule minHeight: (rule minHeight min: minHeight).
	^ rule minHeight
]

{ #category : #visiting }
GncMinHeightComputer >> visitTerminal: terminal [

	^ 0
]
