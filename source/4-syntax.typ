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
    [Defines invertible syntax descriptions, the fundamental building blocks for
      the grammar.],

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
`type-writer font`. For clarity, we will write at a slightly higher level than
@foundations.

== Encoding <syntax:encoding>

Welkin uses ASCII as its base encoding. The term ASCII is slightly ambiguous, as
there are subtly distinct variants, so we formally define US-ASCII as a standard
version. #footnote[Note that this table _itself_ is a representation, which
  represents glyphs with binary words.] We provide the codes for each character
in decimal and hexadecimal, but these can easily be converted into binary words
in Welkin.

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

Moreover, we will need to define *character classes*, or important sets of
characters. These are presented in @syntax:character-classes, with each
character separated by |. Note that strings _may_ contain quotes prefixed with a
slash `\`, refer to @syntax:string.

#figure(
  table(
    columns: (auto, auto),
    align: center,
    table.header([*Set Name*], [*Characters*]),
    [`PRINTABLE`], [Listed in @syntax:printable-ascii-codes.],

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

To more easily describe the language, we provide basic building blocks. Our
approach is based on _parser combinators_, which are functions that take other
parsers as input. We augment these combinators using *invertible syntax
descriptions*, first introduced in @invertible-syntax-descriptions. Here, an
*invertible syntax description* is a pair of functions:
- A *Parser*, converts strings into an intermediate data structure.#footnote[For
    computer scientists: this is an AST. Because this thesis aims to have a
    broader audience, we leave details to @invertible-syntax-descriptions.
  ] We say the parser _consumes_ a string.
- A *Printer*, the reverse of Parser.

Invertible syntax descriptions are used to enable easier formatting. This helps
users more seamlessly switch between a string and the underlying unit. Specific
details are provided in @invertible-syntax-descriptions.

For our use case, we will need four invertible syntax descriptions. These are
based on functions from `parsec`, a Haskell combinator parser library. Here, `A`
and `B` denote meta-variables over syntax descriptions. Parsing `A` means
applying the parser in `A`, and likewise, printing `A` means printing the
corresponding rule. Additionally, `WS` is short-hand for `WHITESPACE`
(@syntax:character-classes).

- `A - seq -> B`:
  - *Parser:* Consumes a string based on `A`. immediately followed by the rule
    `B`. Notice that _no_ `WS` characters are allowed.
  - *Printer:* prints the string `AB`.
- `A - lexeme -> B`:
  - *Parser:* Consumes a string based on `A`. then accepts any number of
    `WHITESPACE` characters, and finally consumes the input based on `B`.
  - *Printer:* first prints `A`, then zero or more `WS` characters, then `B`.
    whitespaces.
- `A - seq_many_till -> B`:
  - *Parser:* Consumes a string based on `A` zero more times, _until_ the input
    is accepted by the rule `B`. Note that the end marker `B` supports
    unambiguous parsing.
  - *Printer:* prints `A*B`, where `A*` is zero or more instances of `A`.
- `A - lex_many_till -> B`:
  - *Parser:* Consumes a string based on `A` _and_ optional whitespace zero more
    times, _until_ the input is accepted by the rule `B`. Note that the end
    marker `B` supports unambiguous parsing.
  - *Printer:* prints zero or more instances of `A` _with_ optional whitespace,
    followed by `B`.

== Strings and IDs <syntax:strings-and-ids>

Strings are defined in @syntax:string, and they allow escaped single or double
quotes. Note that, semantically, single and double quoted strings are
equivalent, consult @syntax:validation-and-transforms.

#figure(
  ```
  STRING := SQ_STRING | DQ_STRING,
  SQ_STRING := "'" - seq -> *{SQ_CHAR, "\'"} - seq_many_till -> "'",
  DQ_STRING := '"' - seq -> *{DQ_CHAR, '\"'} - seq_many_till -> '"',
  ```,
  caption: "Strings.",
)<syntax:string>

IDs are defined in @syntax:id. These are special strings do not require quotes
but forbid whitespace and certain characters. This comparison is reinforced in
@syntax:validation-and-transforms.

#figure(
  ```
  ID := ID_CHAR - seq_many_till -> *{RESERVED, WHITESPACE}
  ```,
  caption: "Syntactic definition of an ID.",
)<syntax:id>

== The Welkin Grammar <syntax:welkin-grammar>

Welkin's grammar is displayed in @syntax:figure-welkin-grammar, inspired by
several languages.

- The binding operator `:=` is inspired by functional languages, emphasizing
how Welkin is immutable. Moreovoer, choices can be written via `|`, which
_themselves_ can include definitions.

- The import system is inspired by Python. Additionally, `*u` is a concept
  borrowed from Python, which gets the contents of a tuple.#footnote[The grammar
    rule `trailer` is also inspired by Python. The Python grammar is available
    at:
    #link("https://docs.python.org/3/reference/grammar.html")]

#let grammar = ```
start := units - lexeme -> EOF,

units := ""
  | {
    unit - lexeme -> {"," - lexeme -> unit}
          - lex_many_until -> *{"", ","}
    },

unit := node - lexeme -> *{"", arc - lexeme -> unit},

arc := right_arc | other_arc,
right_arc := "-" - seq -> node - seq -> "->",
other_arc := "<-" - seq -> node - seq -> *{"-" | "->"},

node := "*"
  - seq_many_till -> *{
    graph,
    path - lexeme -> *{"", binding}
  }

binding := ":=" - lexeme -> choices,
choices := *{"", "|"}
  - lexeme -> unit
  - lexeme -> *{
    "",
    {"|" - lexeme -> unit}
    - lex_many_till -> *{"}", ","}
  },

graph := path
  - lexeme -> "{"
  - lexeme -> units
  - lexeme -> "}",

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
    respectively.],
)<syntax:figure-welkin-grammar>

== Validation and Transformations <syntax:validation-and-transforms>

Due to limited time, this section of the thesis is given at a higher level than
intended. These details may change in the final revision of the language.

We say a string is *valid* if it is accepted by the grammar
(@syntax:figure-welkin-grammar), and the following hold:

- The number of dots (relative import) used must not exceed the number of levels
  available.

- There must be at least one path that starts with `@h`, where `h` is some
  handle. This is used to name the module.

- For all paths that start with `@h1` and `@h2`, respectively, `h1` must be
  equal to `h2`.

- Every definition of a unit must only be stated once. This means
  `u := v, u:= w` is not allowed.

- Accessing a unit $v$ from $u$ requires that $u$ has a closed definition
  containing $v$. This means `u := {v, w}, u.x` is not valid, and neither is
  `u.x` alone.

We leave error handling for future work, described in @conclusion.

Additionally, we define transformation rules after parsing:

- Some node that starts with `@` is found. This marks the module name. Denote
  this name as $m$.

- If `\'` appears in a single quoted string, then this will be replaced by `'`
  in the final contents. For example, given a string `"John\'s dog"`, the
  contents would be `John's dog`.

- A similar rule applies for `"` but with `\"`.

- Double slashes `\\` are converted into one slash `\`.

- Single and double quoted strings are represent each other. For example,
  `'hello' <--> "hello"`. In fact, IDs are special cases of strings, so
  `hello <--> 'hello'`. Practically, the only difference is that units forbid
  `WHITESPACE` or `RESERVED` characters, but they can be written without quotes.

- Paths are resolved, determined where the unit originated. For example, in
  `a, c := {.a, b}`, the `.a` inside `c` would be expanded as `a`.

- Each `*u` for a handle or graph `u` expands to all the members in the enclosed
  unit. If `u` contains a at most one item or is a representation, then `*u` is
  expanded as `u`. Multiple `*`, such as `**u`, recursively expands the contents
  in a unit.

- Each definition `x := a1 | ... | an` expands to
  `x <--> {x - x -> a1, ..., b - x -> an}`. For each graph `a1`, the generated
  graph will contain `v - x -> v`, where `v` is a handle or representation in
  `a1`.

- Each `~x` expands to `x - g -> {}`, where `g` is the name where `~x` is
  placed. At the highest level, this would be the module name, $m$.

== Proof of Unambiguity <syntax:proof-unambiguous>

We show that, by construction, the combinators we used form an $"LL"(1)$
grammar. These grammars have two desirable properties:
- If a string is accepted, it is parsed unambiguously.
- Efficient parsers can be easily and efficiently implemented
  @compilers-dragon-book[Sect. 4.4.3].

Our approach is to based on the work of @edelmann-ll1-parsing. There, they
define $LL(1)$ parsing specifically for parser combinators, which an equivalence
between @syntax:figure-welkin-grammar and a new grammar. More precisely, we
require a bijection with the following property: a string accepted by
@syntax:figure-welkin-grammar is also accepted by the new grammar, and vice
versa. We will then prove the latter is $"LL"(1)$.

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
  The Welkin grammar @syntax:figure-welkin-grammar is $"LL"(1)$, and is
  therefore unambiguous.
]
#proof[
  We first observe that the character classes in @syntax:character-classes are
  disjoint from each other.
  - Strings are enclosed in quoets and do not overlap with $"RESERVED"$ or
    $"WHITESPACE"$.
  - IDs are defined to be disjoint from $"RESERVED"$ or $"WHITESPACE"$.

  It remains to show that all other applicable rules satisfy @syntax:LL1. The
  calculations are given in @syntax:LL1-calculations. Because the intersections
  in this table are all empty, and because at most one derivation derives
  $epsilon$ in a given choice, this proves that @syntax:figure-welkin-grammar
  $"LL"(1)$. Thus, as all $"LL"(1)$ grammars are uanmbiguous by construction, so
  is the Welkin grammar.

  #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      table.header(
        [*Rule*], [*Conflict Type*], [*Set One*], [*Set Two*], [*Intersection*],
        [$"unit"$], [], [], [], [],
      ),
    ),

    caption: [Calculations needed for $"LL"(1)$ proof.],
  )<syntax:LL1-calculations>
]
