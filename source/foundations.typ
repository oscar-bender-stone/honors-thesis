// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": (
  definition, equation_block, labeled_equation, remark,
)
#import "template/ams-article.typ": lemma, proof, recursion, theorem

= Foundations

We introduce the base theory needed for this thesis.
This theory embodies a unifying concept
for formal systems: computatbility.
We capture this through a suitable,
simple type system, definable
in a single page.


We will keep this self-contained;
additional references will be provided in each sub-section.

== Computability

Before continuing, we must introduce
some fundamental recursive definitions.

#definition[
  Fix symbols *zero* $0$, *one* $1$, and *concatenation*. A *binary string* is defined recursively:
  #recursion(
    [$0$ and $1$ are binary strings.],
    [if $w$ is a binary string, then so are $w.0$ and $w.1$.],
  )
]<binary_strings>

#remark[The definition for binary strings, as the remaining recursive definitions, serves as a suitable _uniform_ abstraction for data. From a physical viewpoint, we cannot _verify_ each finite string, a phenomena related to the notion of "Kripkenstein" @kripke_wittgenstein. However, we _can_ provide the template, and working with this definition is more effective than working in an ultra-finitistic setting. For proof checking, we revisit this issue in @bootstrap.
]

== System T


== Key Properties

