// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": (
  corollary, equation_block, lemma, proof, theorem,
)

#import "template/ams-article.typ": proof-sketch

= Metatheory <metatheory>

[TODO: need a quick way to _establish_ the main definitions for information,
then _justify_ here why they are complete.]

This section discusses the provably most general definition of information. This
section is optional. For the base definition of information, refer to
@foundations:information.

+ We show that Welkin's base theory is equivalent to a weak fragment of
  arithmetic, $I Delta_0$.

+ We overview Artemov's work in serial consistency. @artemov_serial_consistency.

+ We establish the meta-theory, and show it can encompass any formal system.

+ We show the meta-theory "meta-proves" its own soundness, _without_
  contradicting known impossibility results.

+ We conclude with the definition of information.

For notation, we will write $"PA"$ for Peano Arithmetic and $"PRA"$ for
Primitive Recursive Arithmetic. Moreover, without loss of generality, we will
consider only first-order theories $T$ that are RE. This can be shown in the
proof of Traktenbroht's Theorem @trakhtenbrot50. In this proof, a step is to
show that for any Turing machine $M$, there is a a first-order theory whose
theorems concide with the language of $M$. [TODO: decide if we want to prove
this is true IN $I Delta_0$, to show that it alone is enough. Put into the
appendix. Pretty simple embedding.]

== Establishing the Floor: $I Delta_0$

To compare Welkin against other theories, we show the unit $"verify"$ can be
translated to $I Delta_0$, a weak fragment of arithmetic, and vice versa. This
subsection is optional, and we will keep the proofs at a high-level for
readability. For background in first-order logic, please refer to
@mendelson_logic.

Herein, let $a <=> b$ denote $a$ if and only if $b$. Robinson Arithmetic denotes
the base set of axioms; refer to @hajek-pudlak-metamath-arithmetic[Ch. 1], which
use $I Sigma_0$ to denote $I Delta_0$.

[TODO[SMALL]: fix equation labels!]

#definition[*Robinson Arithmetic $Q$* is the first-order theory over the
  language of arithmetic with the following axioms, universally quantified over
  $x, y, z$:

  - *Q1:* $not (S(x) != 0)$.
  - *Q2:* $S(x) = S(y) => x = y$.
  - *Q3:* $x != 0 => exists y. x = S(y)$.
  - *Q4:* $x + 0 = x$.
  - *Q5:* $x + S(y) = S(x + y)$.
  - *Q6:* $x * 0 = 0$.
  - *Q7:* $x * S(y) = (x * y) + x$.
  - *Q8:* $x <= y equiv exists z. z + x = y$
]<foundations:robinson-arithmetic>

#definition[The theory $I Delta_0$ @paris-wilkie-delta-0-sets consists of $Q$
  plus the *bounded induction schema*:

  #equation_block(
    prefix: "I",
    [$(phi(0) and forall x. (phi(x) => phi(x + 1))) => forall x. phi(x)$],
  )

  for each $phi$ with bounded quantifiers, which means quantifiers
  $exists x < t. psi(x, t)$ and $forall x < t. psi(x, t)$ where $x$ is free in
  term $t$ and $psi(x, t)$ is quantifier free.
]<foundations:I-Delta0>

#remark[
  Note that the induction schema is stronger than having open formulas. This
  allows statements about, e.g., odd and even numbers to be proved. We will need
  this to express $"verifier"$.
]

[TODO[MEDIUM]: make this more rigorous. ] #lemma[
  The unit $"verifier"$ is definable in $I Delta_0$.
]<foundations:I-Delta0-to-welkin>
#proof-sketch[
  The claim relies on defining $"unit"$. From there, one can easily express the
  conditions in $"verifier"$ by simple recursion.

  To this end, we first argue that the inductive definitions can be written in
  $I Delta_0$. Clearly, every handle can be expressed, indexing each triple of
  functions with Cantor's pairing function, sending triples
  $("UID", "RID", "HID")$ to natural numbers. Similarly, representations can be
  indexed by a pairing argument. It remains to show that blocks can be defined
  as well. We claim that an extended pairing function can be made that is
  defined inductively. [TODO: define this function!]

  Second, it can be easily shown that each rule in @unit-rules are definable by
  induction, in at most 7 variables.
]

An important consequence of this theorem is the following, proving that the
meta-theory for Welkin is as minimal as possible.

Now we proceed that Welkin's $"verifier"$ is itself can process any $I Delta_0$
proof.

#lemma[
  There is a unit $"Q"$ in Welkin and a bijection from propositions $phi$ units
  $u_phi$ such that $Q tack.r phi$ if and only if $u_phi - "part" -> "Q"$.
]<metatheory:Q-in-welkin>
#proof[
  Let $"Q"$ be a new handle. Encode the naturals into words via
  @foundations:bootstrap-binary-word and @foundations:binary-word-equality, with
  successor represented through pairs. [TODO: define addition and multiplication
  via units, in the direct way.]

  Axioms *Q1-Q3* easily follow from @foundations:bootstrap-equality-correctness.
  The remaining axioms are included in $Q$. [TODO: note how quantifiers are
  correctly expressed in a separate lemma]. Using transitivity and ?, this
  completes the proof.
]

#theorem[
  Welkin's $"verifier"$ verifies there is a context with all derivations of
  $I Delta_0$.
]<foundations:welkin-to-I-Delta0>
#proof[
  We prove that $"Q"$, constructed in @metatheory:Q-in-welkin, combined with the
  $"verifier"$ unit proves the claim. TBD.
]

Taken together, we can prove that Welkin has a minimal metatheory.

#corollary[_(Base Theory: $I Delta_0$)._ Suppose $T$ is another first order
  theory that proves the existence of Welkin's $"verifier"$. Then
  $T => I Delta_0$.
]<foundations:welkin-minimal>
#proof[
  Over $I Delta_0$, @foundations:I-Delta0 proves the existence of $"verifier"$
  implies $I Delta_0$. Thus, if $T$ proves the existence of $"verifier"$, it
  must satisfy $I Delta_0$ as well, completing the proof.
]


== Artemov's Approach

A major goal in Welkin is to express any representable notion, _including_ any
representabale proof. Proofs are a finite certificate that consists of a valid
sequence of steps. Importantly, proofs can be verified using a _total_
computable function, one that can check _any_ given proof. Because of the
requirement for computable checking, limitations in computable functions apply.
These are illustrated by several impossibility theorems in the literature,
including Gödel's infamous incompleteness theorems
@goedel-original-incompletness-theorems.

However, previous impossibility results rely on proving strong properties of
proofs. Artemov argues that weaker, constructive properties can be used instead.
We provide a high-level definition of *serial-consistency* before proceeding
onto the embedding in Welkin.

#definition[
  Suppose $T$ is sufficiently strong to express its own proofs. Then $T$ is
  *serial-consistent* if there is a *selector* for $T$. A *selector* is a
  computable function $s$#footnote[Technically, this is a primitive recursive
    function, but we will quickly generalize this to _any_ computable function.]
  with two properties:
  - $s$ accepts any string that encodes a valid proof.
  - if $s$ accepts a proof, then it cannot contain a contradiction.
]<metatheroy:artemov-serial-consistency>

Artemov overcomes Gödel's second incompleteness theorem. This theorem states
that Peano Arithmetic $"PA"$, providing basic properties of the natural numbers,
cannot prove its own consistency. Artemov instead demonstrates that $"PA"$
proves its own _serial-consistency_, as follows:
- He uses a weak meta-theory, in this case, Primitive Recursive Arithmetic
  ($"PRA"$). This theory is bounded by a weak principle of induction.
- Artemov encodes all proofs as natural numbers in $"PRA"$. $"PRA"$ is
  sufficiently strong _just_ to encode all of these proofs.
- Finally, he uses a proof by induction, over encoded proofs in $"PRA"$, to show
  that $"PA"$ proves each _individual_ proof contains no contradictions. This is
  possible through partial truth definitions.

To be clear: Artemov does _not_ show that there is a _single_ proof that $"PA"$
is consistent, that works for all proofs. Instead, his method _takes_ a proof as
a parameter. There have been extensive discussion on the validity of this
technique, and its acceptance by other logicians.#footnote[The discussion is
  available online at: #link(
    "https://mathoverflow.net/questions/469247/situation-with-artemovs-paper",
  ).]

Despite its initial controversy, Artemov's techniques follow closely with
several constructive schools, see @artemov_serial_consistency. This thesis
builds upon this result with a stronger property: *serial-soundness*. The exact
same proof applies, using the same partial truth definition. Tarski's theorem
says that a formal system cannot define its own truth predicate _at the object
language_ @tarski-undefinability-truth. In fact, this truth predicate is
uncomputable, in general. We do not avoid Tarski's theorem, but we do
approximate it _as_ closely as partial computable functions allow. Because some
logics may not have a notion of inconsistency, we will not define consistency
itself. However, given the results in @foundations, first order logic can be
expressed in several ways.

== Truth and Soundness

We embed "Convention T", or Tarski's criterion for truth
@tarski-undefinability-truth, as unit. Recall that, at this stage, Welkin deals
with truh systems. The user's task is to ensure they accurately represent their
referents, because these are free parameters in the theory (see the discussion
below @foundations:handle). For this reason, the aim is to demonstrate the
_preservation_ of these truth systems. This means preserving their axioms and
rules of inference. With this goal in mind, we define a *truth predicate*
accordingly.

// So the original convention T is:
// [phi] is true iff phi,
// where [] is the Goedel number, and phi
// is a sentence in Peano Arithmetic.

[TODO: clarify how $"in"$ works! May need to work with a direct representation.]

#definition[Let $c$ be a context. A unit $t$ is called a *truth predicate* for
  $c$ if for every unit $u$, $u - c -> t$ if and only if $u - "in" -> c$.
]<metatheory:truth>

Truth systems in Welkin, however, are separated by contexts. How can it be
determined whether a unit is "sound", or truthful about derivations? Our
approach is to _merge_ the contents and determine if they match. This precisely
uses rule ? for whether a representation is contained in a unit. [TODO: still
need to clarify global context here! Also, ensure that .]

#definition[
  A unit $u$ is *sound* if for every context $c$ and representation
  ${{a - d -> b} - "in" -> c} - "in" -> u$, ${@c, {a - d -> b}} <--> c$.
]

In other words, adding the representation ${a - d -> b}$ does *not* add new
information to $c$.

[TODO: discuss Tarski's undefinability theorem here.]

In this setting, Gödel's incompleteness theorems manifest in the undecidability
of derivations. The second cannot be avoided with soundness outright, but it can
with a weaker notion. With the _usual_ notions of soundness, the second cannot
be avoided. But it this can be mitigated using a weaker notion of soundness.

[TODO: define the equivalent of total computable functions for units! And
determine if a *single* input is enough to trust soundness. If not, need to
construct examples to show why!]

#definition[
  A unit $u$ is *serial-sound* if there is a total computable function such that
  the following property holds: given an arbitrary, but fixed, unit $v$ as
  input, verifies that any representation "claimed in $u$" is "actually in $v$".
  Moreover the selector must be proven *constructively*, or "without
  explosion"[TODO: define in general!].
]<metatheory:serial-sound>

Note that not every total computable function can be proven to be total. For
this reason, we have a more technical definition in @metatheory:meta-unit. For
now, we can prove the following.

[TODO[SMALL]: make sure to clarify this proof!]
#lemma[
  The unit $"verifier"$ is serial-sound.
]
#proof[
  Equivalent to @foundations:verifier-correctness.
]

Moreover, serial-soundness is transitive, just as with soundness. This
corresponds to composition of meta-proofs.

#lemma[
  Let $u$, $u'$, $u''$ be units, and suppose $u$ is serial-sound. If $u$ proves
  that $u'$ is serial-sound and $u'$ proves that $u''$ is serial sound, then $u$
  proves that $u''$ is serial sound.
]<metatheory:serial-soundness-transitive>
#proof[
  Suppose $u$ is serial-sound. Then, in the context $u$, $u$ contains the a
  selector of $u'$. This selector can then be composed with that from $u''$
  proven in $u'$ to complete the proof.]

== The Meta Unit <metatheory:meta-unit>

[TODO: complete! Want to ensure that proofs can be _chains_ of serial-sound
units. Moreover, should include _any_ expressible derivation that is
"reliable"!]

#definition[
  The *meta recursor* $"meta"$ over all units is defined recursively:
  - *Base case:* $"verifier" - "in" -> "meta"$.
  - *Recursive step:* for each proof in $"meta"$, adding a self-verifying unit
    is a valid proof step.
]<metatheory:meta-def>

If $"meta"$ verifies a claim $C$, then we say that $"meta"$ *meta-proves* $C$.

#remark[A different approach to create more powerful chains of theories is
  _reflection_. One example is from Feferman @feferman-reflection: starting from
  $"PA"$, one can add the encoded statement, roughly meaning: "$"PA"$ is sound".
  One can then iterate this through transfinite induction. While this, too, is a
  way to express all proofs, reflection is a _subset_ of our techniques.]

[TODO: make this constructive! Probably possible. And maybe instead of
consistency we want _coherency_, to generalize having a false operator? So to
prevent _all_ things from being proved, or only useful things being proved?]

#theorem[
  The unit $"meta"$ meta-proves that serial soundness implies soundness.
]<metatheory:serial-to-full-soundness>
#proof[
  Let $u$ be a serial sound unit. By way of contradiction, suppose $u$ is not
  sound. Then there exists a specific instance $phi$ that $u$ contains but is
  not true. However, as $u$ is finite, there is a finite trace that verifies the
  failure of soundness. But, because the serial soundness proof is constructive,
  it reliable proves that _no such_ trace exists, a contradiction. Therefore,
  $u$ must be sound.
]

Remarkably, $"meta"$ _also_ meta-proves its own serial soundness.

#corollary[The unit $"meta"$ meta-proves its own serial soundness, and hence,
  soundness.
]
#proof[
  Fix some claim $C$, and suppose $C$ can be proved by a terminating sequence of
  self-verifying theories. On each $C$ with a proof, define $s$ to be one of
  these proofs. [TODO: make sure choice is not needed! Probably need a way to
  standardize this, though maybe it's already in the constructive definition? Or
  the existence of _any_ of these is enough]. Clearly $s$ is total as the
  sequence terminates, and is correct by construction. This proves $"meta"$ is
  serial-sound. Thus, by @metatheory:serial-to-full-soundness, $"meta"$ is sound
]

== Proof of Complete Expressivity

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

Due to Artemov, there is a _massive_ jump from $I Delta_0$ all the way to
$"ZFC"$. This is because, over $I Delta_0$ as the base-theory, $"ZFC"$ is
self-verifying (proves its own soundness. A reason for this power in $"ZFC"$ is
the axiom of replacement, or even comprehension. We extend this realization
using hyperarithmetic sets, which are known to cover every recursive ordinal,
see @kleene-ordinal-notation [TODO: make sure this citation is correct!]. Based
on Kleene's theorem, our key construction in the limit case is to add this: let
$lambda$ be a limit ordinal and consider all given theories
$T_1, T_2, ..., T_beta, ...$ with $beta < lambda$. Then
$T_lambda = union.big_(beta < lambda) T_beta union "Comp"_lambda (Delta^1_1)$.
The set $"Comp"_lambda (Delta^1_1)$ is an axiom schema over each proposition
$phi$ definable in the extended theory, stating that [TODO: clarify notation!
And double check hyperarithmetic literature!]

$exists X_(phi, lambda). forall n. (n in X <=> (exists p. "Prov"(T_{psi(p)}), phi(p)))$.

Note that this set is encoded through $I Delta_0$ through an appropriate
encoding. And the provability predicate is also encoded through the base theory.
[TODO: clarify these encodings!] This new axiom naturally extends the Axiom of
Comprehension through _other_ sound theories.

[TODO: clarify that hyperarithmetic sets are connected to definability in
$Delta^1_1$!]

We now prove a major property of Welkin.[TODO: definitely clean up!]

#theorem[The unit $"meta"$ expresses any computably expressible proof. More
  precisely, for any recursive ordinal $alpha$, there is a unit $T in "meta"$
  with greater theoretic proof ordinal than $alpha$.
]<metatheory:complete-proof-expressivity>
#proof[
  Using only autonomous progressions [CITE!], it is already know that one can
  reach the Feferman-Schütte ordinal $Gamma_0$. We may therefore focus on
  reaching higher ordinals, which depends on the limit case. But
  @kleene-ordinal-notation already proves that using hyper-arithmetic sets in
  the successor ensures that we can find _some_ $beta > alpha$. This completes
  the proof.
]

Note, however, that detecting if an ordinal is recursive is undecidable. The
upper bound is the best one can hope for, in general.

As an immediate corollary, this proves that $"unit"$, being a simple verifier,
does _not_ impose further restrictions on proofs. Moreover, additional layers of
meta-theories are not needed, thanks to how expressive serial-soundness is.

#remark[
  The definition of information encompasses _every_ meta-proof.
  @metatheory:complete-proof-expressivity is to show that even _one_ chain of
  theories is enough to majorize each recursive ordinal. And the construction is
  entirely definable by a Turing machine!]

