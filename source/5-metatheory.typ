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
    columns: (20%, 30%, 50%),
    align: left,
    table.header([*Section Number*], [*Title*], [*Description*]),
    [@metatheory:artemov-selector-proofs],
    [*Artëmov's #linebreak() Selector Proofs*],
    [Explains Artëmov's selector proofs. This includes his finitistic proof of
      Peano Arithmetic's consistency. Expands selector proofs for soundness.],

    [@metatheory:serial-soundness-and-reliability],
    [*Serial-Soundness and Reliable Proofs*],
    [Expands selector proofs to *serial-soundness*, as well as *self-verifying*
      theories. Defines *reliable proofs* for more general theories.],

    [@metatheory:proof-completeness],
    [*Proof #linebreak() Completeness*],
    [Proves that Welkin can accepts any proof from a provably sound RE theory.],
  ),
  caption: [Overview of @syntax.],
)<metatheory:overview>

#let PA = math.text("PA")
#let PRA = math.text("PRA")
#let ZFC = math.text("ZFC")
#let entails = $⊢$


For simplicity, we will make our base theory Peano Arithmetic ($PA$). Recall
that any unit is equivalent to a Turing machine
(@foundations:turing-completeness-section). Because any Turing machine can be
expressed through a simple encoding in $PA$, so to can units, as well as the
rules in @table:unit-rules. A future work will consider weaker theories that can
embed Welkin. Additionally, we we will consider only RE first-order theories
$T$. This is because any formal system must be defined with proofs accepted by
some Turing machine. In turn, this Turing machine can be expressed as a first
order theory.

As notation, we will write $T entails phi$ to mean that $T$ entails $phi$.
Logical implication is denoted by $=>$.

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
  possible through partial truth predicates.

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

== Serial-Soundness and Reliable Proofs <metatheory:serial-soundness-and-reliability>

We now introduce a stronger version of *serial-soundness*. We will reuse the
term *selector* for this stronger notion.

#definition[
  Let $T$ be an extension of $PA$. Then $T$ is *serial-sound* if there is a
  *selector* $s$. A *selector* is a total computable function of $s$ constructed
  in $PA$, with inputs over proofs of $T$. This function must satisfy two
  properties:
  - $s$ accepts all proofs in $T$.
  - Any proof $p$ accepted by $s$ must satisfy
    $"Tr"_n (chevron.l s(p) chevron.r)$, where $"Tr"_n$ is the $n$-th partial
    truth predicate. For details, refer to @hajek-pudlak-metamath-arithmetic[Ch.
      1.1].
  Moreover, this selector must be proven _without_ use the general Law of the
  Excluded Middle ($phi or not phi$), and without the Principle of Explosion
  (#box[$bot => phi$]). In this case, we call $s$
]<metatheory:serial-soundness>

#remark[We need to remove the Law of the Excluded Middle to ensure the proof is
  completely constructive. Additionally, we must ensure Principle of Explosion
  is not used to falsely prove claims.]

#remark[
  We will briefly explain why, in the meta-theory, serial-soundness is enough to
  justify soundness. By way of contradiction, suppose $T$ is a theory that is
  serial-sound but not sound.#footnote[Constructively, proof of contradiction
    may be used to prove a _negative_ statement. Thus, our use of contradiction
    in this argument is permissible.] Let $s$ be a selector for $T$ and let $p$
  be a proof in $PA$ of the selector's correctness. Then, there must be some
  $phi$ and some $n$ such that $T entails phi$ but
  $not "Tr"_n (chevron.l phi chevron.r)$. However, for fixed $n$, $p$ ensures
  that the selector correctly accepts the proof of $phi$ in $T$. This yields a
  contradiction. Thus, $T$ must be sound.
]

Now we can introduce *self-verifying* theories.

#definition[
  Let $T$ be an extension of $PA$. Then $T$ is *(meta-)-self-verifying* if $PA$
  proves the following: $T$ proves its own serial-soundness.
]<metatheory:self-verifying>


Now, we can prove $"PA"$ is self-verifying, using partial truth predicates. This
is similar to the Artëmov's approach for serial-consistency. Note the
limitations posed by Tarski's theorem. This says that a formal system cannot
define its own truth predicate _at the object language_
@tarski-undefinability-truth. In fact, this truth predicate is uncomputable, in
general. We do not avoid Tarski's theorem, but we do approximate it _as_ closely
as Turing machines allow.

Additionally, there is an important property we will need.

#lemma[Let $T, T'$ be theories, with $T$ being self-verifying. If $T$ proves
  that $T'$ is self-verifying, then so does
  $PA$.]<metatheory:selector-composition>
#proof[
  This corresponds to composing selector proofs.
]

#remark[
  Welkin can prove @metatheory:selector-composition as well thanks to contextual
  lifting (@r:context-lift). This enables a reliable way to transfer proofs
  across theories. To demonstrate this, let $"pa"$ be a unit corresponding to
  $PA$. (This can be done through a Turing machine corresponding to $PA$ and
  using @foundations:turing-completeness-section.) Now, let $T_1, T_2, T_3$ be
  theories, corresponding to units $"T_1", "T_2", "T_3"$, respectively, wihth
  include units $"phi"$ for each sentence $phi$. Set $"phi_1"- "T_i" -> "phi_2"$
  if $T_i entails (phi_1 => phi_2)$. Now, set $"T_1"- "T_3"-> "T_2"$ if $T_3$ is
  a self-verifying theory and
  $PA attach(entails, br: T_3) chevron.l (T_1 entails phi) => (T_2 entails phi) chevron.r$.
  By @r:context-lift, a derivation of #box[$"phi_1" - "T" -> "phi_2"$] lifts
  into #box[$"phi_1" - "T2" -> "phi_2"$] _within_ $"pa"$.
]<metatheory:remark-selector-proof-composition>


From this, we define a $T$*-meta-proof* in $PA$ as follows.

#definition[
  Let $T$ be a self-verifying theory. Then a $T$*-meta-proof* in $PA$ of $phi$,
  denoted $PA attach(entails, br: T) phi$, is any proof of
  $PA entails chevron.l T entails phi chevron.r$. Here,
  $chevron.l T entails phi chevron.r$ denotes the encoding of $T entails phi$ in
  $PA$.
]

Note that the base theory $T$ is important. This is because, two theories may be
sound but prove $phi$ and $not phi$, respectively. Additionally, we want to
cover more general theories. A theory may be unsound yet prove _some_ things
correctly. For example, in Naive Set Theory (encoded in arithmetic), Russell's
Paradox can be proven, but also true statements in $ZFC$, such as
$forall x. x in X "iff" x in X$. Although this is a very simple example, this
does raise the question: what _can_ we reliably accept from a general theory? To
generalize this example, we consider taking a _restriction_ of the theory. If
this theory is sound, provable in an extension that _is_ self-verifying one, we
can trust the specific claim from $T'$. Note that this applies to embeddings of
languages as well. For simplicity, we will only discuss suitable subsets on
$T'$. We provide the full definition below.

#definition[
  Let $T'$ be a first order theory, and let $phi$ be a sentence. A *reliable
  proof* of $phi$ in $T'$ is a pair $(T'', p)$, where $p$ is a proof that
  $T'' entails phi$, and $T''subset.eq T'$ can be extended to a self-verifying
  theory. The set of *reliable proofs* for $phi$ in $T'$, denoted
  $"Reliable"_T'(phi)$, is the set of pairs $(T'', p_1, p_2)$, where $T''$ is
  described above, $p_1$ proves that $T''$ can extend to a self-verifying
  theory, and $p_2$ is a proof that $T'' entails phi$.
]<metatheory:reliability>

#remark[Note that this definition is incomplete: in general, some sound subsets
  of $T'$ will be excluded. We need to ensure that any theory used is _provably_
  sound, i.e., extends to a self-verifying theory.]

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
too, can be done with partial truth predicates. One reason why $ZFC$ is more
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

We carry out this same construction for our use case. For simplicity, we will
ensure that all constructed theories are self-verifying.

Let $lambda$ be a recursive limit ordinal, and consider all given theories
$T_1, T_2, ..., T_beta, ...$ with $beta < lambda$. Define
#set math.equation(numbering: none)
$
  T' = union.big_(beta <lambda) T_beta.
$

Note that, because the sequence above is indexed by recursive ordinals, $T'$ is
computable by some Turing machine. Moreover, $T'$ is self-verifying: one can
combine the selectors for each $T_j$ into a single selector. This requires
dovetailing, which simulates each selector in parallel. The outputs of each
selector can be incrementally added, ensuring that they are enumerated in the
final selector.

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

Constructing $T_lambda$ can be done with dovetailing, as described above. This
ensures that each limit stage does _not_ rely on non-constructive principles,
such as Choice. Similarly, with the same technique, $T_lambda$ can be shown to
be self-verifying.

Using the construction above, we can now prove the power of all meta-proofs in
$PA$.

#theorem[Through some self-verifying RE theory $T$, $PA$, equppied with all
  $T$-meta-proofs, can majorize any proof-theoretic ordinal. More precisely, for
  any recursive ordinal $alpha$, there is an RE theory $T$ such that:
  - $PA$ meta-proves that $T$ proves its own serial-soundness.
  - $T$ has a proof-theoretic ordinal greater than $alpha$.
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

As an immediate corollary, we obtain the following.

#corollary[
  Let $T'$ be an RE theory, $phi$ a sentence, and $alpha$ a recursive ordinal.
  Then, for reliable proof $(T'', p_1, p_2)$, there is a self-verifying
  extension $T$ of $T''$, such that $T$ has proof-theoretic ordinal greater than
  $alpha$.
]<metatheory:reliable-proof-completeness>


Combined with @metatheory:reliable-proof-completeness and
@metatheory:remark-selector-proof-composition, the previous results prove a key
property of Welkin, stated as a major corollary.

#corollary[
  Let $"pa"$ be a unit corresponding to $PA$, as described in
  @metatheory:remark-selector-proof-composition. Let $T'$ be an RE theory and
  $phi$ a sentence. Suppose $P equiv (T'', p_1, p_2)$ be a reliable proof of
  $phi$ in $T'$. Then, this proof in, written in $T'$, is accepted by a
  derivation in $"pa"$. .] <metatheory:welkin-proof-completeness>
