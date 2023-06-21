"
I am responsible for creating rules of a non terminal in a grammar, that is both seamless,
similar to how production rules are written in the literature, and integrates well with
Pharo.
"
Class {
	#name : #GncRuleMaker,
	#superclass : #Object,
	#instVars : [
		'rule',
		'nonTerminal'
	],
	#category : #'Gnocco-Private'
}

{ #category : #'as yet unclassified' }
GncRuleMaker class >> with: rule in: nonTerminal [

	^ self new rule: rule; nonTerminal: nonTerminal; yourself
]

{ #category : #copying }
GncRuleMaker >> , fragment [

	rule addFragment: fragment.
	^ self
]

{ #category : #copying }
GncRuleMaker >> < preCallback [

	rule pre: preCallback
]

{ #category : #copying }
GncRuleMaker >> > postCallback [

	rule post: postCallback
]

{ #category : #copying }
GncRuleMaker >> @ weight [

	rule weight: weight
]

{ #category : #accessing }
GncRuleMaker >> nonTerminal: aNonTerminal [

	nonTerminal := aNonTerminal
]

{ #category : #accessing }
GncRuleMaker >> rule: aRule [

	rule := aRule
]

{ #category : #copying }
GncRuleMaker >> | fragment [

	rule := nonTerminal newRule.
	^ self , fragment
]
