// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let ll1-refactor-table = table(
  columns: (auto, auto, auto),
  [*Original*], [*Transform*], [*LL(1)*],
)

#let ll1-refactor = figure(
  ll1-refactor-table,
  caption: "Step by step refactor for the ",
)
