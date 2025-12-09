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
      i.e., need more indirection (like a non $Sigma^0_1$ formula in HA). This
      is by Blum's compression theorem.

    - BUT can argue for choosing a _computable subset_ of these, even if it
      feels restrictive. Key reason: separate _query_ from _search_. Main
      organizational insight! (TODO: highlight this in intro!)

    - So we need to focus our efforts on the _query_ part itself.

      - We're not focusing on operational semantics here. We're focusing on a
        framework that can _then_ define operational semantics. So we're not
        concerned about _implementing_ the desired model by anymeans - mention
        this as a future work!

      - For now: take a well established class of computable functions, say
        PRFs. Reason: hard to think about most computable functions, e.g., Busy
        Beavers! BUT we want the definition to be self-contained, not _yet_
        getting into complexity or such

      - _Could_ we bring back System T? Maybe simplify the judgements so that we
        don't need contexts, i.e., use a Hilbert style presentation instead?

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

