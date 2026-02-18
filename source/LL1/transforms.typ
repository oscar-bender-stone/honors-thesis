// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let ll1-transforms = figure(
  table(
    columns: (auto, auto, auto),
    [*Rule ID*], [*Name*], [*Transformation*],
    [*T1*],
    [*Group Flattening*],
    [Converts Kleene stars `(A)*` into right-recursive forms
      `A' ::= AS' | epsilon`],

    [*T2*],
    [*Left Refactoring*],
    [Transforms `A ::= BC | BD` into `A ::= B A'`, where `A ::= C | D`.],

    [*T3*],
    [*Left-Recursion Removal*],
    [Transforms `A ::= A B | C` into `A ::= C A'` and `A' ::= BA' | epsilon`],
  ),
  caption: [Well known transformations on grammars that preserve string
    acceptance. For proofs, see @compilers-dragon-book.],
)
