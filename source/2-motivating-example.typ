// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Motivating Example <motivating-example>

// TODO: maybe make this section *about*
// Ratinoale and provide a *concise* example?
== Rationale <rationale>

We justify why the language is focused on representations. First, to mechanize
the information language, we allow only total computable functions, with
computability being a well established notion. Second, to enable clarity in
concepts, we need to resolve the Symbol Grounding Problem, so as to avoid
treating all symbols as being "empty", as discussed in @liu-grounding. We must
therefore include a notion of representation, which, in particular, can
represent partial computable functions. Finally, we claim that expressing _any
computable representation_ is sufficient for a universally expressible
information system. Attempting to provide a self-contained definition of the
notion "any" is problematic, as shown from the introdution. We instead define
"any" with the _least_ restrictions possible, which means, by the first point,
ensuring that a given provided input is accepted by _some_ computable function.
It is important that Welkin includes _every_ computable function in this
definition, which we prove in @universality-theorem.


We illustrate Welkin with a motivating example: geographic maps.

Fix some landscape $L$. A map provides a representation to guide travelers in
$L$, usually through coordinates and directions. Some common elements include
landmarks, paths, and regions.

There are two major problems in creating "good" representations:
1. Between two representations, how can we tell they represent the same entity?
2. Given a representation that represents some referant, how can we distinguish
  from other possible referants?

In the context of maps, we can make these problems more concrete:
1. Consider two maps $M, M'$. How can we tell whether some landmark $O$ in $M$
represents the same entity as $O'$ in $M'$?
2. Consider a map $M$, and suppose there are landscapes $L$, $L'$. With the goal
to have $M$ represent $L$, how does $M$ distnguish between $L$ and $L'$?


This overarching example demonstrates how two sources communicate about some
entity, or how a source's representation can distinguish between two entities.


