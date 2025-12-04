// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, experiment, remark
#import "template/ams-article.typ": lemma, theorem


= Information Graphs <information_graphs>


We now define the universal framework for analyzing information. Our approach
describes information as a _relation_. We show that this framework encompasses
both ontology and formal systems.

From there, we analyze the notion of _compressing_ information in an effectively
realizable way. We establish two key constructions and generalize them as
_information transformations_. The main result in this section is showing that
the best _effectively realizable compression scheme_ can be obtained by
appealing to Tarski's fixed-point theorem on the lattice of these
transformations.

== Motivating Examples

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

== Formal Approach

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
    $tack A = B$ iff $A -> B$ and $B -> A$.

  A *pattern* $P$ is a node such that for some $P' <= P$,
  $P' in V$.#footnote[Our terminology is adapted from Grigore Roșu's _matching
    logic_ @matching_logic. We will return to this comparison later.]
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
  information @information_compression.
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

#definition[The *consequence operator* $tack$ of a bigraph $(X, T, G)$ is
  defined by the judgements in @consequence_operator_axioms.

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
      (
        premises: $tack A_1 -> B_1, ..., A_n -> B_n$,
        conclusion: $tack {A_1, ..., A_n} -> {B_1, .., B_n}$,
        label: "Group",
      ),
    ),
    caption: [Conditions on the link graph, adapted from Meseguer
      @twenty_years_rewriting_logic.],
  )<consequence_operator_axioms>
]<consequence_operator>


// Links have a special property called *mereological extension*: given
// $A - D -> C$ and $D : B$, we obtain $A - B -> C$. In other words, along a path
// via a link $D$, we can think of it equivalently as a path using $B$ but
// restricted to $D$.

