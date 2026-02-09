// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo
#import "us-ascii.typ": ascii-table

= Syntax <syntax>

Now, the base encoding for Welkin is in US-ASCII, formally defined below.

== Encoding

#definition[
  US-ASCII consists of 256 symbols, listed in @US-ASCII-codes.
]

// TODO: complete table
#figure(
  ascii-table(),
  caption: [US-ASCII codes and glyphs.],
)<US-ASCII-codes>

== Strings

We reserve the term *string* when a word is explicitly enclosed in deilmiters,
namely single or double quotes. The precise definition is involved, due to
including quotes within a string, which are called "escaped quotes". To detect
escaped quotes, we use our fixed set of characters (see @US-ASCII-codes).

#definition[
  A *single-quoted string* is defined recursively.

  The definition of double-quoted string is analogous.
]<string>

== Grammar

#definition[
  *Backus-Naur Form (BNF)* consists of productions. Writing
  $r := a_1 | ... | a_n$ is shorthand for the rules $r := a_1, ..., r := a_n$. A
  *derivation* is a sequence of steps, recursively defined by starting with the
  empty derivation, and if $d$ is a derivation and $s$ is a step, then $d.s$ is
  a derivation.
]<BNF>

Now, we formalize an unambiguous form of EBNF for our use case.

Welkin's grammar is displayed in @welkin-grammar, inspired by a minimal, C-style
syntax. Note that the empty string is not accepted, but is instead represented
by the string `{}`.

// NOTE: determine if we should allow non-empty strings or not
#todo[Ensure this is actually LL(1)! Probably need to massage some productions.]
#figure(
  [
    ```
    start ::= (term ",")* term
    term ::= arc | graph | base
    arc ::= (term "-" term "->)+ term
          | (term "<-" term "-")+ term
          | (term "-" term "-")+ term
    graph ::= unit? { term* }
    base ::= unit | string
    unit ::= int
    ```
  ],
  caption: [The grammar for Welkin, shown in BNF notation (see @BNF). The
    terminals `int` and `string` are defined in @word and @string,
    respectively],
)<welkin-grammar>

== Proof of LL(1) Membership

We now prove that the Welkin language is unambiguous by showing it is LL(1), a
rich class of grammars that can be efficiently parsed.

#definition[*(@compilers-dragon-book)* Let $G$ be a grammar.]

#definition[
  *(@compilers-dragon-book)* A grammar is LL(1) if, given two distinct
  productions $r_1, r_2$:
  -
]

#theorem[
  Welkin's grammar is _LL(1)_. Hence, this grammar is unambiguous, i.e., every
  string accepted by the language has exactly one derivation.
]
#proof[
  Consider the corresponding LL(1) table...
]
