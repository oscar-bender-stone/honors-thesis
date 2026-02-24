// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Rationale <rationale>


In this section, we justify the design of Welkin.

[TODO[SHORT]: determine if this would be better integrated with the
introduction.]
== Requirements

There are three core requirements needed for the information base.

- First, to mechanize the information language, any operation must be a partial
  computable function, with the notion of partial computability being a
  well-established notion. For full expressivity, every partial comptuable
  function must be definable in the language.

- Second, the language must allow users to write general assertions and queries
  that are accepted by some partial computable function.

[TODO[SHORT]: make this requirement clearer! And maybe use the term surrogate?]
- Third, to enable clarity in concepts, we need to resolve the Symbol Grounding
  Problem and ensure symbols can carry meaning.

[TODO(SHORT): add links to the requirements above.] Requirement 1 is equivalent
to providing a _finite_ specification of the language and defining any
Turing-complete formalism. We prove this using the SK combinator calculus in
@universality-theorem. Requirement 2 can be done with an initial universal
verifier, which determines if a given trace matches the rules of a description
of a partial computable function. Finally, Requirement 3 can be satisfied by
enabling users to define enumerations, whose origin is _unspecified_.
Extensionally, the development of these enumerations _may_ be modeled by a
partial computable function, but the originally _intent_ can be kept user
specific. This can be used for implementation specific behavior but is more
general purpose, see @semantics for more details.

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

To express these enumerations, we define a _unit_ as an extendable component in
a representation that can be broken down, build new units, or act on other
units. Computationally, we can treat units as IDs to partial computable
functions, but we permit _implicit bindings_ to non-symbolic things (a term made
vague for flexibility).

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
