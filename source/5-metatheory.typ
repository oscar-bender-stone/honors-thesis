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
to jump to @conclusion. We assume the reader has background in first-order
logic, set theory, and the arithmetic hierarchy. For specific references,
consult @mendelson_logic, @monk-set-theory, and @simpson-arithmetic,
respectively.

#figure(
  table(
    columns: (20%, 25%, 55%),
    align: left,
    table.header([*Section Number*], [*Title*], [*Description*]),
    [@metatheory:artemov-selector-proofs],
    [*Artëmov's #linebreak() Selector Proofs*],
    [Explains Artëmov's selector proofs. This includes his finitistic proof of
      Peano Arithmetic's consistency. Expands selector proofs for soundness.],

    [@metatheory:proof-completeness],
    [*Proof #linebreak() Completeness*],
    [Proves that Welkin can define any proof that based in a provably sound RE
      theory.],
  ),
  caption: [Overview of @syntax.],
)<metatheory:overview>

#let PA = math.text("PA")
#let PRA = math.text("PRA")
#let ZFC = math.text("ZFC")

For simplicity, we will make our base theory Peano Arithmetic ($PA$). Recall
that any unit is equivalent to a Turing machine
(@foundations:turing-completeness-section). Because any Turing machine can be
expressed through a simple encoding in $PA$, so to can units, as well as the
rules in @table:unit-rules. A future work will consider weaker theories that can
embed Welkin. Additionally, we make two assumptions without loss of generality:

- First, we will consider only RE first-order theories $T$. This is because any
  formal system must be defined with proofs accepted by some Turing machine. In
  turn, this Turing machine can be expressed as a first order theory.

- Secondly, we will only consider theories in the language of $PA$. Any
  first-order theory can encoded through arithmetic, using a similar
  construction from the point above.

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
  Let $T$ be an extension of $PA$. Then $T$ is *(meta-)self-verifying* if there
  is a total computable function $s$ over proofs of $T$, constructed in $PA$,
  such that $T$ proves this selector only accepts sound proofs. Moreover, this
  selector may _not_ use the general Law of the Excluded Middle
  ($phi or not phi$) nor the Principle of Explosion (#box[$bot => phi$]).
]<metatheory:self-verifying>

We need to remove these principles to ensure the proof is completely
constructive, and that the Principle of Explosion is not used to prove a false
claim.

Now, we can prove $"PA"$ is self-verifying, using partial truth definitions.
This is similar to the Artëmov's approach for serial-consistency. Note the
limitations posed by Tarski's theorem. This says that a formal system cannot
define its own truth predicate _at the object language_
@tarski-undefinability-truth. In fact, this truth predicate is uncomputable, in
general. We do not avoid Tarski's theorem, but we do approximate it _as_ closely
as Turing machines allow.

From this, we define a *meta-proof* in $PA$ as follows.

#let entails = $⊢$
#let metaproves = $attach(⊢, br: "meta")$

#definition[
  Let $T$ be a self-verifying theory. Then a $T$-*meta-proof* in $PA$ of $phi$,
  denoted $PA attach(entails, br: T) phi$, is any proof of
  $PA entails chevron.l T entails phi chevron.r$. Here,
  $chevron.l T entails phi chevron.r$ denotes the encoding of $T entails phi$ in
  $PA$. Additionally, if some meta-proof of $phi$ in $PA$ exists, we say $PA$
  *meta-proves* $phi$, denoted by $PA metaproves phi$.
]

#let metaproves = math.attach(entails, br: $"meta"$)


== Proof Completeness <metatheory:proof-completeness>

To show that this covers _every_ proof that can be computably recognized, we
need to discuss recursive ordinals. For more background on ordinals, refer to
@monk-set-theory[Ch. 2] and @proof-theory-ordinals. For our purposes, we will
only define specific properties needed for this thesis:

#let churchkleene = $omega^"CK"_1$

- Recursive ordinals, roughly, can be defined through a Turing machine. The full
  definition is in @kleene-ordinal-notation.

- The limit of these ordinals is called the *Church-Kleene ordinal*, denoted
  $churchkleene$. This is the first non-recursive ordinal.

- Every RE first-order theory $T$ has a recursive proof ordinal. Here, a proof
  ordinal is related to the strength of the theory. More details are available
  in @kleene-ordinal-notation.

- There are existing encodings of ordinals into $PA$. For one approach, consult
  @proof-theory-ordinals[Ch. 6].

Note that we can only reach so far with the successor stage. If we only permit
unionis in the limit stage, we can only reach the Feferman–Schütte ordinal
$Gamma_0$, as proven in @feferman-progressions. This ordinal is related to
predicative mathematics. However, the aim of Welkin is to be _as_ expressive as
possible, so we want to include _every_ impredicative theory that we can express
as well.

To reach these impredicative theories, we can utilize Artëmov's approach.
Following his method, one can soundly jump from $PA$ all the way to $ZFC$; this,
too, can be done with partial truth definitions. One reason why $ZFC$ is more
powerful is because of the Axiom of Replacement, or even Comprehension. We
extend this realization using hyperarithmetic sets, which are known to cover
every recursive ordinal, proven in @kleene-hyperarithmetic-covering. To this
end, our construction relies on a Simpson's principle of comprehension. This
stems from Simpson's studies in Reverse Mathematics @simpson-arithmetic. The
comprehension axiom states:

#set math.equation(numbering: none)
$ exists X. forall n. lr((n in X <=> Phi(n))) $

where $Phi(n)$ is a predicate that is both $Sigma^1_1$ and $Pi^1_1$. For
details, consult @simpson-arithmetic.

We carry out this same construction for our use case. Let $lambda$ be a
recursive limit ordinal, and consider all given theories
$T_1, T_2, ..., T_beta, ...$ with $beta < lambda$. Define
#set math.equation(numbering: none)
$
  T' = union.big_(beta <lambda) T_beta
$

Note that, because the sequence above is indexed by recursive ordinals, $T'$ is
computable by some Turing machine. Moreover, $T'$ is self-verifying: one can
combine the selectors for each $T_j$ into a single selector. This requires
dovetailing, which is the simulation of these theories in paralelel. The
definitions of each selector can be incrementally added, ensuring that all
theories are covered.

Now, set $T_lambda = T' union "Comp"_lambda (Delta^1_1)$. Here,
$"Comp"_lambda (Delta^1_1)$ is an axiom schema over each predicate $phi(n)$
definable in $T'$. It states that:

#set math.equation(numbering: none)
$
  exists X_(phi, lambda). forall n. lr(
    (n in X_(phi, lambda) <=> PA attach(entails, br: T') phi(n))
  )
  ).
$

Constructing $T_lambda$ can be done with dovetailing, described above. This
ensures that each limit stage does _not_ rely on non-constructive principles,
such as Choice. Using the construction above, we can now prove the power of
meta-proofs in $PA$.

#theorem[$PA$, equipped with all possible meta-proofs, can reach any
  proof-theoretic ordinal. More precisely, for any recursive ordinal $alpha$,
  there is an RE theory $T$ such that:
  - $PA$ meta-proves that $T$ proves its own serial-soundness.
  - $T$ has a theoretic proof ordinal greater than $alpha$.
]<metatheory:complete-proof-expressivity>
#proof[
  As previously mentioned, autonomous progressions are enough to reach the
  Feferman-Schütte ordinal $Gamma_0$ @feferman-progressions. We may therefore
  focus on reaching higher ordinals, i.e., defining a suitable limit stage. For
  this, @kleene-ordinal-notation already proves that using hyper-arithmetic sets
  suffice, which is precisely done by the construction above. This completes the
  proof.
]

Note, however, that detecting if an ordinal is recursive is undecidable. The
upper bound is the best one can hope for, in general.

To complete the proof for Welkin, we call upon contextual lifting
(@r:context-lift).

#corollary[Welkin can express any proof from a provably sound RE
  theory.]<metatheory:welkin-proof-completeness>
#proof[
  First, note that an RE theory is provably sound if it can be expressed by a
  meta-proof in $PA$. For any theory $T_1$, one can construct an extension $T_2$
  with a larger proof theoretic ordinal, based on
  @metatheory:complete-proof-expressivity.

  Second, clearly $PA$ can be embedded into Welkin, based on
  @foundations:turing-completeness-section. Call this unit $"pa"$. We can
  express any self-verifying theories $"T"$ and $"T'"$ as units (again, via
  @foundations:turing-completeness-section), and we add the rule
  $"T'" - "pa" -> "T"$ if $"T"'$ extends $"T"$. Thus, any derivation expressed
  in $"T"$, consisting of steps of the form $u_i - "T'" -> u_j$, means that
  these carry to $T$ as well, _within_ $"pa"$. By this observation and
  @metatheory:complete-proof-expressivity, this completes the proof.
]
