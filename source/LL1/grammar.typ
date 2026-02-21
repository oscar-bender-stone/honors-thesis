// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let ll1-grammar = figure(
  ```
  start    ::= terms
  terms    ::= term ("," term)* ","? | EPS
  term     ::= arc | graph | path | group
  arc      ::= (term ("-" | "<-") term ("-" | "->"))+ term
  graph    ::= path? "{" terms "}"
  group    ::= path? ("(" terms ") | "[" terms "]")

  path     ::= path_segment* unit
  path_segment ::= MODIFIER? (UNIT | ".*" | "."+)

  UNIT     ::= IMPORT | ID | STRING
  MODIFIER   ::= "#" | "@" | "~@" | "&"
  ID         ::= ID_CHAR+
  ID_CHAR    ::= PRINTABLE \ (DELIMITERS | WHITESPACE | "#" | "@" | "~" | "&" | "'" | '"')
  DELIMITERS ::= "," | "." | "-" | "<" | ">" | "*" | "(" | ")" | "[" | "]" | "{" | "}"
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
