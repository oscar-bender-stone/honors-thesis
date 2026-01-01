// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

- Establish meta-theory: combinator version of HA
- Focus on *computable sets* and build from there.
- Explain why Artemov's serial property is the weakest
property desired, so show that any weaker property would produce undesirable
behavior.
- Explain that minimal proofs of serial Sigma^0_1 consistency are important
here.
- Define natural partial order for "reliable" FOL theories
whose language is arithmetic. GOAL: generalize reliability to any formal
concept.

Our first step is to define the set of verifiers, a subset of the computable
functions. Based on our architecture to separate _query_ from _search_, we focus
this subset to primitive recursive functions.

To explore verifiers, we need a reliable metatheory, establishing our logical
TCB. How can we establish what _reliable_ means? [TODO: cite that ZFC, or ZFC +
inaccessibles, is common in literature. ] However, each of these are _specific
theories_, and while ZFC + inaccessibilies likely suffices for, e.g., formal
verification, what about other subjects? We want to make this _as extensible_ as
possible, akin to an infinite hierarchy of theories via reflection. So we will
need a different approach.

The key problem to reliability is, while we can easily verify if a given input
is accepted by a verifier, how do we tell when there is _no_ such input? We use
a novel criterion developed by Artemov's Logic of Proofs @artemov_lp. [TODO:
bridge this with selector proofs. Also, make sure to explain WHY the arithmetic
hierarchy is enough. We JUST want to explore properties of naturals. We can't do
beyond. But we should prove this!]

This is where our metatheory come in. [TODO: explore arithmetic hierarchy
briefly? How do we know _which_ results on computability are trustworthy? This
is ESSENTIAL for the TCB!]

== Logic of Proofs

== Computability

== Verifiers

Given a partial computable function $phi$, let $L(phi)$ be the language
recognized by $phi$.

// TODO: maybe define verifiers with a specific form?
// That way, we don't have cases of functions where we don't even know it's linear time. We need to PROVE this class has all linear time, or something desirable.
#definition[
  An *effective verifier* is a Turing machine that runs in linear time and it
  accepts an input _must_ have read the entire input.
]

In a refined form of Kleene representability, we show that every RE set
corresponds to an effective verifier in an important way.

#lemma[
  For every RE set $S$ with recognizer $phi$, there is an effective verifier
  $V_phi$ such that $x in S$ iff there is some trace $t$ that starts with $x$
  and $t in L(V_phi)$.
]

For the rest of this thesis, all verifiers mentioned will be effective. Note
that we will return to practical verifiers, those with realistic constants.

