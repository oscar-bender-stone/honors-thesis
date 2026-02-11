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
for a finite list of items. We will revisit the notion "finite" more rigorously
in @bootstrap. Moreover, we will postpone discussions on the rationale for the
simple syntax and the underlying meta-theory in @bootstrap.

== Words

#definition[
  The *alphabet of binary words* is $cal(A)_"bword" ::= "bit" | . | w$, where
  $"bit" ::= 0 | 1$. A *binary word* is defined recursively: the symbols $0$ or
  $1$ are strings, or if $w$ is a string, then so are $w.0$ and $w.1$. We set
  concatenation to be right-associative, i.e., $(w.w').w'' = w.(w'.w'')$, and
  safely abbreviate $w.w'$ as $w w'$. We write $w in "bword"$ to denote that $w$
  is a binary word.
]<binary-word>

For simplicity, we extend the alphabet to include two common bases: decimal and
hexadecimal.

// TODO: clean this up!
#definition[
  The *alphabet of words*
  $cal(A)_"word" ::= cal(A)_"bword" + cal(A)_"dec" + cal(A)_"hex"$, where:
  - $cal(A)_"dec" ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9$
  - $cal(A)_"hex" ::= A | B | C | D | E | F$
  A *word* is a concatenation of either only binary digits, only decimal digits,
  or hexadecimal digits. Each of these are denoted with different prefixes:
  decimal has none, binary uses $0b$, and hexadecimal uses $0x$.
]<word>

Using binary words simplifies the bootstrap, so while these digits are included,
they are _defined_ in terms of binary words, see @bootstrap. Additionally, we
will frequently use *bytes*, which are eight bits, or equivalently two
hexadecimal digits.

== Encoding

Welkin uses US-ASCII as its base encoding, due to its widespread use. The term
ASCII is slightly ambiguous, as there are slight dialects of ASCII. We formally
define US-ASCII below.#footnote[Note that this table _itself_ is a
  representation, which represents glyphs with binary words. The use of these
  kinds of representations occur frequently in Welkin, see @bootstrap.
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
  a derivation. We write $alpha =>^* beta$ if there is a derivation from $alpha$
  to $beta$.
]<BNF>

Now, we formalize an unambiguous form of EBNF for our use case.

Welkin's grammar is displayed in @welkin-grammar, inspired by a minimal, C-style
syntax. Note that the empty string is not accepted, but is instead represented
by the string `{}`.

// NOTE: determine if we should allow non-empty strings or not
#figure(
  grammar,
  caption: [The grammar for Welkin, shown in BNF notation (see @BNF). The
    terminals `id` and `string` are defined in @word and @string, respectively],
)<welkin-grammar>

== Proof of LL(1) Membership

We now prove that the Welkin language is unambiguous by showing it is LL(1), a
rich class of grammars that can be efficiently parsed. For more details, please
consult @compilers-dragon-book.

#definition[Let $G$ be a grammar.]<first-set>

#definition[Let $G$ be a grammar.]<follow-set>

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
