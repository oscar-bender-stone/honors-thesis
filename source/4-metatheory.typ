// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": definition, example, remark

#import "template/ams-article.typ": (
  corollary, equation_block, lemma, proof, theorem,
)

= Information <metatheory:information>

This section discusses the provably most general definition of information.

+ We overview Artemov's work in serial consistency. @artemov_serial_consistency.

+ We establish the meta-theory, and show it can encompass any formal system.

+ We show the meta-theory "meta-proves" its own soundness, _without_
  contradicting known impossibility results.

+ We conclude with the definition of information.

Optimizations will be postponed to @information-organization.

== Serial Soundness
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
language_ @tarski-undefinability-truth. We circumvent this problem _precisely_
with a meta-theory.

[TODO: explain the role of chains! It's different than reflection, so we should
show _how_ these chains can build up.]

#definition[
  The *meta recursor* $"meta"$ over all units is defined recursively. We say
  that $"meta"$ *meta-proves* $T$, denoted $T |-_"meta" a$ if there is a proof
  through serial-soundness chains $"unit", T_1, ..., T_n$, where each unit $T_i$
  proves its own serial-soundness.
]

To show that this covers _every_ proof that can be computably recognized, we
need to discuss ordinals. We provide an embedding via $"unit"$.

#theorem[
  The unit $"meta"$ meta-proves that serial soundness implies soundness.
]

#definition[The unit $"recursive_ordinal"$ is defined recursively:
  - *Base:*
  - *Successor:*
  - *Limit:*
]

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

#theorem[The unit $"meta"$ meta-proves its own serial soundness, and hence,
  soundness.
]

== Defining Information
This section provides the definition of information in Welkin.

#definition[
  *Information* about a query $q$ in context $c$ is a any partial meta-proof in
  $"meta"$ of a derivation of ${@c, q}$.
]
