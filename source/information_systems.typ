// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition


= Information Systems <information_systems>


We introduce the bulk of this thesis: providing an optimality criterion for an informatoin system and deriving the best one in terms of explicitly comptuable structures. We first introduce structures, followed by their representations. We then prove that the study to convert betweewn representations is RE-complete, ensuring the theory is sufficiently expressive.

== Structures <structures>

In FOL, the usual definition of a structure relies on a tuple of finitely many relations and function symbols on a domain. We simplify the definition; this will be expanded upon in @semantics.

#let PA = $bold("PA")$

#definition[
  A *structure* is a *bigraph*, namely a tuple $(X, T, G)$, where
  - $X$ is a *domain*, a set of binary strings
  - $T$ is a tree on $X$, the *hierarchy* of $X$. We make this more precise with the following constructors:
    - We add a symbol $emptyset in.not X$ called the *root*.
    - There is a *parent function* $p: X -> X union {emptyset}$ that is surjective. The preimage $p^(-1)(x)$ is the set of *children of $x$*. this can be encoded by a binary predicate $phi_p$ such that it is functional,

      $forall x. forall y_1. forall y_2. (p(x, y_1) and p(x, y_2) -> y_1 = y_2)$

      and surjective,

      $forall x. exists y. p(y, x)$.
  - $G$ is a *hypergraph* on $X$, encoded by a definable binary predicate $phi_G$ in $PA$.
]

Any hypergraph can be used to represent a FOL-structure via a disjoint; the latter can then be considered to be an indexed family of relations.


== Bases For Turing Machines

#let tms = math.cal("M")
#let fin(s) = $cal("F")(cal(A))$

Let $tms$ be the set of all Turing machines.
We examine a suitable lattice-structure on this set provide a semi-lattice
as a step towards organizational optimality.

*Definition.* Let $cal(A) subset.eq tms$. We say $cal(A)$ *spans* $tms$
if there is an explicitly computable, surjective $f: tms -> fin(cal(A))$
such that $cal(A) = {M | f(M) = {M}}$. In this case, we call $f$ an *analyzer* of $cal(A)$.

Analogous to group theory, bases enjoy a computable version of the First Isomorphism
Theorem.

*Theorem.*
#emph[
  Suppose $(cal(A), f)$ is a basis for $tms$. The following hold:
  - Let $rho$ be the function that takes Turing machines to the smallest Turing machine $M'$
    such that $f(M) = f(M')$. Then $g = f compose rho$ is an analyzer for $cal(A)$.
    We call $g$ the *canonical analyzer* w.r.t the basis.

  - The inverse $f^(-1): fin(cal(A)) -> ker(f)$ is explicitly computable; we call
    this
    a *synthesizer*. In particular, so is $g^(-1)$, which we call the *canonical synthesizer*
    (w.r.t. the basis).

  - Define the following operations on Turing machines:
    - $M_1 union.sq M_2 = g^(-1)(f(M_1) union f(M_2))$

    - $M_1 inter.sq M_2 = g^(-1)(f(M_1) inter f(M_2))$

    Then $union.sq$ and $inter.sq$ are explicitly computable, and $(M_1, union.sq, inter.sq)$
    is a semi-lattice. We call the induced partial order $M_1 subset.sq.eq M_2 <=> M_1 = M_1 inter.sq M_2$
    a *part-hood* relation, and the system
    $(tms, union.sq, inter.sq)$ the *Mereological System* of the basis.
]

_Proof_ $qed$

== Mereological Rewrite Systems

#let Hom = math.text("Hom")
#let emptyset = math.diameter
#let Prog = math.text("Prog")

We generalize a basis to include rewrite components. This will be the starting point
for discussing the optimality of the semantics.

#definition[
  Let $(A, f)$ be a basis on $tms$. The *Mereological
  Category* $cal(C)(A, f)$ is the largest category closed under explicit
  transformations on $fin(cal(A))$. In detail, it contains:
  - Objects: $fin(cal(A))$.
  - Morphisms: $Hom(A_1, A_2) = cal(E)(g^(-1)(A_1), g^(-1)(A_2))$. If $Hom(A_1, A_2) != emptyset$,
    then we write $A_1 -> A_2$.
]

#definition[
  *Definition.* A *progress theorem* is a proposition $p$ of the
  form $forall A. exists D_A. forall B. D_A (B) => B -> A$
  where $D_A$ is a family of explicitly computable unary predicates called the *progress predicate of $p$*.
  We say a Mereological Category has *progress $p$* if it satisfies $p$. Note that $A$
  may be free in $D_A$. We write $Prog(cal(C))$ for the set of progress theorems satisfied
  by $cal(C)$.
]

#definition[
  A Mereological Category has *universal progress* if the *Universal Progress Theorem (UPT)*
  holds: for every $A in cal(A)$,
  there is a $N$ such that, for every $B$ with $N$ elements, $B -> A$.
  This ensures the existence of $m: fin(cal(A)) -> NN$, given by
  $m(A) = min {N | forall B, |B| >= N. B -> A}$.
]

#definition[
  The category of Mereological Categories with universal progress consists
  of:

  - Objects: Mereological Categories.

  - Morphisms: $sigma: cal(C)(A_1, f_1) -> cal(C)(A_2, f_2)$ are the faithful functors.

  Our goal is to find the final object in this meta-category above with universal progress.
]



