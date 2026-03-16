// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo
#import "us-ascii.typ": printable-ascii-table

// TODO: create a "current working file" or such,
// or "current working context", and then use *that*
// when getting input! (Though it could be streamed;
// we're using handles as an effective abstraction here!
// Do also make sure multiple users *could* use it as well,
= Syntax <syntax>

// TODO: determine how rigorous the language is here
// vs bootstrap!
// Should the standard be put into an appendix?
This section introduces the grammar for Welkin. To make specific characters
clearer, we write syntactic features in `type-writer font`.#footnote[This font
  is Intel One Mono (#link(
    "https://github.com/intel/intel-one-mono",
  )), licensed under OFL 1.1 (#link(
    "https://github.com/intel/intel-one-mono/blob/main/OFL.txt",
  )).]

== Encoding

Welkin uses ASCII as its base encoding. The term ASCII is slightly ambiguous, as
there are subtly distinct variants, so we formally define US-ASCII as a standard
version. #footnote[Note that this table _itself_ is a representation, which
  represents glyphs with binary words.]

#figure(
  printable-ascii-table(),
  caption: [Printable US-ASCII codes and glyphs.],
)<syntax:printable-ascii-codes>


#definition[
  Welkin's encoding consists of *Printable US-ASCII*, listed in
  @syntax:printable-ascii-codes, as well as character *EOF*, with code 58.
]

To represent general encodings, there is a binary format supported for strings,
see @syntax:string.

[TODO: turn into a table.]

Moreover, we will need to define *character classes*, or important sets of
characters. These are presented in @syntax:character-classes, with each
character separated by |. Notice that `SQ_CHAR` and `DQ_CHAR` contain a word
with two characters. In other words, while `'` (resp. `"`) is not allowed by
itself, `\'` (resp. `\"`) is permitted.

#figure(
  table(
    columns: (auto, auto),
    align: center,
    table.header([*Set Name*], [*Characters*]),
    [`PRINTABLE`], [See @syntax:printable-ascii-codes.],

    [`WHITESPACE`], [`\t` | `\r` | Space ],
    [`DELIMITER`], [`{` | `}` | `'` | `"`| `.` | `,`],
    [`RESERVED`], [`DELIMITER` | `*` | `@`],
    [`SQ_CHAR`], [Any `PRINTABLE` character except `'` | `\'`],
    [`DQ_CHAR`], [Any `PRINTABLE` character except `"` | `\"`],
    [`ID_CHAR`], [Any `PRINTABLE` character not in `RESERVED` or `WHITESPACE`],
  ),
  caption: [Definitions of key character classes. Each class is denoted in
    `UPPERCASE`.],
)<syntax:character-classes>

== Invertible Syntax Descriptions

To more easily describe the language, we provide basic building blocks. For
simplicity, we do not add many primitives. The names are taken from the the
`parsec` combinator library in the programming language Haskell
@leijen-meijer-parsec. We adapt their notation for our purposes:

- `seq` means two rules that must be concatenated _directly_, no `WHITESPACE`
  characters allowed.

- `lexeme` means two rules can be joined with any number of `WHITESPACE`
  characters in between.

- `many_till` means that in `A - many_till -> B`, parse zero or more instances
  of `A` until `B` is encountered.

In contrast to @leijen-meijer-parsec, however, we include the ability _print_ as
well or present the corresponding string. This is done through
@invertible-syntax-descriptions.

== Character Classes

// TODO: complete table
We denote specific characters through quotes, escaping if necessary. There are
several important character classes in , denoted through double quotes.



Strings allow escaped single or double quotes, see @syntax:string.

#figure(
  ```
  STRING := SQ_STRING | DQ_STRING,

  SQ_STRING := "'" - seq -> SQ_CHAR - many_until-> "'",
  DQ_STRING := "\"" - seq -> DQ_CHAR - many_until -> "\"",
  ```,
  caption: "Strings.",
)<syntax:string>

IDs are special cases of strings that do not require quotes but forbid
whitespace and certain characters, see @syntax:id.

#figure(
  ```
  ID := ID_CHAR - many_till -> *RESERVED | *WHTIESPACE
  ```,
  caption: "Syntactic definition of an ID.",
)<syntax:id>

== The Welkin Grammar

Welkin's grammar is displayed in @welkin-grammar, inspired by a minimal, C-style
syntax.

#let grammar = ```
 start := {nodes - lexeme -> EOF},

 terms := "" | {term - lexeme -> terms_tail},
 terms_tail := {"," - lexeme -> term}
   | ","
   | "",

 term := {
   node - seq ->
   {} | {
     arc - seq -> term
   }
 },

 arc := right_arc | other_arc,
 right_arc := {"-" - seq -> node - seq -> "->"},
 other_arc := {"<-" - seq -> node - seq -> ("-" | "->")},

 node := {path - lexeme -> contents | {}},

 path := {ROOT | EPS --> path_segment - many_til -> unit},

 path_segment := UNIT | ".*" | {@times, factor --> "."},

 path_segment := UNIT | ".*" | "."+,

 UNIT <--> ID | STRING
```

#figure(
  grammar,
  caption: [The grammar for Welkin. This includes the definitions of `id` and
    `string`, which are also defined in @syntax:id and @syntax:string,
    respectively.],
)<welkin-grammar>

== Proof of Unambiguity

We show that, by construction, the combinators we used form an $LL(1)$ grammar.
This is a special kind of grammar that can be efficiently parsed. We will keep
definitions self-contained; for more background, consult
@compilers-dragon-book[Ch. 5], @rosenkrantz-ll1.

== Validation

We state two important rules:

- The number of dots used must not exceed the number of levels available.

- Every definition of a unit must only be stated once.

- Accessing a unit $v$ from $u$ requires that $u$ has a closed definition
  containing $v$.

We leave error handling for future work, see @conclusion.

