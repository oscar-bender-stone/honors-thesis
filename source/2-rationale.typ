// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": matched-dash
#show math.minus: matched-dash

#import "template/ams-article.typ": example

= Rationale <rationale>

[TODO[MEDIUM]: make sure that the rationale blends nicely with some of these
sections! For non-experts, say in logic, they should _not_ need to read _how_
the meta-theory works or such. They should only need to follow the bootstrap and
understand the syntax.]

syntaaxIn this section, we justify the design of Welkin.

== General Requirements

The main purpose of an information base is to store information and answer user
queries based on available information. To provide an upper bound on our
requirements, we require two important properties:

+ The information base must be mechanized, which means only "effective
  operations" are allowed. We make "effective operations" precise with the
  technical notion of _partial computable functions_. Partial computable
  functions are computer programs that can process a finite input, and that
  either stop on an input or continue forever. The bedrock for these functions
  is the notion of a _Turing machine_, which models every current form of
  computation. For more information, see @turing-computable-numbers. To obtain
  universality, we need to express _every_ one of these machines.

+ The information base must provide a mechanism to _ground_ symbols defined by
  users. This stems from the Symbol Grounding Problem, posed by Harnard
  @harnard-symbol-grounding. To avoid storing physical objects or such, users
  should have a way to provide _meaning_ to symbols, or a way to _represent_
  their topic of interest.

Combined together, we can now state universality as follows: _an information
base is universal if it can represent anything representable by a partial
computable function._ We will clarify how we define "representable" in the next
section.

== Units <rationale:unit>

[TODO[MEDIUM]: double check all examples!]

The first core concept in Welkin is the notion of a *handle*. Handles are left
as free parameters in the theory#footnote[For mathematicians, this is analogous
  to how key notions are left undefined in Hilbert's formalism of geometry, or
  how a "set" is an undefined notion in set theory.] In an information base,
handles are uniquely identified through their *key*, directly inspired by
database theory. Keys are with triples of IDs $("OID", "MID", "RID", "SID")$,
whose contents are the *origin ID*, *module ID*, *revision ID*, and *handle ID*,
respectively. Each ID serves the following purpose:

- The *origin ID* $"OID"$
- The *module ID* $"MID"$ defines the ID for a given string written in Welkin.
- The *revision ID* $"RID"$ ensures that storing specifications is *immmutable*,
  or provide a static snapshot of a unit. This is _not_ a restriction on
  representing dynamic entities, but rather, this indicates to the information
  base which version of a handle to use.
- The *symbol ID* $"SID"$ refers to the symbol used to index the handle.

We illustrate the use of these IDs in an example.

#example[
  In a scientific experiment, a handle could be an observation or experimental
  data. The unit is then written as a symbol, say $u$, and is _implicitly_ bound
  to this meaning. To distinguish from other symbols, say $v$, the computational
  content is analyzed.[TODO[MEDIUM]: expand out this example!]
]

Indexing handles is only one important aspect of handles. Another is that
handles are precisely by their relationships. These are written as
*representations* $a - c -> b$, which means that $a$ represents $b$ in context
$c$. Here, we call $a$ the *sign*, $b$ the *referent*, and $c$ the *context*.
One can interpret this characterization as follows: handles are defined by how
they are and are _not_ restricted. This idea is directly inspired from Fine's
idea of arbitrary objects @fine-arbitrary-objects, and allows refinements to a
study of interest.

#example[
  A more looser example is a user written journal for therapy sessions,
  containing information about daily habits and emotions. While neither of these
  are stored in the information base, their handles are, via units $"habit"$ and
  $"emotions"$ in a context $"journal"$. Moreover, multiple revisions of the
  journal can be made with dates or other unique IDs.
]

We represent handles in Welkin using an extended notion called a *unit*. A unit
is either a handle, a finite collection of units, or a representation.
Collections of units can have a uniquely generated name by the information base
called a *block*#footnote[In programming languages, this is analogous to an
  anonymous function.].

#example[

]


Units define their own *context*, which means the unit provides its own names
and representations. Writing $a - c -> b$, therefore, only applies to the
_fixed_ context $c$.


[TODO[SMALL]: use better names for entities/businesses/etc]
#example[
  A business could represent their operations using a unit $"business"$ that
  contains units for their workers and ledgers. This allows another unit, say
  $"business2"$, to contain its _own_ label $"workers"$ that is separate from
  the one in $"business"$. In addition to separate labels, these contexts can
  have _distinct_ rules, such as those for how business operations are
  performed.
]

// collectioWithin a fixed revision, handles, by being defined by how they are
// restricted, are _exactly_ described by the consequences of their relationships.
// We describe this as a syntactic rendering of truth through the notion of a truth
// management system. Here, we define a truth management system to consist of a set
// of axioms along with inference rules, whose derivations are accepted by some
// Turing machine. Welkin proves that not only is _any_ truth management system.

== Mechanizing Information <rationale:mechanizing-information>

From the notion of a unit, we practically define information on a unit $v$ as a
_unit that tracks reductions in $v$_. Formally, we define information as a proof
used in derivations, which include refinements of $v$ to other units. Key to
this definition is making it _context-based_, thereby enabling separate
truth-management systems (those systems defined by some Turing machine). This
notion corresponds to Burgin's idea of information as an _operator_ that
transforms a system, and is closely to Bateson's famous quote that "information
is a difference that makes a difference" @bateson-ecology-of-mind. Our practical
distinction between information and knowledge is that we _use_ information, but
users can assert their own notions of these terms by creating restricted
contexts. There are technical constructions to show that our definition is _as
general_ as possible (@foundations:information), as well as optimally organized
(@information-organization).

There are two primary inference rules, which we informally describe now:

- *Internal Transitivity:* if $u$ represents $v$ in context $c$ and $v$
  represents $x$ in context $c$, then $u$ represents $x$ in context $c$.

- *Lifting:* if $u$ represents $v$ in context $c$ and $p$ represents $q$ in
  context $v$, then within context $c$, $p$ represents $q$ in _nested_ context
  $u$.

Transitivity is a common axiom in many systems. It is particularly efficient
when used in contexts, as shown by several projects @lenat-cyc-common-sense,
@goczyla-context-description-logic. Lifting is a notion closely tied to
McCarthy's notion of lifting, but formulated with representations. The idea is,
if $a$ represents $b$ in context $c$, then $a$ provides an _abstraction_ for $b$
relative to $c$. Wherever $b$ is involved in a relationship, $a$ can be used
_instead_, acting as a proxy relative to $c$. Contexts provide an import
mechanism as well, thereby providing Welkin with a module based system. We
provide a simplified version of one McCarthy's examples below. For more existing
examples in the literature, refer to
@declarative-formalization-knowledge-translation.

#example[*(McCarthy's Above Theory).* Consider a set of physical blocks. Denote
  the unit `above` to represent the relation `block A is above block B`. We want
  to say this could be `on` to mean `block A is on block B`, or `floating_above`
  to mean `block A is floating above block B`. One way to state is as two
  axioms: and we could state as an axiom: `A - on -> B` implies `A - above -> B`
  and `A - floating_above -> B` implies `A - floating_above -> B`. Lifting
  provides a more economical approach _without_ needing to provide explicit
  terms, or provides a "point-free" rendering. We could that, within `above`,
  `above` represents `on` and `above` represents `floating_above`. In other
  words, `above` _precisely abstracts_ from the precise relationship between the
  two blocks.]

Another example concerns contexts in the presence of unique objects.

#example[Consider a biological survey of home pets, denoted by context `Survey`.
  Suppose there are two units in `Mammal`, say a dog `Fido` and a cat `Lucy`. We
  could state that `Fido` _represents_ `Mammal`, to say that `Fido` acts as a
  stand-in for a mammal in the survey. The same could be said with `Lucy`
  representing `Mammal`. Note that, depending on the context, the referent need
  _not_ be more refined than the sign; this is an intenional design choice for
  flexibility. With a another context `Taxonomy`, we may naturally state that
  `Mammal - Taxonomy -> Animal`, and we could say
  `Survey - instanceof -> Taxonomy`. Thus, the lifting rule implies in context
  `instanceof`, `Mammal - Survey -> Animal`. Using transitivity, we obtain
  `Fido - Survey -> Animal` and `Lucy - Survey -> Animal` in context
  `instanceof`. We can interpret this example as saying that the _relationships_
  of a general taxonomy are witnessed by a specific taxonomy, namely `Survey`,
  and that they propagate through contexts.#footnote[In programming languages,
    particularly C++ @stroustrup-cpp-lang and Java @java-reference, this
    property is known as "upcasting", with a less refined base class being
    replaced with a more refined subclass. The reverse is "downcasting". Both
    are supported by Welkin for full expressivity.]
]<rationale:more-to-less-refined>

The remaining rules are primarily for efficiency, enabling users to have
positionally invariant information, see @foundations:unit.

== Base Operations

Now, units and information themselves could be expressed in infinitely many
languages, with slightly different syntax or semantics. Welkin is carefully
designed to be a _minimal_ expression of these concepts, with minimal friction
to express any other universal information base. These include:

- In ASCII, #box[`a - b -> c`] for representations. These can be interpreted
  _as_ rewrite rules, depending on the context.

- Traditional braces `{ }` to denote closed definitions of contexts, inspired by
  the C programming language.

- Paths via dots `.` that is inspired by the Python programming language.
  Relative paths are denoted with multiple dots `...`, and absolute imports are
  prefixed with `#`. Subsets of units can be written via `u.{v, x}`, or even
  `u.{v --> x}` to refer to a subset of representations.

- Imports are done through `@u`, which takes all subunits of `u` and puts them
  into the current scope. In other words, the implementation _implicitly_ adds
  denotations `v <--> a.v` for each subunit `v` of `u`. This is motivated by the
  abundance of boolean logic in classical mathematics and computer science, as
  any finite circuit can be expressed in terms of `and` and `not`. Selecting
  specific subunits can be done via `@u.{v, x}`.

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
  languages, or be studied through the _overarching relationships_ in the units.

In general, the minimal restricted keywords is crucial for providing support for
other languages. An implementation of Welkin will contain a small section of
ASCII encoding for easier standardization, but the rest of the program can be
done _entirely_ in the user's native language. This is a novel feature in most
programming languages, which are either predominantly English or are fine tuned
for specific human languages.


== Bootstrapping <rationale:bootstrap>

There are two important considerations in Welkin: how the base operations are
implemented, and how proofs are expressed. In previous revisions, the author
separated these aspects, particularly when describing the syntax and semantics
of the language. However, this left many proofs in English, making it difficult
to transfer.

[TODO: provide citaitons] The author's emphasis of proofs stems from formal
methods, the study of providing mathematical proof to verify computer programs.
A central notion in this field is the *Trusted Computing Base (TCB)* of a
program, which is code used to implement it, as well as the axioms used to prove
its correctness. Many authors advocate for a small, fixed TCB. However, this is
inefficient in practice... Setting for a single system, like ZFC, does not
resolve whether Welkin is universal _for proofs_.

To resolve both issues, we "bootstrap" Welkin from the ground up. This will
enable Welkin to define the syntax _as_ a term in the language. We proceed as
follows:

+ We establish the base rules on units (@unit-rules).
+ Using English as our meta-language, we prove that our rules can define the $S$
  and $K$ combinators as any combination of terms, and thus is Turing complete,
  (@turing-expressible).
+ We show the language has a natural unit that indexes every other index. This
  term will act as a verifier for proofs, which we will show does _not_ limit
  which proofs we accept.

+ Provide the base meta-theory for the language _in_ Welkin. This will be PRA,
  written in a combinator based form. We will show the main axioms of PRA hold.

+ Prove that Peano Arithmetic is provably sound in a weak sense using a method
  developed by Artemov @artemov_serial_consistency. From there, we carry out
  Feferman's Reflection theorem written with our notions.

+ Define handles and information. We also justify information organization to
  promote the _most_ optimal paths to prove things, _if_ proofs are provided.
  This is deeply connected to Blum's speedup theorem and is essential for
  proving Goal 2.

+ Define the rules for path resolution and global IDs. These use a similar
  result to syntax descriptions and are significantly easier to read. [NOTE:
  emphasis on WIP here! Not yet developed in thesis !]

+ Finally, define the syntax through an _invertible syntax description_. This
  idea, pioneered by Rendel and Ostermann @invertible-syntax-descriptions,
  provides a combinator approach to define how concrete syntax, that is user
  written, is converted into abstract syntax, an abstracted form, _and back_.
  Along with the syntax, the encoding is given _itself_ through a
  representation, namely a table provided in this thesis.

