Class {
	#name : #GncStonGrammar,
	#superclass : #GncGrammar,
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
		'ntObjectInstance',
		'ntClassDigit'
	],
	#category : #'Gnocco-Benchmarks-Grammar'
}

{ #category : #initialization }
GncStonGrammar >> defineGrammar [ 

	ntObjects --> ntObjectInstance
		| ntObjectInstance, OSPlatform current lineEnding, ntObjects.
		
	ntObject --> ntPrimitive
		| ntSymbol
		| ntObjectInstance @ 99
		| '@', ntId @ [ :weight |
			availableId isZero ifTrue: [ 0 ] ifFalse: [ weight ] ].
		
	ntObjectInstance --> ntObjectTag, ' ', ntObjectBody.
		
	ntPrimitive --> ntInteger | ntString | ntBoolean.
	ntInteger --> ($0 - $9), ntInteger | ($0 - $9).
	ntBoolean --> 'true' | 'false'.
	ntString --> '''', ntStringContent, ''''.
	
	ntSymbol --> '#', ntStringContent.
	
	ntStringContent --> ntLetter, ntStringContent | ntLetter.
	ntLetter --> ($a - $z) | ($A - $Z).
	
	ntObjectTag --> 'GncFuzzyClass', ntClassDigit.
	ntClassDigit --> '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'.
	ntObjectTag post: [ :result | availableId := availableId + 1 ].
	ntObjectBody --> '[ ', ntValuesOrEmpty, ' ]'.
	ntValuesOrEmpty --> '' | ntValues @ 99.
	ntValues --> ntObject | ntObject, ', ', ntValues @ 99.
	
	ntId --> '' < [ GncLeaf withToken: availableId atRandom printString ].
	^ ntObjectInstance
]

{ #category : #translating }
GncStonGrammar >> generateAst: generator [

	availableId := 0.
	^ super generateAst: generator
]
