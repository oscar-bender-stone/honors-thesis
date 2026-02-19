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
    terms ::= "," terms | END
    terms_tail ::= term terms | END
    ```
  ],

  [`term ::= toplevel | arc | graph | unit`],
  [@ll1-transform:2],
  [```
    term ::= toplevel | unit relation | "." DOTS | "{" terms "}"
    relation ::= graph | arc | EPS
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
  chain ::= LINK unit chain
          | graph
          | END
  LINK ::= "<-" | "->" | "-"
  ```],

  [`graph ::= path? { term* }`],
  [@ll1-transform:1],
  [```
  graph     ::= "{" contents "}"
  contents  ::= term separator term | END
  SEPARATOR ::= "," | END
  ```],

  [`path ::= unit | ".*" | "."+`],
  [@ll1-transform:1],
  [```
  PATH_ALT ".*" | "." DOTS
  ```],
)

#let ll1-refactor = figure(
  ll1-refactor-table,
  caption: [Refactor of grammar @welkin-grammar into @grammar_ll1. Entries with
    `-` mean that no changes are needed.],
)
