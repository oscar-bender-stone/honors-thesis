// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
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

+ $cal(T)$ is already well established.
+ $cal(T)$ is reflective: it can prove properties about itself.
+ $cal(T)$ is straightforward to define.
+ $cal(T)$ proves only true properties about computable functions.
+ $cal(T)$ has has efficient proof checking.

The last condition is not strictly necessary, but it does aid in verifying the
bootstrap in @bootstrap.

#let ZF = math.bold("ZF")
#let PA = math.bold("PA")
#let CL = math.bold("CL")

We could define *Zermelo Frankel Set Theory ($ZF$)* or *Peano Arithmetic ($PA$)*
directly, but these theories have two problems. First, defining first-order
logic, is tedious, specifically free and bound variables. Second, recursively
enumerable functions are _encoded_ into the theory, rather than being first
class citizens. Computable functions are more naturally expressed in type
theories, but partial functions are secondary and are awkward to define. By
interpreting proofs as programs, under the Curry Howard correspondence,
non-terminating functions translate into proofs of inconsistency. Moreover, in
more expressive type theories, like those with dependent types, proof checking
has an extreme time complexity.

Our solution to these issues is to build on Solomon's framework on explicit
mathematics @solomon_logic. His work builds on two key ideas. First, separating
partial functions from proofs is useful. Second, presenting a theory of
computable functions is simpler with combinatory logic, which was specifically
developed to remove involved calculations with variables. This is easier still
using illative combinatory logic, which has useful logical constants (see
@czajka_illative_cl). We will start with a theory equi-consistent to $PA$ and
augment this approach further further by using illative combinatory logic in
_both_ levels.

#let step = math.attach(math.arrow.r, br: $1$)

#let ICA = math.bold("ICA")

#definition[
  We define *Illative Combinatory Arithmetic ($ICA$)* as follows.

  - The *language* $cal(L)_ICA$ consists of:

    - *Constants*: $0 | "nat"$

    - *Base combinators*: $"k" | "s"$
    - *Pairing*: $"pair" | "fst" | "snd"$

    - *Connectives*: $"if" | "join" | "meet" | "A" | "Imp" | "id"$
  - Two sets of axioms called *computational* and *logical*. These are displayed
    as judgements.
]

== Verifiers

