// SPDX-FileCopyrightText: 2025 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, theorem

= Information Compression <information_compression>

A natural question arises with universal formal systems: _which_ one do we
choose? While we have reflection, what is the criterion for the _base_ theory?
Can this be done?

We will show that, under a restricted notion of transformation, there is an
optimal theory. This will form the encoding under @semantics and provide a
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
]
