// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": definition, example, remark

= Defining Information

The goal of this section is to completely define the following: _a proof of
anything expressible by a computable function_. We will then generalize this to
more through handles and mark soundness. Note that this result is effected by
Rice's Theorem, which states that any non-trivial property of a Turing machine
is undecidable. As a result, this method is inherently incomplete with
computable methods. This theory does, however, establish a ceiling.
Optimizations will be postponed to @information-organization.

== Information <metatheory:information>

This section provides the definition of information in Welkin.
// TODO: embed information _as_ evaluation,
// up to {} or something NOT {}.
// This is EXACTLY making a difference/change
// in a system! The difference is finding NOT {},
// if it's true!

// What is a query?
// Something we want to *answer*
// So the thing we can answer in Welkin
// *is the presence of representations*.
// This is what we're working with!


// TODO: probably need a recursor here
// to cover any case!
#definition[
  Let $c$ be a context. Then a *query over $c$* is a question over a fixed unit:
  does $q$ belong to $c$?
]

The easiest queries are _definitional_, or immediately found on inspection. For
example, asking whether $q in {q, a}$ is easy. However, if one must _derive_ $q$
from $"unit"$, then this is not computable, in general.

// We invoke two ideas from @rationale:mechanizing-information:
// - Burgin: information is an operator; a carrier of change in a system
//   @burgin-foundations-information.
// - Bateson: "information is a difference that makes a difference"
//   @bateson-ecology-of-mind.

// In this case, we express the idea of "making a difference" through _impacting
// queries_.

// #definition[
//   Let $c$ be a context, $v$ a query and $u, v$ be units. Then $u$ has
//   *information about* $v$ if .
// ]

// Thus, we can interpret "making a difference" as _
// a representation producing a non-empty unit_. In other words, information is a
// unit that does not "collapse" on itself (producing ${}$).
