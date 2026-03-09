// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, remark, theorem

// TODO: discuss queries.
// We want to centralize organizing
// information *around* queries,
// and as many as possible.
// Need to use general definition
// (anything computably representable)
// to do this!
// Moreover, we need to determine how
// we know a query is "well-posed",
// so if we have enough representations.
// At the very least, we want this
// to be *itself* a component

= Organizing Information <information-organization>


This section overview the most optimal organization of Welkin. We proceed in
several parts:

+ We define two kinds of metrics on units, either being *static* or *dynamic*.
  We prove that these can be converted purely into size and a certain measure,
  respectively.

+ We prove that Welkin can calculate localized versions of these.

+ We show that queries can be _optimized_ based on the locally known
  information. This optimization can be static or dynamic. This optimization is
  not just in finding _shorter_ derivations, but in satisfying certain metrics.

== Computable Measures and Size

[TODO[MEDIUM]: incorporate numbers from syntax to make this easier!]

We adapt Blum's axioms @blum_speedup for measures on units.

#definition[A *computable measure* is a provably computable function $Phi$ that
  assigns units to natural numbers such that bounds on $Phi$ are computable on
  _any_ input.
]

[TODO[SMALL]: define size for units based ona simple representation. We can
ensure this is _small_ to have small overhead.]

#definition[The *size* of a unit is defined recursively:
]<compression:size>

#theorem[Any metric satisfying Blum's axioms can be converted into one about
  size (the number of bytes in a unit).
]
#remark[
  Of course, the conversion _may_ be extremely large, so this _too_ can be
  queried to find a more optimal approach. In any case, finding a constant time
  apparatus to work with these conversions is more praactical and can be
  automated by Welkin.
]

[TODO: show how to get a greater emphasis on size, so one could have a hybrid of
static + dynamic. The dynamic one is basically that?]

== Static Organization: Compression <local-size-compression>

Welkin focuses on optimizing size as that is the simplest metric to use. The
algorithm to calculate size is straightforward, based on the _direct_
representations of units. Thus, one can provide a certificate about whether
information about a context is _more compressed_ than another.

The foundational $"unit"$ recursor is meant to be a simple, direct verifier of
proofs. However, it is _not_ efficient for every problem. Going back to
@turing-expressible, there can easily be large expansions from the $S K$
combinators. How do we tailor recursors _for_ a specific context?

== Dynamic Organization:


== Query Optimization

We completely generalize the results of
@wenfei-query-preserving-graph-compression, which focuses on queries involving a
_bisimulation_ relation.

[TODO: show how this can be done for *both* cases.]

Combining the previous sections, we define how to query on compressed
representations, generalizing ?.
