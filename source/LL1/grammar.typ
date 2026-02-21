// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: fix! Wrong grammar!
#let ll1-grammar = figure(
  ```
  start      ::= terms
  terms      ::= term terms_tail | EPS
  terms_tail ::= "," terms | EPS
  term       ::= node chain

  chain      ::= left_link node right_link
                 node chain | EPS

  left_link  ::= "-" | "<-"
  right_link ::= "-" | "->"

  path     ::= path_segment* unit
  path_segment ::= MODIFIER? (UNIT | ".*" | "."+)

  node       ::= PATH opt_block | block
  opt_block  ::= block | EPS
  block      ::= "{" terms "}"
               | "(" terms ")"

  PATH       ::= MODIFIER PATH_BODY
               | PATH_BODY
  PATH_BODY  ::= "." PATH_DOTS
               | UNIT PATH_TAIL
  PATH_DOTS  ::= "*" PATH_BODY
               | "." PATH_DOTS
               | UNIT PATH_TAIL
  PATH_TAIL  ::= PATH_BODY | EPS

  UNIT     ::= IMPORT | ID | STRING
  MODIFIER   ::= "#" | "@" | "~@" | "&"
  ID         ::= ID_CHAR+
  ID_CHAR    ::= PRINTABLE \ (DELIMITERS | WHITESPACE | "#" | "@" | "~" | "'" | '"')
  DELIMITERS ::= "," | "." | "-" | "<" | ">" | "*" | "(" | ")" | "{" | "}"
  STRING     ::= SQ_STRING | DQ_STRING
  SQ_STRING  ::= "'" (SQ_CHAR | ESCAPE_SQ )* "'"
  DQ_STRING  ::= '"' (DQ_CHAR | ESCAPE_DQ )* '"'
  SQ_CHAR    ::= PRINTABLE \ {"'"}
  DQ_CHAR    ::= PRINTABLE \ {'"'}
  ESCAPE_SQ  ::= "\'" | "\\"
  ESCAPE_DQ  ::= '\"' | "\\"
  EPS        ::= ""
  ```,
  caption: "Transformed LL(1) grammar for Welkin, with all terminals defined.",
)
