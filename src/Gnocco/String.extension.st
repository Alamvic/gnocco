Extension { #name : #String }

{ #category : #'*Gnocco' }
String >> asFragment [

	^ TerminalLiteral newWithLiteral: self
]
