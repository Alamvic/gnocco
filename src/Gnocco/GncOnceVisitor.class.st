Class {
	#name : #GncOnceVisitor,
	#superclass : #GncVisitor,
	#instVars : [
		'cachedVisits',
		'changed'
	],
	#category : #'Gnocco-Visitors'
}

{ #category : #accessing }
GncOnceVisitor >> changed [

	^ changed
]

{ #category : #initialization }
GncOnceVisitor >> initialize [

	cachedVisits := IdentityDictionary new.
	changed := false
]

{ #category : #visiting }
GncOnceVisitor >> temporaryValueFor: nonTerminal [

	self subclassResponsibility
]

{ #category : #visiting }
GncOnceVisitor >> visitNonTerminal: nonTerminal [

	^ cachedVisits at: nonTerminal ifAbsentPut: [
		  | old new |
		  old := self temporaryValueFor: nonTerminal.
		  cachedVisits at: nonTerminal put: old.
		  new := self visitNonTerminalOnce: nonTerminal.
		  old ~= new ifTrue: [ changed := true ].
		  new ]
]

{ #category : #visiting }
GncOnceVisitor >> visitNonTerminalOnce: nonTerminal [

	self subclassResponsibility
]
