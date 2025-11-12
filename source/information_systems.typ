// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example


= Information Systems <information_systems>


We now define the universal framework for analyzing information. Our approach
describes information as _representatives of terms in formal systems_.

== Formal Systems

We must first define a suitable, general class of systems to analyze.
Considering the diversity of formal reasoning, we need a _static_ and _dynamic_
component. These have interpretations in *logic* and *computability*, outlined
in @formal_system_features.

#let features = table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([*Feature*], [*Logic*], [*Computation*]),
  [*Static*], [Formulas], [States],
  [*Dynamic*], [Inference], [Transitions],
)

We will focus on the _logical_ interpretation in our terminology, but note that
this is intentionally _general_ to encompass any other interpretation.


#figure(
  features,
  caption: [Features needed in a general formal system.],
)<formal_system_features>


Given this criterion, we define a formal system as follows,
loosely based on the definition provided by Strassburger @strassburger_what_is_a_logic.

#definition[
  A *formal system* is a pair $cal(S) equiv (cal(F), cal(R))$ consisting of:

  - *formulas* $cal(F)$, a decidable set of binary strings.
  - a set of *derivation rules* #box[$cal(R) subset.eq cal(F) times cal(F)$]. We define the *derivation relation* $=>$ to be the reflexive, transitive closure of $cal(R)$. Furthermore, we require that $=>$ is computable in polynomial time.


  A *sentence* is a closed derivation, and a *theory* is a set of sentences in
  $cal(F)$.
]

Note that the first condition on $cal(F)$ is redundant: reflexivity in $cal(R)$ ensures that each formula can be recognized in polynomial-time.


