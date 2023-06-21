Extension { #name : #String }

{ #category : #'*Gnocco' }
String >> asFragment [

	^ GncTerminalLiteral newWithLiteral: self
]
