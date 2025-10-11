// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Foundations

We introduce the base theory needed for this thesis. We will keep it self-contained;
additional references will be provided in each sub-section.

== Peano Arithmetic

#let PA = math.bold("PA")
#let ZFC = math.bold("ZFC")

Our foundations of Welkin are based on Peano Arithmetic $PA$. We provide the full
list of axioms, relevant results, and justify why $PA$ is the most "minimal" theory
suitable for this language.

#let LA = $ cal(L)_A $

*Definition.* The *language* of $PA$ is the set $LA = {0, 1, S, +, *}$, with symbols
called:
- $0$ (*zero*) and $1$ (*one*).
- $+$ (*addition*) and $*$ (*multiplication*).

$PA$ enjoys several properties.

*Theorem.* $PA$ _proves the following:_
- _Every Primitive Recursive Function (PRF) is total_

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

*Definition.* An *Explicit Turing Machine (ETM)* is a Turing machine with 3-tapes
obeying the following:
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

== Verifiability and RE Languages

*Definition.* Let $cal(L)$ be a language. A *verifier* $V$ of $cal(L)$ is a decider
such that:

$ cal(L) = {w | exists c. (w, c) in L(V)} $

If a verifier of $cal(L)$ exists, then $cal(L)$ is *verifiable*. Moreover, we say $cal(L)$
is *explicitly verifiable* if $V$ is explicit.

*Theorem.* _A language is recursively enumerable if and only if it explicitly verifiable._

_Proof._ $qed$

== Decompositions of Turing Machines

#let tms = math.cal("M")
#let fin(s) = $cal("F")cal(A)$

Let $tms$ be the set of all Turing machines.
We examine a suitable lattice-structure on this set provide a semi-lattice
as a step towards organizational optimality.

*Definition.* Let $cal(A) subset.eq tms$ and $rho: tms -> tms$.

- $cal(A)$ is *spans* $tms$ if there exists an explicitly computable, surjective #box($f: tms -> fin(cal(A))$)
  such that for each $A in cal(A)$, $f(A) = {A}$. We call $f$ an a *analyzer* for $cal(A)$.

- $rho$ is a *canonical form of $f$* if $rho$ is explicitly computable, surjective,
  and has the same kernel equivalence relation as $f$, i.e.,
  $rho M_1 = rho M_2 <=> f M_1 = f M_2.$

- Let $ker f$ be the kernel of $f$. If $f$ is an analyzer for $cal(A)$ and $rho$
  is a a canonical
  form for $f$, then $(cal(A), f, rho)$ is a *(computational) basis* for $tms$.

Analogous to group theory, bases enjoy a computable version of the First Isomorphism
Theorem.

*Theorem*
#emph[
  Suppose $(cal(A), f, rho)$ is a basis for $tms$. The following hold:
  - The function $g = f compose rho$ is an analyzer for $cal(A)$. We call $g$ the *canonical analyzer*
    w.r.t the basis.
  - The inverse $f^(-1): fin(cal(A)) -> ker f$ is explicitly computable; we call
    this
    a *synthesizer*. In particular, so is $g^(-1)$, which we call the *canonical synthesizer*
    (w.r.t. the basis).

  - Define the following operations on Turing machines:
    - $M_1 union.sq M_2 <=> g^(-1)(f(M_1) union f(M_2))$

    - $M_1 inter.sq M_2 <=> g^(-1)(f(M_1) inter f(M_2))$

    Then $union.sq$ and $inter.sq$ are explicitly computable, and $(M_1, union.sq, inter.sq)$
    is a semi-lattice. We call the induced partial order $M_1 subset.sq.eq M_2 <=> M_1 = M_1 inter.sq M_2$
    a *part-hood* relation, and the system
    $(M_1, union.sq, inter.sq)$ the *Mereological System* of the basis.
]

_Proof_ $qed$

== Mereological Rewrite Systems

We generalize a basis to include rewrite components. This will be the starting point
for discussing the optimality of the semantics.

*Definition.* Let $(A, f, rho)$ be a basis on $tms$. A *Mereological Rewrite System*
(MRS) is a graph $(fin(cal(A)), ->)$ such that:
- $->$ has a unique null element $emptyset$: $emptyset -> A$ iff $A = emptyset$.
- $->$ extends $supset.eq$.

*Definition.* A Progress theorem is a *progress theorem*, a propposition $p$ of the
form $forall A. exists D. forall B. D(B) -> B -> A$
where $D$ is a explicitly computable predicate and called the *progress predicate of $p$*.
We say a MRS has *progress $p$* if it satisfies $p$.

*Definition.* A MRS has *universal progress* if the *Universal Progress Theorem (UPT)*
holds: for every $A in cal(A)$,
there is a $N$ such that, for every $B$ with $N$ elements, $B -> A$.
This ensures the existence of $m: fin(cal(A)) -> NN$, given by
$m(A) = min {N | forall |B| >= N. B -> A}$.

== Optimality of Decompositions
