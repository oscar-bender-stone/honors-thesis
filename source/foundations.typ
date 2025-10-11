// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Foundations

We introduce the base theory needed for this thesis. We will keep it self-contained;
additional references will be provided in each sub-section.

== Peano Arithmetic

#let PA = math.bold("PA")
#let ZFC = math.bold("ZFC")

The foundations of Welkin are based on Peano Arithmetic $PA$. We provide the full
list of axioms, relevant results, and justify why $PA$ is the most "minimal" theory
suitable for this language.

#let LA = $ cal(L)_A $

*Definition.* The *language* of $PA$ is the set $LA = {0, 1, S, +, *}$, with symbols
called:

- $0$ (*zero*) and $1$ (*one*).

- $+$ (*addition*) and $*$ (*multiplication*).

*Definition.* The axioms of $PA$ are:

-

-

-

$PA$ enjoys several properties.

*Theorem.* $PA$ _proves the following:_
- _Every Primitive Recursive Function (PRF) is total._

- $PA$ _is *only* infinitely axiomatizable._

Our criterion for why we choose $PA$ is the following.

*Theorem.* _$PA$ is the smallest theory to prove every Primitive Recursive Function (PRF) is total.
More precisely, suppose $T'$ is equivalent to a strict subset of $PA$. Then $T'$ fails to prove some PRF is total._

_Remark._ The proof of this theorem is beyond the scope of this thesis. Instead,
we refer
to the standard constructions in the literature. Additionally, these proofs can be _astronomically_
large, but the point is to ensure we can discuss _prove_ any PRF is total, which
will be key in exploring decompositions.

One key strength of $PA$ is its ability to encode _any_ Turing
machine and, given a trace, verify its correctness. This enables encodings of _any_
first-order theory, including $ZFC$. However, the only proofs necessary
for Welkin are completely contained in $PA$.

== Explicit Computability

#let Hom = math.text("Hom")

*Definition.* An *Explicit Turing Machine (ETM)* is a 3-tape Turing machine with
the following restrictions:

- *Read Tape:* the only transitions allowed are those labeled with right (R)

- *Work Tape:* this cannot contain any inner loops. Can access the read and stack
  tapes.

- *Stack Tape:* used ONLY as a stack.

A function computable by an ETM is said to be *explicitly computable*.

*Lemma.*
#emph[
  ETMs are closed under:

  - Composition

  - Finite Unions and Finite Intersections

  - Complements

  - Kleene Star
]

To explore transformations between Turing machines, we first introduce their encodings.

*Definition* The *description* of a Turing machine is the encoding of its transition
diagram into a standard format.

*Definition.* Let $M_1, M_2$ be Turing machines. An *explicit transformation*
$tau: M_1 -> M_2$ is an explicitly computable function from the description of $M_1$
to the description of $M_2$.

As a natural consequence of the Lemma above,
we can completely determine the explicitly computable transformations _only_ with
explicit functions.

*Lemma*. _Let $M_1, M_2$ be Turing machines. Then there is an explicitly computable $sigma$
that enumerates through all explicit transformations of $M_1$ to $M_2$. We
write $cal(E)(M_1, M_2)$ as the set of explicit transformations._

== Verifiability and RE Languages

*Definition.* Let $cal(L)$ be a language. A *verifier* $V$ of $cal(L)$ is a decider
such that:

$ cal(L) = {w | exists c. (w, c) in L(V)} $

If a verifier of $cal(L)$ exists, then $cal(L)$ is *verifiable*. Moreover, we say $cal(L)$
is *explicitly verifiable* if some verifier $V$ is explicit.

*Theorem.* _A language is recursively enumerable if and only if it explicitly verifiable._

_Proof._ $qed$

This provides the bedrock of our main definition, inspired by Hoprocroft et. al.

*Definition.*
- A *problem* is an explicitly verifiable language.
- A *problem instance* is any binary string.
- A *solution* to a problem $P$ is a Turing machine that recognizes $P$.

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

*Definition.* Let $(A, f)$ be a basis on $tms$. The *Mereological
Category* $cal(C)(A, f)$ is the largest category closed under explicit
transformations on $fin(cal(A))$. In detail, it contains:
- Objects: $fin(cal(A))$.
- Morphisms: $Hom(A_1, A_2) = cal(E)(g^(-1)(A_1), g^(-1)(A_2))$. If $Hom(A_1, A_2) != emptyset$,
  then we write $A_1 -> A_2$.
*Definition.* A *progress theorem* is a proposition $p$ of the
form $forall A. exists D_A. forall B. D_A (B) => B -> A$
where $D_A$ is a family of explicitly computable unary predicates called the *progress predicate of $p$*.
We say a Mereological Category has *progress $p$* if it satisfies $p$. Note that $A$
may be free in $D_A$. We write $Prog(cal(C))$ for the set of progress theorems satisfied
by $cal(C)$.

*Definition.* A Mereological Category has *universal progress* if the *Universal Progress Theorem (UPT)*
holds: for every $A in cal(A)$,
there is a $N$ such that, for every $B$ with $N$ elements, $B -> A$.
This ensures the existence of $m: fin(cal(A)) -> NN$, given by
$m(A) = min {N | forall B, |B| >= N. B -> A}$.

*Definition.* The category of Mereological Categories with universal progress consists
of:

- Objects: Mereological Categories.

- Morphisms: $sigma: cal(C)(A_1, f_1) -> cal(C)(A_2, f_2)$ are the faithful functors.

Our goal is to find the final object in this meta-category above with universal progress.

== Optimality of Decompositions
