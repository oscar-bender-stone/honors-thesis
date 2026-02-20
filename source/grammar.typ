// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let grammar = [
  ```
  start     ::= (term ",")* term
  term      ::= root | arc | graph | path | group
  root      ::= "#" NAME
  arc       ::= (term "-" term "->")+ term
              | (term "<-" term "-")+ term
              | (term "<-" term "->")+ term
              | (term "-" term "-")+ term
  graph     ::= path? "{" term* "}"
  group     ::= "(" (term ",")* term ")"
            | "[" (term ",")* term "]"
  path      ::= modifier? unit | ".*" | "."+
  modifier  ::= "@" | "~@" | "&"
  unit      ::= IMPORT | NAME | "#."
  ```
]

