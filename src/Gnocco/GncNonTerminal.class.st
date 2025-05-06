"
I am a non-terminal in a generative grammar.

I am responsible for generating all nodes of a certain kind in the generated AST.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	name:		<Object>
	rules:		<Object>


    Implementation Points
"
Class {
	#name : #GncNonTerminal,
	#superclass : #GncFragment,
	#instVars : [
		'name',
		'rules',
		'preHook',
		'postHook',
		'minSize',
		'minHeight'
	],
	#category : #'Gnocco-Grammar'
}

{ #category : #construction }
GncNonTerminal class >> withName: aName [

	^ self new name: aName
]

{ #category : #accessing }
GncNonTerminal >> --> fragment [
	"Add a new definition of a non terminal, keeping the old ones."

	| currentRule |
	currentRule := self newRule.
	currentRule addFragment: fragment.
	^ GncRuleMaker with: currentRule in: self
]

{ #category : #accessing }
GncNonTerminal >> ->> fragment [
	"Add new definition of a non terminal, overwriting the previous ones."

	rules := OrderedCollection new.
	^ self --> fragment
]

{ #category : #translating }
GncNonTerminal >> generateAst: generator [

	| result rule |
	preHook ifNotNil: [ preHook value ifNotNil: [ :value | ^ value ] ].

	rule := generator selectRule: rules.
	result := rule visit: generator withSubLevel.
	postHook ifNotNil: [ postHook value: result ].
	^ result.
	
	
]

{ #category : #initialization }
GncNonTerminal >> initialize [
	rules := OrderedCollection new.
	minHeight := Float infinity.
	minSize := Float infinity.
]

{ #category : #accessing }
GncNonTerminal >> minHeight [

	^ minHeight
]

{ #category : #accessing }
GncNonTerminal >> minHeight: cost [

	minHeight := cost
]

{ #category : #accessing }
GncNonTerminal >> minSize [

	^ minSize
]

{ #category : #accessing }
GncNonTerminal >> minSize: size [

	minSize := size
]

{ #category : #accessing }
GncNonTerminal >> name [

	^ name
]

{ #category : #accessing }
GncNonTerminal >> name: string [

	name := string
]

{ #category : #accessing }
GncNonTerminal >> newRule [

	| rule |
	rule := GncRule new.
	rules add: rule.
	^ rule
]

{ #category : #accessing }
GncNonTerminal >> post: postBlock [

	postHook := postBlock
]

{ #category : #accessing }
GncNonTerminal >> postHook [

	^ postHook
]

{ #category : #accessing }
GncNonTerminal >> pre: preBlock [

	preHook := preBlock
]

{ #category : #accessing }
GncNonTerminal >> preHook [

	^ preHook
]

{ #category : #printing }
GncNonTerminal >> printNameOn: stream [

	^ stream << name
]

{ #category : #printing }
GncNonTerminal >> printOn: stream [

	| first |
	stream
		<< name;
		<< ' (h=';
		print: self minHeight;
		<< ',s=';
		print: self minSize;
		<< ')';
		<< OSPlatform current lineEnding.
	first := true.
	rules do: [ :rule |
		stream << '  '.
		first
			ifTrue: [ stream << '--> ' ]
			ifFalse: [ stream << '  | ' ].
		first := false.
		stream
			print: rule;
			<< OSPlatform current lineEnding ]
]

{ #category : #accessing }
GncNonTerminal >> rule: rule [
	rules add: (GncRule newWithFragments: rule)
]

{ #category : #private }
GncNonTerminal >> rules [

	^ rules
]

{ #category : #private }
GncNonTerminal >> seal [

	rules do: [ :rule | rule seal ]
]

{ #category : #accessing }
GncNonTerminal >> visit: visitor [

	^ visitor visitNonTerminal: self
]
