// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: maybe provide brief rationales for each transformation?
#let ll1-refactor-table = table(
  columns: (auto, auto, auto),
  [*Original*], [*Transform*], [*LL(1)*],
  [`start ::= (term ",")* term`],
  [@ll1-transform:0, @ll1-transform:1],
  [```
    start ::= term terms
    terms ::= "," terms | epsilon
    terms_tail ::= term terms | epsilon
    ```
  ],

  [`term ::= toplevel | arc | graph | unit`],
  [@ll1-transform:2],
  [```
  term ::= toplevel | unit | adjunct | "." DOTS | "{" terms "}"
  ```],

  [`toplevel ::= "#" NAME`], [N/A], [-],

  [```
  arc ::= (term "-" term "->)+ term
          | (term "<-" term "-")+ term
          | (term "<-" term "->")+ term
          | (term "-" term "-")+ term
  ```],
  [@ll1-transform:1, @ll1-transform:2],
  [```
  suffix ::= link term suffix | graph | epsilon
  chain  ::= arc unit chain | graph | epsilon
  right_link ::= "->" | epsilon
  edge_link ::=  "-" | epsilon

  ```],
)

#let ll1-refactor = figure(
  ll1-refactor-table,
  caption: [Refactor of grammar @welkin-grammar into @grammar_ll1. Entries with
    `-` mean that no changes are needed.],
)
