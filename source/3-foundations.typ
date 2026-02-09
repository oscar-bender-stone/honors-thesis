// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo

= Foundations <foundations>

== Words

To keep this thesis self-contained, all recursive definitions are included. For
simplicity, we will use the notation $a_0, ..., a_n$ for a finite list of items.
We will revisit the notion "finite" more rigorously in @bootstrap.

#definition[
  The *alphabet of binary words* is $cal(A)_"bword" ::= "bit" | . | w$, where
  $"bit" ::= 0 | 1$. A *binary word* is defined recursively: the symbols $0$ or
  $1$ are strings, or if $w$ is a string, then so are $w.0$ and $w.1$. We set
  concatenation to be right-associative, i.e., $(w.w').w'' = w.(w'.w'')$, and
  safely abbreviate $w.w'$ as $w w'$. We write $w in "bword"$ to denote that $w$
  is a binary word.
]

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
]

Using binary words simplifies the bootstrap, so while these digits are included,
they are _defined_ in terms of binary words, see @bootstrap.

== Arithmetic

