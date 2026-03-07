// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": (
  corollary, equation_block, lemma, proof, theorem,
)

= Metatheory <metatheory:information>

This section discusses the provably most general definition of information. This
section is optional. For the base definition of information, refer to
@foundations:information.

+ We overview Artemov's work in serial consistency. @artemov_serial_consistency.

+ We establish the meta-theory, and show it can encompass any formal system.

+ We show the meta-theory "meta-proves" its own soundness, _without_
  contradicting known impossibility results.

+ We conclude with the definition of information.

Optimizations will be postponed to @information-organization.


For notation, we will write $"PA"$ for Peano Arithmetic and $"PRA"$ for
Primitive Recursive Arithmetic.

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

== Truth

We embed "Convention T", or Tarski's criterion for truth
@tarski-undefinability-truth, as unit.

// So the original convention T is:
// [phi] is true iff phi,
// where [] is the Goedel number, and phi
// is a sentence in Peano Arithmetic.

[TODO[MEDIUM]: refer back to Artemov to develop a syntactic description of truth
that corresponds closely to using handles!]

#definition[Fix some context $c$. A unit $t in c$ is called a *truth predicate*
  for $c$ if for every unit $u$, $u - c -> t$ if and only if $u - c -> u$.
]<metatheory:truth>

[TODO: clarify. The main definition here means that we can join the specific
unit $u$ with the "actual" representation. They need to _match_. This is exactly
what coherency means! So we are *merging* $c$ with the contents of the _actual_
unit in question!]
#definition[
  A context $c$ is *sound* if for every $u - "in" -> c$, "$u$ is 'actually'
  true".
]

Recall that Gödel's incompleteness theorems asserts that the theory $"PA"$
cannot prove its own soundness. And recall that each unit is _finitely
generated_. This means a units face a similar incompleteness theorem, _in the
object level_. We now define serial-soundness as an approximation, feasible by a
_metatheory_.

#definition[
  A unit $u$ is *serial-sound* if .
]<metatheory:serial-sound>

#lemma[
  The unit $"verifier"$ is serial-sound.
]
#proof[
  [TODO: likely uses $I Delta_0$ from a previous section.]
]

== The Meta Unit

// #definition[
//   The *meta recursor* $"meta"$ over all units is defined recursively. We say
//   that $"meta"$ *meta-proves* $T$, denoted $T ⊢_"meta" a$ if there is a proof
//   through serial-soundness chains $"unit", T_1, ..., T_n$, where each unit $T_i$
//   proves its own serial-soundness.
// ]

[TODO: complete!]
#definition[
  The *meta recursor* $"meta"$ over all units is defined recursively:
  - *Base case:* $"unit" in "meta"$.
  - *Recursive step:* for each proof in $"meta"$, adding a self-verifying unit
    is a valid proof step.
]

#remark[A different approach to create more powerful chains of theories is
  _reflection_. One example is from Feferman @feferman-reflection: starting from
  $"PA"$, one can add the encoded statement, roughly meaning: "$"PA"$ is sound".
  One can then iterate this through transfinite induction. While this, too, is a
  way to express all proofs, reflection is a _subset_ of our techniques.]

#theorem[
  The unit $"meta"$ meta-proves that serial soundness implies soundness.
]

Remarkably, $"meta"$ _does_ meta-prove its own serial soundness.

#corollary[The unit $"meta"$ meta-proves its own serial soundness, and hence,
  soundness.
]

== Proof of Complete Expressivity

To show that this covers _every_ proof that can be computably recognized, we
need to discuss recursive ordinals. We provide an embedding via $"unit"$. For
more background on ordinals, refer to @monk-set-theory[Ch. 2],
@kleene-ordinal-notation. To keep the presentation self-contained, we will
_define_ ordinals in a restricted context through transfinite induction.

#definition[The unit $"recursive_ordinal"$ is defined recursively, containing
  nothing else:
  - *Base:* $0 in "recursive_ordinal"$.
  - *Successor:*
  - *Limit:*
]<metatheory:transfinite-induction>

#[TODO: probably add a big idea marker here!]

// TODO: build on this! Very very important!
The primary idea is: derivations about a unit can be checked from other
_external_ units, IF they can be proven to be reliable..

Note that using a _specific_ mechanism here does not limit Welkin's
expressivitiy. We will clarify this in the following theorem.

#theorem[]

#theorem[The unit $"meta"$ expresses any computably expressible proof. More
  precisely, for any recursive ordinal $alpha$, there is a unit $T in "meta"$
  with greater theoretic proof ordinal than $alpha$
]
#proof[

]

Note, however, that detecting if an ordinal is recursive is undecidable. The
upper bound is the best one can hope for, in general.

As an immediate corollary, this proves that $"unit"$, being a simple verifier,
does _not_ impose further restrictions on proofs.

