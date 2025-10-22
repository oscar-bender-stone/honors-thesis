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

== Computability

Before continuing, we must introduce some fundamental recursive definitions.

#definition[
  Fix the symbols $cal(L)_B = {. thin 0 thin 1}$:
  - *concatenation* "."
  - *zero* $0$ and *one* $1$.

  A *binary string* is defined recursively:
  #recursion(
    [$0$ and $1$ are binary strings.],
    [if $w$ is a binary string, then so are $w.0$ and $w.1$.],
  )

  As notation, we will write $w 0$ for $w.0$, and similarly, $w 1$ denotes
  $w.1$.
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
page.

We know introduce System T as our underlying meta-theory. We closely follow the
presentation from William Tait @tait_system_t, but for further reading, we
recommend @girard_proofs_and_types.

#definition[
  *System T* is the theory defined as follows.

  First we define *terms* recursively:
  #recursion(
    [],
    [],
  )
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
