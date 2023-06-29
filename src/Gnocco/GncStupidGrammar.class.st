Class {
	#name : #GncStupidGrammar,
	#superclass : #GncGrammar,
	#instVars : [
		'ntStart'
	],
	#category : #'Gnocco-Grammar Library'
}

{ #category : #initialization }
GncStupidGrammar >> defineGrammar [

	ntStart --> 'true' | 'false'
]

{ #category : #accessing }
GncStupidGrammar >> start [

	^ ntStart
]

{ #category : #accessing }
GncStupidGrammar >> stats: generations seed: seed [

	| generator result |
	generator := GncGenerator new seed: seed.
	result := {
		          (#true -> 0).
		          (#false -> 0) } as: Dictionary.
	1 to: generations do: [ :i |
		| s |
		s := self generate: generator.
		result at: s put: (result at: s) + 1 ].
	^ result
]
