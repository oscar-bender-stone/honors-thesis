// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, theorem

= Information Organization <information-organization>

- Main question: *which* universal system to choose? Is this practical?

  - What is a suitable criterion for a base theory?

  - Recall aim: want to mechanically store systems for a database

    - What if possible performance degredation? Will we get stuck
    if we start with one architecture? Will we have to adjust later?

    - Aim is to ensure architecture is completely flexible and
    can automatically adapt

    - One key metric: ability to store as many systems coherently as possible,
    i.e., store as much information as psosible
  - Main problem: Blum's speedup theorem

    - Briefly generalize this for slate logic

    - Show that no single way to completely organize systems based on a
      computable metric.
    This is part of the need for new search techniques!

    - Want to separate search from storage though, but we want to improve
    stored results *with* new results. This forms the idea behind the database
    architecture: have a simple way to store results that automatically gets
    better with new techniques/results.
    - Need explicit proofs for this! Not sure how to store certificates...


== Impossible Classes

The reason to restrict our transformations is two-fold. First, we need to ensure
we can _verify_ them efficiently. Determining whether a morphism between two
formal systems exist can be reduced to the Halting problem, and is therefore not
practical for defining an optimal formal system. Second, if we include those
tranformations that we _can_ effectively check, no optimal formal system exists.

#theorem[
  With respect to the class of all computable transformations that can be
  computably verified, there is no optimal formal system.
]<impossible_complete_compression>

== Efficient Querying

Instead of making proofs most efficient as is, we want to support finding
optimal representations. But we want to do this from an efficiently queryable
system, which _is_ the most optimal.



