// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo
#import "us-ascii.typ": ascii-table
#import "grammar.typ": grammar

= Syntax <syntax>

// TODO: determine how rigorous the language is here
// vs bootstrap!
// Should the standard be put into an appendix?
We keep this section self-contained with explicit alphabets and recursive
definitions. For general notation, we write $a_0, ..., a_n$ for a finite list of
items, and use $a ::= a_1 | ... | a_n$ to denote a definition of $a$ in terms of
$a_1, ..., a_n$. that for verification purposes, we will incorporate fixed
bounds into @bootstrap. Moreover, we will postpone discussions on the rationale
for the simple syntax until @semantics.

== Words

Welkin's main encoding uses binary words, but add notation for decimal and
hexadecimal.

#figure(
  ```
  bit ::= 0 | 1
  digit ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  nibble ::= A | B | C | D | E | F
  ```,
  caption: "Binary, decimal, and hexadecimal digits.",
)<digits>

// TODO: determine a suitable symbol to replace . for contatenation
// OR figure out how to bake into semantics
A word is a sequence of digits, see @word. We leave concatenation `;` as an
undefined notion. We set concatenation to be right-associative, i.e.,
$(w.w')+w'' = w.(w'.w'')$, and abbreviate $w.w'$ as $w w'$. Moreover, we add a
conversion from decimal and hexadecimal into binary via @digit-conversions. We
provide the explicit recursive definiton based on this table in
@word-conversions, where `a <--> b` means that `a` is converted into `b` and
vice versa. This is a restriction on the notion of representations that will be
addressed in @bootstrap.


#figure(
  ```
  word --> binary | decimal | hex
  binary --> bit | binary.bit
  decimal --> digit | decimal.digit
  hex --> nibble | hex.nibble
  ```,
  caption: "Definition of words.",
)<word>

#figure(
  table(
    columns: (auto, auto, auto),
    [*Hexadecimal*], [*Decimal*], [*Binary*],
    [0], [0], [0],
    [1], [1], [1],
    [2], [2], [10],
    [3], [3], [11],
    [4], [4], [100],
    [5], [5], [101],
    [6], [6], [110],
    [7], [7], [111],
    [8], [8], [1000],
    [9], [9], [1001],
    [A], [10], [1010],
    [B], [11], [1011],
    [C], [12], [1100],
    [D], [13], [1101],
    [E], [14], [1110],
    [F], [15], [1111],
  ),
  caption: "Conversions of digits between different bases.",
)<digit-conversions>

// TODO: determine if "0x0".something should mean string concatenation.
// Might be nice to have?
// But then we have to distinguish with our notation,
// so maybe use seomthing *besides* . for contaenation?
// TODO: complete!
#figure(
  ```
  ```,
  caption: "Recursive definition for converting words between bases.",
)<word-conversions>

#figure(
  ```
  "0".word <--> word
  "0b0".word <--> "0b".word
  "0x0".word <--> "0x".word
  ```,
  caption: "Conversions with leading zeros.",
)<leading-zeros>


== Terminals

Welkin uses ASCII as its base encoding. The term ASCII is slightly ambiguous, as
there are subtly distinct dialects, so we formally define US-ASCII as a standard
dialect.#footnote[Note that this table _itself_ is a representation, which
  represents glyphs with binary words. The use of these kinds of representations
  occur frequently in Welkin, see @bootstrap.
]

#definition[
  US-ASCII consists of 256 symbols, listed in @US-ASCII-codes.
]

To represent general encodings, there is a binary format supported for strings,
see @string.


// TODO: complete table
#figure(
  ascii-table(),
  caption: [US-ASCII codes and glyphs.],
)<US-ASCII-codes>

There are several important character classes.

#figure(
  ```
  PRINTABLE  ::= [0x20-0x7E]
  WHITESPACE ::= [0x09, 0x0A, 0x0D, 0x20]
  DELIMITER ::= [0x7B, 0x7D, 0x2C, 0x2D, 0x2A, 0x3C, 0x3E, 0x22, 0x27, 0x5C]
  ```,
  caption: "Important character classes.",
)<character-classes>

#figure(
  ```
  STRING ::= SQ_STRING | DQ_STRING
  ```,
  caption: "Strings.",
)<string>

#figure(
  ```
  IMPORT ::= "@" ID
  ID :: ID_CHAR+
  ID_CHAR ::= PRINTABLE / DELIMITERS
  ```,
  caption: "IDs.",
)<id>

== Grammar

Welkin's grammar is displayed in @welkin-grammar, inspired by a minimal, C-style
syntax.

// TODO: decide if empty strings should be accepted or not
// Note that the empty string is not accepted, but is instead represented
// by the string `{}`.

// NOTE: determine if we should allow non-empty strings or not
#figure(
  grammar,
  caption: [The grammar for Welkin. The terminals `id` and `string` are defined
    in @word and @string, respectively],
)<welkin-grammar>

#figure(
  ```
  node ::= leaf | node [node1, node2, ..., noden]
  leaf ::= t in T | epsilon
  ```,
  caption: "Representation of a parse tree as a list.",
)<parse-tree>

== Proof of LL(1) Membership

We now prove that the Welkin language is unambiguous by showing it is LL(1), a
rich class of grammars that can be efficiently parsed. For more details, please
consult @compilers-dragon-book.

Moreover, we define the top of a word in @top.

#figure(
  ```
  top(word) ::= nil => nil | bit.word => bit
  ```,
  caption: "Definition of the top of a word.",
)<top>

#definition[(@rosenkrantz-ll1). A grammar is LL(1) iff the following holds: for
  any terminals $w_1, w_2$ and nonterminal $A$, there is at most one rule $r$
  such that for some $w_2, w_3$,
  - $S => "top"(w_1)A w_3$
  - $A => w_2 (p)$
  - $"top"(w_2 w_3) = w$
]<LL1>

#theorem[
  Welkin's grammar is _LL(1)_. Hence, this grammar is unambiguous, i.e., every
  string accepted by the language has exactly one derivation.
]
#proof[
  Consider the corresponding LL(1) table...
]
