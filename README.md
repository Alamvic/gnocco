```text
   ____    _   _     U  ___ u   ____    ____   U  ___ u 
U /"___|u | \ |"|     \/"_ \/U /"___|U /"___|   \/"_ \/ 
\| |  _ /<|  \| |>    | | | |\| | u  \| | u     | | | | 
 | |_| | U| |\  |u.-,_| |_| | | |/__  | |/__.-,_| |_| | 
  \____|  |_| \_|  \_)-\___/   \____|  \____|\_)-\___/
  _)(|_   ||   \\,-.    \\    _// \\  _// \\      \\
 (__)__)  (_")  (_/    (__)  (__)(__)(__)(__)    (__)
```

# Example: a phone number grammar

Let us create a grammar that generates French phone numbers. The grammar should have the following generative rules
```
PhoneNumer -> StartBlock ' ' Block ' ' Block ' ' Block ' ' Block
StartBlock -> '0' [1-7]
Block -> [0-9] [0-9]
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
```
We should also specify the start symbol
```smalltalk
PhoneGrammar >> start

  ^ ntPhoneNumber
```
*et voilà*, the grammar is already ready to generate some phone numbers!
```smalltalk
PhoneGrammar new generateWithMinCost >> '04 67 92 39 04'
```
