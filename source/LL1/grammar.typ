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
  graph           ::= "{" terms "}"
  terms           ::= term separator terms | ε
  separator       ::= "," | ε
  arc             ::= "-"  term arrow_chain
                    | "<-" term dash_chain

  dash_chain      ::= "->" right_edge_chain
                    | "-"  plain_edge_chain

  arrow_chain     ::= "-"  left_edge_chain
                    | "->" symmetric_chain
  right_chain     ::= "-" term "->" right_chain | ε
  left_chain      ::= "<-" term "-" left_chain  | ε
  edge_chain      ::= "-" term "-" plain_chain  | ε
  symmetric_chain ::= "-" term "->" symmetric_chain  | ε
  DOTS            ::= STAR | "." DOTS | ε
  STAR            ::= "." "*"
  NAME            ::= ID | STRING

  ```,
  caption: "Transformed LL(1) grammar for Welkin.",
)
