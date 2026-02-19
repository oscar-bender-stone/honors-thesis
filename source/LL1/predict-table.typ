// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: maybe use | as the separator?
#let ll1-predict-table = table(
  columns: (auto, auto, 1fr),
  inset: 6pt,
  fill: (x, y) => if y == 0 { luma(200) },
  [*Non-Terminal*], [*Lookahead (a)*], [*Production Chosen*],

  ["start"],
  [#set text(size: 9pt); `"#"` , ID, STRING, IMPORT, `"."`, `"{"`],
  [`term terms`],

  ["sequence"], [ `","` ], [ `"," terms terms` ],
  [], [ EOF ], [ EPS ],

  ["term"], [ `"#"` ], [ "toplevel" ],
  [], [ ID, STRING, IMPORT ], [ `unit chain` ],
  [], [ `"."` ], [ `"."` "DOTS" ],
  [], [ `"{"` ], [ `"{"` "terms" `"}"` ],

  ["suffix"], [ `"{"` ], [ "graph" ],
  [], [ `"-"`, `"<-"`, `"->"` ], [ "arc" ],
  [], [ `","`, `"}"`, EOF ], [ EPS ],

  ["DOTS"], [ `".*"` ], [ STAR ],
  [], [ `"."` ], [ `"."` "DOTS" ],
  [], [ `","`, `"}"`, EOF ], [ EPS ],
)

#let ll1-predict-figure = figure(
  ll1-predict-table,
  caption: [LL(1) Table for @grammar_ll1],
)
