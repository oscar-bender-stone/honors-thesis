// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": (
  corollary, equation_block, lemma, proof, theorem,
)

#import "template/ams-article.typ": proof-sketch

= Metatheory <metatheory>

This section proves that Welkin's definition of information
(@foundations:information) is as general as possible, outlined in
@metatheory:overview. This proof is optional, and most readers are recommended
to jump to @conclusion. We assume the reader has background in first-order logic
and set theory. For specific references, consult @mendelson_logic and
@monk-set-theory, respectively.

#figure(
  table(
    columns: (20%, 25%, 55%),
    align: left,
    table.header([*Section Number*], [*Title*], [*Description*]),
    [@metatheory:artemov-selector-proofs],
    [*Artëmov's Selector Proofs*],
    [Explains Artëmov's selector proofs, specifically his finitistic proof of
      Peano Arithmetic's consistency. Expands this to soundness.],

    [@metatheory:artemov-logic-of-proofs],
    [*Artëmov's Logic of Proofs*],
    [Introduces Artëmov's *Logic of Proofs*, a logic that explains how
      jutsifications work. We also define *serial-soundness*.],

    [@metatheory:proof-completeness],
    [*Proof Completeness*],
    [Proves that Welkin can define any proof that is a) based on a sound theory,
      and b) is accepted by some Turing machine.],
  ),
  caption: [Overview of @syntax.],
)<metatheory:overview>

#let PA = math.text("PA")
#let PRA = math.text("PRA")
#let ZFC = math.text("ZFC")

For simplicity, we will make our base theory Peano Arithmetic ($PA$). Recall
that any unit is equivalent to a Turing machine
@foundations:turing-completeness-section. Because any Turing machine can be
expressed through a simple encoding in $PA$, so to can units, as well as the
rules in @table:unit-rules. A future work will consider weaker theories that can
embed Welkin. Additionally, we make two assumptions without loss of generality:

- First, we will consider only RE first-order theories $T$. This is because any
  formal system must be defined with proofs accepted by some Turing machine. In
  turn, this Turing machine can be expressed as a first order theory, consult
  @trakhtenbrot50.

- Secondly, we will only consider theories in the language of $PA$. Any
  first-order theory can encoded through arithmetic, using a similar
  construction from the point above.

- Thirdly, we stick to first order theories that use classical logic for
  simplicity. This will not affect completeness due to Gödel's double-negation
  translation. More details are available in @goedel-double-translation, but the
  details are not important here.

== Artëmov's Selector Proofs <metatheory:artemov-selector-proofs>

A major goal in Welkin is to express any representable notion, _including_ any
representabale proof. Proofs are a finite certificate that consists of a valid
sequence of steps. Importantly, proofs can be verified using a _total_
computable function, one that can check _any_ given proof. Because of the
requirement for computable checking, limitations in computable functions apply.
These are illustrated by several impossibility theorems, including Gödel's
infamous incompleteness theorems @goedel-original-incompletness-theorems.

However, previous impossibility results rely on proving strong properties of
proofs. Artëmov's argues that weaker, constructive properties can be used
instead. We provide a high-level definition of *serial-consistency* before
proceeding onto the embedding in Welkin.

#definition[
  Suppose $T$ is sufficiently strong to express its own proofs. Then $T$ is
  *serial-consistent* if there is a *selector* for $T$. A *selector* is a
  computable function#footnote[Technically, this is a primitive recursive
    function, but we will quickly generalize this to _any_ computable function.]
  $s$ with two properties:
  - $s$ accepts any string that encodes a valid proof.
  - if $s$ accepts a proof, then it cannot contain a contradiction.
]<metatheroy:artemov-serial-consistency>

Artëmov overcomes Gödel's second incompleteness theorem. This theorem states
that Peano Arithmetic $PA$, cannot prove its own consistency. Artëmov instead
demonstrates that $PA$ proves its own _serial-consistency_, as follows:
- He uses a weak meta-theory, in this case, Primitive Recursive Arithmetic
  ($PRA$). This theory is bounded by a weak principle of induction.
- Artëmov encodes all proofs as natural numbers in $PRA$; this theory is
  sufficiently strong _just_ to encode all of these proofs.
- Finally, he uses a proof by induction, over encoded proofs in $PRA$, to show
  that $PA$ proves each _individual_ proof contains no contradictions. This is
  possible through partial truth definitions.

To be clear: Artëmov does _not_ show that there is a _single_ proof that $PA$ is
consistent, that works for all proofs. Instead, his method _takes_ a proof as a
parameter. There have been extensive discussion on the validity of this
technique, and its acceptance by other logicians.#footnote[The discussion is
  available online at: #link(
    "https://mathoverflow.net/questions/469247/situation-with-artemovs-paper",
  ).]

Despite its initial controversy, Artëmov's techniques follow closely with
several constructive schools, consult @artemov_serial_consistency. This thesis
builds upon this result with a stronger property: *serial-soundness*. We will
need a specific stronger version for our purposes.

#definition[
  Let $T$ be an extension of $PA$. Then $T$ is *(meta-) self-verifying* if there
  is a total computable function $s$ over proofs of $T$, constructed in $PA$,
  such that $T$ proves this selector only accepts sound proofs. Moreover, this
  selector may _not_ use the general Law of the Excluded Middle
  ($phi or not phi$) nor the Principle of Explosion (#box[$bot => phi$]).
]

The exact same proof applies, using the same partial truth definition. Tarski's
theorem says that a formal system cannot define its own truth predicate _at the
object language_ @tarski-undefinability-truth. In fact, this truth predicate is
uncomputable, in general. We do not avoid Tarski's theorem, but we do
approximate it _as_ closely as partial computable functions allow. Because some
logics may not have a notion of inconsistency, we will not define consistency
itself. However, given the results in @foundations, first order logic can be
expressed in several ways.

== Artëmov's Logic of Proofs <metatheory:artemov-logic-of-proofs>

Building on serial soundness, we need to leverage Artëmov's *Logic of Proofs*.
This system is used to give semantics for meta-proofs, or proofs _on_ proofs.

#definition[

]<metatheory:def-logic-of-proofs>


== Proof Completeness <metatheory:proof-completeness>

[TODO: find a simpler proof! Maybe we don't _need_ ordinals?]

To show that this covers _every_ proof that can be computably recognized, we
need to discuss recursive ordinals. We provide an embedding via $"unit"$. For
more background on ordinals, refer to @monk-set-theory[Ch. 2],
@kleene-ordinal-notation. To keep the presentation self-contained, we will
define a unit for recursive ordinals. [TODO: maybe use a separate appendix?]

// #definition[The unit $"recursive_ordinal"$ is defined recursively, containing
//   nothing else:
//   - *Base:* $0 in "recursive_ordinal"$.
//   - *Successor:*
//   - *Limit:*
// ]<metatheory:transfinite-induction>


At a high level, it is not enough to carry out a _successor_ step, and then
solely combine theories through a union in the limit stage. At most, we can only
reach the Feferman–Schütte ordinal, denoted $Gamma_0$. [CITE!]. [TODO: discuss
predicative and impredicative theories more closely!] Feferman himself
_advocated_ for the sole use of predicative mathematics [CITE]. However, the aim
of Welkin is to be _as_ expressive as possible, especially as impredicative
theories have use in certain areas, e.g., formal methods projects [TODO: cite
these!]

Due to Artëmov's, there is an enormous jump from $PA$ all the way to $ZFC$. This
is because, over $PA$ as the base-theory, $ZFC$ is self-verifying (proves its
own soundness. A reason for this power in $ZFC$ is the axiom of replacement, or
even comprehension. We extend this realization using hyperarithmetic sets, which
are known to cover every recursive ordinal, refer to @kleene-ordinal-notation
[TODO: make sure this citation is correct!]. Based on Kleene's theorem, our key
construction in the limit case is to add this: let $lambda$ be a limit ordinal
and consider all given theories $T_1, T_2, ..., T_beta, ...$ with
$beta < lambda$. Then
$T_lambda = union.big_(beta < lambda) T_beta union "Comp"_lambda (Delta^1_1)$.
The set $"Comp"_lambda (Delta^1_1)$ is an axiom schema over each proposition
$phi$ definable in the extended theory, stating that [TODO: clarify notation!
And double check hyperarithmetic literature!]

$exists X_(phi, lambda). forall n. (n in X <=> (exists p. "Prov"(T_{psi(p)}), phi(p)))$.

Note that this set is encoded through $I Delta_0$ through an appropriate
encoding. And the provability predicate is also encoded through the base theory.
[TODO: clarify these encodings!] This new axiom naturally extends the Axiom of
Comprehension through _other_ sound theories.

We now prove a major property of Welkin.[TODO: definitely clean up!]

#theorem[$PA$, equipped with meta-proofs, can express any computably expressible
  proof from a sound RE theory. More precisely, for any recursive ordinal
  $alpha$, there is an RE theory $T$ such that:
  - $PA$ meta-proves that $T$ proves its own serial-soundness.
  - $T$ has a theoretic proof ordinal greater than $alpha$.
  than $alpha$.
]<metatheory:complete-proof-expressivity>
#proof[
  Using only autonomous progressions, it is already know that one can reach the
  Feferman-Schütte ordinal $Gamma_0$ @feferman-progressions. We may therefore
  focus on reaching higher ordinals, which depends on the limit case. But
  @kleene-ordinal-notation already proves that using hyper-arithmetic sets in
  the successor ensures that we can find _some_ $beta > alpha$. This is
  precisely the construction presented above. This completes the proof.
]

Note, however, that detecting if an ordinal is recursive is undecidable. The
upper bound is the best one can hope for, in general.

To complete the proof for Welkin, we call upon contextual lifting
(@r:context-lift).

#corollary[Welkin can express]
#proof[

]
