"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGnocco,
	#superclass : #PackageManifest,
	#category : #'Gnocco-Manifest'
}

{ #category : #'code-critics' }
ManifestGnocco class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#GncRule #weight #false)) #'2023-06-21T16:39:20.507684+02:00') )
]

{ #category : #'code-critics' }
ManifestGnocco class >> ruleEmptyExceptionHandlerRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'SingletonFactory class' #clearAll #true)) #'2023-06-16T16:17:15.694661+02:00') #(#(#RGMethodDefinition #(#GncObjectGraph #with: #false)) #'2023-06-20T09:20:27.940313+02:00') )
]

{ #category : #'code-critics' }
ManifestGnocco class >> ruleEqualNotUsedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#GncPhoneGrammar #defineGrammar #false)) #'2023-06-19T13:45:12.039781+02:00') #(#(#RGMethodDefinition #(#GncStonGrammar #defineGrammar #false)) #'2023-06-19T14:53:00.14885+02:00') )
]

{ #category : #'code-critics' }
ManifestGnocco class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#Gnocco)) #'2023-06-22T09:49:08.935871+02:00') )
]

{ #category : #'code-critics' }
ManifestGnocco class >> ruleSelfSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SingletonFactory #getSingletonClass: #false)) #'2023-06-16T11:24:34.723509+02:00') )
]

{ #category : #'code-critics' }
ManifestGnocco class >> ruleThreeElementPointRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#GncWeightedExpressionGrammar #defineGrammar #false)) #'2023-06-19T13:11:23.04342+02:00') #(#(#RGMethodDefinition #(#GncStonGrammar #defineGrammar #false)) #'2023-06-19T15:53:00.368699+02:00') )
]

{ #category : #'code-critics' }
ManifestGnocco class >> ruleToDoCollectRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'GncObjectGraph class' #fuzz:from:to: #true)) #'2023-06-23T09:37:50.947666+02:00') )
]

{ #category : #'code-critics' }
ManifestGnocco class >> ruleUnaryAccessingMethodWithoutReturnRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'SingletonFactory class' #clearAll #true)) #'2023-06-16T16:17:21.083052+02:00') #(#(#RGMethodDefinition #(#GncNonTerminal #seal #false)) #'2023-06-19T09:56:47.606384+02:00') #(#(#RGMethodDefinition #(#GncTerminal #computeCost #false)) #'2023-06-19T12:13:02.266643+02:00') #(#(#RGMethodDefinition #(#GncNonTerminal #computeCost #false)) #'2023-06-19T12:13:24.383547+02:00') #(#(#RGMethodDefinition #(#ListOfFragments #computeCost #false)) #'2023-06-19T14:10:58.321598+02:00') )
]
