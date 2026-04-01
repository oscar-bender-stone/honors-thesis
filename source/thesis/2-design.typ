// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": matched-dash
#show math.minus: matched-dash

#import "template/ams-article.typ": example

= Language Design <design>

In this section, we justify the design of Welkin.

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
  computation. For more background, refer to @turing-computable-numbers. To
  obtain universality, we need to express _every_ one of these machines.

+ The information base must provide a mechanism to _ground_ symbols defined by
  users. This stems from the Symbol Grounding Problem, posed by Harnard
  @harnard-symbol-grounding. To avoid storing physical objects or such, users
  should have a way to provide _meaning_ to symbols, or a way to _represent_
  their topic of interest.

Combined together, we can now state universality as follows: an information base
is universal _if it can represent anything representable by a computer program._
We will clarify how we define "representable" in the next section.

== Units <design:unit>

The first core concept in Welkin is the notion of a *handle*. Handles are left
as free parameters in the theory#footnote[For mathematicians, this is analogous
  to how key notions are left undefined in Hilbert's formalism of geometry, or
  how a "set" is an undefined notion in set theory.] In an information base,
handles are uniquely identified through their *ID*.

#example[
  Consider a business that distributes vehicle parts. The inventory could be
  could be recorded via handles, one for each category. One could be for
  `tires`, another for `wheels`, and so for. Each of these names are then
  _distinct_, ensuring one category does not interfere with another. Specific
  items can be given their own handles as well.
]<design:example-1>

Having unique indexes is only one important aspect of handles. Another is that
they are precisely characterized by their relationships. These are written as
*representations* $a - c -> b$. This is read as: $a$ *represents* $b$ *in
context* $c$. Here, we call $a$ the *sign*, $b$ the *referent*, and $c$ the
*context*. One can interpret this characterization as follows: handles are
defined by how they are and are _not_ restricted. This idea is directly inspired
from the philosophical idea of arbitrary objects, developed by Fine
@fine-arbitrary-objects. These representations can be refined and adjusted to a
given study of interest.

#example[
  An animal taxonomy can be stored through representations. Here, we write
  $"A" - "Taxonomy" -> "B"$ for handles $"A", "B"$ if $"B"$ is a special case of
  $"A"$. For example, we can add $"Mammal" - "Taxonomy" -> "Dog"$, as well as
  $"Mammal" - "Taxonomy" -> "Cat"$. Adding the rule
  $"Animal" - "Taxonomy" -> "Mammal"$ would allow simple deductions, such as
  $"Animal" - "Taxonomy" -> "Dog"$.
]<design:example-2>

We represent handles in Welkin using an extended notion called a *unit*. A unit
is either a handle, a finite collection of units, or a representation.
Collections of units can have a uniquely generated name by the information base
called a *block*.#footnote[In programming languages, this is analogous to an
  anonymous function.]

Units define their own *context*, which means the unit provides its own names
and representations. Writing $a - c -> b$, therefore, only applies to the
_fixed_ context $c$.

#example[
  A business could represent their operations using a unit $"business1"$ that
  contains units for their workers and ledgers. This allows another unit, say
  $"business2"$, to contain a label $"workers"$. Here, we can separate
  $"business1.workers"$ and $"business2.workers"$. In addition to separate
  units, these contexts can have _distinct_ rules, such as those for how
  business operations are performed.
]

== Mechanizing Information <design:mechanizing-information>

From the notion of a unit, we practically define information on a unit $v$ as a
_unit that tracks reductions in $v$_. Formally, we define information as a unit
containing a derivation ending in a unit containing $v$. Key to this definition
is making it _context-based_, thereby enabling separate truth-management systems
(those systems defined by some Turing machine). This notion corresponds to
Burgin's idea of information as an _operator_ that transforms a system, and is
closely to Bateson's famous quote that "information is a difference that makes a
difference" @bateson-ecology-of-mind. Our practical distinction between
information and knowledge is that we _use_ information, but users can assert
their own notions of these terms by creating restricted contexts. There are
technical constructions to show that our definition is _as general_ as possible
(@foundations:information).

An important rule pivotal to information is the following rule called
*contextual lifting*:

#set quote(block: true)
#quote(
  [Suppose $a$ represents $b$ in context $c$, and $p$ represents $q$ in context
    $a$. #linebreak() Then, _within_ context $c$, $p$ represents $q$ in context
    $b$.],
)

Written in symbols: $a - c -> b$ and $p - a -> q$ implies $p - b -> q$ _within_
$c$. Lifting is a notion closely tied to McCarthy's notion of lifting, but
formulated with representations. The idea is, if $a$ represents $b$ in context
$c$, then $a$ is a *surrogate* for $b$ relative to $c$. In other words, $a$ is a
_faithful_ proxy to $b$: if there is a relationship in context $a$, then it will
_also_ be in context $b$. Specific examples can be found throughout the
literature, including @declarative-formalization-knowledge-translation.
Additionally, lifting means that the definition of information is theoretically
_as general_ as possible. For details, consult @metatheory.

== Base Operations

Now, units and information themselves could be expressed in infinitely many
languages, with slightly different syntax or semantics. Welkin is carefully
designed to be a _minimal_ expression of these concepts, with minimal friction
to express any other universal information base. The core rules are provided in
@table:unit-rules. To express the syntax of the language, we write these in
ASCII in `type-writer` font.#footnote[This font is Intel One Mono (#link(
    "https://github.com/intel/intel-one-mono",
  )), licensed under OFL 1.1 (#link(
    "https://github.com/intel/intel-one-mono/blob/main/OFL.txt",
  )).] These include:

- In ASCII, #box[`a - b -> c`] for representations. These can be interpreted
  _as_ rewrite rules, depending on the context. The shorthand #box[`a --> b`] is
  used for the overarching context. Moreovoer, #box[`a <--> b`] means
  #box[`a --> b`] and #box[`b --> a`].

- Traditional braces `{ }` to denote closed definitions of contexts, inspired by
  the C programming language.

- Paths via dots `.` that is inspired by the Python programming language.
  Relative paths are denoted with multiple dots `...`, and absolute imports are
  prefixed with `@`. Subsets of units can be written via `u.{v, x}`, or even
  `u.{v --> x}` to refer to a subset of representations.

- Imports are done through `@u`, which takes all units in `u` and puts them into
  the current scope. In other words, the implementation _implicitly_ adds
  denotations `v <--> a.v` for each unit `v` in `u`.

- Selecting specific nested units can be done via `u.{v, x}` or, equivalently,
  `u.{v, x}`.

- Imports can be _negated_ via the notation `{g, ~u}`. This is an uncommon
  feature of most programming languages, appearing primarily in Haskell and CSS.

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
to a specific human language.
