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

{ #category : #accessing }
GncTerminalRange >> formatName: stream [

	stream
		<< '[';
		<< from;
		<< '-';
		<< to;
		<< ']'.
]

{ #category : #translating }
GncTerminalRange >> from: f to: t [

	from := f.
	to := t
]

{ #category : #translating }
GncTerminalRange >> generateAstWithMaxCost: cost [

	| offset |
	offset := (to charCode - from charCode + 1) atRandom.
	^ GncLeaf withToken: (from charCode + offset - 1) asCharacter
]
