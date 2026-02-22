// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: maybe provide brief rationales for each transformation?
#let ll1-refactor-table = table(
  columns: (auto, auto, auto),
  inset: 3pt,
  align: (left, center, left),
  fill: (x, y) => if y == 0 { luma(200) } else { none },
  table.header([*Original*], [*Transform*], [*LL(1)*]),

  // 1. Start Rule (Comma Logic)
  [`start ::= terms`, \ `terms ::= term ("," term)* ","? | EPS`],
  [@ll1-transform:0],
  [```
  start      ::= terms
  terms      ::= term terms_tail | EPS
  terms_tail ::= "," terms | EPS
  ```],

  // 2. Term & Arc (Left Recursion)
  [```
  term ::= arc | graph |
           group | path
  arc  ::= (term ("-" | "<-")
            term ("-" | "->"))+ term
  ```],
  [@ll1-transform:3],
  [```
  /* Extracted 'node' to fix recursion.
     Arcs are strict left/right link pairs */
  term       ::= node chain

  chain      ::= left_link node right_link
                 node chain | EPS

  left_link  ::= "-" | "<-"
  right_link ::= "-" | "->"
  ```],

  // 3. Ambiguity Resolution
  [```
  graph ::= path? "{" terms "}"
  tuple ::= path? "(" terms ")"
  path  ::= modifier? path_segment* unit
  ```],
  [@ll1-transform:1, \ @ll1-transform:2],
  [```
  /* Left-factor path & blocks. */
  node       ::= PATH opt_block | block
  opt_block  ::= block | EPS
  block      ::= "{" terms "}"
               | "(" terms ")"

  /* Expand path +, * contiguously */
  PATH       ::= MODIFIER PATH_BODY
               | PATH_BODY
  PATH_BODY  ::= "." PATH_DOTS
               | UNIT PATH_TAIL
  PATH_DOTS  ::= "*" PATH_BODY
               | "." PATH_DOTS
               | UNIT PATH_TAIL
  PATH_TAIL  ::= PATH_BODY | EPS
  ```],
)

#let ll1-refactor = figure(
  ll1-refactor-table,
  caption: [Refactor of grammar @welkin-grammar into @grammar_ll1. Entries with
    `-` mean that no changes are needed.],
)
