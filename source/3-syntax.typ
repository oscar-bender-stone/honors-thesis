// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo

= Syntax

To keep this thesis self-contained, all recursive definitions are included. For
simplicity, we will use the notation $a_0, ..., a_n$ for a finite list of items.
We will revisit the notion "finite" more rigorously in @bootstrap.

#definition[
  The *alphabet of binary words* is $cal(A)_"word" ::= "bit" | . | w$, where
  $"bit" ::= 0 | 1$. A *binary word* is defined recursively: the symbols $0$ or
  $1$ are strings, or if $w$ is a string, then so are $w.0$ and $w.1$. We
  abbreviate $w.w'$ to $w w'$ and write $w in "word"$ to mean that $w$ is a
  binary word.
]

For simplicity, we extend the alphabet to include decimal and hexadecimal.


We formalize an unambiguous form of EBNF for our use case.

#definition[
  *EBNF* consists of productions. Writing $r := a_1 | ... | a_n$ is shorthand
  for including the rules $r := a_1, ..., r := a_n$.
]
