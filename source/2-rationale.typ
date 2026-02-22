// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Rationale <rationale>

We justify why the language is focused on representations. First, to mechanize
the information language, we allow only total computable functions, with
computability being a well established notion. Second, to enable clarity in
concepts, we need to resolve the Symbol Grounding Problem, so as to avoid
treating all symbols as being "empty", as discussed in @liu-grounding. We must
therefore include a notion of representation, which, in particular, can
represent partial computable functions. Finally, we claim that expressing _any
computable representation_ is sufficient for a universally expressible
information system. Attempting to provide a self-contained definition of the
notion "any" is problematic, as shown from the introduction. We instead define
"any" with the _least_ restrictions possible, which means, by the first point,
ensuring that a given provided input is accepted by _some_ computable function.
It is important that Welkin includes _every_ computable function in this
definition, which we prove in @universality-theorem.

== Units

A crucial question is to answer _how_ representations can be used in the
language. A representation at least contains two components: a *sign* that
represents a *referent*. However, this is not sufficient to express any
computable function, because we do not have _conditional_ representations. A key
insight in this thesis is showing that expressing conditions is equivalent to
having _contexts_, which we incorporate into our mechanism for namespaces and
generalizes Burgin's notion of infological systems @burgin-information-book.
This proves an informal claim made in Meseguer @twenty_years_rewriting_logic,
which claims that rewriting logics without conditional rules are "strictly less"
expressive than those with conditions, see @definability-conditions.

We define a _unit_ as an extendable component in a representation that can be
broken down, build new units, or act on other units. Computationally, we can
treat units as IDs to partial computable functions, but we permit _implicit
bindings_ to non-symbolic things (a term made vague for flexibility).

== Information

Using the notion of units, we practically formalize information being
_contained_ in a unit, enabling change in a context through checking for some
_non_-fixed point. This connects to Burgin's analogy of information as energy,
as well as Bateson's famous quote that "information is a difference that makes a
difference" @bateson-ecology-of-mind. For the full definition, see @unit. Our
practical distinction between knowledge is that we _use_ information. However,
users can easily assert their equivalence, or not,by creating restricted
contexts.

== Example

[TODO: determine a substantial but self-contained example that is related to
Information Management literature, so maybe something to do with companies and a
logistics chain.]
