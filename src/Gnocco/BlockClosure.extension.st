Extension { #name : #BlockClosure }

{ #category : #'*Gnocco' }
BlockClosure >> asWeight [

	^ GncComputableWeight newWithWeight: self
]
