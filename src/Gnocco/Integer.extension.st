Extension { #name : #Integer }

{ #category : #'*Gnocco' }
Integer >> asWeight [

	^ GncParametricWeight newWithWeight: self
]

{ #category : #'*Gnocco' }
Integer >> isFinite [

	^ true
]
