Class {
	#name : #StonGrammar,
	#superclass : #Grammar,
	#instVars : [
		'ntId',
		'ntPrimitive',
		'ntSymbol',
		'ntObjectTag',
		'ntObjectBody',
		'ntInteger',
		'ntString',
		'ntBoolean',
		'ntStringContent',
		'ntLetter',
		'ntValuesOrEmpty',
		'ntValues',
		'ntObject',
		'ntObjects',
		'availableId',
		'ntObjectInstance'
	],
	#category : #Gnocco
}

{ #category : #initialization }
StonGrammar >> defineGrammar [ 

	ntObjects --> ntObjectInstance @ 1
		| ntObjectInstance, OSPlatform current lineEnding, ntObjects @ 99.
		
	ntObject --> ntPrimitive @ 0
		| ntSymbol @ 0
		| ntObjectInstance @ 5
		| '@', ntId @ [ availableId isZero ifTrue: [ 0 ] ifFalse: [ 1 ] ].
		
	ntObjectInstance --> ntObjectTag, ' ', ntObjectBody.
		
	ntPrimitive --> ntInteger | ntString | ntBoolean.
	ntInteger --> ($0 - $9), ntInteger | ($0 - $9).
	ntBoolean --> 'true' | 'false'.
	ntString --> '''', ntStringContent, ''''.
	
	ntSymbol --> '#', ntStringContent.
	
	ntStringContent --> ntLetter, ntStringContent | ntLetter.
	ntLetter --> ($a - $z) | ($A - $Z).
	
	ntObjectTag --> 'FuzzyClass', ($0 - $9).
	ntObjectTag post: [ :result | availableId := availableId + 1 ].
	ntObjectBody --> '[ ', ntValuesOrEmpty, ' ]'.
	ntValuesOrEmpty --> '' | ntValues @ 99.
	ntValues --> ntObject | ntObject, ', ', ntObject @ 99.
	
	ntId --> '' < [ Leaf with: availableId atRandom printString ].
]

{ #category : #translating }
StonGrammar >> generateAstWithMaxCost: cost [

	availableId := 0.
	^ super generateAstWithMaxCost: cost
]

{ #category : #accessing }
StonGrammar >> start [

	^ ntObjectInstance
]
