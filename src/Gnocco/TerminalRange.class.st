Class {
	#name : #TerminalRange,
	#superclass : #Terminal,
	#instVars : [
		'from',
		'to'
	],
	#category : #Gnocco
}

{ #category : #'instance creation' }
TerminalRange class >> from: from to: to [

	^ self new from: from to: to
]

{ #category : #accessing }
TerminalRange >> formatName: stream [

	stream
		<< '[';
		<< from;
		<< '-';
		<< to;
		<< ']'.
]

{ #category : #translating }
TerminalRange >> from: f to: t [

	from := f.
	to := t
]

{ #category : #translating }
TerminalRange >> generateAstWithMaxCost: cost [

	| offset |
	offset := (to charCode - from charCode + 1) atRandom.
	^ Leaf with: (from charCode + offset - 1) asCharacter
]
