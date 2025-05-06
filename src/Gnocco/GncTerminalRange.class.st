Class {
	#name : #GncTerminalRange,
	#superclass : #GncTerminal,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Gnocco-Grammar'
}

{ #category : #'instance creation' }
GncTerminalRange class >> from: from to: to [

	^ self new from: from to: to
]

{ #category : #translating }
GncTerminalRange >> from: f to: t [

	from := f.
	to := t
]

{ #category : #translating }
GncTerminalRange >> generateAst: generator [

	| charCode |
	charCode := (from charCode to: to charCode) atRandom:
		            generator random.
	^ GncLeaf withToken: charCode asCharacter
]

{ #category : #translating }
GncTerminalRange >> generateToken: generator [

	| charCode |
	charCode := (from charCode to: to charCode) atRandom:
		            generator random.
	^ GncLeaf withToken: charCode asCharacter
]

{ #category : #printing }
GncTerminalRange >> printNameOn: stream [

	stream
		<< '[';
		<< from;
		<< '-';
		<< to;
		<< ']'.
]
