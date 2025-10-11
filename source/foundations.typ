// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Foundations

We introduce the base theory needed for this thesis. We will keep it self-contained;
additional references will be provided in each sub-section.

== Peano Arithmetic

#let PA = math.bold("PA")

Our foundations of Welkin are based on Peano Arithmetic $PA$. We provide the full
list of axioms, relevant results, and justify why $PA$ is the most "minimal" theory
suitable for this language.

#let LA = $ cal(L)_A $

*Definition.* The *language* of $PA$ is the set $LA = {0, 1, S, +, *}$, with symbols
called:
- $0$ (*zero*) and $1$ (*one*).
- $+$ (*addition*) and $*$ (*multiplication*).

$PA$ enjoys several properties.

*Theorem.* $PA$ _proves the following:_
- _Every Primitive Recursive Function (PRF) is total_

Our criterion for why we choose $PA$ is the following.

*Theorem.* _$PA$ is the smallest theory to prove every Primitive Recursive Function (PRF) is total.
More precisely, suppose $T'$ is equivalent to a strict subset of $PA$. Then $T'$ fails to prove some PRF is total._

The proof of this theorem is beyond the scope of this thesis. Instead, we refer
to the standard constructions in the literature. Additionally, these proofs can be _astronomically_
large, but the point is to ensure we can discuss _prove_ any PRF is total, which
will be key in exploring decompositions.

== Decompositions of Turing Machines

#let tms = math.cal("M")

Let $tms$ be the set of all Turing machines.

== Optimality of Decompositions
