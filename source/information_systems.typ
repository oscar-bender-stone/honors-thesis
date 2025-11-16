// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, experiment, remark
#import "template/judgements.typ": judgement


= Information Systems <information_systems>


We now define the universal framework for analyzing information. Our approach
describes information as a _relation_. We show that this framework encompasses
both ontology and formal systems.

From there, we analyze the notion of _compressing_ information in an effectively
realizable way. We establish two key constructions and generalize them as
_information transformations_. The main result in this section is showing that
the best _effectively realizable compression scheme_ can be obtained by
appealing to Tarski's fixed-point theorem on the lattice of these
transformations.

== Information

Our motto is this: _information is a relation_. We will consider several
examples.

#example[Alice tells Bob that "I have a cat". This is a relation that relates
  Alice to some cat. In contrast, "a cat" is not a relation, and therefore not
  information.]

#example[A statement like $2 + 2 = 4$ is information. But it is also _true_
  information, or _knowledge_. We allow $2 + 2 = 5$ to be information as well,
  because it asserts _some_ relation between $2 + 2$ and $5$. A non-example is
  simply the number $2$ or a random binary string `0b010001`. Neither of these
  are relations because they are missing an _explicit connection_. Note that
  these relations can be unary, such as $2 = 2$.]


#example[Information can include quantifiers: "Joe has at least one egg." This
  asserts the existence of _some_ egg. Similarly, we can . However, we want to
  include more general notions. For instance, we could have quantifiers on
  _surfaces_: "This ball is red everywhere". This is not builtin directly as a
  first-order quantifier. Additionally, we would like to allow for modal
  sentences, like "There is necesarially one marble in the bag" or "There is
  possibly one marble in the basket". We will consider these generalized
  connectives into our definition (see @information).
]

However, we quickly run into philosophical blockades when we want to _use_
information.

#experiment[Suppose a person describes their feelings through a painting. Does
  this painting _convey_ information? Perhaps we can infer some emotions, such
  as feelings of sadness in a rainy scene or happiness in a cheerful one. How
  exactly do we _use_ or even _store_ this information? Is this data
  _subjectively_ information, requiring a person as an observer?]

We avoid these ideas by focusing on _formal_ information. This can be rigorously
defined into two key components: a *hierarchy* and a set of *connections*. Our
notion is based on *bigraphs*, a data structure created by Robin Milner
@robin_milner_bigraphs.

#let In = math.text("In")
#let Out = math.text("Out")
#let Link = math.text("Link")

#definition[*Information* is a *bigraph*, a triple $(X, T_X, G_X)$ where:
  - $X = V union T$ is the *domain*, where $V$ is the set of *variables* and $T$
    is the set of *bound terms*, each of which are countable sets of binary
    strings. We call $cal(P)(X)$ the set of *nodes*.
  - $T_X$ is the *place graph* or *hierarchy*, a tree with nodes in
    $cal(P)(X) union {bot}$, where the root is a distinguished element
    $bot in.not X$. For nodes $A, B$ we write $A <= B$ if $A = B$ or $A$ is a
    descendant of $B$.
  - $G_X subset.eq cal(P)(X) times cal(P)(X) times cal(P)(X)$ is the *link
    graph*. We write $(A, B, C) in G_X$ as $tack A - B -> C$. In the case where
    $B = emptyset$, we simply write $tack A -> C$. Additionally, we write
    $tack A = B$ iff $A -> B$ and $B -> A$. We impose several requirements,
    displayed in @link_graph_conditions, adapted from Meseguer
    @twenty_years_rewriting_logic.

    #judgement(
      rules: (
        (conclusion: $tack A -> A$, label: "Refl"),
        (
          premises: $tack A -> B, B -> C$,
          conclusion: $tack A -> C$,
        ),
        (
          premises: $tack A -> B, A = A', B = B'$,
          conclusion: $tack A' -> B'$,
          label: "Equality",
        ),
      ),
      caption: "Conditions on the link graph.",
    )<link_graph_conditions>

    - *Reflexivity:* $tack a -> a$ for each $a in X$.

    - *Transitivity:* $a -> b, b -> c$ entail $a -> c$ for $a, b, c in X$.

  A *pattern* $P$ is a node such that for some $P' <= P$,
  $P' in V$.#footnote[Our terminology is adapted from Grigore Roșu's _matching
    logic_ @matching_logic. We will return to this comparison later.]

  // We define three kinds of *neighborhoods* for each node $A$:
  // - $In(A) = {A - B -> C | B, C in X}$.
  // - $Out(A) = {B - C -> A | B, C in X}$.
  // - $Link(A) = {B - A -> C | B, C in X}$.
]<information>


#remark[
  Our notion of bigraph diverges from Milner @robin_milner_bigraphs in several
  important ways. Firstly, Milner's theory focuses around modeling
  non-deterministic operations in programming languages. Briefly, he considers
  place graphs which are _forests_ (with special regions), and allows for
  "holes" in the link graph. We simplify his definition by using a tree (with a
  designated root $bot$), and incorporating holes instead as patterns. Secondly,
  Milner's approach defines an algebra for bigraphs, as well as dynamic
  semantics (via _bigraphical reactive systems_). This is not immediately
  natural for our generalized setting; we will return to this issue in
  @transformations.
]

We interpret the elements of $X$ as _parts_, and think of the tree $T_X$ as
defining a _part-whole_ relation. A key design of Welkin is to enable _multiple_
notions of part-hood and seamlessly work among these. We provide a motivating
example one possible construction.

#example[
  - *Physical Composition:* Let $X_1 = {"house", "wall", "floor"}$ and suppose
    $"wall"$ and $"floor"$ are parts of $"house"$. In this case, parthood means
    _physical composition_.
  - *Classification:* Let $X_2 = {"animal", "dog", "bird"}$, and let $"dog"$ and
    $"bird"$ be parts of $"animal"$. Parthood is treated as a _taxonomy_ among
    things, specifically animals.
  - *Hybrid:* Suppose we want to put $X_1$ and $X_2$ above into a knowledge
    base. One way to distinguish between _physical composition_ and _taxonomy_
    is to introduce new links: $"makes"$ and $"isa"$, respectively. We take
    $T_3 = T_1 union T_2$ and introduce new relations:
    $"wall" ->^"makes" "floor" ->^"makes" "house"$
    $"dog" ->^"isa" "animal", "bird" ->^"isa" "animal"$, respectively.
]<parts_examples>


#definition[
  W
]<connection_axioms>


// Links have a special property called *mereological extension*: given
// $A - D -> C$ and $D : B$, we obtain $A - B -> C$. In other words, along a path
// via a link $D$, we can think of it equivalently as a path using $B$ but
// restricted to $D$.

== Formal Systems


We must first define a general class of formal systems. Considering the
diversity of formal reasoning, we need a _static_ and _dynamic_ component. These
have interpretations in *logic* and *computability*, outlined in
@formal_system_features.

#let features = table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([*Feature*], [*Logic*], [*Computation*]),
  [*Static*], [Formulas], [States],
  [*Dynamic*], [Inference], [Transitions],
)

We will focus on the _logical_ interpretation in our terminology, but note that
this is intentionally _general_ to encompass any other interpretation.


#figure(
  features,
  caption: [Features needed in a general formal system.],
)<formal_system_features>


Given this criterion, we define a formal system as follows, loosely based on the
definition provided by Strassburger @strassburger_what_is_a_logic.

#definition[
  A *formal system* is a pair $cal(S) equiv (cal(F), cal(R))$ consisting of:

  - *formulas* $cal(F)$, a decidable set of binary strings.
  - a set of *derivation rules* #box[$cal(R) subset.eq cal(F) times cal(F)$]. We
    define the *derivation relation* $=>$ to be the reflexive, transitive
    closure of $cal(R)$. Furthermore, we require that $=>$ is computable in
    polynomial time.

  A *sentence* is a closed derivation, and a *theory* is a set of sentences in
  $cal(F)$.
]

Note that the first condition on $cal(F)$ is redundant: reflexivity in $cal(R)$
ensures that each formula can be recognized in polynomial-time.

== Information Transformations <transformations>

== Optimal Compression Scheme

