// SPDX-FileCopyrightText: 2025 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": equation_block, lemma, proof, theorem

#import "template/ams-article.typ": equation_block


= Information Systems

Now with our meta-theory in @foundations, we can proceed to discuss information
systems.

== Motivating Examples

#theorem[
  There is no faithful embedding from unconditional rewrite systems to
  conditional ones.
]

How do we bring back the simplicity of the first definition, while ensuring we
include conditional rewrite systems? The answer is to use a tradic relation
instead and allow this relation to faithfully represent _any_ condition that is
expressible by a TM.

== Main Definition

Each of the previous examples suggests a common definition: _information is a
relation_. However, we want to express any formalizable kind of information. A
binary relation _can_ encode any other computable one, but not without clear
reasons or connections. We add this missing component by using triadic relations
instead, building off of semiotics and many other thinkers.

#definition[
  An *information system* is a pair $(D, I)$, where:
  - $D$ is the *domain*, a finite set of *data* in $NN$
  - $I$ is *information*, a computable subset of
    $D times D times D$
]

We will show this definition is suitable because a related concept can naturally
define formal systems.

TODO: Discuss how information reuse is possible via transformations.

#let Info = math.bold("Info")

== Reflection

Let $Info$ be the set of all information systems.

#theorem[
  Any R.E. structure on $$ can be represented in $$
]

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
