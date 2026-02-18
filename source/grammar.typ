// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let grammar = [
  ```
  start ::= (term ",")* term
  term ::= toplevel | arc | graph | path
  toplevel ::= "#" NAME
  arc ::= (term "-" term "->)+ term
        | (term "<-" term "-")+ term
        | (term "<-" term "->")+ term
        | (term "-" term "-")+ term
  graph ::= path? { term* }
  path ::= unit | "."."*" | "."+
  dots ::= "." dots*
  unit ::= IMPORT | NAME
  NAME ::= ID | STRING
  DOTS ::= ".*" | "."+ | "."
  ```
]
