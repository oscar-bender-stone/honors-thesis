// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let grammar = [
  ```
  start <--> nodes,

  node <--> "" | {term - then -> {"," - then -> term} - then -> "," | "" },

  term <--> {
    node - then ->
    {} | {
      arc - then -> term
    }
  },

  arc <--> left_arc | right_arc | both_arc
  left_arc <--> {"<-" - then -> node - then -> "-"}
  right_arc <--> {"-" - then -> node - then -> "->"}
  both_arc <--> {"<-" - then -> node - then -> "->"}

  node {path - then -> contents | {}}

  path {MODIFIER | {} --> path_segment* -then ->  unit}

  path_segment <--> UNIT | ".*" | {@times, factor --> "."}

  path_segment ::= UNIT | ".*" | "."+
  UNIT <--> ID | STRING
  ```
]
