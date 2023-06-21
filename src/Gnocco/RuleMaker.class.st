Class {
	#name : #RuleMaker,
	#superclass : #Object,
	#instVars : [
		'rule',
		'nonTerminal'
	],
	#category : #Gnocco
}

{ #category : #'as yet unclassified' }
RuleMaker class >> with: rule in: nonTerminal [

	^ self new rule: rule; nonTerminal: nonTerminal; yourself
]

{ #category : #copying }
RuleMaker >> , fragment [

	rule addFragment: fragment.
	^ self
]

{ #category : #copying }
RuleMaker >> < preCallback [

	rule pre: preCallback
]

{ #category : #copying }
RuleMaker >> > postCallback [

	rule post: postCallback
]

{ #category : #copying }
RuleMaker >> @ weight [

	rule weight: weight
]

{ #category : #accessing }
RuleMaker >> nonTerminal: aNonTerminal [

	nonTerminal := aNonTerminal
]

{ #category : #accessing }
RuleMaker >> rule: aRule [

	rule := aRule
]

{ #category : #copying }
RuleMaker >> | fragment [

	rule := nonTerminal newRule.
	^ self , fragment
]
