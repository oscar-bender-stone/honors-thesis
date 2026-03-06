// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo
#import "us-ascii.typ": printable-ascii-table

#import "grammar.typ": grammar
#import "LL1/grammar.typ": ll1-grammar
#import "LL1/refactor.typ": ll1-refactor
#import "LL1/transforms.typ": ll1-transforms
#import "LL1/predict-table.typ": ll1-predict-figure

= Syntax <syntax>

// TODO: determine how rigorous the language is here
// vs bootstrap!
// Should the standard be put into an appendix?
[TODO[SMALL]: determine where to use type writer font. Maybe ONLY in the
bootstrap?] For consistency with Welkin, we write syntax using
`type-writer font`.#footnote[This font is Intel One Mono (#link(
    "https://github.com/intel/intel-one-mono",
  )), licensed under OFL 1.1 (#link(
    "https://github.com/intel/intel-one-mono/blob/main/OFL.txt",
  )).]

== Numbers

We add numbers and provide equivalnces between them.

#definition[

]

Welkin's main encoding uses binary words, but add notation for decimal and
hexadecimal.

#figure(
  ```
  bit <--> 0 | 1
  digit <--> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  nibble <--> A | B | C | D | E | F
  ```,
  caption: "Binary, decimal, and hexadecimal digits.",
)<digits>

#figure(
  ```
  number <--> binary | decimal | hex
  binary <--> bit | binary.bit
  decimal <--> digit | decimal.digit
  hex <--> nibble | hex.nibble
  ```,
  caption: "Definition of words.",
)<syntax:word>

== Terminals

Welkin uses ASCII as its base encoding. The term ASCII is slightly ambiguous, as
there are subtly distinct variants, so we formally define US-ASCII as a standard
version. #footnote[Note that this table _itself_ is a representation, which
  represents glyphs with binary words.]

#definition[
  Welkin's encoding consists of *Printable US-ASCII*, listed in
  @syntax:printable-ascii-codes, as well as character *EOF*, with code 58. In
  Welkin (@syntax:welkin-encoding):

  #figure(
    [```
    encoding <--> {"EOF" --> 58, @printable}
    ```],
    caption: [The full encoding for Welkin, written in Welkin.],
  )<syntax:welkin-encoding>
]

To represent general encodings, there is a binary format supported for strings,
see @string.


// TODO: complete table
#figure(
  printable-ascii-table(),
  caption: [US-ASCII codes and glyphs.],
)<syntax:printable-ascii-codes>

We denote specific characters through quotes, escaping if necessary. There are
several important character classes in @character-classes, denoted through
double quotes.

// TODO: convert into using glyphs.
// Maybe use abbreviations for Printable
// *or* list specific character classes?
#figure(
  ```
  whitespace <--> "\t" | "\n" | "\r" | " ",
  reserved <--> delimiter | "." | "*" | "\" | "@" | "#",
  delimiter <--> "{", "}" | "\"" | "'"| ","
  ```,
  caption: "Important character classes.",
)<character-classes>

Strings allow escaped single or double quotes, see @string. IDs are special
cases of strings that do not require quotes but forbid whitespace and certain
characters, see @syntax:id.

[TODO[SMALL]: determine if terminals should be uppercase.]

#figure(
  ```
  string <--> sq_string | dq_string,

  sq_string <--> {start --> "'", contents --> sq_contents, end --> "'"},
  dq_strings <--> {start --> "\"", contents --> dq_contents, end --> "\""},

  sq_contents <--> {top --> eps | {@printable, ~{"\""}}, next --> sq_contents},
  dq_contents <--> {top --> eps | {@printable, ~{"\""}}, next --> qq_contents},
  escape_sq <--> "\'" | "\\",
  escape_dq <--> "\"" | "\\",
  ```,
  caption: "Strings.",
)<string>

#figure(
  ```
  toplevel <--> {marker --> "#", name --> id}
  import <--> {marker --> "@", graph --> id},
  id <--> {top --> id_char, next --> id},
  id_char <--> {@printable, ~{@reserved, @whitespace}}
  ```,
  caption: "IDs.",
)<syntax:id>

[TODO(MEDIUM): find good way to implement directly with Welkin or discuss.]

== Invertible Syntax Description

== The Welkin Grammar

Welkin's grammar is displayed in @welkin-grammar, inspired by a minimal, C-style
syntax.

#figure(
  grammar,
  caption: [The grammar for Welkin. This includes the definitions of `id` and
    `string`, which are also defined in @syntax:word and @string,
    respectively.],
)<welkin-grammar>

== Proof of Unambiguity

We now prove that the Welkin language is unambiguous by showing it is LL(1), a
rich class of grammars that can be efficiently parsed. For more details, please
consult @compilers-dragon-book.

// #figure(
//   ```
//   top(word) ::= nil => nil | bit.word => bit
//   ```,
//   caption: "Definition of the top of a word.",
// )<top>

// #definition[(@rosenkrantz-ll1). A grammar is LL(1) iff the following holds: for
//   any terminal $w_1$ and nonterminal $A$, there is at most one rule $r$ such
//   that for some $w_2, w_3$ appearing at the top of $A$ such that,
//   - $S => "top"(w_1)A w_3$
//   - $A => w_2 (p)$
//   - $"top"(w_2 w_3) = w$
// ]<LL1>

// #theorem[
//   There exists some _LL(1)_ grammar that accepts the same strings as the Welkin
//   grammar @welkin-grammar. Hence, Welkin's syntax is unambiguous, i.e., every
//   string accepted by the language has exactly one derivation.
// ]
// #proof[
//   // TODO: should we explain why LL(1) => unambiguous?
//   We use transformations in @transforms-ll1 that preserve the language of the
//   original grammar, resulting in @grammar_ll1. For the refactor step by step,
//   see @refactor_ll1. We can readily verify that there are no shared prefixes for
//   a single production, see @predict-table-ll1. Because there are no conflicts,
//   the transformed grammar is LL(1), and hence, the grammar is unambiguous.

//   #ll1-transforms<transforms-ll1>

//   #ll1-grammar<grammar_ll1> #ll1-refactor<refactor_ll1>

//   #ll1-predict-figure<predict-table-ll1>

// ]

