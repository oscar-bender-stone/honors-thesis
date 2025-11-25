// SPDX-FileCopyrightText: 2025 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, theorem

= Information Compression <information_compression>

A natural question arises with universal formal systems: _which_ one do we
choose? While we have reflection, what is the criterion for the _base_ theory?
Can this be done? One loose, but natural, mteric is this: _a universal system which stores as many "interesting" proofs as possible_. The motivation behind this metric is to enable effective querying of "good" proofs.

We will show that, under a restricted notion of transformation, there is an
optimal universal system. This will form the encoding under @semantics and provide a
justification for Welkin as this base theory.


= Impossible Classes

The reason to restrict our transformations is two-fold. First, we need to ensure
we can _verify_ them efficiently. Determining whether a morphism between two
formal systems exist can be reduced to the Halting problem, and is therefore not
practical for defining an optimal formal system. Second, if we include those
tranformations that we _can_ effectively check, no optimal formal system exists.

#theorem[
  With respect to the class of all computable transformations that can be
  computably verified, there is no optimal formal system.
]<impossible_complete_compression>

= Efficient Querying

Instead of making proofs most efficient as is,
we want to support finding optimal representations.
But we want to do this from an efficiently queryable
system, which _is_ the most optimal.



