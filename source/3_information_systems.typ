// SPDX-FileCopyrightText: 2025 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": equation_block, lemma, proof, theorem

#import "template/ams-article.typ": equation_block


= Information Systems

Now with our meta-theory in @foundations, we can proceed to discuss information
systems.

== Motivating Examples and Definition

We start with simple informal examples to explore the concept of information:

- Statements about the world.

- Taxonomies.

- Mathematical relations.

- More sophisticated: formal theories.

Each of the previous examples suggests a common definition: _information is a
relation_. However, we want to express any formalizable kind of information. A
binary relation _can_ encode any other computable one, but not without clear
reasons or connections. We add this missing component by using triadic relations
instead, building off of semiotics and related schools of thought.

#definition[
  An *information system* is a pair $(D, I)$, where:
  - $D$ is the *domain*, a finite set of *data* in $NN$
  - $I$ is *(partial) information*, a partially computable subset of
    $D times D times D$. This information is *complete* if $I$ is totally
    computable.
]

== Constructions and Reflection

#let Info = math.bold("Info")

Let $Info$ be the set of all information systems.


A natural construction to include is a system with _indexed information_, akin
to index families of sets.

#definition[
  Let $cal(S) = {(D_i, I_i)}_{i in NN}$ be a family of information systems,
  indexed by a computable function $e: NN -> cal(S)$. Then the *sum* of these is
  $(union.dot.big D_i, union.dot.big I_i)$.
]


A natural question that arises is: what is information _between_ information?
Before we address this question, we want to conceptualize information _reuse_.
Traditionally, if we view information as being a _true formula_ in a theory,
then we would want to preserve truth between theories. Our definition is more
general, and we can to capture of a transformation instead, which takes all of
one system and relates it into another. We generalize beyond functions to
naturally model bisimulations and other relations. We intentionally express
transformations _as_ information systems themselves.

#definition[
  Let $cal(S)_1 equiv (D_1, I_1)$ and $cal(S)_2 equiv (D_2, I_2)$ be information
  systems. A *transformation* $T$ from $cal(S)_1$ to $cal(S)_2$ is an
  information system $(D_1 union.dot D_2, I')$, where $I' inter D_1 = I_1$ and
  $I' inter D_2 = I_2$.
]


As another construction, we can naturally model formal systems by asserting that
$I$ is reflexive and transitive in a general sense, formalized by below.

#definition[
  A *formal system* is an information system such that the information relation
  is reflexive and .
]

This construction is *information compressing*: we can encode information into a
different representation and decode it back computably.


Special systems:

- $(emptyset, emptyset)$ is the *null information system*
- $(NN, NN times NN times NN)$ is the *discrete information system*

#lemma[
  Let $cal(H) equiv (Info, <=)$, where $(D_1, I_1) <= (D_2, I_2)$ iff
  $D_1 subset.eq D_2$ and $I_1 subset.eq I_2$. Then $cal(H)$ forms a Heyting
  Algebra, with bottom element being the null information system and the top
  element being the discrete one.
]

#theorem[
  - The discrete information system cannot represent $cal(H)$.
  - $cal(H)$ can represent any extension of this structure and therefore induces
    an idempotent operator.
]

TODO: Show that a formal system provides a proof system that is a way to
_optimize_ the search space of information systems.


== Universality


#theorem[
  Every universal formal system induces a framework $FF'$, as the image of the
  functor $cal(G): FF -> FF'$, given by
  $cal(G)(cal(S)) = ("Image"(G_cal(S)), cal(R)_cal(U) inter "Image"(G_cal(S))^2)$.
  Conversely, every framework induces a universal formal system.
]

#proof[
  We must show that $FF'$ is a framework for $FF$. Clearly this is a computable
  sub-category. To prove $cal(G)$ is an equivalence, notice that $cal(G)$ is
  full and faithful as a full sub-category of $FF$. Additionally, $cal(G)$ is
  essentially surjective precisely by construction. This completes the forwards
  direction.

  Conversely, a univeral framework can be formed from a system by creating a
  computable encoding of the formulas and rules of a system. The family $G$ can
  then be defined from an equivalence from $FF$ to $FF'$, which can be easily
  verified to preserve and reflection derivations.
]

// #remark[
//   Strassburger @strassburger_what_is_a_logic advocates to _define_ a logic as a
//   category. But this is not immediate for certain logics. For instance, in the
//   sequence calculus, composition of two proofs is not uniquely defined. Our
//   definition approaches this by using an artificial, inefficient representation.
//   Strassburger's work on deep inference addresses this problem, but instead of a
//   generalization, we intrepret it as an _optimization_.
// ]

// #definition[
//   Let $(cal(F), cal(R))$ be a formal system, and let $cal(T)$ be a set of
//   formulas. The *deductive closure* of $cal(T)$ is
//   $"Th"(cal(T)) = {phi in cal(F) | exists psi in cal(T). psi vdash(cal(R)) phi}$.
//   We call $cal(T)$ a *theory* if $cal(T) = "Th"(cal(T))$. A set of formulas
//   $cal(A)$ serve as *axioms* for a theory $cal(T)$ if $cal(T) = "Th"(cal(A))$.
// ]


// == Universal Systems

// We want to study formal systems in general. A key invariant we want to preserve
// is _faithful representations_, or the notion of "$epsilon$-representatoin
// distance" from José Meseguer @twenty_years_rewriting_logic. The idea is that a
// _good_ representation of a mathematical object is one which preserves and
// reflects isomorphism. We can treat this as _soundness_ (isomorphic
// representations have actually isomorphic objects) and _completeness_ (isomorphib
// objects produce isomorphic representations) of the representation, respectively.
// To make this precise,we introduce *transformations*, which are mappings between
// formulas of two systems, and then proceed to *morphisms*, which are structure
// preserving maps.

// #definition[
//   Let $(cal(F)_1, cal(R)_1), (cal(F)_2, cal(R)_2)$ be formal systems. Then a
//   *transformation* $f: (cal(F)_1, cal(R)_1) -> (cal(F)_2, cal(R)_2)$ is a pair
//   $(F, R)$, where $F: cal(F)_1 -> cal(F)_2$ is computable and
//   $R subset.eq cal(R)_1 times cal(R)_2$ is left-total and if $F(phi) = psi$,
//   then $phi R psi$.
// ]<formal_system_transformation>
