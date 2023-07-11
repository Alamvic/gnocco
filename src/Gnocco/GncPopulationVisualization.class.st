Class {
	#name : #GncPopulationVisualization,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'population'
	],
	#category : #'Gnocco-Genetic Optimization'
}

{ #category : #'accessing - defaults' }
GncPopulationVisualization >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #accessing }
GncPopulationVisualization >> population: aGncPopulation [ 
	population := aGncPopulation
]

{ #category : #hooks }
GncPopulationVisualization >> prepareData [

	^ population scores
]

{ #category : #hooks }
GncPopulationVisualization >> renderIn: aCanvas [

	| chart boxPlot y max linePlot |
	y := self prepareData.
	max := y collect: [ :group | group max ].

	chart := RSChart new.
	chart container: aCanvas.
	boxPlot := RSBoxPlot new y: y.
	linePlot := RSLinePlot y: max.

	chart add: boxPlot.
	chart add: linePlot.
	chart horizontalTick
		integer;
		doNotUseNiceLabel;
		numberOfTicks: 10.
	chart xlabel: 'Generations'.
	chart verticalTick
		integer;
		numberOfTicks: 10.
	chart ylabel: 'Score (higher is better)'.
	chart title: 'Population score over generations'.
	chart build
]
