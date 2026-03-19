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
  turn, this Turing machine can be expressed as a first order theory.

- Secondly, we will only consider theories in the language of $PA$. Any
  first-order theory can encoded through arithmetic, using a similar
  construction from the point above.

- Thirdly, we stick to first order theories that use classical logic for
  simplicity. This will not affect completeness either. Again, the corresponding
  Turing machine of a non-classical logic can be simulated by a classical one.

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

== Artëmov's Logic of Proofs <metatheory:artemov-logic-of-proofs>

Building on serial soundness, we need to leverage Artëmov's *Logic of Proofs*.
This system is used to give semantics for meta-proofs, or proofs _on_ proofs.
For more details, refer to @Artemov1994-ARTLOP.

#let entails = $⊢$
#let realizes = math.class("relation", context {
  let ts = $entails$

  let ts_metrics = measure(ts)
  let bar_height = ts_metrics.height

  let bar = box(
    line(start: (0pt, 0pt), end: (0pt, bar_height), stroke: 0.05em),
  )

  bar
  h(0.15em) // Increase this if you want them further apart
  ts
})

#definition[
  The *(Constructive) Logic of Proofs (LP)* is defined as follows:
  - *Proof terms* are built recursively as either:
    - A *proof variable*, a symbol $x_1, x_2, ...$
    - A *constant*, a symbol $c_1, c_2, ...$. These represent axioms.
    - *Application*: $s dot t$ for proof terms $s, t$. This concatenates two
      proofs together.
    - *Sums*: $s + t$. This corresponds to logical disjunction.
    - *Checker:* $!t$. This represents checking a proof.
  - *Formulas* are built recursively as either:
    - Propositional variables $p_1, p_2, ...$
    - False ($bot$).
    - Logical implication ($=>$).
    - *Justification* $(t realizes F)$, where $t$ is a proof term and $F$ is a
      formula. We say that $t$ *realizes* $F$.#footnote[Note that Artëmov
        originally denostes this by $t : F$. However, this conflicts with
        standard notation in type theory. For this reason, we have chosen to
        write $t realizes F$ instead. Additionally, this relates back to the
        connections between Artëmov's work and realizability. For details,
        consult @Artemov1994-ARTLOP.]
  - The axioms are presented as follows:
    - All the rules of classical propositional logic, except the Law of the
      Excluded Middle ($p or not p$) and Explosion ($bot => p$). Again, these
      are restricted for similar reasons from @metatheory:self-verifying.
    - *Application:*
      $(s realizes (F => G)) => ((t realizes F) => ((s dot t) realizes G))$.
    - *Sum:* $(s realizes F) => ((s + t) realizes F)$ and
      $(t realizes F) => ((s + t) realizes F)$.
    - *Reflection:* $(t realizes F) => F$.
    - *Checkability:* $(t realizes F) => (!t realizes (t realizes F))$. This
      means that if a proof term realizes a formula, it can always be checked.
  - The inference rules are as follows, built on the *entailment relation* $⊢$:
    - *Modus Ponens:* if $⊢ F$ and $⊢ F => G$, then $⊢ G$.
    - *Constant Specifications:* this is an RE set of proof constants. Enables
      any base theory to be expressed.

]<metatheory:def-logic-of-proofs>

From this, we define a *meta-proof* in $PA$ as a proof term $t$ derived (under
entailment) from a constant specification $cal("CS")$. Moreover, this
$cal("CS")$ must be self-verifying (@metatheory:self-verifying). We write
$t attach(realizes, br: cal("CS")) F$ to specify which constants are used in
proving that $t$ realizes $F$.

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
Following his method, one can soundly jump from $PA$ all the way to $ZFC$. This
is because, over $PA$ as the base-theory, $ZFC$ is self-verifying. A reason for
the power increase due to the axiom of replacement, or even comprehension. We
extend this realization using hyperarithmetic sets, which are known to cover
every recursive ordinal, proven in @kleene-hyperarithmetic-covering. Our
construction relies on a well known principle of comprehension established in by
Simpson in Reverse Mathematics @simpson-arithmetic:

#set math.equation(numbering: none)
$ exists X. forall n. lr((n in X <=> Phi(n))) $

where $Phi(n)$ is a predicate that is both $Sigma^1_1$ and $Pi^1_1$. For
details, consult @simpson-arithmetic.

We carry out this same construction for our use case. Let $lambda$ be a
recursive limit ordinal, and consider all given theories
$T_1, T_2, ..., T_beta, ...$ with $beta < lambda$. Note that, by definition,
this sequence is computable by some Turing machine. Then
$T_lambda = union.big_(beta < lambda) T_beta union "Comp"_lambda (Delta^1_1)$.
The set $"Comp"_lambda (Delta^1_1)$ is an axiom schema over each proposition
$phi$ definable in the extended theory. It states that

#set math.equation(numbering: none)
$
  exists X_(phi, lambda). forall n. lr(
    (n in X_(phi, lambda) <=> (exists t. (t
          attach(realizes, br: Lambda) phi(n))))
  )
$

where $Lambda$ is a constant specification, defined by all the constants in
$union.big_(beta < lambda) T_beta$. To actually construct $T_lambda$,
dovetailing can be applied. That is, one can simulate each of these theories in
parallel, incrementally adding more steps from each theory used.

Using the construction above, we can now prove the power of meta-proofs in $PA$.

#theorem[$PA$, equipped with meta-proofs, can express any computably expressible
  proof from a sound RE theory. More precisely, for any recursive ordinal
  $alpha$, there is an RE theory $T$ such that:
  - $PA$ meta-proves that $T$ proves its own serial-soundness.
  - $T$ has a theoretic proof ordinal greater than $alpha$.
]<metatheory:complete-proof-expressivity>
#proof[
  Using only autonomous progressions, it is already know that one can reach the
  Feferman-Schütte ordinal $Gamma_0$ @feferman-progressions. We may therefore
  focus on reaching higher ordinals, which depends on the limit stage. For this,
  @kleene-ordinal-notation already proves that using hyper-arithmetic sets
  suffice, which is precisely done by the construction above. This completes the
  proof.
]

Note, however, that detecting if an ordinal is recursive is undecidable. The
upper bound is the best one can hope for, in general.

To complete the proof for Welkin, we call upon contextual lifting
(@r:context-lift).

#corollary[Welkin can express any proof from a sound RE
  theory.]<metatheory:welkin-proof-completeness>
#proof[
  Clearly $PA$ can be embedded into Welkin, based on
  @foundations:turing-completeness-section. Call this unit $"pa"$. We can
  express any self-verifying theory $"T"$ as a unit (again, via
  @foundations:turing-completeness-section), and we add the rule
  $"T'" - "pa" -> "T"$ if $"T"'$ extends $"T"$. Thus, any derivation expressed
  in $"T"$, consisting of steps of the form $u_i - "T'" -> u_j$, mean that these
  carry to $T$ as well _within_ $"pa"$. By this and
  @metatheory:complete-proof-expressivity, this completes the proof.
]
