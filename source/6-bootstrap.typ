// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Bootstrap <bootstrap>

// TODO: decide soon whether to include proofs IN the bootstrap!
// Definitely need to finsih those soon, if so
This section proves that there is a file, which we call `weklin.welkin`, that
contains enough information to _represent_ Welkin. We do not bootstrap proofs in
this thesis, but that could easily be a future extension.


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
#let bootstrap-text = ```
#welkin,

radix {
  bit --> 0 | 1,
  digit --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9,
  nibble --> decimal | A | B | C | D | E | F,
}

word {
  @radix,

  . --> "0b".&binary) | decimal | "0x".&hex,
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

```

// TODO: make this neater!
// Probably set as an appendix?
#block(bootstrap-text, breakable: true),
