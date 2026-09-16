Class {
	#name : 'GncGenericGrammarParserTest',
	#superclass : 'TestCase',
	#category : 'Gnocco-Grammar',
	#package : 'Gnocco',
	#tag : 'Grammar'
}

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseArithExpr01 [

	| node input |

	input := '1(2*3)'.
	node := GncGenericGrammarParser parse: input from: AritExpressionGrammar new.
	
	self assert: node equals: nil
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseCsv01 [

	| node input |

	input := 'id,first_name,last_name,email,gender,n
1,Jeannine,Sutehall,jsutehall@lulu.com,Female,250
2,Lynnette,Pashbee,lpashbee@blogger.com,Female,380
3,Garrick,Fontell,gfontell@sitemeter.com,Male,412
4,Osbert,O''Henecan,oohenecan@senate.gov,Male,242
5,Doug,Vieyra,dvieyra@chronoengine.com,Genderfluid,525'.
	node := GncGenericGrammarParser parse: input from: CSVGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseJsonObject01 [

	| node |

	node := GncGenericGrammarParser parse: '4' from: JSONGrammar new.
	
	self assert: node generate equals: '4'
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseJsonObject02 [

	| node |

	node := GncGenericGrammarParser parse: '{}' from: JSONGrammar new.
	
	self assert: node generate equals: '{}' 
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseJsonObject03 [

	| node |

	node := GncGenericGrammarParser parse: '[]' from: JSONGrammar new.
	
	self assert: node generate equals: '[]'
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseJsonObject04 [

	| node |

	node := GncGenericGrammarParser parse: 'true' from: JSONGrammar new.
	
	self assert: node generate equals: 'true'
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseJsonObject05 [

	| node |

	node := GncGenericGrammarParser parse: '[42,true]' from: JSONGrammar new.
	self assert: node generate equals: '[42,true]'
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseJsonObject06 [

	| node json |

	json := '{"n":true,"n":true,"x":6}'.
	node := GncGenericGrammarParser parse: json from: JSONGrammar new.
	
	self assert: node generate equals: json
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseMarkdown01 [

	| node input |

	input := '# Header'.
	node := GncGenericGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseMarkdown02 [

	| node input |

	input := '# Header', Character cr asString, '# This is a line comment'.
	node := GncGenericGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseMarkdown03 [

	| node input |

	input := '# Header
** This is a line comment **'.
	node := GncGenericGrammarParser parse: input from: MarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseMarkdown04 [

	| node input |

	input := '# Header
** This is a line comment **'.
	node := GncGenericGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseMarkdown05 [

	| node input |

	input := '# Header
	** This is a line comment **
	
	```
	code
	```
   
   	![Pharo is cool](http://pharo.org)
	
   	- list
   	1. ordered list 

  	`in text` and for Pharo hyperlinks to class, method and package: 
  	`Point`, `Point class`, `Point>>#setX:setY:`, `#’Microdown-Tests’`

  	References: @ref@'.
	node := GncGenericGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseMarkdown06 [

	| node input |

	input := '```  ```'.
	node := GncGenericGrammarParser parse: input from: ExtendedMarkdownGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseRegex01 [

	| node input |

	input := 'b?ab?b?b?(ac?ab?(aca((ac))?|b)?a|c)?c?'.
	node := GncGenericGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseRegex02 [

	| node input |

	input := 'aa*a*..*.+(.+.?(.?.*((.b.b.aab)a|)a*))+a'.
	node := GncGenericGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseRegex03 [

	| node input |

	input := '(a|a|a|a|a|a|c)+a?a+.(a)+(a+a+a+(a)+a)b'.
	node := GncGenericGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseRegex04 [

	| node input |

	input := 'a+(a+a.?(a*.*a?a*a*b?.*aa?a+|a)+a.a)....a'.
	node := GncGenericGrammarParser parse: input from: GncRegexGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseRegexN [

	| inputs |
	inputs := { 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'.
	          'ac?ab?ab|.b?aa.?aaab?c?a(ca)?ac?aaab?a?a'.
	          'ac?ab?ab?b?aa.?aaab?c?a(c)?abc?aa*ab?a?a'.
	          'ac?ab?ab?ab?aa.?aaa*b?c?a(c)?ac?aacb?a?a'.
	          'ac?ab?ab?ab?aa.?aaa*b?c?a(c)?cc?aacb?a?a'.
	          'ac?aa?ab?ab?aa.?aaa*b?c?a(c)?ac?aaca+a?a'.
	          'ac?aa?ab?ab?aa.?aaa*a?c?a(c)?ac?aaca?a?a'.
	          'ac?aa+ab?ab?aa.?aaa*a?c?a(c).accaaca?a?a'.
	          'ac?aa?ab?ab?aa.?aaa*a?a?a(c)?aa?aa+a?a?a'.
	          'ac.aa?ab?ab?aa.?aaa*a?c?a(c)?ac+aaca?a?a'.
	          'ac?aa?aa?.b?aa.?aaa*a?a?a(c)?aa?aa+a?a?a'.
	          'ac?aa?aa?.b?aa.?aaa*a?a?b(.)?aa?aa+a?a?a'.
	          'a.?aa?aa|.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?a'.
	          'ac?aaaab?ab?aa.?aaa*a?c?a(c)?a.+aaca?a?a'.
	          'a.?aa?aa|.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?b'.
	          'ac?aaaaa?.c?aa.?aaa*a?a?a(c)?aa?aa+aaa?a'.
	          'a.?aabaa|.b?aa.?aaa*a?aba(c)?aa?|a+a?a?a'.
	          'ac?aaaaa?.c?aa.?aaa*a?a?a(c)*aa?ab+aaa?a'.
	          'ac?aaaaa?.c?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaaaa?.a?aa.?caa*a?a+a(c)aaa?aa+aaa?a'.
	          'ac?aaa+a?.c?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?c*a+a?.c?aa.?aaa*a?a+a(c)?aa?aa+aaaba'.
	          'aa?aaa+a?.c+aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa+aa.c?aa.?aaa*a?a+a(c)?aa?aa+aca?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?a'.
	          'ac?aaa+a?.c?aa.?aca*a?a|a(c)?aa?aa+aaa?a'.
	          'ac?aaa+a?.c?aa.caaa*a?a.a(c)?aaaaa+aaa?a'.
	          'ac?aaa?a?.c?aa.?aaa.a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa+a?.c?aa.?aaa*a?a+c(c).aa?aa+aaa|a'.
	          'ac?aaa+a?.c?aa.?aaa*a?a+a(c)?aa?ac+aba?a'.
	          'ac?aaa+a?.c?aa.?aaaaa?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa+a?.c?aaa?aaa*a?a?a(c)?aa?aa?aaa?a'.
	          'ac?aaa+a|.c?aa.?aaa*a?a+a(c)?aa?aaaaaa?a'.
	          'ac?aaa+a?.c?aa.?aab*aaa+a(c)?aa?aa+aaa?a'.
	          'a.?aa.aaa.b?aa.?aac*a?a?a(c)?aa?|a+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?a*c|a+a?a|a'.
	          'ac?aa.+a?ac?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaa?a?.c?aa.?aaa*a?a+a(c)?aa?aa+aba?a'.
	          'ac?aaaaa|bc?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac?aaacac.c?aa.?aaa*a?a+a(c)?aa?aacaaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a|a?a(c)?aa?|a*a|a?a'.
	          'ac?aaa+a?.c?aa.aaaaca?a+a(c)?aabaa+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?.?a(c)?aa?|aaa?aaa'.
	          'ac?aaa+a?.c*aa.?aaaaa?a+|(c)?aa?aa+aaa?a'.
	          'ac?aaaba?bc?aa.?aaa*a?a+a(c)?aa?aa+aaa?a'.
	          'ac*aaa+a?.c?aa.?aaa*a?aca(c)?aaaaa+aaa?a'.
	          'ac.aaa+a?.c?aa.?a+a*a?a+a(c)?aa.aa+aaa?a'.
	          'ac.aaa+a?.c?aa.?a+a*a?a+a(c)?aaaaa+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?aa?|a+c?a?a'.
	          'ac.aaa+a?.c?aa.?a+a*a?a+a(c)?aa.aa+a+a?a'.
	          'a(.aaa+a?.c?a|.?a+a*a?a+a(c)?aa.aa+aaa)a'.
	          'ac.aaa+a?.c?aa.?a+a(a?a)a(c)?aa.aa+aaa?a'.
	          'ac.a+a+a?.c?aa.?.+a*a?a+a(c)?aa.aa+aaa?a'.
	          'ab.a+a+a?.c?aa.?.+a*a?a+a(c)?aa.aa+caa?a'.
	          'ac.a+a.a?.c?aa.?.+a*a?a+a(c)?aa.|a+a*a?a'.
	          'ac.a+b+a?.c?aa.?.+a*a?a+a(a)?aa.?a+aaa?a'.
	          'ac.a+a+a?.c?aa.?.+a*a?a+a(c)*aa.aa+aaa?a'.
	          'a.?aa?aa+.b?aa.?aaa*a?a?a(c)+ab?|a+a?a?a'.
	          'ac.a+.+a?.c?aa...+a*a?a+a(c)baa.aa+aaa?a'.
	          'ac.a+a+a?.c?aa.?.ba*a?a+a(a)?aa.aa+baa?a'.
	          'ac.aca+a?.c?aa.?.+a*aac+a(c)?aa.aa+aaa?a'.
	          'ac.a+a+a..c?aa.?.+a*a?a+a(c)?aa.aa+aaa?a'.
	          'a.?aa?aaa.b?aa.?aaa*a?a?a(c)?aa?|a+a?.aa'.
	          'a.?aa?aaa.c?aa.?aaa+a?a?a(c)?aa?|a+a?a?a'.
	          'ab.a+a+a?.c+aa.?.+a*a?a+a(c)?aa.aa+aaa?a'.
	          'ac?aa?aaa.b?aa.?aaa+a?a?a(c)?aa?|a+a?a?a'.
	          'a.?aa?baa.b?aa.?aaa*a?a?a(c)?aa?|a+a?a?a'.
	          'ac.a+a+a?.c?aa.?.+a*a?a+a(c)?aa.aa+a|a?|'.
	          'aa.a+a+a?.c?a+.?.ca*a?a+a(c)?aa.aa+aaa?a'.
	          'ac.a+a+c?.c?aa.?.+a*.?a+a(c)?aa.aa+aaa?a'.
	          'ac.a(a+a?.c?a|.?.+a*a?)+a(c)?aa.aa+aaa?a'.
	          'ac.a(a+aa.c?a|a?.+a*a?)+a(c)?aa.aa+aaa?a' }.

	inputs do: [ :input |
			| node |
			node := GncGenericGrammarParser parse: input from: GncRegexGrammar new.
			self assert: node generate equals: input ]
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseSvgPath01 [

| node input |
	input := 'M797,632.3v100.1c0,44.2-15.7,82.2-47.5,113.5c-31.3,31.9-69.4,47.6-113.5,47.6H171.1c-44.2,0-82.2-15.7-114.1-47.6c-31.3-31.3-47-69.4-47-113.5V267.6c0-44.2,15.7-82.2,47-113.5c31.9-31.9,69.9-47.5,114.1-47.5h393.8c9.5,0,17.3,7.3,17.3,17.9v35.8c0,10.6-7.8,17.9-17.3,17.9H171.1c-24.6,0-45.9,9-63.2,26.3c-17.3,17.3-26.3,38.6-26.3,63.2v464.8c0,24.6,9,45.9,26.3,63.2c17.3,17.3,38.6,26.3,63.2,26.3h464.8c24.6,0,45.9-9,63.2-26.3c17.3-17.3,26.3-38.6,26.3-63.2V632.3c0-10.6,7.3-17.3,17.9-17.3h35.8C789.7,614.9,797,621.7,797,632.3L797,632.3z M983.3,350.4L800.4,532.7c-14.5,15.7-38,3.4-38-15.7v-91.2h-80.5c-23.5,0-54.3,1.1-92.9,2.8c-38.6,1.7-76.6,8.4-114.7,19.6c-37.5,11.2-67.7,24-90.6,38.6c-22.4,14.5-38,29.1-47.5,43.6c-9,14-16.8,33-24.1,56.5c-7.3,23.5-10.6,47-10.6,71c0,12.9,0.6,28,1.7,44.2c0,2.8,1.7,13.4,1.7,17.9c0,6.7-4.5,12.3-11.2,12.3c-4.5,0-7.8-2.2-10.1-6.2c-3.9-5-10.1-20.7-13.4-26.8c-30.2-67.7-39.7-137-28-207.5c6.2-48.7,31.3-95.7,76.1-140.4C390.9,279.3,512.3,243,681.8,243h80.5v-91.7c0-19.6,23.5-30.8,38-16.2l182.9,182.9C992.2,327.4,992.2,341.4,983.3,350.4z'.
	node := GncGenericGrammarParser parse: input from: SvgPathGrammar new.
	
	self assert: node generate equals: input
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseSvgPath02 [

	| input node |
	
	input := 'm 1,2L 1 2'.
	
	node := GncGenericGrammarParser parse: input from: SvgPathGrammar new. 
	self assert: node generate equals: input. 
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseSvgPath03 [

	| input node |
	
	input := 'm1,2L 2-2 2-2'.
	
	node := GncGenericGrammarParser parse: input from: SvgPathGrammar new. 
	self assert: node generate equals: input. 
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseSvgPath04 [

	| input node |
	
	input := 'm1,3L,16,95'.
	
	node := GncGenericGrammarParser parse: input from: SvgPathGrammar new. 
	self assert: node generate equals: input. 
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseSvgPathCheckingOnlyOneRoot [

| node input |
	input := 'm-.99,-.4,7-93.,03-.8'.
	node := GncGenericGrammarParser parse: input from: SvgPathGrammar new.
	
	self
		assert: (node allNodes allButFirst collect: #root) asSet size
		equals: 1
]

{ #category : 'tests' }
GncGenericGrammarParserTest >> testParseSvgPathN [

	| inputs |
	
	inputs := {
	'M797,632.3v100.1c0,44.2-15.7,82.2-47.5,113.5c-31.3,31.9-69.4,47.6-113.5,47.6H171.1c-44.2,0-82.2-15.7-114.1-47.6c-31.3-31.3-47-69.4-47-113.5V267.6c0-44.2,15.7-82.2,47-113.5c31.9-31.9,69.9-47.5,114.1-47.5h393.8c9.5,0,17.3,7.3,17.3,17.9v35.8c0,10.6-7.8,17.9-17.3,17.9H171.1c-24.6,0-45.9,9-63.2,26.3c-17.3,17.3-26.3,38.6-26.3,63.2v464.8c0,24.6,9,45.9,26.3,63.2c17.3,17.3,38.6,26.3,63.2,26.3h464.8c24.6,0,45.9-9,63.2-26.3c17.3-17.3,26.3-38.6,26.3-63.2V632.3c0-10.6,7.3-17.3,17.9-17.3h35.8C789.7,614.9,797,621.7,797,632.3L797,632.3z M983.3,350.4L800.4,532.7c-14.5,15.7-38,3.4-38-15.7v-91.2h-80.5c-23.5,0-54.3,1.1-92.9,2.8c-38.6,1.7-76.6,8.4-114.7,19.6c-37.5,11.2-67.7,24-90.6,38.6c-22.4,14.5-38,29.1-47.5,43.6c-9,14-16.8,33-24.1,56.5c-7.3,23.5-10.6,47-10.6,71c0,12.9,0.6,28,1.7,44.2c0,2.8,1.7,13.4,1.7,17.9c0,6.7-4.5,12.3-11.2,12.3c-4.5,0-7.8-2.2-10.1-6.2c-3.9-5-10.1-20.7-13.4-26.8c-30.2-67.7-39.7-137-28-207.5c6.2-48.7,31.3-95.7,76.1-140.4C390.9,279.3,512.3,243,681.8,243h80.5v-91.7c0-19.6,23.5-30.8,38-16.2l182.9,182.9C992.2,327.4,992.2,341.4,983.3,350.4z' .
	'm-.99,-.4,7-93.,03-.8 -19.9-.2449 7-1742 -269 -747L -5 16.-132 2L1.04-55.9' 
	}.
	
	inputs do: [ :input | | node |
			node := GncGenericGrammarParser parse: input from: SvgPathGrammar new.
			self assert: node generate equals: input ]
]
