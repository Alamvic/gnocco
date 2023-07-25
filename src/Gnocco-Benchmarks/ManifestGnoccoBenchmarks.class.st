"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGnoccoBenchmarks,
	#superclass : #PackageManifest,
	#category : #'Gnocco-Benchmarks-Manifest'
}

{ #category : #'code-critics' }
ManifestGnoccoBenchmarks class >> ruleThreeElementPointRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#GncRegexGrammar)) #'2023-07-24T15:16:32.31375+02:00') )
]
