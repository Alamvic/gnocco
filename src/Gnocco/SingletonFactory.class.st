Class {
	#name : #SingletonFactory,
	#superclass : #Object,
	#instVars : [
		'current'
	],
	#category : #Gnocco
}

{ #category : #accessing }
SingletonFactory class >> clearAll [

	| code |
	EpMonitor disableDuring: [
		0 to: self maxClasses do: [ :i |
			code := String streamContents: [ :stream |
				        stream
					        << 'Singleton';
					        << i printString;
					        << ' removeFromSystem' ].
			[ self compiler evaluate: code ]
				on: Error
				do: [ "Ignore classes that do not exist." ] ] ]
]

{ #category : #accessing }
SingletonFactory class >> maxClasses [

	^ 100000
]

{ #category : #'as yet unclassified' }
SingletonFactory >> getSingleton [

	| object |
	object := (self getSingletonClass: current) new.
	current := current + 1.
	current > self maxClasses ifTrue: [ current := 0 ].
	^ object
]

{ #category : #'as yet unclassified' }
SingletonFactory >> getSingletonClass: n [

	| name code class |
	name := 'Singleton' , current printString.
	Object subclass: name.
	code := String streamContents: [ :stream |
		        stream
			        << 'getCurrentSingletonClass';
			        << OSPlatform current lineEnding;
			        << '  ^ ';
			        << name ].
	self class compile: code.
	class := self getCurrentSingletonClass.
	self class removeSelector: name.
	^ class
]

{ #category : #initialization }
SingletonFactory >> initialize [
	current := 0
]

{ #category : #accessing }
SingletonFactory >> maxClasses [

	^ 100000
]
