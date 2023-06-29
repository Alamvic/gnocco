"
I am the combination of an `OrderedCollection` and of a `Dequeue` (double ended
queue), which means I can be used as both data structures, without any significant
performance hit. In particular, since there is no Queue data structure in the standard
library, I can be used only as a dequeue.

I store data inside an array, and I will grow only if the said array is full. I will
also avoid allocation of that array on creation, so it's ""cheap"" to create me.

Currently, I never shrink. Once the inner array has been grown, it will take that
space forever. This is more time-efficient, but less space-efficient. No particular
thought has been put in that tradeoff, it just happens to be how it's implemented.
"
Class {
	#name : #ArrayDequeue,
	#superclass : #Object,
	#instVars : [
		'startIndex',
		'endIndex',
		'array',
		'size',
		'addLastCode',
		'addFirstCode'
	],
	#category : #'Gnocco-Data Structures'
}

{ #category : #adding }
ArrayDequeue >> addFirst: element [

	addFirstCode value: element
]

{ #category : #private }
ArrayDequeue >> addFirstCode [

	^ [ :value |
	  self reallocateIfNecessary.
	  size := size + 1.
	  startIndex := self prev: startIndex.
	  array at: startIndex put: value ]
]

{ #category : #adding }
ArrayDequeue >> addLast: element [

	addLastCode value: element
]

{ #category : #private }
ArrayDequeue >> addLastCode [

	^ [ :value |
		self reallocateIfNecessary.
		size := size + 1.
		array at: endIndex put: value.
		endIndex := self next: endIndex ]
]

{ #category : #accessing }
ArrayDequeue >> at: index [

	^ array at: (self convertToArrayIndex: index)
]

{ #category : #accessing }
ArrayDequeue >> at: index put: value [

	^ array at: (self convertToArrayIndex: index) put: value
]

{ #category : #accessing }
ArrayDequeue >> capacity [

	^ array size
]

{ #category : #initialization }
ArrayDequeue >> convertToArrayIndex: index [

	| arrayIndex |
	(index < 1 or: [ index > size ]) ifTrue: [
		SubscriptOutOfBounds signalFor: index ].
	arrayIndex := startIndex + index - 1.
	arrayIndex > self capacity ifTrue: [
		arrayIndex := arrayIndex - self capacity ].
	^ arrayIndex
]

{ #category : #private }
ArrayDequeue >> firstAllocSize [

	^ 4
]

{ #category : #private }
ArrayDequeue >> firstPushCode [

	^ [ :value |
	  size := 1.
	  array := Array new: self firstAllocSize.
	  array at: 1 put: value.
	  startIndex := 1.
	  endIndex := 2.
	  addLastCode := self addLastCode.
	  addFirstCode := self addFirstCode ]
]

{ #category : #initialization }
ArrayDequeue >> initialize [

	size := 0.
	addLastCode := self firstPushCode.
	addFirstCode := addLastCode
]

{ #category : #accessing }
ArrayDequeue >> isEmpty [

	^ size = 0
]

{ #category : #private }
ArrayDequeue >> next: index [

	^ (index % self capacity) + 1
]

{ #category : #private }
ArrayDequeue >> prev: index [

	^ index = 1
		  ifTrue: [ self capacity ]
		  ifFalse: [ index - 1 ]
]

{ #category : #private }
ArrayDequeue >> reallocateIfNecessary [

	| newArray |
	size = self capacity ifFalse: [ ^ self ].
	newArray := Array new: 2 * size.
	1 to: size do: [ :i | newArray at: i put: (self at: i) ].
	array := newArray.
	startIndex := 1.
	endIndex := size + 1
]

{ #category : #removing }
ArrayDequeue >> removeFirst [

	| result |
	self isEmpty ifTrue: [ CollectionIsEmpty signalWith: self ].
	result := array at: startIndex.
	startIndex := self next: startIndex.
	size := size - 1.
	^ result
]

{ #category : #removing }
ArrayDequeue >> removeLast [

	| result |
	self isEmpty ifTrue: [ CollectionIsEmpty signalWith: self ].
	endIndex := self prev: endIndex.
	result := array at: endIndex.
	size := size - 1.
	^ result
]

{ #category : #accessing }
ArrayDequeue >> size [ 

	^ size
]
