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
  chain           ::= arc term chain
                    | graph
                    | epsilon
  graph           ::= "{" terms "}"
  terms           ::= term separator terms | ε
  separator       ::= "," | ε

  link            ::= "<-" arrow_tail
                    | "-" dash_tail
  arrow_tail      ::= "->" | epsilon
  edge_tail       ::= "-" | epsilon

  DOTS            ::= STAR | "." DOTS | ε
  STAR            ::= "." "*"
  NAME            ::= ID | STRING

  ```,
  caption: "Transformed LL(1) grammar for Welkin.",
)
