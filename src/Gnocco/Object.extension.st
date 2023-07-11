Extension { #name : #Object }

{ #category : #'*Gnocco' }
Object >> allVariables [

	| result |
	result := OrderedCollection ofSize:
		          self class allSlots size + self basicSize.
	self allVariablesDo: [ :each | result add: each ].
	^ result asArray
]
