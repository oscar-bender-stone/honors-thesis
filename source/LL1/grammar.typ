// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let ll1-grammar = figure(
  ```
  start ::= (term ",")* term
  term ::= arc | graph | path
  arc ::= (term "-" term "->)+ term
        | (term "<-" term "-")+ term
        | (term "-" term "-")+ term
  graph ::= path? { term* }
  path ::= unit | "."."*" | "."+
  dots ::= "." dots*
  unit ::= IMPORT | ID | STRING
  ```,
  caption: "Transformed LL(1) grammar for Welkin.",
)
