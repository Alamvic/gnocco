```text
   ____    _   _     U  ___ u   ____    ____   U  ___ u 
U /"___|u | \ |"|     \/"_ \/U /"___|U /"___|   \/"_ \/ 
\| |  _ /<|  \| |>    | | | |\| | u  \| | u     | | | | 
 | |_| | U| |\  |u.-,_| |_| | | |/__  | |/__.-,_| |_| | 
  \____|  |_| \_|  \_)-\___/   \____|  \____|\_)-\___/
  _)(|_   ||   \\,-.    \\    _// \\  _// \\      \\
 (__)__)  (_")  (_/    (__)  (__)(__)(__)(__)    (__)
```

Gnocco is a generative grammar library. It allows creating [generative (context-free) grammars](https://en.wikipedia.org/wiki/Generative_grammar).

You can find here a quick tour of Gnocco features. To get started as quickly as possible, you should read [*Defining grammars*](#defining-grammars),
to understand how to create grammars, and [*Generators*](#generators), to be able to use the defined grammar to produce things.

If you don't know what a generative grammar is, or you need a quick brush-up, you can read [*What are generative grammars?*](#what-are-generative-grammars?)
Otherwise, you can skip directly to [*Defining grammars*](#defining-grammars).

# What are generative grammars?

Generative grammars are a kind of rewriting system: their goal is to produce strings by successively rewriting intermidiate strings. Strings are
composed of symbols, which can either be terminals or non-terminals. As their name implies, terminal symbols are symbols that are not going to be 
rewritten anymore. Once they have been produced, they will remain as is until the end of the rewriting procedures. Non-terminals, on the other hand,
*have* to be rewritten to something else before the rewriting system halts.

A generative grammar also contains the rules that are used to rewrite non-terminals. Such a rule is of the form `A → α_1 … α_n`, where `A` is the
non-terminal that should be replaced, and `α_1` through `α_n` are what replaces `A` once the rule is applied. They are called the rule fragments.
They can be either terminals or non-terminals.

A generative grammar starts with a string that contains a single non-terminal, called the *starting non-terminal* (specified in the grammar), and
applies rules in any order until the string contains no non-terminals anymore.

# Defining grammars

## Grammars

In Gnocco, grammars are subclasses of `GncGrammar`. You can simply subclass `GncGrammar` directly, if you are working on simple grammars, or if
you are working on a single grammar. But, despite the DSL, Gnocco works like the rest of the Pharo system. Grammars can be subclassed themselves
to produce more involved grammar hierarchies, or even define pieces of grammars in traits.

Gnocco will also check that, when a grammar is instanciated, you didn't forget any crucial part, or accidentally produced useless grammars or
pieces of grammars. It will raise an exception, for instance, if no string can ever be generated from your grammar, or if, after some rewritings,
no string can ever be generated anymore. For instance, for the grammar `A → a`, `A → B` and `B → B` with start symbol `A`, and assuming `a` is
a terminal symbol, Gnocco will raise an error telling you that, if it ever expands `A` using the second rule, then it will never end. For more
details, refer to the [*Generators* section](#generators).

The definition of the rules is done by the method `defineGrammar`, that should be implemented by the user. It also returns the starting 
non-terminal.

## Non-terminals 

The non-terminals of the grammars are the instance variables whose name starts with `nt`. You never need to instanciate them: Gnocco will take
care of that for you. Instead, you should use the DSL Gnocco provides you to define the rules bound to each non-terminal. In fact, the suggested
workflow is to start defining the rules, naming non-terminals that haven't been defined yet, then saving and letting Pharo create instance 
variables with these names for you. Since Gnocco will also warn you if you have forgotten to define the rules of a certain non-terminal, you have
immediate feedback and writing the grammar can be done in a single pass.

The production rules are defined in the method `defineGrammar`. For each non-terminal `A`, and for each rule `A → α_1 … α_n`, a corresponding 
rule is defined in `defineGrammar`:
```smalltalk
MyGrammar>> defineGrammar

   ntA --> α_1, …, α_n.
```
As a convenience, rules which share the same left-hand side (ie. that expand the same non-terminal) can be accumulated without repeating the
left-hand side using the `|` operator. If we have two rules `A → α_1 … α_n` and `A → β_1 … β_m`, they can be written as
```smalltalk
MyGrammar>> defineGrammar

    ntA --> α_1, ..., α_n
          | β_1, ..., β_m.
```
You can add as many rules as you want this way.

Note that `-->` will *add* the rules to the non-terminal. If, instead, you wish define the rules in place of those already defined, you can
use `->>`. This is useful if you have inherited a non-terminal from an other grammar, and want to change its behavior.

## Fragments

The right-hand side of a rule is a concatenation of *fragments*, separated with `,`. There are four predefined kind of fragments, but others can
be added if needed. Once a rule `A --> α_1, …, α_n` is used to expand `A`, all the fragments are, in turn, expanded.

### Non-terminals

A non-terminal `B` is a fragment, and is expanded exactly as explained above: a rule `B --> β_1, …, β_m` is chosen, `B` gets replaced by the
right-hand side of the rule, and each fragment is in turn expanded. For more information about how the rule is *chosen*, refer to the
[*Generators* section](#generators).

### Literal strings

A literal string `'a literal'` is a valid fragment. It does not get expanded any further. In the end, only strings remain, and they get concatenated
to retrieve the generated string.

### Character range

A character range `($a-$z)` (the parenthesis are mandatory, think of them as classes in regular expressions `[a-z]`) is a fragment. It gets 
expanded by choosing a character in the range (inclusive on both ends).

### Block

An arbitrary block `[ 'hello' ]` can be used as a fragment. On expansion, it will be executed, and the result (which is expected to be a string)
will be used instead of the fragment.

## Example: a phone number grammar

Let us create a grammar that generates French phone numbers. The grammar should have the following generative rules
```
PhoneNumer → StartBlock ' ' Block ' ' Block ' ' Block ' ' Block
StartBlock → '0' [1-7]
Block → [0-9] [0-9]
```
Let's create a new class for that grammar:
```smalltalk
GncGrammar << #PhoneGrammar
  slots: { #ntPhoneNmber. #ntStartBlock. #ntBlock }
```
note that, for each non terminal, we have created a slot with the same name, but prefixed with `st`.
Now, let us define the generative rules.
```smalltalk
PhoneGrammar >> defineGrammar

  ntPhoneNumber --> ntStartBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock, ' ', ntBlock.
  ntStartBlock --> '0', ($1-$7).
  ntBlock --> ($0-$9), ($0-$9).
  
  "Specify the start symbol"
  ^ ntPhoneNumber
```
*et voilà*, the grammar is already ready to generate some phone numbers!
```smalltalk
PhoneGrammar new generateWithMinCost >>> '04 67 92 39 04'
```
The method `generateWithMinCost` generates a string with a generator whose maximum allowed height is minimal. Please refer

# Generators

Gnocco has a lot of choices to take during the generation of a string: indeed, each time it has to expand a non-terminal, any rule
associated with that non-terminal could be used. Gnocco delegates these choices to a generator object. The generator then takes
into account certain constraints to choose which rule to use.

## Bounding the size of the result

Gnocco provides a strong guarantee about the maximum size of a generated string: it will bound the height of the derivation tree
with the height given as argument, plus the minimum height of a derivation tree. To know more about derivation trees, see
the [*Post-mortem debugging* section](#post-mortem-debugging).

The generator will always only choose rules which may lead to a derivation tree which respects this constraint.

Roughly put, this will bound the logarithm (in *some* base, which depends on the grammar) of the length of the final string.

## Weights

Among all rules which satisfy the above constraint, the generator will select a rule at random, taking into account the weight
of each rule. By default, each rule weighs `1`. The weight of a rule can be set with the `@` operator:
```smalltalk
ntHello --> '25% probability' @ 1
          | '75% probability' @ 3.
```

Weights can even be blocks
```smalltalk
ntHello --> 'hello' @ [ 5 ]
```
This allows disabling a rule if an other rule has not been selected before, for example. Beware, however, of the golden rule
of weights:
**You must not set the weight of a rule to `0` if the height of the minimum derivation tree from that rule is strictly less than
the minimum height of the other rules associated to the same non-terminal!**
Not respecting this rule can (and, most likely, will) break an internal invariant of Gnocco. Gnocco used to have sanity checks
which would point out quite quickly if an invariant had been broken, and why, but for performance reasons these sanity checks
have been removed so you will eventually get a `What?` error if you break that invariant, without further context. You've been
warned!

## Using a generator

Currently, the generator `GncGrammarGenerator` has two parameters you can change: the maximum height of a derivation tree, and
the seed of the random number generator.
```smalltalk
generator := GncGrammarGenerator new
    maxHeightCost: 20;
    seed: 31;
    yourself.
```
Note that a `maxHeightCost` of `0` means the smallest derivation tree possible. Negative costs will not work. The (maximum) size
of a tree will grow exponentially with `maxHeightCost` (the base of the exponential depending on the grammar). Then, to generate
a string, use
```smalltalk
MyGrammar new generate: generator
```

# Debugging a grammar

If you don't understand why a given grammar produces a certain string, Gnocco offers some tools to help you debug it. First of all,
we recommend seeding the generation in development, so that if you generate a string and you'd like to debug the *generation* step,
you can reuse the same seed and reproduce the same generation procedure. That being said, there are two main ways to debug a string
generation. They are complementary, but currently the "post-mortem" way is broken so we recommend using the "live" way.

## Live debugging

It is possible to debug the grammar generation in live, without understanding the nitty details of what Gnocco is doing. To do so,
simply use the Pharo debugger in combination with hooks to trigger a halt at any step in the generation. Almost any step of the
generation can be hooked into. Please refer to the [*Hooking into the generation* section](#hooking-into-the-generation) for more details.

## Post-mortem debugging

Gnocco does *not* keep a string of all the symbols (called a *sentential form*) that it keeps expanding. Instead, it works on a tree:
each inner node of the tree is a non-terminal. Each leaf of the tree is a terminal. The children of a non-terminal are the the right-hand
side of the rule used to expand that non-terminal. This tree is called a *derivation tree*.
Not only this is much more efficient, but it also means that Gnocco keeps a
data structure with a history of everything that happened: which non-terminal was expanded, when, with which rule! In particular,
it allows exploring that happened and how it happened *after* the generation has ended. You just have to ask Gnocco to generate a tree
instead of a string, by calling `generateAst:` instead of `generate:`.

Note that this is currently considered broken: the tree is not inspectable as is (trying to inspect it will raise an exception), and the
tagging mechanism that records which specific rule was used to expand a given non-terminal is not fully implemented yet. This doesn't
mean that it cannot be used for debugging; it means that prior knowledge of implementation details of Gnocco are required for this
debugging technique to be proficient.

# Hooking into the generation

Gnocco offers hooks pretty much everywhere in the generation process. Non-terminals offer respectively pre- and post- expansion hooks.
Blocks can be attached to these hooks with `ntMyNonTerminal pre: aBlock` and `ntMyNonTerminal post: aBlock` respectively.

Similarly, hooks can be attached to rules using `<` and `>`, as such
```smalltalk
ntMyNonTerminal --> 'something' < [ "pre-hook" ]
                | 'else'      > [ "post-hook" ].
```

Finally, using block fragments, one can hook in between fragment expansions, as such:
```smalltalk
ntMyNonTerminal --> [ "hook 1" '' ], ntSomething, [ "hook 2" '' ], ntElse, [ "hook 3" '' ].
```
Fragments are guaranteed to be expanded left-to-right. Note that they should return the empty string `''` not to impact the final result.
