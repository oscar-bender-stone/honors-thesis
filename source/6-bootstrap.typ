// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark

= Bootstrap <bootstrap>

[TODO: decide soon whether to include proofs IN the bootstrap!]

This section proves that there is a file, which we call `weklin.welkin`, that
contains enough information to _represent_ Welkin. We do not bootstrap proofs in
this thesis, but that could easily be a future extension.

== Welkin64 <welkin64>

As mentioned in the start of @syntax, we address a major practical concern:
determining the truth of a claim in Welkin, such as whether a string is accepted
by the grammar or whether a database contains enough information to solve a
query. The notion of "finite" is limited by implementations ability to check for
correctness up to a certain bound. This phenomena is known as "Kripkenstein"
@kripke_wittgenstein and poses a major problem with creating a reliable Trusted
Computing Base.

[TODO: create this boolean formula! Do we *include* parsing in this or *only*
involve units and a specific, efficient implementation for a global ID system
with arcs?] For our use case, we define 64 bit hashes. This can be defined by a
predetermined boolean formula.

== Revisions

[TODO: complete this stub! These are my short ideas, but I think this is enough.
Metadata, like time, can be added separately. This is a perfect use case of
representations!]

Welkin enables revisions through a builtin unit called `revision`. Users can
create a list. Alternatively, they may import revisions from separate files,
which may be automated by an implementation (but with all files visible for
direct access).

[TODO: combine with validation of a unit _defined_ by a unit. This would be
great to have in the language and likely may need its own subunit in `welkin`.]
#definition[
  The contents of a revision must not include recursion and no context-sensitive
  rules. Only direct representations are allowed (aliases), but scopes may be
  used, following Welkin's usual rules.]

Interestingly, the revision unit allows for "meta-revisions", or revisions on
revisions. This flexibility is enabled through Welkin, but is fundamentally
starts with revision. Moreover, Welkin can optimize graphs that satisfy the
rules of a revision and _internally_ store such as a revision, which can be user
accessed.

For more details, see the end of the bootstrap.

== Self-Contained Standard

This section is self-contained and defines _everything_ necessary about Welkin.
The complete bootstrap is in appendix ?.


// TODO: emphasize that Welkin is
// homo-iconic, similar to lisp!
// Very powerful!
// TODO: double check grammar!
// Decide whether to use LL(1) grammar.
// Also removes needed for EBNF (for simplicity)
// FIXME: remove ANY traces of EBNF in this bootstrap
#let bootstrap-text = ```welkin
"TODO: make sure this is complete! It is NOT currently",
#welkin,

radix {
  bit --> 0 | 1,
  digit --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9,
  nibble --> decimal | A | B | C | D | E | F,
}

word {
  @radix,

  . --> "0b".binary) | decimal | "0x".hex,
  binary --> bit | binary.bit,
  decimal --> digit | decimal.digit,
  hex --> nibble | hex.nibble,
  {
    {w, w', w''} --> binary | decimal | hex,
    (w.w').w'' <--> w.(w'.w'')
  }
}

ASCII {

}

character_classes {
  PRINTABLE,
  DELIMITERS,
}

grammar {
  @word,
  @character_classes,

  start --> terms,
  terms --> term ("," term)* ","? | EPS
  term  --> arc | graph | group | path
  arc   --> (term ("-" | "<-") term ("-" | "->"))+ term
  graph --> path? "{" terms "}"
  group --> path? ("(" terms ")" | "[" terms "]")
  path --> MODIFIER? path_segment* unit
  path_segment --> unit | ".*" | "."+,
  unit --> ID | STRING,

  MODIFIER --> "#" | "@" | "~@" | "&",
  ID --> ID_CHAR | ID_CHAR ID,
  ID_CHAR --> {.PRINTABLE, ~@{.DELIMITERS, .WHITESPACE}},
  DELIMITERS --> "," | "." | "-" | "<" | ">" | "*" | "(" | ")" | "[" | "]" | "{" | "}"
  STRING --> SQ_STRING | DQ_STRING,
  SQ_STRING --> '"' SQ_CONTENTS '"',
  DQ_STRING ::= "'" DQ_CONTENTS "'",
  SQ_CONTENTS --> SQ_CHAR | SQ_CHAR.DQ_CONTENTS,
  DQ_CONTENTS --> DQ_CHAR | DQ_CHAR.DQ_CONTENTS,
  SQ_CHAR --> {.PRINTABLE, ~"'"},
  DQ_CHAR --> {.PRINTABLE, ~'"'},
  ESCAPE_SQ --> "\'" | "\\",
  ESCAPE_DQ --> '\"' | '\\',
  EPS --> ""
}

AST {
  "Abstract Syntax Tree" --> .,

}

evaluation {

}

organization {


}


revision {

}

```

// TODO: make this neater!
// Probably set as an appendix?
#block(bootstrap-text, breakable: true),
