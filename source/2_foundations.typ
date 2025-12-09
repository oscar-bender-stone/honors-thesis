// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

Our first step is to define the set of _verifiers_, a subset of the computable
functions. Based on our architecture to separate _query_ from _search_, we focus
this subset to primitive recursive functions.

While we can easily verify if a given input is accepted by a verifier, how do we
tell when there is _no_ such input? This is where our metatheory come in. [TODO:
explore arithmetic hierarchy briefly? How do we know _which_ results on
computability are trustworthy? This is ESSENTIAL for the TCB!]

== Computability

== Verifiers

Given a partial computable function $phi$, let $L(phi)$ be the language
recognized by $phi$.

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

