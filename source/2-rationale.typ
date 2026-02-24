// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Rationale <rationale>

#import "template/ams-article.typ": example

In this section, we justify the design of Welkin.


== Information Bases

The main purpose of an information base is to store information and enable user
queries based on the available information. To make this idea precise, we
dissect the approach taken by Algorithmic Information Theory, specifically
through a well known book by Li and Vitányi @intro_kolmogorov_complexity. Their
book starts the idea of enumerating _objects_ to strings called _descriptions_.
A valid enumeration is described as follows:

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
the enumeration can be mechanized. The authors proceed define the _information
content_ of a string through Kolmogorov complexity, the size of the smallest
description that accepts an object, or in other words, the smallest program that
accepts a string. From there, they prove multiple foundational results for
Algorithmic Information Theory, including that Kolmogorov complexity is
uncomputable, in general.

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
@liu-algorithmic-symbol-grounding, demonstrating the same impossibility of
completely grounding a system of symbols through a fixed grounding set.

[TODO[SMALL]: maybe clarify how powerful deduction is? That's my point here,
that we don't have to check if a property holds _if_ we use a theorem instead,
or we use different set of conditions to get a certain property.]

To address these issues, we emphasize that an information base is a _tool_,
which is useful when fully mechanized for _communication_, not to resolve
philosophical inquiries on the existence or absence of things or abilities.
Information itself is used for _predictions_: a person that translates the
sentence "It will rain today" to Chinese to convey a semantic property of the
world, that there will be rain. This scales to larger examples, with major
theorems providing even more refined or general properties _given_ a set of
assumptions. Note that this is different form Shanon's seminal work on
Information Theory, in which methods are found to convey the _exact_ bits of
strings in noisy channels. Because communication _itself_ does not carry the
physical entities, relationships are key to effectively conveying ideas. A
recent work bridges this gap with Shannon's work to express meaning through
finite models in first-order logic, so that two strings are considered
equivalent if they are that are provably equivalent as first order sentences are
in fact equal, regardless of different bits @information-logical-semantics.

== Units

Taking inspiration from @information-logical-semantics, this thesis completely
generalizes their approach using a notion of _handles_ via _representations_,
emphasizing an implicit user created binding between a handle called a *sign*
that represents a *referent*. The information base _itself_ is not in charge
with considering how to store or retrieve certain entities, like an animal. For
information bases to be useful, one must determine the _fidelity_ of
representations, determined by consequences of axioms, both treated as handles
(for more details, see @universality-truth-management). Our core building block
to explain this system is through _units_. A unit is provided by a user-defined
enumeration of handles, and units can be broken down, build new units, or act on
other units via representations. Our approach is slightly more general than the
enumerations defined by Li and Vitányi, see @unit, and they can define _any_
formal system, see ?. Operationally, units can be used as partial computable
functions, but the former are strictly more expressive, due to user-defined
implicit bindings.

[TODO: make this clear? Can't a unit *be* itself information?]

From the notion of a unit, instead of defining information _as_ as a strict
entity, we define when a unit _contains_ information on another (see
@information). We do this through how well representations _distinguish_ between
other units, made more @semantics. This notion is analogous to _prefix_
Kolmogorov complexity, which is the Kolmogorov complexity of a string $x$
_given_ the description of a string $y$. This notion also corresponds closely to
Bateson's famous quote that "information is a difference that makes a
difference" @bateson-ecology-of-mind and generalizes a propositional rendering
of this statement [CITE]. Our practical distinction between information and
knowledge is that we _use_ information, but users can assert their own notions
of these terms by creating restricted contexts.

[TODO[MEDIUM]: probably provide an example of higher order logic or so? Would be
nice! Shows that we don't need _exactly_ a thing. But do emphasize that getting
_exact_ data formats can make information dissemination easier!]
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

There is an important extension required to express _any_ partial computable
function. With only two components, representations our representation is too
restrictive, because we cannot naturally express _conditions_ through
_conditional representations_. Another issue is that managing two sets of
handles is difficult with _solely_ unconditional representations. Providing a
form of _namespaces_, or a mechanism to distinguish two sets of names, which is
crucial for determining and distinguishing available information as well. In
addition to naming collisions, we also require a way to provide subject specific
knowledge, as Burgin does through infological systems
@burgin-foundations-information. A key insight in this thesis is showing that
expressing conditions is _equivalent_ to creating these namespaces: we express
this idea as a *context*. This is related to an informal claim made in Meseguer
@twenty_years_rewriting_logic, that rewriting logics without conditional rules
are strictly less expressive than those with conditions, see
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


