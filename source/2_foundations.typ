// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

== Computability

- High level issues

  - How do we discuss BOTH partial AND computable functions?

    - Can't define the _whole_ set of computable functions on binary strings,
      i.e., need more indirection (like a non $Sigma^0_1$ formula in HA)

    -

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

