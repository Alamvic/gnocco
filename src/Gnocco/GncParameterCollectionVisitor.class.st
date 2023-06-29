Class {
	#name : #GncParameterCollectionVisitor,
	#superclass : #GncOnceVisitor,
	#instVars : [
		'parameters'
	],
	#category : #'Gnocco-Visitors'
}

{ #category : #'instance creation' }
GncParameterCollectionVisitor class >> new [

	^ super new
		  parameters: OrderedCollection new;
		  yourself
]

{ #category : #accessing }
GncParameterCollectionVisitor >> parameters [

	^ parameters
]

{ #category : #accessing }
GncParameterCollectionVisitor >> parameters: anObject [

	parameters := anObject
]

{ #category : #visiting }
GncParameterCollectionVisitor >> temporaryValue [

	^ nil
]

{ #category : #visiting }
GncParameterCollectionVisitor >> visitNonTerminalOnce: nonTerminal [

	nonTerminal rules do: [ :rule | rule visit: self ]
]

{ #category : #visiting }
GncParameterCollectionVisitor >> visitRule: rule [

	parameters add: rule weightBox.
	rule fragments do: [ :fragment | fragment visit: self ]
]

{ #category : #visiting }
GncParameterCollectionVisitor >> visitTerminal: terminal [
]
