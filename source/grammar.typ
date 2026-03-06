// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let grammar = [
  ```
  start <--> terms,

  // terms ::= term ("," term)* ","? | EPS

  terms <--> {term --> top, {top --> {top --> ",", next --> term} | "," | "" --> next} --> next}

  // term  <--> arc | graph | tuple | path
  // arc          ::= (term ("-" | "<-") term ("-" | "->"))+ term
  // graph        ::= path? "{" terms "}"
  // tuple        ::= path? "(" terms ")"

  path         ::= MODIFIER? path_segment* unit

  path_segment <--> unit | ".*" | {@times, factor --> "."}

  path_segment ::= unit | ".*" | "."+
  unit         ::= ID | STRING
  ```
]
