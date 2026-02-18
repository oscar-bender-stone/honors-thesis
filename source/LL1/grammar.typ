// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let ll1-grammar = figure(
  ```
  start           ::= term sequence
  terms           ::= "," terms_tail| ε
  terms_tail      ::= term terms | ε
  term            ::= toplevel
                    | unit adjunct
                    | "." DOTS
                    | "{" terms "}"
  toplevel        ::= "#" NAME
  unit            ::= IMPORT | NAME
  adjunct         ::= graph | arc | ε
  chain           ::= LINK unit chain
                    | graph
                    | epsilon

  graph           ::= "{" contents "}"
  contents        ::= term separator terms | ε
  separator       ::= "," | ε

  LINK            ::= "<-" | "->" | "-"

  DOTS            ::= STAR | "." DOTS | ε
  STAR            ::= "." "*"
  NAME            ::= ID | STRING

  ```,
  caption: "Transformed LL(1) grammar for Welkin.",
)
