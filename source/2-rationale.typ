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
for universality. Li and Vitányi proceed to define the inforthe information
content of strings through Kolmogorov complexity, the size of the smallest
description that accepts an object, or in other words, the smallest program that
accepts a string.


[TODO[SMALL]: add note about _what_ we do to resolve symbol grounding. OR even
say it's not perfect/limited, BUT for an information base, it's enough, based on
requiring partial computable operations.]

However, Li and Vitányi's approach does not generally reflect the ways people
disseminate and create new information. The term "object" is a vague term that
is vastly different between disciplines and can be difficult to model for
entities. For example, consider a dynamic biological systems. In an evolving
system, what is the "boundary" of the object? Another issue is well known in the
literature as the Symbol Grounding Problem, formulated by Harnard
@harnard-symbol-grounding. As an example, Harnard considers a person expecting
to learn Chinese as their first language with _only_ a Chinese dictionary. How
does the person ground their symbols in concrete meanings? An information base
cannot practically store the denotations of a word, such as storing animals. In
some cases, it is nebulous what "store" means for certain concepts, though as
abstract ideas. The problem even arises when modeled with _solely_ formal
entities. For instance, Liu @liu-theory-based-symbol-grounding models symbol
grounding as axioms in a general deductive system, and uses Gödelian-based
diagonalization argument to show that the grounding predicate, indicating which
symbols are grounded, is undefinable in a single system. In a related work,
symbol grounding can be modeled directly through Kolmogorov complexity
@liu-algorithmic-symbol-grounding, demonstrating the same impossibility of fully
grounding a system of symbols through a fixed grounding set.

To address these issues, we make an important distinction between philosophical
inquiries and _practical_ requirements for an information base. On one hand,
many authors have argued _how_ an entity can take a meaning, with firm responses
on whether physical objects are required, the world must be a certain way, and
so on. On the other hand, we want an information base to be used as a _tool_,
mechanized so that it is precisely described and can be expressed as binary
strings as unified data format. We shift the target of study from objects in Li
and Vitányi to _handles_ via _representations_, emphasizing an implicit user
created binding between a handle called a *sign* that represents a *referent*.
The information base _itself_ is not in charge with considering how to store or
retrieve certain entities, like an animal. For information bases to be useful,
one must determine the _fidelity_ of representations, determined by consequences
of axioms, both treated as handles (for more details, see
@universality-truth-management). Our core building block to explain this system
is through _units_. A unit is provided by a user-defined enumeration of handles,
and units can be broken down, build new units, or act on other units via
representations. Our approach is slightly more general than the enumerations
defined by Li and Vitányi, see @unit. Then, instead of defining information _as_
as a strict entity, we define when a unit _contains_ information on another (see
@information). We do this through how well representations _distinguish_ betwe .
Operationally, units can be used as partial computable functions, but the former
are strictly more expressive, due to user-defined implicit bindings.

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

