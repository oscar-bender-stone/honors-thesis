// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

This section develops two major components for this thesis:

- The base metatheory, which defines binary strings (as binary trees) and proofs
  for computability. We justify why this theory is reliable, based on work from
  Artemov @artemov_serial_consistency.

- The definition of a verifier, which is a computable function on binary
  strings.

== Metatheory

To formally define computatbility, we require a metatheory $cal(T)$ such that:

- $cal(T)$ is already well established.

- $cal(T)$ is $Sigma_1$ sound: it only proves true properties about computable
  functions.

- $cal(T)$ has efficiently computable proof checking.

The last condition is not strictly necessary, but it does make the bootstrap in
this thesis more practical.

#definition[
  We define *Heyting Arithmetic* as follows.
]


#theorem[
  Heyting Arithmetic is equi-consistent to Peano Arithmetic.
]

== Verifiers

