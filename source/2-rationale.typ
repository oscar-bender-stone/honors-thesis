// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Rationale <rationale>

#import "template/ams-article.typ": example

In this section, we justify the design of Welkin.

[TODO[SHORT]: determine if this would be better integrated with the
introduction.]


== Units

We start by reviewing the approach to analyze entities in in Algorithmic
Information Theory, as explained by Li and Vitányi @intro_kolmogorov_complexity.
This work introduces the idea of _enumerating objects_ through _numerical IDs_.

[TODO[SMALL]: determining good format to give specific pages.]
#set quote(block: true)
#quote(attribution: [@intro_kolmogorov_complexity, page 1.])[
  _Assume that each description describes at most one object. That is, there be
  a specification method $D$ that associates at most one object $x$ with a
  description $y$. This means that $D$ is a function from the set of
  descriptions, say $Y$, into the set of objects, say $X$. It seems also
  reasonable to require that for each object $x$ in $X$, there be a description
  $y$ in $Y$ such that $D(y) = x$. (Each object has a description.)_
]

Here, the specification method $D$ is a partial computable function to ensure
the enumeration can be mechanized. Partial computatbility establishes a clear
ceiling for information bases, and being able to define _any_ one is important
for universality.

However, Li and Vitányi's approach does not generally reflect the ways people
disseminate and create new information. This is well known in the literature as
the symbol grounding problem @liu-grounding. Beyond this, the term _object_ is
generally associated to _complete_ entities and makes it unclear how to work
with abstract ideas and dynamic processes. To resolve this, we shift the target
of study to _handles_ via _representations_, emphasizing an implicit user
created binding between a *sign* and a *referent*, what it represents. The
binding itself may not be reasonable to store, such as an animal, so instead we
_represent representations_ themselves. We formalize both notions using _units_.
A unit is provided by a user-defined enumeration of handles, and units can be
broken down, build new units, or act on other units. Abstracting away from the
implicit meaning, units act as partial computable functions, but the latter is
strictly _less_ expressive, as argued above.

#example[
  In a scientific experiment, a handle could be an observation or experimental
  data. The unit is then written as a symbol, say $u$, and is _implicitly_ bound
  to this meaning. To distinguish from other symbols, say $v$, the computational
  content is analyzed.[TODO[MEDIUM]: expand out this example!]
]

#example[
  A more looser example is a user written journel, containing information about
  daily habits and emotions. While neither of these are stored in the
  information base, their handles are, via units $"habit"$ and $"emotions"$ in a
  context $"journal"$. Moreover, multiple revisions of the journal can be made
  with dates or other unique IDs.
]

#example[
  A business could represent their operations using a unit $"business"$ that
  contains units for their workers and ledgers.
]

Now, our definition of representation is too restrictive, because we cannot
naturally express _conditions_ through _conditional representations_. A key
insight in this thesis is showing that expressing conditions is equivalent to
having _contexts_, which we incorporate into our mechanism for namespaces and
generalizes Burgin's notion of infological systems @burgin-information-book.
This is related to an informal claim made in Meseguer
@twenty_years_rewriting_logic, that rewriting logics without conditional rules
are strictly less expressive than those with conditions, see
@definability-conditions. Our crucial rule is related to @mccarthy-contexts but
generalizes the context to be an operator itself.

== Information

[TODO[SHORT]: emphasize that this is in line with AIT BUT authors in AIT don't
state it this way!]

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
