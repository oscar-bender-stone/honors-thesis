// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let grammar = [
  ```
  start ::= (term ",")* term
  term ::= arc | graph | base
  arc ::= (term "-" term "->)+ term
        | (term "<-" term "-")+ term
        | (term "-" term "-")+ term
  graph ::= (dots? path)? { term* }
  path ::= (base ".")* base
  dots ::= "." dots*
  base ::= ID | STRING
  ```
]
