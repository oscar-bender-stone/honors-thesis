// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo

= Syntax <syntax>

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
#proof[
  Consider the corresponding LL(1) table.
]
