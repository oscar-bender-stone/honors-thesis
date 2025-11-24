// SPDX-FileCopyrightText: 2025 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT



#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": equation_block, lemma, proof, theorem

#import "template/ams-article.typ": equation_block


= Formal Reasoning

Now with our meta-theory in @foundations, we can proceed to discuss formal
systems.


== Formal Systems

To bridge information graphs with formal reasoning, We must first define formal
systems generally. Our definition is based on three sources:

- Mendelson @mendelson_logic.
- Cook and Reckhow @cook_proof_systems with "formal proof systems".
- Jean-Yves Béziau @universal_logic and field of Universal Logic.

#definition[
  A *formal system* is a pair $(cal(F), cal(R))$ consisting of:

  - *formulas* $cal(F)$, a decidable set of binary strings.
  - a set of *derivation rules* #box[$cal(R) subset.eq cal(F) times cal(F)$]. We
    define the *derivation relation* $tack_R$ to be the reflexive, transitive
    closure of $cal(R)$. Furthermore, we require that $tack_R$ is computable in
    polynomial time.

  A *sentence* is a closed derivation. A *theory* $cal(T)$ is a set of sentences
  in $cal(F)$ that is deductively closed. A set of sentences $cal(A)$ are
  *axioms* for $cal(T)$ iff $cal(T)$ is equal to the deductive closure under
  $cal(A)$.
]

Note that the first condition on $cal(F)$ is redundant: reflexivity in $cal(R)$
ensures that each formula can be recognized in polynomial-time.

We want a suitable notion of embedding from formal systems into information
systems. We adapt this notion from José Meseguer's notion of
$epsilon$-representation distance, introduced in @twenty_years_rewriting_logic.
To formalize this, we start with defining *transformations*, mappings on the
formulas, and then proceed to *morphisms*, which are structure preservig.

#definition[
  Let $(cal(F)_1, cal(R)_1), (cal(F)_2, cal(R)_2)$ be formal systems. Then a
  *transformation* $f: (cal(F)_1, cal(R)_1) -> (cal(F)_2, cal(R)_2)$ is a
  computable function $f: cal(F)_1 -> cal(F)_2$.
]<formal_system_transformation>


#definition[
  A *morphism* $f$ is a transformation such that $phi tack_cal(R)_1 psi => f(phi) tack_cal(R)_2 f(psi)$. An
  *isomorphism* is an invertible morphism whose inverse is also a morphism.
]<formal_system_morphism>

#lemma[
  The *category of formal systems* $FF$ consists of:

  - *Objects:* formal systems.

  - *Morphisms:* defined in @formal_system_morphism.

  This algebraic structure satisfies reflexivity and existence of composites.
]

== Universal Systems

#definition[A *(full) sub-category* $FF'$ of $FF$ consists of a set of objects
  and all the morphisms. A *framework* is a subcategory equivalent to $FF$ such
  that the objects form a decidable set.
]

Frameworks closely relate to the notion of *universal* formal systems.

#definition[
  A formal system $cal(U) equiv (cal(F)_cal(U), cal(R)_cal(U))$ is *universal*
  if there is a computable family of injective functions
  $G = {G_cal(S): cal(F)_cal(S) -> cal(F)_cal(U) | cal(S) equiv (cal(F), cal(R)) in FF}$
  over all formal systems such that at each fixed system $cal(S)$ and for all
  formulas $phi, psi in cal(F)$,

  $phi tack_cal(R) psi <=> G_cal(S)(phi) tack_cal(R)_cal(U) G_cal(S)(psi)$.

]

Our motivation for defining universal systems is a property called *reflection*,
similar to the one outlined in @twenty_years_rewriting_logic. That is, universal
systems _themselves_ can be studied in the context of a single universal system.
This enables meta-theoretic reasoning.

#theorem[
  Every universal formal system induces a framework $FF'$, as the image of the
  functor $cal(G): FF -> FF'$, given by

  #equation_block(
    prefix: "U",
    [$cal(G)(cal(S)) = ("Image"(G_cal(S)), cal(R)_cal(U) inter "Image"(G_cal(S))^2)$.],
  )

  Conversely, every framework induces a universal formal system.
]

#proof[
  We must show that $FF'$ is a framework for $FF$. Clearly this is a computable
  sub-category. To prove $cal(G)$ is an equivalence, notice that $cal(G)$ is
  full and faithful as a full sub-category of $FF$. Additionally, $cal(G)$ is
  essentially surjective precisely by construction. This completes the forwards direction.

  Conversely, a univeral framework can be formed from a system by creating a
  computable encoding of the formulas and rules of a system. The family $G$ can
  then be defined from an equivalence from $FF$ to $FF'$, which can be easily
  verified to preserve and reflection derivations.
]

