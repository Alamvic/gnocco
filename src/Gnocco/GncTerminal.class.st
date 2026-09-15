Class {
	#name : 'GncTerminal',
	#superclass : 'GncFragment',
	#category : 'Gnocco-Grammar',
	#package : 'Gnocco',
	#tag : 'Grammar'
}

{ #category : 'translating' }
GncTerminal >> aMCTSValue [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
GncTerminal >> generateMCTSAst: generator level: level [

	^ GncLeaf withToken: self aMCTSValue
]

{ #category : 'testing' }
GncTerminal >> isTerminal [

	^ true
]

{ #category : 'accessing' }
GncTerminal >> minHeight [

	^ 0
]

{ #category : 'accessing' }
GncTerminal >> minSize [

	^ GncLeaf treeSize
]

{ #category : 'accessing' }
GncTerminal >> minimumTree [

	self subclassResponsibility 
]

{ #category : 'parsing' }
GncTerminal >> parse: input from: currentIndex with: generator rule: rule [

	^ generator parseTerminal: self on: input from: currentIndex rule: rule
]

{ #category : 'parsing' }
GncTerminal >> parse: string with: generator [

	^ generator parseTerminal: string from: self
]

{ #category : 'as yet unclassified' }
GncTerminal >> terminals [ 

	^ { self }
]

{ #category : 'accessing' }
GncTerminal >> values [
	
	self subclassResponsibility
]

{ #category : 'accessing' }
GncTerminal >> visit: visitor [

	^ visitor visitTerminal: self
]

{ #category : 'visiting' }
GncTerminal >> visit: visitor level: level [

	^ visitor visitTerminal: self level: level
]
