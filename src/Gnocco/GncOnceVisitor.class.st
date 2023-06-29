Class {
	#name : #GncOnceVisitor,
	#superclass : #GncVisitor,
	#instVars : [
		'cachedVisits'
	],
	#category : #'Gnocco-Visitors'
}

{ #category : #visiting }
GncOnceVisitor >> temporaryValue [

	self subclassResponsibility
]

{ #category : #visiting }
GncOnceVisitor >> visitNonTerminalOnce: nonTerminal [

	self subclassResponsibility
]
