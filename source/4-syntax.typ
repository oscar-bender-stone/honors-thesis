// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": corollary, lemma, theorem
#import "template/ams-article.typ": proof
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
This section examines the grammar for Welkin and provides validation rules. For
specific sections, consult @syntax:overview.

#figure(
  table(
    columns: (20%, 25%, 55%),
    align: left,
    table.header([*Section Number*], [*Title*], [*Description*]),
    [*@syntax:encoding*], [*Encoding*], [Introduces the encoding for Welkin.],

    [*@syntax:invertible-descriptions*],
    [*Invertible #linebreak(justify: true) Syntax #linebreak(justify: true)
    Descriptions*],
    [Defines *invertible syntax descriptions*, the fundamental building blocks
      for the grammar.],

    [*@syntax:strings-and-ids*],
    [*Strings and IDs*],
    [Defines the syntax for strings and IDs.],

    [*@syntax:welkin-grammar*],
    [*The Welkin #linebreak() Grammar*],
    [Presentts the Welkin grammar, defining which strings are syntactically
      allowed.],

    [*@syntax:proof-unambiguous*],
    [*Proof of #linebreak() Unambiguity*],
    [Proves that the Welkin grammar is unambiguous.],

    [*@syntax:validation-and-transforms*],
    [*Validation and Transforms*],
    [Defines which strings are *valid*, as well as transforms on certain
      constructs.],
  ),
  caption: [Overview of @syntax.],
)<syntax:overview>

To make specific characters clearer, we write syntactic features in
`type-writer font`.#footnote[This font is Intel One Mono (#link(
    "https://github.com/intel/intel-one-mono",
  )), licensed under OFL 1.1 (#link(
    "https://github.com/intel/intel-one-mono/blob/main/OFL.txt",
  )).] For clarity, we will write at a slightly higher level than @foundations.

== Encoding <syntax:encoding>

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
    [`DELIMITER`], [`{` | `}` | `'` | `"` | `.` | `,`],
    [`RESERVED`], [`DELIMITER` | `*` | `@`],
    [`SQ_CHAR`], [Any `PRINTABLE` character except `'` and `\`],
    [`DQ_CHAR`], [Any `PRINTABLE` character except `"` and `\`],
    [`ID_CHAR`], [Any `PRINTABLE` character not in `RESERVED` or `WHITESPACE`],
  ),
  caption: [Definitions of key character classes. Each class is denoted in
    `UPPERCASE`.],
)<syntax:character-classes>

== Invertible Syntax Descriptions <syntax:invertible-descriptions>

To more easily describe the language, we provide basic building blocks. For
simplicity, we do not add many primitives. The names are taken from the the
`parsec` combinator library in the programming language Haskell
@leijen-meijer-parsec. Using @invertible-syntax-descriptions, we augment these
functions as invertible syntax descriptions. Here, an *invertible syntax
description* is a pair of functions:
- A `parser`, from strings to an intermediate data structure.#footnote[For
    computer scientists: this is an AST. Because this thesis aims to have a
    broader audience, we leave details to @invertible-syntax-descriptions.
  ]
- A `printer`, the reverse of `parser`.

The detailed correspondence is described in @syntax:invertible-descriptions. We
adapt the notation from `parsec` and @invertible-syntax-descriptions for our
purposes:

[TODO: define how printing works here! Use a table.]

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

== Strings and IDs <syntax:strings-and-ids>

Strings allow escaped single or double quotes, see @syntax:string. Note that,
semantically, single and double quoted strings are equivalent, see
@syntax:validation-and-transforms.

#figure(
  ```
  STRING := SQ_STRING | DQ_STRING,
  SQ_STRING := "'" - seq -> *{SQ_CHAR, "\'"} - seq_many_till -> "'",
  DQ_STRING := '"' - seq -> *{DQ_CHAR, '\"'} - seq_many_till -> '"',
  ```,
  caption: "Strings.",
)<syntax:string>

IDs are special cases of strings that do not require quotes but forbid
whitespace and certain characters, see @syntax:id.

#figure(
  ```
  ID := ID_CHAR - seq_many_till -> *{RESERVED, *WHITESPACE}
  ```,
  caption: "Syntactic definition of an ID.",
)<syntax:id>

== The Welkin Grammar <syntax:welkin-grammar>

Welkin's grammar is displayed in @syntax:figure-welkin-grammar, inspired by
several languages.

#let grammar = ```
start := units - lexeme -> EOF,

units :=
  | ""
  | {
      unit
      - lexeme -> *{"", "," - lexeme -> unit}
      - lex_many_until -> *{"", ","}
    },

unit := node - lexeme -> *{"", arc - lexeme -> unit},

arc := right_arc | other_arc,
right_arc := "-" - seq -> node - seq -> "->",
other_arc := "<-" - seq -> node - seq -> *{"-" | "->"},

node := *{"", "*"}
  - seq -> *{
    graph,
    path - lexeme -> *{"", binding}
  }

binding := ":=" - lexeme -> choices,
choices := *{"", "|"}
  - lexeme -> unit
  - lexeme -> *{
    "",
    {"|" - lexeme -> unit}
    - lex_many_til -> *{"}", ","}
  },

graph := path - lexeme -> "{" - lexeme -> units - lexeme -> "}",

path := *{"", "~"}
  - seq -> *{"", "@"}
  - seq -> HANDLE
  - seq -> trailer,

trailer - *{
  "",
  "." - seq -> *{graph, HANDLE - seq -> trailer}
}

HANDLE := ID | STRING

STRING := SQ_STRING | DQ_STRING,
SQ_STRING := "'" - seq -> *{SQ_CHAR, "\'"} - seq_many_till -> "'",
DQ_STRING := '"' - seq -> *{DQ_CHAR, '\"'} - seq_many_till -> '"',

ID := ID_CHAR - seq_many_till -> *{RESERVED, WHITESPACE}
```

#figure(
  grammar,
  caption: [The complete grammar for Welkin. This includes the rules `STRING`
    and `ID`, which are also provided in @syntax:string and @syntax:id,
    respectively. Character classes are defined in @syntax:character-classes.],
)<syntax:figure-welkin-grammar>

== Validation and Transformations <syntax:validation-and-transforms>

We say a string is *valid* if it is accepted by the grammar
(@syntax:figure-welkin-grammar), and the following hold:

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
  `'hello' <--> "hello"`. In fact, IDs are special cases of strings, so
  `hello <--> 'hello'`. Practically, the only difference is that units forbid
  `WHITESPACE` or `RESERVED` characters, but they can be written without quotes.

- Each `*` within a path expands to all the members in the respective unit.

- Each `*u` for a handle or graph $u$ expands to all the members in the enclosed
  unit.

- The definitions for `|` and `~` are expanded, see @unit-rules. [TODO: maybe
  provide a remark on new notation? Or make a notation env?].

== Proof of Unambiguity <syntax:proof-unambiguous>

We show that, by construction, the combinators we used form an $"LL"(1)$
grammar. These grammars have two desirable properties:
- If a string is accepted, it is parsed unambiguously.
- Efficient parsers can be easily and efficiently implemented
  @compilers-dragon-book[Sect. 4.4.3].

Our approach is to provide an equivalence between @syntax:figure-welkin-grammar
and a new grammar. More precisely, we require a bijection with the following
property: a string accepted by @syntax:figure-welkin-grammar is also accepted by
the new grammar, and vice versa. We will then prove the latter is $"LL"(1)$.

We will keep definitions and theorems here self-contained. For more background,
please consult @compilers-dragon-book[Ch. 5], @rosenkrantz-ll1.

First, we need to define a general *context-free grammar*.

#definition[
  A *Context-free Grammar (CFG)* $G = (N, T, P)$ consists of:
  - A finite set of *non-terminals* $N$.
  - A finite set of *terminals* $T$.
  - A finite set of *productions* $P$, where a *production* is a rule of the
    form #box[$A => alpha_1 ... alpha_n$]. Here, $A$ is a non-terminal,
    $alpha_1 ... alpha_n$ denotes concatenation, and each $alpha_i$ may be a
    non-terminal or terminal. Note that this string may be empty, denoted by
    $"EPS"$.
  - A *start symbol* $S in N$.
]

For our use case, we will assume that $T$ is a set of ASCII strings
(@syntax:encoding-strings). Additionally, we define a *string of grammar
symbols* as a string of the form $alpha_1...alpha_n$, with each $alpha_i$ being
a terminal or non-terminal. Additionally, we will abbreviate `WHITESPACE` in a
CFG as $"WS"$, and $A => alpha | beta$ means the grammar includes the
productions $A => alpha$ and $A => beta$.

We require another important definition.

#definition[
  Let $G = (N, T, P, S)$ be a CFG. Let $A in N$ and $alpha, beta, gamma in T$.
  Then $alpha A beta => alpha gamma beta$ if there is a production $A => gamma$
  in $P$. This is called a *one-step derivation*. More generally, $alpha$
  *derives* $beta$, denoted $alpha =>^* beta$, if there is some finite sequence
  #box[$alpha_1 equiv alpha => alpha_2 => ... => alpha_n equiv beta$]. The
  *language* of $G$, denoted $L(G)$, is the set of all strings $s$ such that
  $S =>^* s$.
]<syntax:derivation>

Next, we need to convert the combinators in @syntax:invertible-descriptions into
CFG productions. These are based on [CITE], which proves that the combinators
accept exactly the same set of strings as their transformed productions.

- `A - seq -> B` corresponds to $"A_B" => "A" "B"$.

- `A - lexeme -> B` corresponds to $"A_B" => "A" "WS_star" "B"$, where
  $"WS_star" => "WS" "WS_star" | epsilon$.

- `A - seq_many_till -> B` corresponds to $"A_star_B" => "A_star" "B"$, where
  $"A_star" => "A" "A_star" | epsilon$.

- `A - lex_many_till -> B`corresponds to
  $"A_lex_star_B" => "A_lex_star" "WS_star" "B"$ where
  $"A_lex_star" => "A" "WS_star" "A_star" | epsilon$.

#figure(
  $
    "start" => "unit" "WS"
  $,
  caption: [CFG for the Welkin grammar, based on
    @syntax:figure-welkin-grammar.],
)<syntax:converted-cfg>

Substituting these produces @syntax:converted-cfg, and we obtain the following
theorem.

#theorem[
  The Welkin grammar (@syntax:figure-welkin-grammar) accepts exactly the same
  ASCII words as @syntax:converted-cfg.
]<syntax:original-equiv-cfg>

#definition[
  (@compilers-dragon-book). Let $G = (N, T, P)$ be a CFG and string of grammar
  symbols $A$.
  - The *FIRST* set, denoted $"FIRST"(A)$, consists of all $beta$ such that
    $alpha => beta gamma_1 ... gamma_n$, as well as $epsilon$ if the grammar
    contains a a production $alpha => epsilon$.
  - The *FOLLOW* set, denoted $"FOLLOW"(A)$, is the set of all non-terminals $A$
    such that, for some $alpha$ and $beta$, $S =>^* alpha A a beta$.
]<syntax:first-and-follow>

Using this definition, we are now ready to define $"LL"(1)$ grammars.

#definition[(@compilers-dragon-book[Ch. 5]). A CFG is $"LL"(1)$ if and only if
  for every production #box[$A => alpha | beta$]:
  - At most one of $alpha$ or $beta$ can derive $epsilon$.
  - $"FIRST"(alpha)$ and $"FIRST"(beta)$ are disjoint.
  - if $epsilon in "FIRST"(beta)$, then $"FIRST"(alpha)$ and $"FOLLOW"(A)$ are
    disjoint. A similar condition is required on $beta$ if
    $epsilon in "FIRST"(alpha)$.
]<syntax:LL1>

Now, we work on the proof that the new grammar is $"LL"(1)$.

#theorem[
  The grammar in @syntax:converted-cfg is $"LL"(1)$. Hence, the Welkin grammar
  @syntax:figure-welkin-grammar is unambiguous.
]
#proof[
  We first observe that the character classes in @syntax:character-classes are
  disjoint from each other.
  - Strings are enclosed in quoets and do not overlap with $"RESERVED"$ or
    $"WHITESPACE"$.
  - IDs are defined to be disjoint from $"RESERVED"$ or $"WHITESPACE"$.

  It remains to show that all other applicable rules satisfy @syntax:LL1. For
  this, see the calculations in @syntax:LL1-calculations. Because the
  intersections in this table are all empty, and because at most one derivation
  derives $epsilon$ in a given choice, this proves that @syntax:converted-cfg is
  $"LL"(1)$. Thus, by @syntax:original-equiv-cfg, the Welkin grammar accepts the
  same strings as an unambiguous language.

  #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      table.header(
        [*Rule*], [*Sets*], [*Set One*], [*Set Two*], [*Intersection*],
        [$"unit"$], [], [], [], [],
      ),
    ),

    caption: [Calculations needed for $"LL"(1)$ proof.],
  )<syntax:LL1-calculations>
]

By @syntax:original-equiv-cfg, we immediately obtain the following.

#theorem[
  The Welkin grammar (@syntax:figure-welkin-grammar) is unambiguous.
]
