// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo
#import "us-ascii.typ": printable-ascii-table

#import "grammar.typ": grammar

// TODO: create a "current working file" or such,
// or "current working context", and then use *that*
// when getting input! (Though it could be streamed;
// we're using handles as an effective abstraction here!
// Do also make sure multiple users *could* use it as well,
// so need to make that clear. Might need a notion
// of a user/original source at a time.)
// TODO: need to figure out an effective way
// to get revisions! And need to keep in mind,
// might be implementation specific!
// So just need to *create* the map
// (
//   name: "Module",
//   lbl: "r:module",
//   content: [$\#h_1 <--> \#h_2$ if and only if $h_1 <--> h_2$.],
// ),

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

[TODO[MEDIUM]: make imports precise! We *want* to get into using dot notation as
soon as possible!]

Note that *R2 (Context Lifting)* will be crucial to define the syntax.

== Encoding

Welkin uses ASCII as its base encoding. The term ASCII is slightly ambiguous, as
there are subtly distinct variants, so we formally define US-ASCII as a standard
version. #footnote[Note that this table _itself_ is a representation, which
  represents glyphs with binary words.]

[TODO: for simplicity, just use binary for the encoding.]
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
see @syntax:string.

Moreover, we will need the following sets of terminals.

// TODO: convert into using glyphs.
// Maybe use abbreviations for Printable
// *or* list specific character classes?
#figure(
  ```
  PRINTABLE <--> {ENCODING, ~ENCODING.EOF},
  WHITESPACE <--> "\t" | "\n" | "\r" | " ",
  RESERVED <--> @DELIMITER | "*" | "\" | "@" | "#",
  DELIMITER <--> "{" | "}" | "'"| "." | "," | "|"
  ```,
  caption: "Important character classes.",
)<terminal-classes>

== Invertible Syntax Descriptions

To more easily describe the language, we provide basic building blocks. Note
that one of these, $|$, can be desugared in the bootstrap. For simplicity, we do
not add many primitives. The names are taken from the the `parsec` combinator
library in the programming language Haskell @leijen-meijer-parsec. The authors
use the following notation:

- `seq` to mean two rules that must be concatenated _directly_, no whitespace
  allowed.

- `lexeme`, to mean two rules can be joined with any number of whitespaces in
  between.

- `many_till`, to mean that in `A - many_till -> B`, parse zero or more
  instances of `A` until `B` is encountered.

In contrast to @leijen-meijer-parsec, however, we include the ability _print_ as
well or present the corresponding string. This is done through
@invertible-syntax-descriptions. For the combinators we need, see
@syntax:base-combinators.


[TODO: an important thing is making sure that when using the standard library,
invariants are held! So we may need verifier to come into play here!]

[TODO: explain that we will keep `a` vs `"a"` distinct, just to make parsing
easier.] #figure(
  [```
  "TODO: indicate errors somehow! Likely needs to the accept/reject mechnaism in verify!",
  input <--> {} | {begin --> character, next --> input},

  codec <--> {
    parse --> unit,
    print --> unit,

    {s --> input, u --> unit, ~{s - parse -> {}}} -->
    {
      {s - parse -> u}
      <-->
      {u - print -> s}
    }
  },

  "TODO: incorporate abstract syntax tree here! Important!",
  {before - seq -> after} <--> {
    @codec,
    parse -->
    | "" --> {},
    | {c --> char} --> {name --> c}

    print -->
    | {} --> ""
    |
    ,
  },

  {before - many_till -> after} <--> {
    repeat <--> {} | before - seq -> repeat,
    repeat - seq -> after
  },

  {before - lexeme -> after} <--> {before - seq -> WHITESPACE - many_till -> after}
  ```],
  caption: [Definitions for the main combinators used.],
)<syntax:base-combinators>


#lemma[
  In the combinators above, `parser` commutes with `print`. More precisely: ?.
]<syntax:combinator-correctness>
#proof[

]

== Character Classes

// TODO: complete table
#figure(
  printable-ascii-table(),
  caption: [Printable US-ASCII codes and glyphs.],
)<syntax:printable-ascii-codes>

We denote specific characters through quotes, escaping if necessary. There are
several important character classes in @terminal-classes, denoted through double
quotes.

#figure(
  ```
  MODULE <--> {"#" - seq -> ID},
  IMPORT <--> {"@" - seq -> ID}
  ID <--> {{@printable, ~{@reserved, @whitespace}} - many_till -> @reserved | @whitespace}
  ```,
  caption: "IDs.",
)<syntax:id>


Strings allow escaped single or double quotes, see @syntax:string. IDs are
special cases of strings that do not require quotes but forbid whitespace and
certain characters, see @syntax:id.

[TODO: clean up with `many_till`!] #figure(
  ```
  STRING <--> SQ_STRING| DQ_STRING,
  STRING_CONTENTS <--> SQ_CONTENTS | DQ_CONTENTS,

  SQ_STRING <--> {start --> "'", contents --> SQ_CONTENTS, end --> "'"},
  DQ_STRING <--> {start --> "\"", contents --> DQ_CONTENTS, end --> "\""},

  SQ_CONTENTS <--> {{@printable, ~{"\""}}| {"\" - seq -> "\" | "'"}, next --> SQ_CONTENTS},
  DQ_CONTENTS <--> {top --> "" | {@printable, ~{"\""}}| {"\" - seq -> "\" | "\""}, next --> DQ_CONTENTS},
  ```,
  caption: "Strings.",
)<syntax:string>

== The Welkin Grammar

Welkin's grammar is displayed in @welkin-grammar, inspired by a minimal, C-style
syntax.

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

== Import Resolution
