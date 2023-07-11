Class {
	#name : #GncOnceVisitor,
	#superclass : #GncVisitor,
	#instVars : [
		'cachedVisits'
	],
	#category : #'Gnocco-Visitors'
}

{ #category : #initialization }
GncOnceVisitor >> initialize [

	cachedVisits := IdentityDictionary new
]

{ #category : #visiting }
GncOnceVisitor >> temporaryValueFor: nonTerminal [

	self subclassResponsibility
]

{ #category : #visiting }
GncOnceVisitor >> visitNonTerminal: nonTerminal [

	^ cachedVisits at: nonTerminal ifAbsentPut: [
		  cachedVisits at: nonTerminal put: (self temporaryValueFor: nonTerminal).
		  self visitNonTerminalOnce: nonTerminal ]
]

{ #category : #visiting }
GncOnceVisitor >> visitNonTerminalOnce: nonTerminal [

	self subclassResponsibility
]
