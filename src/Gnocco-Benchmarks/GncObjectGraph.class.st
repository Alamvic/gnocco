"
I am an object graph, as produced by a fuzzing grammar generator like `GncStonGrammar` deserialized
with `STON`.

I hold information about the structure of the produced graph. In particular, you can inspect me to
find neat representations (so to speak) of the data produced.

I can be created with `GncObjectGraph fuzz: graphCost`, where `graphCost` is an upper bound on the
logarithm of the size of the graph (roughly).

Public API and Key Messages

- `GncObjectGraph >> #dataSize`
- `GncObjectGraph >> #nbEdges`
- `GncObjectGraph >> #nbNodes`
- `GncObjectGraph >> #serializeInto: file`
"
Class {
	#name : #GncObjectGraph,
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
	#category : #'Gnocco-Benchmarks'
}

{ #category : #'instance creation' }
GncObjectGraph class >> fuzz [

	^ self fuzz: (GncGrammarGenerator new
			   maxHeightCost: 20;
			   yourself) "Why 20? Why not... :|"
]

{ #category : #'instance creation' }
GncObjectGraph class >> fuzz: generator [

	| input data |
	input := GncStonGrammar new generate: generator.
	data := STON reader
		        on: input readStream;
		        next.
	^ self with: data
]

{ #category : #'instance creation' }
GncObjectGraph class >> fuzz: nbFuzz from: minCost to: maxCost [

	| input output stuff result |
	input := Array new: nbFuzz.
	output := Array new: nbFuzz.
	1 to: nbFuzz do: [ :i |
		stuff := self fuzz: (minCost to: maxCost) atRandom.
		result := stuff benchIntoFile: 'hello.fuel'.
		input at: i put: result key.
		output at: i put: result value ].
	^ GncFullBenchmarkResult new given: input itProduces: output
]

{ #category : #'instance creation' }
GncObjectGraph class >> with: objects [

	^ self new with: objects
]

{ #category : #accessing }
GncObjectGraph >> dataSize [

	^ self nbNodes + self nbEdges
]

{ #category : #'private - lazy initialization' }
GncObjectGraph >> ensureCanvasIsBuilt [

	| graphNodes eb |
	canvas ifNil: [
		graphNodes := nodes
			              collect: [ :m |
				              RSLabel new
									  text: m class name;
					              model: m ]
			              as: RSGroup.
		canvas := RSCanvas new.
		canvas addAll: graphNodes.

		eb := RSEdgeBuilder arrowedLine.
		eb moveBehind.
		eb shape color: Color gray.
		eb withBorderAttachPoint.
		eb canvas: canvas.
		eb connectToAll: #allVariables.
		RSCircleLayout on: graphNodes.
		canvas edges do: #withBorder.
		canvas edges @ RSHighlightable red.
		canvas nodes @ RSHighlightable red withOutgoingEdges.

		canvas @ RSCanvasController ].
]

{ #category : #inspector }
GncObjectGraph >> inspectGraph [

	<inspectorPresentationOrder: 0 title: 'Graph'>
	self ensureCanvasIsBuilt.
	^ SpRoassal3InspectorPresenter new
		  canvas: canvas;
		  yourself
]

{ #category : #'accessing - parameters' }
GncObjectGraph >> minNumberOfRuns [

	^ 1
]

{ #category : #'instance creation' }
GncObjectGraph >> nbEdges [

	^ nbEdges
]

{ #category : #'instance creation' }
GncObjectGraph >> nbNodes [

	^ nodes size
]

{ #category : #'instance creation' }
GncObjectGraph >> nodes [

	^ nodes
]

{ #category : #'instance creation' }
GncObjectGraph >> serializeIntoStream: stream [

	FLSerializer serialize: data on: stream
]

{ #category : #'instance creation' }
GncObjectGraph >> with: objects [

	| seen boundary current |
	data := objects.
	nodes := OrderedCollection new.
	nbEdges := 0.
	seen := Set with: data.
	boundary := OrderedCollection with: data.
	[ boundary isNotEmpty ] whileTrue: [
		| neighbours |
		current := boundary removeLast.
		nodes add: current.
		neighbours := current allVariables.
		nbEdges := nbEdges + neighbours size.
		neighbours
			select: [ :next | (seen includes: next) not ]
			thenDo: [ :next |
				seen add: next.
				boundary add: next.
				nodes add: next ] ]
]
