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

- $cal(T)$ is reflective: it can prove properties about itself.

- $cal(T)$ only proves true properties about computable functions.

- $cal(T)$ has has efficient proof checking.

The last condition is not strictly necessary, but it does aid in verifying the
bootstrap in @bootstrap.

We could define Zermelo Frankel Set Theory (ZF) or Peano Arithmetic (PA)
directly. However, we want _explicit_ definitions for terms, using simple
algorithms. This ensures we have true statements in computability, _and_
provides a simpler, self-contained presentation over PA, which is quite
involved. Our theory is thus based on Combinatory Logic, specifically designed
to be a simpler alternative to first order logic by removing variables. We
closely follow Scott @scott_data_types_as_lattices.


#definition[
  We define *Combinatory Logic (CL)* as follows.
]


#theorem[
  Each term in $bold("CL")$ is equivalent to a $Sigma^0_1$ formula in
  $bold("PA")$.
]

== Verifiers

