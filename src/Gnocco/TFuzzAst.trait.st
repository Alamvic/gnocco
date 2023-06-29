"
I represent classes that have the ability to ""fuzz"" (ie. randomly generate) Abstract Syntax Trees (a `GncAST`).
The only method required to be implemented is `generateAstWithMaxCost: maxCost`, where `maxCost` is the maximum height of the generated tree.

Note that using this trait automatically provides the `TFuzzText` trait, because the generated AST is assumed to use `TFuzzText`.
"
Trait {
	#name : #TFuzzAst,
	#classTraits : 'TFuzzText classTrait',
	#category : #'Gnocco-AST'
}

{ #category : #translating }
TFuzzAst >> generate: generator [

	^ String streamContents: [ :stream |
		  (self generateAst: generator) generateInto: stream ]
]

{ #category : #translating }
TFuzzAst >> generateAst: generator [

	^ self explicitRequirement
]
