// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let ll1-grammar = figure(
  ```
  start           ::= term sequence
  terms           ::= "," terms_tail| EPS
  terms_tail      ::= term terms | EPS
  term            ::= toplevel
                    | unit relation
                    | "." DOTS
                    | "{" terms "}"
  toplevel        ::= "#" NAME
  unit            ::= IMPORT | NAME
  relation        ::= graph | arc | EPS
  chain           ::= LINK unit chain
                    | graph
                    | epsilon

  graph           ::= "{" contents "}"
  contents        ::= term separator terms | EPS
  separator       ::= "," | EPS

  LINK            ::= "<-" | "->" | "-"

  DOTS            ::= STAR | "." DOTS | EPS
  STAR            ::= "." "*"
  NAME            ::= ID | STRING

  IMPORT ::= "@" ID
  ID :: ID_CHAR+
  ID_CHAR ::= PRINTABLE / (DELIMITERS + WHITESPACE + "#" + "@" + "'" + "\"")
  STRING ::= SQ_STRING | DQ_STRING
  SQ_STRING ::= "'" (SQ_CHAR | ESCAPE_SQ )* "'"
  DQ_STRING ::= "'" (DQ_CHAR | ESCAPE_DQ )* "'"

  SQ_CHAR ::= PRINTABLE \ {'}
  DQ_CHAR ::= PRINTABLE \ {"}
  ESCAPE_SQ ::= "\'" | "\\"
  ESCAPE_DQ ::= "\"" | "\\"

  EPS ::= ""
  ```,
  caption: "Transformed LL(1) grammar for Welkin, with all terminals defined.",
)
