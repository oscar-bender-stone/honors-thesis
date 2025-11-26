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

#let tree = $TT$

#definition[
  We define the *theory of binary trees* as $tree$ follows.
]


#theorem[The theory $tree$ is equivalent to the theory of hereditarily finite
  ets, and hence, to Peano Arithmetic.
]
#proof[The first claim is a straightforward conversion, done recursively. The
  second claim follows from Ackermann's well known encoding of hereditarily
  finite sets to natural numbers.]


== Verifiers

