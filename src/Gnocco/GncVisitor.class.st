Class {
	#name : #GncVisitor,
	#superclass : #Object,
	#category : #'Gnocco-Visitors'
}

{ #category : #visiting }
GncVisitor >> visitNonTerminal: nonTerminal [

	self subclassResponsibility 
]

{ #category : #visiting }
GncVisitor >> visitOn: fragment [

	^ fragment visit: self
]

{ #category : #visiting }
GncVisitor >> visitRule: rule [

	self subclassResponsibility 
]

{ #category : #visiting }
GncVisitor >> visitTerminal: terminal [

	self subclassResponsibility 
]
