Class {
	#name : #BaselineOfGnocco,
	#superclass : #BaselineOf,
	#category : #BaselineOfGnocco
}

{ #category : #baseline }
BaselineOfGnocco >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'Gnocco';
			package: 'Gnocco-Benchmarks'
				with: [ spec requires: #( 'Gnocco' ) ];
			package: 'Gnocco-GeneticMutation'
				with: [ spec requires: #( 'Gnocco-Benchmarks' ) ];
			package: 'Gnocco-Tests' with: [ spec requires: #( 'Gnocco' ) ];
			group: 'default'
				with: #( 'Gnocco' 'Gnocco-Tests' ) ]
]
