// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let grammar = [
  ```
  start <--> {nodes - lexeme -> EOF},

  terms <--> "" | {term - lexeme -> terms_tail},
  terms_tail <--> {"," - lexeme -> term}
    | ","
    | "",

  term <--> {
    node - seq ->
    {} | {
      arc - seq -> term
    }
  },

  arc <--> right_arc | other_arc
  right_arc <--> {"-" - seq -> node - seq -> "->"}
  other_arc <--> {"<-" - seq -> node - seq -> ("-" | "->")}

  node {path - lexeme -> contents | {}}

  path {MODIFIER | {} --> path_segment* - seq ->  unit}

  path_segment <--> UNIT | ".*" | {@times, factor --> "."}

  path_segment ::= UNIT | ".*" | "."+


  UNIT <--> ID | STRING
  ```
]
