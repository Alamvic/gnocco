Class {
	#name : #GncFuzzyClass,
	#superclass : #Array,
	#type : #variable,
	#category : #'Gnocco-Private'
}

{ #category : #helper }
GncFuzzyClass class >> removeFuzzyClasses: numberOfFuzzyClasses [
	"A helper utility that allows you to remove classes created with `setupFuzzyClasses`."

	EpMonitor disableDuring: [
		1 to: numberOfFuzzyClasses do: [ :i |
			| code |
			code := String streamContents: [ :stream |
				        stream
					        nextPutAll: self name;
					        print: i;
					        nextPutAll: ' removeFromSystem' ].
			self compiler evaluate: code ] ]
]

{ #category : #helper }
GncFuzzyClass class >> setupFuzzyClasses: numberOfFuzzyClasses [
	"A helper utility that allows you to create `numberOfFuzzyClasses` that subclass this class.
	Each of them will be named like this one, with an added number at the end, going from `1` to
	`numberOfFuzzyClasses`. It is up to you to delete these classes afterwards."
	
	EpMonitor disableDuring: [
		1 to: numberOfFuzzyClasses do: [ :i |
			| code |
			code := String streamContents: [ :stream |
				        stream
					        nextPutAll: self name;
					        nextPutAll: ' subclass: #';
					        nextPutAll: self name;
					        print: i ].
			self compiler evaluate: code ] ]
]

{ #category : #accessing }
GncFuzzyClass >> className [
	"^ self class name allButFirst: super class name size"
	"Why this doesn't work????"

	^ self class name allButFirst: self class superclass name size
]

{ #category : #comparing }
GncFuzzyClass >> hash [ 
	
	^ self identityHash
]
