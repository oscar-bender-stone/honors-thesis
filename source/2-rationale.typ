// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Rationale <rationale>

#import "template/ams-article.typ": example

In this section, we justify the design of Welkin.

[TODO[SHORT]: determine if this would be better integrated with the
introduction.]


== Units

We start by reviewing the approach to analyze entities in Algorithmic
Information Theory through Li and Vitányi @intro_kolmogorov_complexity. This
book introduces the idea of _enumerating objects_ through strings called
_descriptions_,.

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

[TODO[SMALL]: add note about _what_ we do to resolve symbol grounding. OR even
say it's not perfect/limited, BUT for an information base, it's enough, based on
requiring partial computable operations.] However, Li and Vitányi's approach
does not generally reflect the ways people disseminate and create new
information. This is well known in the literature as the symbol grounding
problem, formulated by Harnard @harnard-symbol-grounding. The problem is: How
can the semantic interpretation of a symbol be intristinic to a system, rather
than being externally driven or "parasitic on the meanings in our heads"
(@harnard-symbol-grounding)? system be made intrinsic to the system, rather than
just parasitic on the meanings in our heads?

. Many authors have proposed solutions, though one negative theoretical result
shows that no _single_ formal system can contain every grounding set
@liu-grounding. In addition to symbol grounding, the term _object_ is generally
associated to _complete_ entities and makes it unclear how to work with abstract
ideas and dynamic processes.

To resolve this, we shift the target of study to _handles_ via
_representations_, emphasizing an implicit user created binding between a handle
called a *sign* that represents a *referent*. The binding itself may not be
reasonable to store, such as an animal, so instead we _represent
representations_ themselves. Truth itself is represented by the _accuracy_ of
representations, determined by consequences of axioms as handles (see
@universality-truth-management). We formalize both notions using _units_. A unit
is provided by a user-defined enumeration of handles, and units can be broken
down, build new units, or act on other units via representations. In contrast to
the requirement in the quote above, the enumeration need _not_ be surjective but
only _locally_ so. Abstracting away from the implicit meaning, units act as
partial computable functions, but the latter is strictly _less_ expressive by
removing user provided meaning.

#example[
  In a scientific experiment, a handle could be an observation or experimental
  data. The unit is then written as a symbol, say $u$, and is _implicitly_ bound
  to this meaning. To distinguish from other symbols, say $v$, the computational
  content is analyzed.[TODO[MEDIUM]: expand out this example!]
]

#example[
  A more looser example is a user written journal for therapy sessions,
  containing information about daily habits and emotions. While neither of these
  are stored in the information base, their handles are, via units $"habit"$ and
  $"emotions"$ in a context $"journal"$. Moreover, multiple revisions of the
  journal can be made with dates or other unique IDs.
]

Now, our definition of representation is too restrictive, because we cannot
naturally express _conditions_ through _conditional representations_. Another
issue is that managing two sets of IDs is difficult with _solely_ unconditional
representations. Providing a form of _namespaces_, or a mechanism to distinguish
two sets of names, is crucial for information bases. But we also require a way
to provide subject specific knowledge, as Burgin does through infological
systems @burgin-foundations-information. A key insight in this thesis is showing
that expressing conditions is _equivalent_ to creating these namespaces: we
express this idea as a *context*. This is related to an informal claim made in
Meseguer @twenty_years_rewriting_logic, that rewriting logics without
conditional rules are strictly less expressive than those with conditions, see
@definability-conditions.

[TODO[SMALL]: use better names for entities/businesses/etc]
#example[
  A business could represent their operations using a unit $"business"$ that
  contains units for their workers and ledgers. This allows another unit, say
  $"business2"$, to contain its _own_ label $"workers"$ that is separate from
  the one in $"business"$. In addition to separate labels, these contexts can
  have _distinct_ rules, such as those for how business operations are
  performed.
]

Moreover, our formal rules are centered around contexts and are related to
@mccarthy-contexts but generalizes the context to be an operator itself (see
@semantics).

== Information

[TODO[HIGH]: COMPLETE. Needed before finishing semantics!] Given the notion of
units, how can they can they be _used_? The usual operation in an information
base, as with a database, is the ability to make _queries_... Beyond this, we
want to combine notions of knowledge management to express any truth management
system. This means the ability to make _assertions_. We can express both of
these as units with a special interpretation. As normal units, these can be
studied in their own right and _themselves_ be queried and/or provided
assertions. Both of these concepts can be bridged with a practical notion of
information. Our definition is... This connects to Burgin's analogy of
information as energy, as well as Bateson's famous quote that "information is a
difference that makes a difference" @bateson-ecology-of-mind. For the full
definition, see @unit. Our practical distinction between knowledge is that we
_use_ information. However, users can easily assert their equivalence, or not,by
creating restricted contexts.

== Base Operations

Now, units and information themselves could be expressed in infinitely many
languages, with slightly different syntax or semantics. Welkin is carefully
designed to be a _minimal_ expression of these concepts, with minimal friction
to express any other universal information base. These include:

- Intuitive arrow notation for representations, expressed in ASCII as
  `a - b -> c`. These can be interpreted _as_ rewrite rules, depending on the
  context.

- Traditional braces `{ }` to denote closed definitions of contexts, inspired by
  the C programming language.

- Paths via dots `.` that is inspired by the Python programming language.
  Relative paths are denoted with multiple dots `...`, and absolute imports are
  prefixed with `#`. Subsets of units can be written via `u.{v, x}`, or even
  `u.{v --> x}` to refer to a subset of representations.

- Imports are done through `@u`, which takes all subunits of `u` and puts them
  into the current scope. In other words, the implementation _implicitly_ adds
  denotations `v <--> a.v` for each subunit `v` of `u`. This is motivated by the
  abundance of logic gates in computer science, as any finite circuit can be
  expresseed in terms of `and` and `not`. Selecting specific subunits can be
  done via `@u.{v, x}`.

- Imports can be _negated_ via the notation `~@u`, and specific units can be
  negated through `~u`. This is an uncommon feature of most programming
  languages, appearing primarily in Haskell and CSS. While potentially opaque,
  Welkin provides robust definitions to ensure that negated forms can be easily
  translated into more explicit ones _and_ back again. [TODO[SMALL]: provide
  link, probably to bootstrap or so?]

- Comments _are_ strings can be treated as any unit. No comments need to be
  removed in the files and can _enhance_ the study of new
  subjects.#footnote[Contexts can mimic regular comments, but Welkin aims to be
    inspectable by users. Encapsulation or private information can be enforced
    through _rejecting_ specific contexts or only accepting certain ones.] These
  units can _then_ be analyzed by others to promote translations to other human
  languages, or be studied through the _overaching relationships_ in the units.

In general, the minimal restricted keywords is crucial for providing support for
other languages. An implementation of Welkin will contain a small section of
ASCII encoding for easier standardization, but the rest of the prgoram can be
done _entirely_ in the user's native language. This is a novel feature in most
programming languages, which are either predominantly English or are fine tuned
for specific human languages. [TODO: cite source on this about most programming
languages being in English, as well as programming languages written in
_different_ human languages. Would be useful to have.]

