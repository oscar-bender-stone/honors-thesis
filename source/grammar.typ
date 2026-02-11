// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: ensure final grammar IS LL(1)!
#let grammar = [
  ```
  start ::= (term ",")* term
  term ::= arc | graph | base
  arc ::= (term "-" term "->)+ term
        | (term "<-" term "-")+ term
        | (term "-" term "-")+ term
  graph ::= unit? { term* }
  base ::= unit | string
  unit ::= int
  ```
]
