// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo

= Foundations <foundations>

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

Now, the base encoding for Welkin is in US-ASCII, formally defined below.

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

Now, the base encoding for Welkin is in US-ASCII, formally defined below.

#definition[
  US-ASCII consists of 256 symbols, listed in Table ?.
]

We reserve the term *string* when a word is explicitly enclosed in deilmiters,
namely single or double quotes.

Now, we formalize an unambiguous form of EBNF for our use case.

#definition[
  *BNF* consists of productions. Writing $r := a_1 | ... | a_n$ is shorthand for
  including the rules $r := a_1, ..., r := a_n$.

  *EBNF* additionally contains the following abbreviations:
  - $r := a_1 | ... | a_n$ is shorthand for including the rules
    $r := a_1, ..., r := a_n$.
]

Welkin's grammar is displayed in ...


#definition[
  A grammar is LL(1) if ...
]

#theorem[
  Welkin's grammar is _LL(1)_. Hence, this grammar is unambiguous.
]
