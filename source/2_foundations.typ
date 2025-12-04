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
@czajka_illative_cl). We will start with a theory equi-consistent to
constructive $PA$ and augment this approach further further by using illative
combinatory logic in _both_ levels. Our system uses a Hilbert-style calculi,
which presents the logic with many axioms and few rules of inference. This
enables the system to avoid contexts, which pose similar challenges as
variables.

#let step = math.attach(math.arrow.r, br: $1$)

#let ICA = math.bold("ICA")
#let Imp(x, y) = $"Imp" thin #x thin #y$
#let pair(x, y) = $"pair" thin #x thin #y$

#let vdash = math.tack

#definition[
  We define *Illative Combinatory Arithmetic ($ICA$)* as follows.

  - The *language* $cal(L)_ICA$ consists of:
    - *Constants*: $bot | 0 | "nat"$
    - *Consequence Relation*: $vdash$
    - *Base Combinators*: $"k" | "s"$
    - *Pairing*: $"pair" | "fst" | "snd"$
    - *Connectives*: $"if" | "join" | "meet" | "A" | "Imp" | "id"$
  - *Terms* are defined recursively:
  - We add useful notation, where $X, Y$ are terms:
    - $X => Y equiv Imp(X, Y)$.
    - $(X, Y) equiv pair(X, Y)$.
    - $(X) equiv X$.
  - Two sets of axioms called *computational* and *logical*. We write these
    using $vdash$.
    - $vdash X -> (Y -> Z)$
    - $vdash (X -> (Y -> Z)) -> ((X -> Y) -> (Y -> Z))$
  - One rule of inference called *Modus Ponens*: $vdash X$ and $vdash X -> Y$
    implies $vdash Y$.
]

== Verifiers

