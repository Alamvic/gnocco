Class {
	#name : #GncPoorlySerialized,
	#superclass : #Object,
	#traits : 'TBenchmarkable',
	#classTraits : 'TBenchmarkable classTrait',
	#instVars : [
		'data'
	],
	#category : #Gnocco
}

{ #category : #'accessing - method dictionary' }
GncPoorlySerialized class >> addAndClassifySelector: selector withMethod: compiledMethod inProtocol: aCategory [

	"When a new methods is added, I add it to the localMethodDict and also propagate the changes to my users"
	self localMethodDict at: selector put: compiledMethod.

	super
		addAndClassifySelector: selector
		withMethod: compiledMethod
		inProtocol: aCategory.

	TraitChange addSelector: selector on: self.
]

{ #category : #'accessing - method dictionary' }
GncPoorlySerialized class >> addSelector: selector withMethod: compiledMethod [
	"When a new selector is installed in a class I insert the selector in the local methodDict and propagate the changes to my users"

	self localMethodDict at: selector put: compiledMethod.
	super addSelector: selector withMethod: compiledMethod.
	TraitChange addSelector: selector on: self
]

{ #category : #'accessing - method dictionary' }
GncPoorlySerialized class >> addSelector: selector withRecompiledMethod: compiledMethod [
	"When a new selector is installed in a class I insert the selector in the local methodDict and propagate the changes to my users"

	compiledMethod isFromTrait
		ifTrue: [ ^ super addSelector: selector withRecompiledMethod: compiledMethod ].

	self localMethodDict at: selector put: compiledMethod.
	super addSelector: selector withRecompiledMethod: compiledMethod.
	TraitChange addSelector: selector on: self
]

{ #category : #querying }
GncPoorlySerialized class >> allTraits [
	^ self traitComposition allTraits
]

{ #category : #benchmarking }
GncPoorlySerialized class >> benchFor: sizes [

	| result |
	result := sizes collect: [ :size |
		          | ps res |
		          ps := self new: size.
		          res := ps benchIntoFile: 'hello2.fuel'.
		          res ].
	^ GncFullBenchmarkResult new given: sizes itProduces: result
]

{ #category : #benchmarking }
GncPoorlySerialized class >> benchFor: sizes with: data [
	| result |
	result := sizes collect: [ :size | | ps |
		ps := self new: size with: data.
		ps benchIntoFile: 'hello2.fuel' ].
	^GncFullBenchmarkResult new given: sizes itProduces: result.
]

{ #category : #initialization }
GncPoorlySerialized class >> doRebuildMethodDictionary [
	| selectors removedSelectors removeFromOrganization modified|

	"During the creation of the class or after a change in the traitComposition, the whole method dictionary is calculated.
	If I return true, my users should be updated"

	"1. I recreate the local methodDict"
	modified := false.
	self methodDict valuesDo: [ :m | m traitSource ifNil: [ self localMethodDict at: m selector put: m ]].

	"2. I filter the selectors from the trait composition, rejecting the ones that are locally defined.
	And then I install the methods in myself. The trait composition only install the method if it is needed."
	selectors := self traitComposition selectors reject: [ :e | (self localMethodDict includesKey: e) ].
	selectors do: [ :e | modified := modified | (self traitComposition installSelector: e into: self replacing: false)].

	"3. I handle the methods that I have and they are no more in the traitComposition."
	removedSelectors := self methodDict keys reject: [ :aSelector | (selectors includes: aSelector) or: [ self localMethodDict includesKey: aSelector] ].
	modified := modified | (removedSelectors isNotEmpty).
	removedSelectors do: [ :aSelector | self methodDict removeKey: aSelector ].

	"4. Finally, I remove these methods from my class organization"
	removeFromOrganization := self organization allMethodSelectors reject: [:e | self methodDict includesKey: e ].
	removeFromOrganization do: [ :aSelector | self organization removeElement: aSelector ].

	^ modified
]

{ #category : #testing }
GncPoorlySerialized class >> findOriginClassOf: aMethod [

	"I return the myself or the trait that has the original implementation of a method.
	If the method is an alias, the returned class includes the original aliased method"

	(aMethod hasProperty: #traitSource)
		ifTrue: [ ^ aMethod traitSource innerClass ].

	(self includesLocalSelector: aMethod selector)
		ifTrue: [ ^ self ].

	^ (self traitComposition traitDefining: aMethod selector ifNone: [ ^ self ]) innerClass
]

{ #category : #testing }
GncPoorlySerialized class >> findOriginMethodOf: aMethod [

	"I return the original method for a aMethod.
	If this is a local method, the original method is itself.
	If it cames from a trait composition I look for the method in the trait composition.
	First I try with the trait stored in the traitSource.
	If it is an aliased or conflicting method, the method is look up in the whole trait composition"

	(self includesLocalSelector: aMethod selector)
		ifTrue: [ ^ aMethod ].

	(aMethod hasProperty: #traitSource)
		ifTrue: [ |newSelector|
			newSelector := self traitComposition originSelectorOf: aMethod selector.
			^ aMethod traitSource compiledMethodAt: newSelector ifAbsent: [aMethod] ].

	^ (self traitComposition traitDefining: aMethod selector ifNone: [ self ])
		compiledMethodAt: aMethod selector ifAbsent: [ ^ aMethod ]
]

{ #category : #testing }
GncPoorlySerialized class >> hasTraitComposition [

	^ self traitComposition isEmpty not
]

{ #category : #testing }
GncPoorlySerialized class >> includesLocalSelector: aSymbol [
	^ self isLocalSelector: aSymbol
]

{ #category : #testing }
GncPoorlySerialized class >> isAliasSelector: aSymbol [
	"Return true if the selector aSymbol is an alias defined
	in my or in another composition somewhere deeper in
	the tree of traits compositions."

	^ self traitComposition isAliasSelector: aSymbol
]

{ #category : #testing }
GncPoorlySerialized class >> isLocalAliasSelector: aSymbol [
	"Return true if the selector aSymbol is an alias defined
	in my trait composition."

	^ self traitComposition isLocalAliasSelector: aSymbol
]

{ #category : #testing }
GncPoorlySerialized class >> isLocalMethodsProtocol: aProtocol [
	"Checks if the protocol has local selectors"

	aProtocol methodSelectors ifEmpty: [ ^ true ].
	^ aProtocol methodSelectors anySatisfy: [ :each | self isLocalSelector: each ]
]

{ #category : #testing }
GncPoorlySerialized class >> isLocalSelector: aSelector [

	^ self localMethodDict includesKey: aSelector
]

{ #category : #accessing }
GncPoorlySerialized class >> localMethodDict [
	"The local methodDict is in the metaclass. In this way I do not have to recompile the methods during the bootstrap when we don't have a compiler."
	^ self class baseLocalMethods
]

{ #category : #accessing }
GncPoorlySerialized class >> localMethodDict: aMethodDictionary [
	^ self class baseLocalMethods: aMethodDictionary
]

{ #category : #accessing }
GncPoorlySerialized class >> localMethods [
	"returns the methods of classes excluding the ones of the traits that the class uses"

	^ self localMethodDict values
]

{ #category : #'accessing - method dictionary' }
GncPoorlySerialized class >> localSelectors [

	^ self localMethodDict keys
]

{ #category : #'instance creation' }
GncPoorlySerialized class >> new: size [

	| data s |
	s := SingletonFactory new.
	data := (1 to: size) collect: [ :i | s getSingleton ].
	^ self new
		  data: data;
		  yourself
]

{ #category : #'instance creation' }
GncPoorlySerialized class >> new: size with: content [

	| data |
	data := (1 to: size) collect: [ :i | content clone ].
	^ self new
		  data: data;
		  yourself
]

{ #category : #initialization }
GncPoorlySerialized class >> rebuildMethodDictionary [

	"Useful to be rewritten in Traits"
	^ self doRebuildMethodDictionary
]

{ #category : #categories }
GncPoorlySerialized class >> recategorizeSelector: selector from: oldCategory to: newCategory [
	| original |

	"When a method is recategorized I have to classify the method, but also recategorize the aliases pointing to it"

	original := self organization categoryOfElement: selector ifAbsent: [ ^ self ].

	"If it is nil is because it is a removal. It will removed when the method is removed."
	newCategory ifNil: [ ^ self ].

	original = oldCategory
		ifTrue: [ self organization classify: selector under: newCategory suppressIfDefault: true ].

	(self traitComposition reverseAlias: selector) do: [ :e |
		self recategorizeSelector: e from: oldCategory to: newCategory.
		self notifyOfRecategorizedSelector: e from: oldCategory to: newCategory ].

	self organization removeEmptyCategories
]

{ #category : #recompilation }
GncPoorlySerialized class >> recompile: selector from: oldClass [
	"Compile the method associated with selector in the receiver's method dictionary."

	| method newMethod |
	method := oldClass compiledMethodAt: selector.
	newMethod := self compiler
				source: (oldClass sourceCodeAt: selector);
				class: self;
				failBlock: [^ self];
				compiledMethodTrailer: method trailer;
				compile.   "Assume OK after proceed from SyntaxError"
	selector == newMethod selector ifFalse: [self error: 'selector changed!'].

	method properties
		at: #traitSource
		ifPresent: [ :aSource | newMethod propertyAt: #traitSource put: aSource].

	self addSelector: selector withRecompiledMethod: newMethod
]

{ #category : #'trait-composition' }
GncPoorlySerialized class >> removeFromComposition: aTrait [

	self setTraitComposition: (self traitComposition copyWithoutTrait: aTrait asTraitComposition)
]

{ #category : #removing }
GncPoorlySerialized class >> removeFromSystem: logged [

	"When a traited class is removed the traits it is using should be updated"
	| mySubclasses |
	self traitComposition removeUser: self.
	self class traitComposition removeUser: self class.

	TraitedClass removeUser: self class.

	mySubclasses := self subclasses.

	super removeFromSystem: logged.

	"As I am a traited class my subclasses does not have the basic traited class
	methods, so I add them."
	mySubclasses do: [ :each | each class initializeBasicMethods ]
]

{ #category : #removing }
GncPoorlySerialized class >> removeSelector: aSelector [

	"When a selector is removed it should be notified to my users.
	Check the class TraitChange for more details"
	super removeSelector: aSelector.
	self localMethodDict removeKey: aSelector ifAbsent: [  ].

	TraitChange removeSelector: aSelector on: self
]

{ #category : #accessing }
GncPoorlySerialized class >> traitComposition [
	"My trait composition is in my class. So I do not need to recompile the methods when installing them during bootstrap"
	^ self class baseComposition
]

{ #category : #accessing }
GncPoorlySerialized class >> traitComposition: aComposition [

	aComposition asTraitComposition allTraits do: [ :aMaybeTrait |
		aMaybeTrait isTrait ifFalse: [
			self error: 'All the members of the trait composition should be traits' ]].

	self class baseComposition: aComposition
]

{ #category : #accessing }
GncPoorlySerialized class >> traitCompositionString [
	^ self traitComposition asString
]

{ #category : #accessing }
GncPoorlySerialized class >> traitUsers [
	"I am a traited class, I have no users, this is for compatibility with traits"
	^ #()
]

{ #category : #accessing }
GncPoorlySerialized class >> traits [
	^ self traitComposition traits
]

{ #category : #accessing }
GncPoorlySerialized >> data: givenData [
	data := givenData.
]

{ #category : #accessing }
GncPoorlySerialized >> dataSize [

	^ data size
]

{ #category : #'accessing - parameters' }
GncPoorlySerialized >> minBenchTime [

	^ 5
]

{ #category : #'accessing - parameters' }
GncPoorlySerialized >> minNumberOfRuns [

	^ 3
]

{ #category : #accessing }
GncPoorlySerialized >> serializeInto: file [

	FLSerializer serialize: self toFileNamed: file
]
