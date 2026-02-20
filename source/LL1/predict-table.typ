// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: maybe use | as the separator?
#let ll1-predict-table = table(
  columns: (auto, 1fr, 1fr),
  inset: 3pt,
  align: (left, left, left),
  fill: (x, y) => if y == 0 { luma(200) } else { none },
  table.header([*Non-Terminal*], [*Lookahead (a)*], [*Production Chosen*]),

  // START
  [`start`],
  [`"#" | "@" | "~@" | "&" | "." | ID | STRING | "{" | "(" | "[" | EOF`],
  [`terms`],

  // TERMS & TAIL
  [`terms`],
  [`"#" | "@" | "~@" | "&" | "." | ID | STRING | "{" | "(" | "["`],
  [`term terms_tail`],

  [], [`EOF | "}" | ")" | "]"`], [`EPS`],
  [`terms_tail`], [`","`], [`"," terms`],
  [], [`EOF | "}" | ")" | "]"`], [`EPS`],

  // TERM & NODE
  [`term`],
  [`"#" | "@" | "~@" | "&" | "." | ID | STRING | "{" | "(" | "["`],
  [`node chain`],

  [`node`], [`"#" | "@" | "~@" | "&" | "." | ID | STRING`], [`PATH opt_block`],
  [], [`"{" | "(" | "["`], [`block`],

  // OPTIONAL BLOCK & BLOCK
  [`opt_block`], [`"{" | "(" | "["`], [`block`],
  [], [`EOF | "}" | ")" | "]" | "," | "-" | "<-" | "->"`], [`EPS`],

  [`block`], [`"{"`], [`"{" terms "}"`],
  [], [`"("`], [`"(" terms ")"`],
  [], [`"["`], [`"[" terms "]"`],

  // CHAIN (Arc Enforcer)
  [`chain`], [`"-" | "<-"`], [`left_link node right_link node chain`],
  [], [`EOF | "}" | ")" | "]" | ","`], [`EPS`],

  [`left_link`], [`"-"`], [`"-"`],
  [], [`"<-"`], [`"<-"`],

  [`right_link`], [`"-"`], [`"-"`],
  [], [`"->"`], [`"->"`],

  // PATH STATE MACHINE
  [`PATH`], [`"#" | "@" | "~@" | "&"`], [`MODIFIER PATH_BODY`],
  [], [`"." | ID | STRING`], [`PATH_BODY`],

  [`PATH_BODY`], [`"."`], [`"." PATH_DOTS`],
  [], [`ID | STRING`], [`UNIT PATH_TAIL`],

  [`PATH_DOTS`], [`"*"`], [`"*" PATH_BODY`],
  [], [`"."`], [`"." PATH_DOTS`],
  [], [`ID | STRING`], [`UNIT PATH_TAIL`],

  [`PATH_TAIL`], [`"." | ID | STRING`], [`PATH_BODY`],
  [],
  [`EOF | "}" | ")" | "]" | "," | "-" | "<-" | "->" | "{" | "(" | "["`],
  [`EPS`],

  // TERMINALS
  [`MODIFIER`], [`"#"`], [`"#"`],
  [], [`"@"`], [`"@"`],
  [], [`"~@"`], [`"~@"`],
  [], [`"&"`], [`"&"`],

  [`UNIT`], [`ID`], [`ID`],
  [], [`STRING`], [`STRING`],
)

#let ll1-predict-figure = figure(
  ll1-predict-table,
  caption: [LL(1) Table for @grammar_ll1],
)
