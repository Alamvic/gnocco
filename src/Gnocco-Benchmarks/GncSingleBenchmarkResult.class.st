Class {
	#name : #GncSingleBenchmarkResult,
	#superclass : #Object,
	#instVars : [
		'time',
		'gctime',
		'dataSize'
	],
	#category : #'Gnocco-Benchmarks-Benchmark Results'
}

{ #category : #accessing }
GncSingleBenchmarkResult >> dataSize [

	^ dataSize
]

{ #category : #accessing }
GncSingleBenchmarkResult >> dataSize: anObject [

	dataSize := anObject
]

{ #category : #accessing }
GncSingleBenchmarkResult >> gctime [

	^ gctime
]

{ #category : #accessing }
GncSingleBenchmarkResult >> gctime: anObject [

	gctime := anObject
]

{ #category : #accessing }
GncSingleBenchmarkResult >> time [

	^ time
]

{ #category : #accessing }
GncSingleBenchmarkResult >> time: anObject [

	time := anObject
]
