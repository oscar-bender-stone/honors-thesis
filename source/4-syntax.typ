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

== Numbers

[TODO[MEDIUM]: make this easier to use! Maybe *just* use binary or so? OR can
formally define digits and nibbles later, if so we choose.]

We add numbers and provide equivalnces between them. Before this, we need an
important construction: *general pairs*.

Welkin's main encoding uses binary words, but add notation for decimal and
hexadecimal.

#figure(
  ```
  bit <--> 0 | 1,
  digit <--> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9,
  nibble <--> A | B | C | D | E | F
  ```,
  caption: "Binary, decimal, and hexadecimal digits.",
)<digits>

#figure(
  ```
  number <--> binary | decimal | hex,
  decimal <--> {top --> bit, next --> decimal},
  hex <--> {top --> nibble, next --> hex}
  ```,
  caption: "Definition of words.",
)<syntax:word>

== Encoding

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
see @syntax:string.

Moreover, we will need the following sets of terminals.

// TODO: convert into using glyphs.
// Maybe use abbreviations for Printable
// *or* list specific character classes?
#figure(
  ```
  // EPS <--> "",
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

In contrast to @leijen-meijer-parsec, however, we include the ability to _print_
as well, via the ideas in @invertible-syntax-descriptions. For the combinators
we need, see @syntax:base-combinators.

#figure(
  [```
  "TODO: provide a way to indicate what are input strings!",
  s | t | u | v --> unit,

  description <--> {parse --> unit, print --> unit},

  WHITESPACE_MANY <--> "" | {WHITESPACE - then -> WHITESPACE_MANY},

  {before - seq -> after} <--> ?,

  {before - then -> after} <--> {before - seq -> WHITESPACE_MANY - seq -> after},

  ```],
  caption: [Definitions for the main combinators used.],
)<syntax:base-combinators>

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
  toplevel <--> {marker --> "#", name --> id}
  import <--> {marker --> "@", graph --> id},
  id <--> {top --> {@printable, ~{@reserved, @whitespace}}, next --> id}
  ```,
  caption: "IDs.",
)<syntax:id>


Strings allow escaped single or double quotes, see @syntax:string. IDs are
special cases of strings that do not require quotes but forbid whitespace and
certain characters, see @syntax:id.

[TODO[SMALL]: determine if terminals should be uppercase.]

#figure(
  ```
  string <--> sq_string | dq_string,
  string_contents <--> sq_contents | dq_contents

  sq_string <--> {start --> "'", contents --> sq_contents, end --> "'"},
  dq_strings <--> {start --> "\"", contents --> dq_contents, end --> "\""},

  sq_contents <--> {top --> "" | {@printable, ~{"\""}}, next --> sq_contents},
  dq_contents <--> {top --> "" | {@printable, ~{"\""}}, next --> dq_contents},
  escape_sq <--> "\'" | "\\",
  escape_dq <--> "\"" | "\\"
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


== Import Resolution
