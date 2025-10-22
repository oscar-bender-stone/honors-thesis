// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": (
  definition, equation_block, labeled_equation, remark,
)
#import "template/ams-article.typ": lemma, proof, recursion, theorem

= Foundations

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
System T @goedel_system_t. and the entire theory can be defined in a single
page. We closely follow the presentation from William Tait @tait_system_t, but
for further reading, we recommend @girard_proofs_and_types. The full definitions
are provided in @system_t_types and @system_t_terms.

#let Var = math.bold("Var")

#definition[
  The *base language of System T* consists of symbols
  $L_(B T) = {NN thin BB thin x -> times \( \)}$. The *types* of System T are
  defined recursively:
  #recursion(
    [These are called *base types*.
      - $NN$ is a type, called the *natural numbers type*.
      - $BB$ is a type, called the *boolean type*.
    ],
    [let $sigma$ and $tau$ be types. Then $sigma -> tau$ and $sigma times tau$
      are types. Moreover, we set $(sigma) equiv sigma$],
  )
  The *(complete) language* is $L_(S T) = L_(B T) union Var$, where $Var$
  consists of the *variables*, symbols $x_i^T$ for each binary string $i$ (the
  *index*) and type $T$. A recursive definition can be adapted from
  @binary_strings and the one above.

]<system_t_types>

#definition[
  The *terms* of System T are defined recursively:

]<system_t_terms>

#remark[For notational ease of use, we will add several conventions:
  - Variables will be denoted with letter names $a, b, ..., z$ with an implicit
    index. Note that distinguishing variables is important, so we will use
    distinct names when possible.
  - We define new notation with parantheses via recursion (with the base case
    already set above): let $sigma$, $tau$, $rho$ be types.
    - We set products to be *left-associative*:
      $sigma times tau times rho equiv (sigma times tau) times rho$.
    - We add *greater precedence* for $->$ over $times$:
      $sigma -> tau times rho equiv (sigma -> tau) times rho$ and
      $sigma times tau -> rho equiv sigma times (tau -> rho)$.
]



== Serial Consistency

As mentioned, System T is closely related to Peano Arithmetic. Specifically,
Gödel proved that Peano Arithmetic is equi-consistent to System T. He did this
to base the former on an intuisonistic logic, further compounded by a theory of
functionals. The proof is extremely technical and out of the scope of this
thesis; we refer to @goedel_system_t for details.

#theorem[
  The consistency of the following theories are equivalent:
  - System T
  - Heyting Arithmetic
  - Peano Arithmetic
]<equi_consistency>


However, a weaker property is _provable_ within these systems, a revival of
Hilbert's program. This was discovered by Sergei Artemov, outlined in multiple
papers. We refer to his latest one but recommend the others.

#theorem[
  Peano Arithmetic proves that.
]<serial_consistency>
