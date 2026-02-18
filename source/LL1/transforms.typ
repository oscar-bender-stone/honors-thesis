// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// To reference individual cells,
// we adapt this solution from @Andrew
// on the typst forms:
// https://forum.typst.app/t/how-do-i-include-custom-references-to-items-in-a-table/4409/3
#show figure.where(kind: "ll1-transform"): it => it.body // remove block

#let req-counter = counter("ll1-transform")
// #req-counter.update(1)
#let Transform(name, description) = {
  let no() = req-counter.display() + req-counter.step()
  let number() = req-counter.get().first()
  let transform() = figure(
    kind: "transform",
    supplement: "Transform",
    numbering: "1.",
  )[]
  let transform-context = context [T#no()#transform()#label(
      "ll1-transform:" + str(number()),
    )]
  (
    strong(transform-context),
    strong(name),
    description,
  )
}

#let ll1-transforms = figure(
  table(
    columns: (auto, auto, 1fr),
    [*Rule ID*], [*Name*], [*Description*],

    ..Transform[Group Flattening][Converts Kleene stars `(A)*` into
      right-recursive forms
      `A' ::= AS' | epsilon`],
    ..Transform[Left Refactoring][Transforms `A ::= BC | BD` into `A ::= B A'`,
      where `A ::= C | D`.],
    ..Transform[Left-Recursion Removal][Transforms `A ::= A B | C` into
      `A ::= C A'` and `A' ::= BA' | epsilon`],
  ),
  caption: [Well known transformations on grammars that preserve string
    acceptance. For proofs, see @compilers-dragon-book.],
)
