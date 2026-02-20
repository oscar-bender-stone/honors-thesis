// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// To reference individual cells,
// we adapt this solution from @Andrew
// on the typst forms:
// https://forum.typst.app/t/how-do-i-include-custom-references-to-items-in-a-table/4409/3
#show figure.where(kind: "ll1-transform"): it => it.body

#let req-counter = counter("ll1-transform")
#req-counter.update(0)

#let Transform(name, description) = {
  let no() = req-counter.display() + req-counter.step()
  let number() = context req-counter.get().first()
  let transform() = figure(
    kind: "ll1-transform",
    supplement: "Transform",
    numbering: "1",
  )[]
  let transform-context = context [T#no()#transform()#label(
      "ll1-transform:" + str(req-counter.get().first()),
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
    align: (center, left, left),
    fill: (x, y) => if y == 0 { luma(200) } else { none },
    table.header([*Rule ID*], [*Name*], [*Description*]),

    ..Transform[Group Flattening][Converts Kleene stars `A*` and regex-like
      lists into right-recursive forms `A' ::= A A' | EPS`.],
    ..Transform[Left Refactoring][Transforms overlapping prefixes
      `A ::= B C | B D` into `A ::= B (C | D)` to eliminate FIRST set
      collisions.],
    ..Transform[Lexical State Expansion][Expands complex sequence operators
      (`+`, `*`) into strict right-recursive terminal rules, ensuring contiguous
      consumption without whitespace interruptions.],
    ..Transform[Left-Recursion Removal][Eliminates immediate left-recursion
      `A ::= A B | C` by rewriting as `A ::= C A'` and `A' ::= B A' | EPS` to
      prevent infinite loops.],
  ),
  caption: [Well known transformations on grammars that preserve string
    acceptance.],
)
