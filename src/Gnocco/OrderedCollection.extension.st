Extension { #name : #OrderedCollection }

{ #category : #'*Gnocco' }
OrderedCollection >> swapRemoveAt: index [
	"Remove the element at index `index` in contant time, and answer it. Does not preserve the order."

	self swap: index with: self size.
	^ self removeLast
]
