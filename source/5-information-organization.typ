// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, theorem

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

= Information Organization <information-organization>

The presentation of Welkin's universal expressivity, stated as
@universality-theorem, is fixed with one particular representation. Following
the analogue of units to partical computable functions, we define *Universal
Representation Systems (URS)* as the analogues of Universal Turing Machines, see
@universal-representation-system.

A major problem for scalability is _choosing_ a URS. Possibly the use of
multiple URSs for different use cases is more optimal, in some sense? The key
operation in an information base is _querying_, so this must be as efficient as
possible. . This As established in @semantics, bounded queries can be answered
in $O(?)$ time. The problem then becomes about optimizing the number of steps.
While this is query dependent, and depends on the database, we prove that any of
these criterion can be converted to one about _size_. Our proof generalizes
Blum's axioms @blum_speedup and Kolomogorov complexity
@intro_kolmogorov_complexity. While finding the absolute smallest size of a unit
that will best optimize a query is impossible, we _can_ optimize the database
with the available information. Our localized algorithm provides a nice
architecture to solve problems: combining bounded queries in the database to
confirm the presence of an answer, combined wth unbounded searches by some
search procedure or heuristics. Note that the search procedure may or may not be
computable; what is important is that bounded queries are always efficient. We
also provide proof certificates.

== Universal Systems
// TODO: also mention ZFC as an
// example with its own reflection theorem,
// or briefly mention it.

Note that there are multiple ways to prove @universality-theorem, infinitely in
fact. This motivates the following definition.

// TODO: develop!
#definition[
  A universal representation system (URS) is a unit that can represent any
  representation.
]<universal-representation-system>


// TODO: Make this more precise and complete proof.
#theorem[
  A unit is a universal representation system if and only if it can represent
  any partial computable function. Moreover, any universal representation system
  can represent any universal representation system. In particular, representing
  itself is called *reflection*.
]

// TODO: dissue axiomatic systems!
// Want to emphasize the relevant *process* (per context) is important!
// That is, the journey to discover new things.
// ONLY FI the specification is complete in some way (or "finalized"),
// it is then that axiomatic systems *can* help.
// Expand this discussion into a paragraph or two.


The term _universal_ is specifically for expressing _representations_
symbolically. The free parameter still needs to be included and is an additional
feature on top of partial comptuable functions. However, the _management_ of
these symbols is done entirely with partial computable functions.

The next section discusses the issue of _managing_ the infinitely many choices
for URSs.


// == Impossible Classes

// The reason to restrict our transformations is two-fold. First, we need to ensure
// we can _verify_ them efficiently. Determining whether a morphism between two
// formal systems exist can be reduced to the Halting problem, and is therefore not
// practical for defining an optimal formal system. Second, if we include those
// tranformations that we _can_ effectively check, no optimal formal system exists.

// #theorem[
//   With respect to the class of all computable transformations that can be
//   computably verified, there is no optimal formal system.
// ]<impossible_complete_compression>

== Localized Size Compression <local-size-compression>

Instead of making proofs most efficient as is, we want to support finding
optimal representations. But we want to do this from an efficiently queryable
system, which _is_ the most optimal.



