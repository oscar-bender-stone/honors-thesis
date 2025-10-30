// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": (
  definition, equation_block, labeled_equation, remark,
)
#import "template/ams-article.typ": corollary, lemma, proof, recursion, theorem

#let PA = math.bold("PA")
#let HA = math.bold("HA")

= Foundations <foundations>

We introduce the base theory needed for this thesis. This theory embodies a
unifying concept for formal systems: computatbility. We capture this through a
suitable, simple type system, definable in a single page.


We will keep this self-contained; additional references will be provided in each
sub-section.

== Base Notions

Before continuing, we must introduce some fundamental recursive definitions.

#definition[
  Define the *language of binary strings* as
  $cal(L)_B = {. thin 0 thin 1 thin w}$:
  - *concatenation* "."
  - *zero* $0$ and *one* $1$.

  A *binary string* is defined recursively:
  #recursion(
    [$0$ and $1$ are binary strings.],
    [if $w$ is a binary string, then so are $w.0$ and $w.1$.],
  )

  As notation, we will write $w 0$ for $w.0$, and similarly, $w 1$ denotes
  $w.1$.

  *Equality* on binary strings is defined recursively:
  #recursion(
    [$0 = 0$ and $1 = 1$, but $0 != 1$],
    [let $w$, $w'$ be binary strings. Then if $w = w'$, then $w.0 = w'.0$ and
      $w.1 = w'.1$],
  )
]<binary_strings>

#remark[The definition for binary strings, as the remaining recursive
  definitions, serves as a suitable _uniform_ abstraction for data. From a
  physical viewpoint, we cannot _verify_ each finite string, a phenomena related
  to the notion of "Kripkenstein" @kripke_wittgenstein. However, we _can_
  provide the template and is more suitable as a definition, and we presume
  these definitions are completely contained (i.e., no other rules are allowed).
  On the other hand, proof checking will be done in an ultra-finitistic setting
  and is addressed in @bootstrap.
]

For simplicity, our primary encoding uses binary. We directly use this in the
notion of a variable in the next section.


== System T

The choice for foundations go back to the very foundational crisis of the 20th
century. During this time, logicians sought a rigorous underpinning of
mathematics, responding to uncertainty in the past with the introduction of the
real numbers. The predominant system that remains today is ZFC. We explore an
alternative well known in computer science: type theory. Starting in 1932,
Alonzo Church introduced his original untyped lambda calculus
@original_lambda_calculus. However, it was quickly shown to be inconsistent, via
the Kleene-Rosser paradox, but was fixed in 1936 with a revision
@church_revised_calculus. He then restricted it further in 1940 with simple type
theory @church_simple_types, which is the basis today for most proof assistants.
For additional context, please consult @laan_type_history.

The simply typed lambda calculus on its own is too weak for proofs on
computability. The solution is to augment this with induction, via Kurt Gödel's
System T @goedel_system_t. We closely follow the presentation from
@girard_proofs_and_types. This theory consists of three key parts:

- *Types:* @system_t_types.

- *Terms:* @system_t_terms.

- *Operational Semantics:* @system_t_semantics.

- *Normal forms:* @system_t_normal_form.

#let Var = math.bold("Var")

#definition[
  The *base language of System T* consists of symbols
  $L_(B T) = {top thin bot thin 0 thin 1 thin + thin * thin BB thin NN thin x thin : thin -> times thin lambda thin D thin R thin angle.l thin angle.r thin \( thin \)}$.
  The *types* of System T are defined recursively:
  #recursion(
    [These are called *base types*.
      - $BB$ is a type, called the *boolean type*.
      - $NN$ is a type, called the *natural numbers type*.
    ],
    [let $U$ and $S$ be types. Then $U -> S$ and $U times S$ are types.
      Moreover, we set $(U) equiv U$.],
  )
  The *(complete) language* is $L_(S T) = L_(B T) union Var$, where $Var$
  consists of the *variables*, symbols $x_i^S$ for each binary string $i$ (the
  *index*) and type $S$. A recursive definition can be adapted from
  @binary_strings and the one above.

]<system_t_types>


#definition[
  The *terms* of System T are defined recursively.
  #recursion(
    [
      - Each variable $x_i^S$ is a term of $S$.
      - $top$ and $bot$ are the _only_ terms of $BB$.
      - $0$ and $1$ are terms of $NN$.
    ],
    [
      - If $u$ is a term of $U$ and $v$ is a term of $V$, then
        $lr(angle.l u, v angle.r)$ is a term of $U times V$.
      - Given a term $lr(angle.l u, v angle.r)$ of $U times V$, then $u$ is a
        term of $U$ and $v$ is a term of $V$.
      - If $t$ has type $tau$ and $f$ has type $S -> U$, then $f(t)$ has type
        $U$.
      - For each variable $x_i^S$ of type $S$, if $f(s)$ has type $U$, then
        $lambda x_i^S. f(x_i^S)$ has type $T -> U$.
      - If $u: U$, $v: U$ and $t : BB$, then $D thin u thin v thin t$ has type
        $U$.
      - For each term $n$ of $NN$, $n+1$ is a term of $NN$.
      - Let $u : U$, $v : U -> (NN -> U)$, and $t: NN$. Then
        $R thin u thin v thin t : U$.
    ],
  )

]<system_t_terms>



#definition[

]<system_t_normal_form>


#definition[

]<system_t_semantics>

#remark[For notational ease of use, we will add several conventions:
  - Variables will be denoted with letter names $a, b, ..., z$ with an implicit
    index.
  - We define new notation with parantheses via recursion (with the base case
    already set above): let $sigma$, $tau$, $rho$ be types.
    - We set products to be *left-associative*:
      $sigma times tau times rho equiv (sigma times tau) times rho$.
    - Similarly, $+$ and $*$ on $NN$ are left-associative.
    - We add *greater precedence* for $->$ over $times$:
      $sigma -> tau times rho equiv (sigma -> tau) times rho$ and
      $sigma times tau -> rho equiv sigma times (tau -> rho)$.
]



== Serial Consistency

As mentioned, System T is closely related to Peano Arithmetic. Specifically,
Gödel proved that Peano Arithmetic ($PA$) is equi-consistent to System T. He did
this to base the former on an intuisonistic logic via Heyting Arithmetic ($HA$),
further compounded by a theory of functionals. The proof is extremely technical
and out of the scope of this thesis; we refer to @goedel_system_t for details.

#theorem[
  The consistency of the following theories are equivalent:
  - System T
  - Heyting Arithmetic
  - Peano Arithmetic
]<equi_consistency>


Due to Gödel's second incompletness theorem, none of these theories can prove
that _any_ of them are consistent. However, a weaker property is _is_ provable
within these systems and represents a revival of Hilbert's program. This was
discovered by Sergei Artemov, outlined in multiple papers
@artemov_serial_consistency. We refer to his latest one but recommend the
others.

#theorem[
  $PA$ proves that there exists a primitive recursive function (PRF) $s$ such
  that, given a proof of $D$, verifies that it contains no contradictions. We
  call $s$ a *selector* and say that $PA$ is *serial-consistent*.
]<serial_consistency>

Note that Artemov's condition is distinct from the normal definition of
consistency, that there is a _single_ proof to demonstrate this consistency.
Thus, this does _not_ contradict Gödel's incompleteness theorems, and in fact
underlies an important principle, closely aligning to Artemov's views:


#show quote.where(block: true): block.with(stroke: (
  left: 2pt + gray,
  rest: none,
))
#quote(block: true)[
  *_Finitistic consistency relies on inductively verifying proof-checkers as
  combinatorial objects._*
]

This is closely tied to an equivalent notion: $Sigma^0_1$ proofs. This involves
the arithmetic hierarchy, but in short, this is the set of _partial computable
statements_ we wish to verify. With Sergei's theorem, we obtian:

#corollary[
  $PA$ is *serial-$Sigma^0_1$-sound*, which means that there is a PRF $t$ that,
  given a statement of a $Sigma^0_1$ statement in $PA$, provides a $PA$-proof.
]


With this corollary, in combination to @equi_consistency, we can _definitively
claim_ which statements are proven correctly in the realm of computatbility.
This is key for the reliablity of the method presented in the remaining sections
of this paper.
