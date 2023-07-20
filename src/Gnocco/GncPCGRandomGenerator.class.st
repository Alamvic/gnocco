Class {
	#name : #GncPCGRandomGenerator,
	#superclass : #Object,
	#instVars : [
		'state',
		'seed'
	],
	#category : #'Gnocco-Grammar'
}

{ #category : #'instance creation' }
GncPCGRandomGenerator class >> seed: anInteger [

	^ self new seed: anInteger
]

{ #category : #accessing }
GncPCGRandomGenerator >> initialize [

	super initialize.
	state := DoubleWordArray new: 1.
	self useClockBasedSeed
]

{ #category : #accessing }
GncPCGRandomGenerator >> maxValue [

	^ 16r7FFFFFFF
]

{ #category : #accessing }
GncPCGRandomGenerator >> next [
	"Answer a random Float in the interval [0 to 1)."

	^ (self privateNextValue / (self maxValue + 1)) asFloat
]

{ #category : #accessing }
GncPCGRandomGenerator >> next: anInteger [

	^ self next: anInteger into: (Array new: anInteger)
]

{ #category : #accessing }
GncPCGRandomGenerator >> next: anInteger into: anArray [

	1 to: anInteger do: [ :index | anArray at: index put: self next ].
	^ anArray
]

{ #category : #accessing }
GncPCGRandomGenerator >> nextBetween: lowerBound and: higherBound [
	"Answer a random float number from the range [lowerBound, higherBound)"

	^ lowerBound + (self next * (higherBound - lowerBound))
]

{ #category : #accessing }
GncPCGRandomGenerator >> nextInteger: anInteger [
	"Answer a random integer in the interval [1, anInteger].
	Handle large numbers too (for cryptography)."

	anInteger strictlyPositive ifFalse: [
		self error: 'Range must be positive' ].

	^ (self privateNextValue / (self maxValue + 1) * anInteger) truncated
	  + 1
]

{ #category : #accessing }
GncPCGRandomGenerator >> nextIntegerBetween: lowerBound and: higherBound [
	"Answer a random integer number from the inclusive range [lowerBound, higherBound]"

	^ lowerBound + (self nextInteger: higherBound - lowerBound + 1) - 1
]

{ #category : #accessing }
GncPCGRandomGenerator >> primitiveRandomNumber: stateArray [
	"Answer a random Float in the interval [0 to 1)."

	| count returnValue |
	returnValue := stateArray at: 1.

	count := returnValue >> 59.

	stateArray
		at: 1
		put:
			(returnValue * 6364136223846793005 + 1442695040888963407 bitAnd:
				 16rFFFFFFFFFFFFFFFF).

	returnValue := returnValue >> 18 bitXor: returnValue.

	returnValue := returnValue >> 27 bitAnd: 16rFFFFFFFF.
	^ (returnValue >> count bitOr:
		   returnValue << (count negated bitAnd: 31)) bitAnd: 16r7FFFFFFF
]

{ #category : #accessing }
GncPCGRandomGenerator >> privateNextValue [
	"Answer a random Float in the interval [0 to 1)."

	^ self primitiveRandomNumber: state
]

{ #category : #accessing }
GncPCGRandomGenerator >> seed [
	"Since [1] says...
	    'After initialization the ideal solution is to hide seed from the user'
	...this method is placed in the 'private' protocol. Perhaps it sould even be deleted."

	^ seed
]

{ #category : #accessing }
GncPCGRandomGenerator >> seed: aNumber [
	"Refer #privateNextSeed and [1], seed should be positive and less than m"

	seed := aNumber.
	self setStateFromSeed
]

{ #category : #accessing }
GncPCGRandomGenerator >> setStateFromSeed [

	state at: 1 put: seed + 1442695040888963407.
	self primitiveRandomNumber: state
]

{ #category : #accessing }
GncPCGRandomGenerator >> state [

	^ state
]

{ #category : #accessing }
GncPCGRandomGenerator >> useClockBasedSeed [
	"Set a reasonable Park-Miller starting seed [1] based on the ms clock."

	[
	seed := (Time millisecondClockValue bitAnd: 16rFFFFFFFFFFFFFFFF)
		        bitXor: self hash.
	seed = 0 ] whileTrue: [ "Try again if ever get a seed = 0" ].

	self setStateFromSeed
]

{ #category : #accessing }
GncPCGRandomGenerator >> useUnixRandomGeneratorSeed [
	"Try to seed the receiver using random bytes from a Unix OS' /dev/random.
	Return true if we succeeded, false otherwise.
	Note that this might block until the OS thinks it has enough entropy."

	^ [
	  (File named: '/dev/random') readStreamDo: [ :in |
		  [
		  seed := (in next: 4) asInteger.
		  seed isZero ] whileTrue. "Try again if we ever get a zero value"
		  self setStateFromSeed.
		  true ] ]
		  on: Error
		  do: [ false ]
]
