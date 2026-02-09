// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Motivating Example <motivating-example>

We illustrate Welkin with a motivating example: geographic maps.

Fix some landscape $L$. A map provides a representation to guide travelers in
$L$, usually through coordinates and directions. Some common elements include
landmarks, paths, and regions.

There are two major problems in creating "good" representations:
- Between two representations, how can we tell they represent the same entity?
- Between two entities, how can we tell a representation distinguishes one from
  another?

In the context of maps, we can make these problems more concrete:
- Consider two maps $M, M'$. How can we tell whether some landmark $O$ in $M$
represents the same entity as $O'$ in $M'$?
- Consider a map $M$, and suppose there are landscapes $L$, $L'$. With the goal
to have $M$ represent $L$, how does $M$ distnguish between $L$ and $L'$?

This overarching example demonstrates how two sources communicate about some
entity, or how a source's representation can distinguish between two entities.


