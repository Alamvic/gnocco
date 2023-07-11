Extension { #name : #BlockClosure }

{ #category : #'*Gnocco' }
BlockClosure >> asFragment [

	^ GncTerminalBlock new
		  block: self;
		  yourself
]

{ #category : #'*Gnocco' }
BlockClosure >> asWeight [

	^ GncComputableWeight newWithWeight: self
]
