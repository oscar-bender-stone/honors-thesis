// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo

= Syntax <syntax>

Now, the base encoding for Welkin is in US-ASCII, formally defined below.

== Encoding

#definition[
  US-ASCII consists of 256 symbols, listed in @US-ASCII-codes.
]

// TODO: complete table
#figure(
  [],
  caption: [US-ASCII codes and glyphs.],
)<US-ASCII-codes>

We reserve the term *string* when a word is explicitly enclosed in deilmiters,
namely single or double quotes. The precise definition is involved, due to
including quotes within a string, which are called "escaped quotes". This is one
reason why the base encoding is fixed to US-ASCII encoding: the negation
operation cannot be expressed as a natural regular expression in general, but
can if all the possibilities are listed.

== Strings

#definition[
  A *single-quoted string* is defined recursively.

  The definition of double-quoted string is analogous.
]<string>

== Grammar

#definition[
  *BNF* consists of productions. Writing $r := a_1 | ... | a_n$ is shorthand for
  the rules $r := a_1, ..., r := a_n$. A *derivation* is a sequence of steps,
  recursively defined by starting with the empty derivation, and if $d$ is a
  derivation and $s$ is a step, then $d.s$ is a derivation.
]

Now, we formalize an unambiguous form of EBNF for our use case.

#definition[
  *EBNF* is a superset of BNF with the abbreviations:
]

Welkin's grammar is displayed in ...

== Unambiguity

#definition[
  A grammar is LL(1) if ...
]

#theorem[
  Welkin's grammar is _LL(1)_. Hence, this grammar is unambiguous.
]
#proof[
  Consider the corresponding LL(1) table.
]
