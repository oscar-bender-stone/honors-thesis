// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo
#import "us-ascii.typ": ascii-table
#import "grammar.typ": grammar

= Syntax <syntax>

We keep this section self-contained with explicit alphabets and explicit
recursive definitions. For simplicity, we will use the notation $a_0, ..., a_n$
for a finite list of items, and use $a ::= a_1 | ... | a_n$ to denote a
definition of $a$ in terms of $a_1, ..., a_n$. We will revisit the notion
"finite" more rigorously in @bootstrap. Moreover, we will postpone discussions
on the rationale for the simple syntax and the underlying meta-theory in
@bootstrap.

== Words

#figure(
  ```
  word ::= bit | word.0 | word.1
  bit  ::= 0 | 1
  ```,
  caption: "Definition of bits and words.",
)<word>


We set concatenation to be right-associative, i.e., $(w.w').w'' = w.(w'.w'')$,
and safely abbreviate $w.w'$ as $w w'$.

We extend the alphabet to include two common bases: decimal (via digits) and
hexadecimal, shown in @digits.

#figure(
  ```
  digit ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  nibble ::= A | B | C | D | E | F
  ```,
  caption: "Decimal and hexadecimal digits.",
)<digits>

We set the default base to be decimal and use prefixes.

A *byte* is eight bits, or two nibbles.

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

The full list of terminals is provided in @terminals.


#figure(
  ```
  ```,
  caption: "Strings.",
)<string>


#figure(
  ```
  STRING ::= SQ_STRING | DQ_STRING
      ID ::= [^\s]
  ```,
  caption: [Terminals, where `SQ_STRING` and `DQ_STRING` are defined in
    @string],
)<terminals>

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

== Proof of LL(1) Membership

We now prove that the Welkin language is unambiguous by showing it is LL(1), a
rich class of grammars that can be efficiently parsed. For more details, please
consult @compilers-dragon-book.

#definition[
  A grammar is LL(1) if, given two distinct productions $alpha, beta$:
  -
  -
  - If $beta =>^* epsilon$...
]<LL1>

#theorem[
  Welkin's grammar is _LL(1)_. Hence, this grammar is unambiguous, i.e., every
  string accepted by the language has exactly one derivation.
]
#proof[
  Consider the corresponding LL(1) table...
]
