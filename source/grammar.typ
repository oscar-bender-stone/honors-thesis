// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let grammar = [
  ```
  start        ::= terms
  terms        ::= term ("," term)* ","? | EPS
  term         ::= arc | graph | tuple | path
  arc          ::= (term ("-" | "<-") term ("-" | "->"))+ term
  graph        ::= path? "{" terms "}"
  tuple        ::= path? "(" terms ")"

  path         ::= MODIFIER? path_segment* unit
  path_segment ::= unit | ".*" | "."+
  unit         ::= ID | STRING


  MODIFIER ::= "#" |  "@" | "~@" | "~"
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
  PRINTABLE  ::= [0x20-0x7E]
  WHITESPACE ::= [0x09, 0x0A, 0x0D, 0x20]
  DELIMITER ::= [0x7B, 0x7D, 0x2C, 0x2D, 0x2A, 0x3C, 0x3E, 0x22, 0x27, 0x5C, 0x7D]
  EPS        ::= ""
  ```
]
