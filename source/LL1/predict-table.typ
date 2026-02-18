// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// TODO: maybe use | as the separator?
#let ll1-predict-table = table(
  columns: (auto, auto, auto),
  table.header([Non-terminal], [Lookahead ($a$)], [Production Chosen]),
  [start], [`#` | `ID` | `STR` | `IMP` | `.` | `{`], [term sequence],
  [sequence], [`,`], [`","` term sequence],
  [], [`EOF`], [ε],
  [term], [`#`], [toplevel],
  [], [`ID` | `STR` | `IMP`], [unit suffix],
  [unit suffix], [`.`], [`.` DOTS],
  [], [`{`], [`{` terms `}`],
  [suffix], [`{`], [graph],
  [], [`-` | `<-`], [arc],
  [], [`,` | `}` | `EOF`], [ε],
  [arc], [`-`], [`-` term dash_link],
  [], [`<-`], [`<-` term arrow_link],
  [dash_link], [`->`], [`->` right_chain],
  [], [`-`], [`-` plain_chain],
  [arrow_link], [`-`], [`-` left_chain],
  [], [`->`], [`->` symm_chain],
  [right_chain], [`-`], [`-` term `->` right_chain],
  [], [`,` | `}` | `EOF`], [ε],
  [DOTS], [`.*`], [STAR],
  [], [`.`], [`.` DOTS],
  [], [FOLLOW\*], [ε],
  [terms], [`#` | `ID` | `STR` | `IMP` | `.` | `{`], [term terms],
  [], [`}`], [`}`],
)

#let ll1-predict-figure = figure(
  ll1-predict-table,
  caption: [LL(1) Table for @grammar_ll1],
)
