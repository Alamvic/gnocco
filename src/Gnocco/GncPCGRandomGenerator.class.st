"
This Random Number Generator is an implementation of a Permuted Congruential Generator (https://www.pcg-random.org/index.html)

If you just want a quick random integer, use:
		10 atRandom
Every integer interval can give a random number:
		(6 to: 12) atRandom
SequenceableCollections can give randomly selected elements:
		'pick one of these letters randomly' atRandom
SequenceableCollections also respond to shuffled, as in:
		($A to: $Z) shuffled

The correct way to use class Random is to store one in an instance or class variable:
		myGenerator := Random new.
Then use it every time you need another number between 0.0 and 1.0 (excluding)
		myGenerator next
You can also generate a positive integer
		myGenerator nextInteger: 10


The implementation used here is the minimal implementation:

```c
// *Really* minimal PCG32 code / (c) 2014 M.E. O'Neill / pcg-random.org
// Licensed under Apache License 2.0 (NO WARRANTY, etc. see website)

typedef struct { uint64_t state;  uint64_t inc; } pcg32_random_t;

uint32_t pcg32_random_r(pcg32_random_t* rng)
{
    uint64_t oldstate = rng->state;
    // Advance internal state
    rng->state = oldstate * 6364136223846793005ULL + (rng->inc|1);
    // Calculate output function (XSH RR), uses old state for max ILP
    uint32_t xorshifted = ((oldstate >> 18u) ^ oldstate) >> 27u;
    uint32_t rot = oldstate >> 59u;
    return (xorshifted >> rot) | (xorshifted << ((-rot) & 31));
}
```

@TechReport{oneill:pcg2014,
title = """"PCG: A Family of Simple Fast Space-Efficient Statistically Good Algorithms for Random Number Generation"""",
author = """"Melissa E. O'Neill"""",
institution = """"Harvey Mudd College"""",
address = """"Claremont, CA"""",
number = """"HMC-CS-2014-0905"""",
year = """"2014"""",
month = Sep,
xurl = """"https://www.cs.hmc.edu/tr/hmc-cs-2014-0905.pdf"""",
}
"
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
