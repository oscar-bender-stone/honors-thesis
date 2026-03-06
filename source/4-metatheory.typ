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
  contradicting the known impossibility results.

+ We conclude with the definition of information.

Optimizations will be postponed to @information-organization.

== Serial Soundness
A major goal in Welkin is expressing _any_ representable notion, but also _any_
reprsentable proof. Proofs are a finite certificate that justify a sequence of
steps, ensuring each assumption and step is correct. Moreover, we want to verify
this sequence using a partial computable function. Because of this, there are
several incompleteness theorems in the literature, one of which includes Gödel's
infamous incompleteness theorems @goedel-original-incompletness-theorems.

However, the existing literature relies on proving _strong_ properties. Artemov
argues that weaker but _constructive_ properties can be used instead.

#definition[
  Suppose $T$ is sufficiently strong to express its own proofs. Then $T$ is
  *serial-consistent* if there is a *selector* for $T$. A *selector* is a
  computable function $s$#footnote[Technically, this is a primitive recursive
    function, but we will quickly generalize this to _any_ computable function.]
  with two properties:
  - Accepts any string encoded as a valid.
  - Any proof accepted must not contain a contradiction.
]<metatheroy:artemov-serial-consistency>

Artemov proves the following: _over_ the theory $"PRA"$, one can construct a
selector $s$ such that, the axioms of $"PA"$ _encoded into_ $"PRA"$ prove that
$s$ is correct. The use of a meta-theory is critical here. Without this, $"PA"$
can only prove any _fixed_ approximation to the selector exists. To be clear:
Artemov does _not_ show that there is a _single_ proof that $"PA"$ is
consistent, that works for _any_ proof. Instead, his method _takes_ a proof as a
parameter. There have been extensive discussion on the validity of this
technique, and its acceptance by other logicians.#footnote[The discussion is
  available online at:
  #link(
    "https://mathoverflow.net/questions/469247/situation-with-artemovs-paper",
  )]

Despite its initial controversy, Artemov's key techniques follow closely with
several constructive schools, see @artemov_serial_consistency. This thesis
builds upon this result with a stronger property: *serial-soundness*. The exact
same proof applies, as Artemov uses a partial truth definition, which defines
truth up to a fixed finite bound. Tarski's theorem says that a formal system
cannot define its own truth predicate _at the object language_
@tarski-undefinability-truth. We circumvent this problem _precisely_ with a
meta-theory.

#definition[
  The *meta recursor* $"meta"$ over all units is defined recursively.
]

[TODO[HIGH]: replace proof sketches *with* full proofs, IN Welkin!]

#theorem[]

== Completeness


== Defining Information
This section provides the definition of information in Welkin.
