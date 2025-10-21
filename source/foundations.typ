// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": (
  definition, equation_block, labeled_equation, lemma, remark, theorem,
)
#import "template/ams-article.typ": proof

= Foundations

We introduce the base theory needed for this thesis. We will keep it self-contained;
additional references will be provided in each sub-section.
We introduce an informal, set-theoretic definition, followed by the appropriate encoding into the meta-theory.

#let PA = math.bold("PA")
#let ZFC = math.bold("ZFC")

== Well-formed Formulas

#let LFOL = $ cal(L)_"FOL" $

The foundations of Welkin are based on the first-order theory of Peano Arithmetic. We will integrate the presentation of both. We only introduce one notion general to first-order logic:

#definition[
  The *language* of first-order logic consists of the symbols $LFOL = {not and or -> <-> forall exists ()} union {x_i}$, with symbols called:
  - *Unary connective*: *not* $not$
  - *Binary connectives*: *and* $and$, *or* $or$, *implication* $->$, and *iff* $<->$
  - *Quantifiers* called *for all* $forall$ and *exists* $exists$
  - *Left/Right parantheses* ()
  - a *variable* $x_i$ for each binary string $i$
]<fol_lang>

We will restrict our _primary_ language to ensure simplicity of the checker, limited to the language of Peano Arithmetic, but extra notation is added throughout in a meta-theoretic sense.

#let LA = $ cal(L)_A $
#let LT = $ cal(L)_T $

#definition[
  The *language* of $PA$ is the set $LA = {0, 1, +, *}$, with symbols
  called:

  - *zero* ($0$) and *one* ($1$).

  - *addition* ($+$) and *multiplication* ($*$).

  - *less than or equals* ($<=$)
]<pa_lang>



Note that the full language of our meta-theory is $LT = LFOL union LA$. We will encode these in the syntax of Welkin; see @semantics.

We require the notion of *well-formed formula* to introduce the axioms, specific to Peano-Arithmetic.


#definition[
  A *term* in Peano Arithmetic is defined recursively:
  - *Base case:*
    - The constants $0$ and $1$ are terms.
    - Each variable $x_i$ is a term.
  - *Recursive case*: let $alpha$ and $beta$ be terms. Then $alpha + beta$, $alpha * beta$, and $(alpha)$ are terms.

  A *constant term* is a term without variables. More precisely:
  - *Base case:* $0$ and $1$ are constant terms.
  - *Inductive step*: let $alpha$ and $beta$ be constant terms. Then $alpha + beta$, $alpha * beta$, and $(alpha)$ are constant terms.
]

#definition[
  A *well-formed formula (wff)* in Peano Arithmetic is defined recursively:
  - *Base case:* given terms $alpha$ and $beta$, $alpha = beta$ is a wff.
  - *Recursive case*: let $phi$ and $psi$ be wffs.
    - *Connectives*: $not phi$, $phi and psi$, $phi or psi$, $phi -> psi$, and $phi <-> psi$ are wffs.
    - *Quantifiers*: Let $x$ be a variable. Then $forall x. phi$ and $exists x. phi$ are wffs.

]

#remark[To simplify writing formulas, we add several abbreviations.

  - We add two symbols:

    - *successor function* $S$, given by: $S(n) equiv N + 1$

    - *inequality* $<=$, given by: $x <= y equiv exists z.z + x = y$

  - We assume _most_ of the binary connectives are *right-associative*. More precisely, for any wffs $phi$, $psi$, and $rho$, we add the following abbreviations:
    - $phi and psi and rho equiv phi and (psi and rho)$

    - $phi or psi or rho equiv phi or (psi or rho)$

    - $phi <-> psi <-> rho equiv phi <-> (psi <-> rho)$

    We exclude $->$ due to a a higher risk of ambiguity. However, in our theory, the remaining connectives are provably associative, and therefore, this notation is permissible (see @fol_axioms).

  - We exclude parantheses between _different_ connectives through the following *order of operations* or *priorities:* first $not$, then either $and$ or $or$, next either $forall$ and $exists$, and finally $->$ and $<->$.

]

#definition[
  Let $x$ be a variable and $alpha$ be a term. We define when $x$ *occurs* in $alpha$ inductively.
  - *Base case:*
    - $x$ does not occur in $0$ and $1$.
    - $x$ occurs in $x_i$ iff $x = x_i$.
  - *Inductive step:* let $alpha$ and $beta$ be terms.
    - $x$ occurs in $(alpha)$ iff $x$ occurs in $alpha$.
    - $x$ occurs in $alpha + beta$, $alpha * beta$ iff $x$ occurs in both $alpha$ and $beta$.
]


#definition[
  Let $x$ be a variable and $phi$ a wff. We recursively define when $x$ is *bound* to $phi$:

  - *Base case:* for atomic formulas $phi$, $x$ is bound in $phi$ iff $x$ occurs in $phi$.
  - *Inductive step:* let $phi$, $psi$ be formulas.
    - $x$ is bound in $not phi$ iff $x$ is bound in $phi$.
    - $x$ is bound in $not phi$, $phi and psi$, $phi or psi$, $phi -> psi$, and $phi <-> psi$ iff $x$ is bound in both $phi$ and $psi$.
    - Let $y$ be a variable. Then $x$ is bound in $forall y. phi(y)$, $exists y. phi(y)$ iff either $x = y$ or $x$ is bound in $phi$.

  We say $x$ is *free* in $phi$ if it is not bound in $phi$.
]

#definition[
  A *sentence* is a wff with no free variables. For completeness, we define this inductively:
  - *Base case*: for constant terms $alpha$ and $beta$, $alpha = beta$ is a sentence.
  - *Recursive case*: let $phi$ and $psi$ be sentences.
    - *Connectives:* $not phi$, $phi and psi$, $phi or psi$, $phi -> psi$, and $phi <-> psi$ are sentences.
]

== Peano Arithmetic: Axioms and Proofs

Before we introduce proof, we introduce the axioms of $PA$.


#definition[The *axioms of FOL* include:

]<fol_axioms>


#definition[
  The theory *Robinson Arithmetic* $bold("Q")$ contains the following axioms:


  #equation_block(prefix: "Q", [
    - $forall x. x + 1 != 0$
    - $forall x. forall y. x + 1 = y + 1 -> x = y$
    - $forall x. (x != 0 -> exists y. x = y + 1)$
    - $forall x. x + 0 = x$
    - $forall x.forall y.(x + (y + 1) = (x + y) + 1)$
    - $forall x. x * 0 = 0$
    - $forall x.forall y.x * (y + 1) = x * y + x$
  ])


  The theory $PA = bold("Q") union bold("I")$, where $bold("I")$ is an *induction schema*, defined over each first-order formula $phi$ in $LA$:

  #labeled_equation[
    $phi(0) and forall n (phi(n) -> phi(n+1)) -> forall n phi(n)$
  ]<induction>


  We adopt a single rule of inference, namely *modus ponens*, a meta-theoretic rule:

  #labeled_equation(label: "MP", [
    $A "and" A -> B "implies" B$
  ])
]<pa_axioms>


Now we can define proofs.

#definition[
  A *proof* in $PA$ is defined recursively.

  - *Base Case:*

  - *Recursive Case:*
]

== Key Properties of Peano Arithmetic


$PA$ enjoys several properties. We will define the first in depth, but it is cited here for clarity.

#theorem[
  $PA$ proves the following:

  - Every Primitive Recursive Function (PRF) is total.

  - $PA$ is infinitely axiomatizable but not finitely so.
]

We choose $PA$ as a well-established theorem and a reasonable "minimal" theory. This contrasts with $bold("Q")$, which is too weak for computability proofs without induction, as well as $ZFC$, which has oa much larger proof ordinal. Welkin requires a rich enough theory that can _directly_ encode its core proofs, even with added verbosity. Note that any of these proofs can be _astronomically large_, but the point is to work in a theory where they are _possible_.

Note that from the work of Sergei Artemov, there is a weak form consistency that can be proven in $PA$ _and_ $ZFC$,separately. However, $PA$ is needed as a meta-theory to ensure that Welkin is self-contained; see more in Boostrap for details. $PA$ can also be used to _define_ Turing machines, which we next.


== Set Theoretic Notions

We wish to define our notions in terms of set-theory, as that is predominant in the definitions of computability. To do this, we introduce suitable _encodings_ into PA. We will elaborate when necessary.


#definition[
  We encode the following set-theoretic notions recursively:
  -

]<basic_set_theory>



- Instead of considering arbitrary alphabets, we consider binary ${0, 1}$.

- Any finite set is encoded by a natural numb3er

== Turing Machines <turing_machines>

#definition[
  A *Turing machine (TM)* is a 7-tuple $(Q, Sigma, Gamma, delta, q_0, B, F)$, where:
  - $Q$ is a finite set of *states*
  - $Sigma$ is a finite *alphabet*
  - $Gamma$ is a finite set of *tape symbols*
  - $delta: Q times Gamma -> Q times Gamma times {L, R}$ is a *transition function*, where ${L, R}$ denote directions *left* and *right*, respectively.
]

The encoding of TMs is more involved but possible through several mechanisms.

#definition()[
  Let $T$ be a TM. The *description* $d_T$ of a Turing machine is the encoding of its transition
  diagram into a standard format.
]<turing_machine_description>

