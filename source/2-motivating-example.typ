// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Motivating Example <motivating-example>

// TODO: maybe make this section *about*
// Ratinoale and provide a *concise* example?
== Rationale <rationale>

We justify why the language is focused on representations. First, to mechanize
the information language, we allow only total computable functions, with
computability being a well established notion. Second, to enable clarity in
concepts, we need to resolve the Symbol Grounding Problem, so as to avoid
treating all symbols as being "empty", as discussed in @liu-grounding. We must
therefore include a notion of representation, which, in particular, can
represent partial computable functions. Finally, we claim that expressing _any
computable representation_ is sufficient for a universally expressible
information system. Attempting to provide a self-contained definition of the
notion "any" is problematic, as shown from the introdution. We instead define
"any" with the _least_ restrictions possible, which means, by the first point,
ensuring that a given provided input is accepted by _some_ computable function.
It is important that Welkin includes _every_ computable function in this
definition, which we prove in @universality-theorem.

== Units

A crucial question is to answer _how_ representations can be used in the
language. A representation at least contains two components: a _sign_ that
represents a _referant_. However, this is not sufficient to express any
computable function, because we do not have _conditional_ representations. A key
insight in this thesis is showing that expressing conditions is equivalent to
having _contexts_, which we incorporate into our mechanism for namespaces and
generalizes Burgin's notion of infological systems @burgin-information-book.
This proves an informal claim made in Meseguer @twenty_years_rewriting_logic,
which claims that rewriting logics without conditional rules are "strictly less"
expressive than those with conditions, see @definability-conditions.


We define a _unit_ as an extendible component in a representation that can be
broken down, build new units, or act on other units. Computationally, we can
treat units as IDs to partial computable functions, but we permit _implicit
bindings_ to non-symbolic things (a term made vague for flexibility). From
there, we practically formalize information being _contained_ in a unit,
enabling change in a context through checking for some _non_-fixed point. This
connects to Burgin's analogy of information as energy, as well as Bateson's
famous quote that "information is a difference that makes a difference"
@bateson-ecology-of-mind. For the full definition, see @unit.

== Example

We illustrate Welkin with a motivating example: geographic maps.

Fix some landscape $L$. A map provides a representation to guide travelers in
$L$, usually through coordinates and directions. Some common elements include
landmarks, paths, and regions.

There are two major problems in creating "good" representations:
1. Between two representations, how can we tell they represent the same entity?
2. Given a representation that represents some referant, how can we distinguish
  from other possible referants?

In the context of maps, we can make these problems more concrete:
1. Consider two maps $M, M'$. How can we tell whether some landmark $O$ in $M$
represents the same entity as $O'$ in $M'$?
2. Consider a map $M$, and suppose there are landscapes $L$, $L'$. With the goal
to have $M$ represent $L$, how does $M$ distnguish between $L$ and $L'$?


This overarching example demonstrates how two sources communicate about some
entity, or how a source's representation can distinguish between two entities.


