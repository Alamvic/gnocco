Class {
	#name : #BenchResult,
	#superclass : #Object,
	#instVars : [
		'inData',
		'outData',
		'plot'
	],
	#category : #Gnocco
}

{ #category : #'as yet unclassified' }
BenchResult >> dumpAt: file [
	| fileStream |
	fileStream := (FileSystem disk workingDirectory / file) writeStream.
	inData
		with: outData
		do:  [ :size :time |
			fileStream 
				<< size printString;
				<< ',';
				<< time asFloat printString;
				<< OSPlatform current lineEnding ].
	fileStream close.
]

{ #category : #'as yet unclassified' }
BenchResult >> ensurePlotIsBuilt [

	plot ifNil: [
		plot := self plot.
		plot build ]
]

{ #category : #'as yet unclassified' }
BenchResult >> given: input itProduces: output [
	inData := input.
	outData := output.
]

{ #category : #'as yet unclassified' }
BenchResult >> inspectorPlot [

	<inspectorPresentationOrder: 0 title: 'Results'>
	self ensurePlotIsBuilt.
	^ SpRoassal3InspectorPresenter new
		  canvas: plot canvas;
		  yourself
]

{ #category : #'as yet unclassified' }
BenchResult >> plot [

	| chart lineaxes |
	chart := RSChart new.
	lineaxes := RSScatterPlot new.
	lineaxes x: inData y: outData.
	chart addPlot: lineaxes.
	chart addDecoration: RSVerticalTick new.
	chart addDecoration: (RSXLabelDecoration new
			 title: 'Size (arbitrary unit)';
			 fontSize: 12).
	chart addDecoration: (RSYLabelDecoration new
			 title: 'Time (ms)';
			 fontSize: 12).
	chart addDecoration: RSHorizontalTick new.
	^ chart
]
