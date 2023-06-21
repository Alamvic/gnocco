Class {
	#name : #Data,
	#superclass : #Object,
	#type : #variable,
	#traits : 'TBenchmarkable',
	#classTraits : 'TBenchmarkable classTrait',
	#instVars : [
		'data',
		'nodes',
		'canvas',
		'nbEdges'
	],
	#category : #Gnocco
}

{ #category : #'instance creation' }
Data class >> fuzz [

	^ self fuzz: 20 "Why 20? Why not... :|"
]

{ #category : #'instance creation' }
Data class >> fuzz: cost [

	| input data |
	input := StonGrammar new generateWithMaxCost: cost.
	data := STON reader
		        on: input readStream;
		        next.
	^ self with: data
]

{ #category : #'instance creation' }
Data class >> fuzz: nbFuzz from: minCost to: maxCost [

	| input output stuff result |
	input := Array new: nbFuzz.
	output := Array new: nbFuzz.
	1 to: nbFuzz do: [ :i |
		stuff := self fuzz: (minCost to: maxCost) atRandom.
		result := stuff benchIntoFile: 'hello.fuel'.
		input at: i put: result key.
		output at: i put: result value ].
	^ BenchResult new given: input itProduces: output
]

{ #category : #'instance creation' }
Data class >> with: objects [

	^ self new with: objects
]

{ #category : #'as yet unclassified' }
Data >> dataSize [

	^ self nbNodes + self nbEdges
]

{ #category : #'as yet unclassified' }
Data >> ensureCanvasIsBuilt [

	| graphNodes eb |
	canvas ifNil: [
		graphNodes := nodes
			              collect: [ :m |
				              RSLabel new
									  text: m className;
					              model: m ]
			              as: RSGroup.
		canvas := RSCanvas new.
		canvas addAll: graphNodes.

		eb := RSEdgeBuilder arrowedLine.
		eb moveBehind.
		eb shape color: Color gray.
		eb withBorderAttachPoint.
		eb canvas: canvas.
		eb connectToAll: [ :x | x ].
		RSCircleLayout on: graphNodes.
		canvas edges do: #withBorder.
		canvas edges @ RSHighlightable red.
		canvas nodes @ RSHighlightable red withOutgoingEdges.

		canvas @ RSCanvasController ].
]

{ #category : #'instance creation' }
Data >> inspectGraph [

	<inspectorPresentationOrder: 0 title: 'Graph'>
	self ensureCanvasIsBuilt.
	^ SpRoassal3InspectorPresenter new
		  canvas: canvas;
		  yourself
]

{ #category : #'instance creation' }
Data >> minNumberOfRuns [

	^ 1
]

{ #category : #'instance creation' }
Data >> nbEdges [

	^ nbEdges
]

{ #category : #'instance creation' }
Data >> nbNodes [

	^ nodes size
]

{ #category : #'instance creation' }
Data >> nodes [

	^ nodes
]

{ #category : #'instance creation' }
Data >> serializeInto: file [

	FLSerializer serialize: data toFileNamed: file
]

{ #category : #'instance creation' }
Data >> with: objects [

	| seen boundary current |
	data := objects.
	nodes := OrderedCollection new.
	nbEdges := 0.
	seen := Set with: data.
	boundary := OrderedCollection with: data.
	[ boundary isNotEmpty ] whileTrue: [
		current := boundary removeLast.
		nodes add: current.
		nbEdges := nbEdges + current size.
		current
			select: [ :next | (seen includes: next) not ]
			thenDo: [ :next |
				seen add: next.
				boundary add: next.
				nodes add: next ] ]
]
