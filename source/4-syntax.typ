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
  )).] For clarity, we will write at a slightly higher level than @foundations.

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
  @syntax:printable-ascii-codes, as well as character `EOF`, with code 58. An
  *ASCII string* is the concatenation of any finite number of printable
  characters, followed by an `EOF` character.
]<syntax:encoding-strings>

To represent general encodings, there is a binary format supported for strings,
see @syntax:string.

[TODO: turn into a table.]

Moreover, we will need to define *character classes*, or important sets of
characters. These are presented in @syntax:character-classes, with each
character separated by |. Note that strings _may_ contain quotes prefixed with a
slash `\`, see @syntax:string.

#figure(
  table(
    columns: (auto, auto),
    align: center,
    table.header([*Set Name*], [*Characters*]),
    [`PRINTABLE`], [See @syntax:printable-ascii-codes.],

    [`WHITESPACE`], [`\t` | `\r` | Space ],
    [`DELIMITER`], [`{` | `}` | `'` | `"`| `.` | `,`],
    [`RESERVED`], [`DELIMITER` | `*` | `@`],
    [`SQ_CHAR`], [Any `PRINTABLE` character except `'`],
    [`DQ_CHAR`], [Any `PRINTABLE` character except `"`],
    [`ID_CHAR`], [Any `PRINTABLE` character not in `RESERVED` or `WHITESPACE`],
  ),
  caption: [Definitions of key character classes. Each class is denoted in
    `UPPERCASE`.],
)<syntax:character-classes>

== Invertible Syntax Descriptions <syntax:invertible-descriptions>

To more easily describe the language, we provide basic building blocks. For
simplicity, we do not add many primitives. The names are taken from the the
`parsec` combinator library in the programming language Haskell
@leijen-meijer-parsec. We adapt their notation for our purposes:

- `seq` means two rules that must be concatenated _directly_, no `WHITESPACE`
  characters allowed.

- `lexeme` means two rules can be joined with any number of `WHITESPACE`
  characters in between.


- `seq_many_till` means that in `A - many_till -> B`, parse zero or more
  instances of `A` _without_ any `WHITESPACE` characters, until `B` is
  encountered.

- `lex_many_till` means that in `A - many_till -> B`, parse zero or more
  instances of `A` _with_ any number of `WHITESPACE` characters, until `B` is
  encountered.

In contrast to @leijen-meijer-parsec, however, we include the ability _print_ as
well or present the corresponding string. This is done through
@invertible-syntax-descriptions.

== Strings and IDs

Strings allow escaped single or double quotes, see @syntax:string. Note that,
semantically, single and double quoted strings are equivalent, see
@syntax:validation-and-transforms.

#figure(
  ```
  STRING := SQ_STRING | DQ_STRING,

  SQ_STRING := "'" - seq -> SQ_CHAR | "\'" - seq_many_till-> "'",
  DQ_STRING := '"' - seq -> DQ_CHAR | '\"' - seq_many_till -> '"',
  ```,
  caption: "Strings.",
)<syntax:string>

IDs are special cases of strings that do not require quotes but forbid
whitespace and certain characters, see @syntax:id.

#figure(
  ```
  ID := ID_CHAR - many_till -> *RESERVED | *WHITESPACE
  ```,
  caption: "Syntactic definition of an ID.",
)<syntax:id>

== The Welkin Grammar

Welkin's grammar is displayed in @welkin-grammar, inspired by several languages.

#let grammar = ```
start := {terms - lexeme -> EOF},

terms := "" | {term - lexeme -> terms_tail},
terms_tail := "" | {"," - lexeme -> "" | term},

term := {
  node - seq ->
  "" | {
    arc - seq -> term
  }
},

arc := right_arc | other_arc,
right_arc := {"-" - seq -> node - seq -> "->"},
other_arc := {"<-" - seq -> node - seq -> "-" | "->"},

node := {
  path - lexeme ->
    | ""
    | {
      *{"", ":="}
      - lexeme -> "{"
      - lexeme -> path
      - lexeme -> terms
      - lexeme -> "}"
      }
},

path := {
  *{{"@" - seq -> UNIT }, {"." - seq_many_till -> UNIT}, ""}
  - seq -> {*{UNIT, "*"} - seq -> "."}
  - many_until -> UNIT
},

UNIT := ID | STRING
```

#figure(
  grammar,
  caption: [The grammar for Welkin. The rules `STRING` and `ID` are defined in
    @syntax:string and @syntax:id, respectively.],
)<welkin-grammar>

== Proof of Unambiguity

We show that, by construction, the combinators we used form an $"LL"(1)$
grammar. This is a special kind of grammar with two desirable properties:

- If a string is accepted, it is parsed unambiguously.

- Efficient parsers can be easily and efficiently implemented
  @compilers-dragon-book[Sect. 4.4.3].

Our approach is to provide an equivalence between @welkin-grammar and a new
grammar. More precisely, we require a bijection with the following property: a
string accepted by @welkin-grammar is also accepted by the new grammar, and vice
versa. We will then prove the latter is $LL(1)$.

We will keep definitions and theorems here self-contained. For more background,
please consult @compilers-dragon-book[Ch. 5], @rosenkrantz-ll1.

First, we need to define a general *context-free grammar*.

#definition[
  A *Context-free Grammar (CFG)* $G = (N, T, P)$ consists of:
  - A finite set of *non-terminals*.
  - A finite set of *terminals* $T$.
  - A finite set of *productions* $P$, where a *production* is a rule of the
    form $A => alpha_1 ... alpha_n$, where $A in N$ and $alpha_1 ... alpha_n$ is
    the concatenation of terminals $alpha_1, ..., alpha_2$ in $T$,
]

For our use case, we will assume that $T$ is a set of ASCII strings
(@syntax:encoding-strings).

#definition[
  Let $G = (N, T, P)$ be a CFG and $A$ a non-terminal.
  - The *FIRST* set of
  - The *FOLLOW* set of
]

#definition[*_(@compilers-dragon-book[Ch. 5])_* A CFG is $"LL"(1)$ if and only
  if for every production $A => alpha_1 | ... | alpha_n$
  -
  -
]


== Validation and Transformations <syntax:validation-and-transforms>

We say a string is *valid* if it is accepted by the grammar (@welkin-grammar),
and the following hold:

- The number of dots (relative import) used must not exceed the number of levels
  available.

- Every definition of a unit must only be stated once. This means
  `u := v, u:= w` is not allowed.

- Accessing a unit $v$ from $u$ requires that $u$ has a closed definition
  containing $v$. This means neither `u := {v, w}, u.x` nor `u.x` alone are
  valid.

We leave error handling for future work, see @conclusion.

Additionally, we define transformation rules after parsing:

- If `\'` appears in a single quoted string, then this will be replaced by `'`
  in the final contents. For example, given a string `"John\'s dog"`, the
  contents would be `John's dog`.

- A similar rule applies for `"` but with `\"`.

- Double slashes `\\` are converted into one slash `\`.

- Single and double quoted strings are represent each other. For example,
  `'hello' <--> "hello"`. However, in general, `hello` is _not_ equivalent to
  `"hello"`. [TODO: make sure this is not confusing!]

- Each `*` within a path expands to all the members in the respective unit.

- Each `*{...}` term expands to all the members in the enclosed unit.

- The definitions for `|` and `~` (see @unit-rules) are expanded [TODO: maybe
  provide a remark on new notation? Or make a notation env?].
