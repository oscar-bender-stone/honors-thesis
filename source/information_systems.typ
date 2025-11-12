// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, experiment


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

However, we quickly run into philosophical blockades when we want to _use_
information.

#experiment[Suppose a person describes their feelings through a painting. Does
  this painting _convey_ information? Perhaps we can infer some emotions, such
  as sadness in a rainy scene or happiness in a cheerful one. How exactly do we
  _use_ or even _store_ this information? Is this information only conveyed when
  _experienced_ as a person]

We avoid these ideas by focusing on _formal_ information. This can be rigorously
defined into two key components: a *hierarchy* and a set of *connections*. Our notion is based on *bigraphs*, a data structure created by Robin Milner @robin_milner_bigraphs.

#definition[*Information* is a *bigraph*, a triple $(X, T_X, G_X)$ where:
  - $X$ is the *domain*, a countable set of binary strings.
  - $T_X$ is the *place graph* or *hierarchy*, a tree with nodes in $cal(P)(X) union {bot}$, where $bot in.not X$ is a distinguished element called the *root*. When $A$ is a descendant of $P$, we write $A : P$.
  - $G_X subset.eq cal(P)(X) times cal(P)(X) times cal(P)(X)$ is the *link
    graph*. We write $(A, B, C) in G_X$ as $A - B -> C$.
]


We interpret the elements of $X$ to represent _parts_, and the tree $T_X$ represent generalized part-whole relations. For example, in the domain $X = {}$. But we can consider more broader ideas, such as considering a $"dog": "animal"$ in $X = {"animal", "dog", "bird"}$.

Links have a special property called *mereological extension*: given $A - D -> C$ and $D : B$, we obtain $A - B -> C$. In other words, along a path via a link $D$, we can think of it equivalently as a path using $B$ but restricted to $D$.

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

== Information Transformations

== Optimal Compression Scheme

