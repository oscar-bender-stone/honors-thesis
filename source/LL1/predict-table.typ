// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: maybe use | as the separator?
#let ll1-predict-table = figure(
  table(
    columns: (auto, auto, auto),
    inset: 6pt,
    fill: (x, y) => if y == 0 { luma(200) },
    [*Non-Terminal*], [*Lookahead (a)*], [*Production Chosen*],

    // START
    [start],
    [#set text(size: 9pt); `"#" | ID | STRING | IMPORT | "." | "{"`],
    [ `term terms` ],

    // TERMS (Previously sequence)
    [`terms`], [ `","` ], [ `"," terms_tail` ],
    [], [ `EOF | "}"` ], [ `EPS` ],

    // TERM
    [`term`], [ `"#"` ], [ `toplevel` ],
    [], [ `ID | STRING | IMPORT` ], [ `unit chain` ],
    [], [ `"."` ], [ `"." DOTS` ],
    [], [ `"{"` ], [ `{ terms }` ],

    // CHAIN (Previously suffix)
    [`chain`], [ `"{"` ], [ `graph` ],
    [], [ `"- | <-"`, `"->"` ], [ `LINK unit chain` ],
    [], [ `"," | "}" | EOF` ], [ `EPS` ],

    // DOTS
    [`DOTS`], [ `".*"` ], [ `STAR` ],
    [], [ `"."` ], [ `"." DOTS` ],
    [], [ `"," | "}" | EOF` ], [ `EPS` ],
  ),
  caption: [LL(1) Predict Table],
)

#let ll1-predict-figure = figure(
  ll1-predict-table,
  caption: [LL(1) Table for @grammar_ll1],
)
