// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": (
  definition, equation_block, labeled_equation, lang-def-horizontal,
  lang-def-vertical,
)
#import "template/ams-article.typ": (
  corollary, lemma, proof, recursion, remark, theorem,
)
#import "template/judgements.typ": judgement

#let PA = math.bold("PA")
#let HA = math.bold("HA")

= Foundations <foundations>

We introduce the base theory needed for this thesis. This theory embodies a
unifying concept for formal systems: computability. We capture this through a
suitable simple type theory.


We will keep this self-contained; additional references will be provided in each
sub-section. For general notation, we write $:=$ to mean "defined as".


== Base Notions

Before continuing, we must introduce some fundamental notions.
We introduce *alphabets*, using three columns: the first is the symbol name, in monospace font; the second is the mathematical notation used; and the third is the symbol's name. See @alphabet for the template. Note that we informally use natural numbers. However, each definition is self-contained. See @kripkenstein for a related discussion.


#lang-def-vertical(
  $cal(A)$,
  (
    (`s0`, $s_0$, "symbol zero"),
    (`s1`, $s_1$, "symbol one"),
    ("", $...$, ""),
    (`sn`, $s_n$, [symbol $n$]),
  ),
  caption: [Template for an alphabet $A$.],
)<alphabet>


#let Bit = math.bold("Bit")
#let Digit = math.bold("Digit")

#definition[
  The *binary digits (bits)* are given by:
  #lang-def-vertical(
    $"Bit"$,
    (
      (`0`, $0$, "zero"),
      (`1`, $1$, "one"),
    ),
    caption: "The symbols used in bits.",
  )
]<bits>


// #definition[
//   The set of *hexadecimal digits* is the set of symbols given by $Digit$, shown
//   in @digits. The *binary digits (bits)* are $Bit := 0 | 1$.

//   #lang-def-horizontal(
//     $Digit$,
//     (
//       "0": "zero",
//       "1": "one",
//       "2": "two",
//       "3": "three",
//       "4": "four",
//       "5": "five",
//       "6": "six",
//       "7": "seven",
//       "8": "eight",
//       "9": "nine",
//     ),
//     anon-symbols: ("A", "B", "C", "D", "E", "F"),
//     caption: "Hexadecimal digits.",
//   )<digits>

// ]<lang_digits>

#let LW = $cal(L)_W$

#let vdash = $tack.r$

Recursive definitions are given in the form of a *judgement* (@judgement), consisting of *premises* on top and a *conclusion* on the bottom.

#judgement(
  rules: (
    (
      premises: $P$,
      conclusion: $C$,
      label: $J$,
    ),
  ),
  caption: "Template for a judgement.",
)<judgement>

#definition[
  The *language of words* $LW$ is provided in @lang_words. A *word* $w : W$ is
  given by the judgements in @words.

  #lang-def-vertical(
    $LW$,
    (
      (`Bit`, $"Bit"$, [See @bits]),
      (`{}`, $epsilon$, "Empty word"),
      (`.`, $.$, "Concatenation"),
      (`=`, $=$, "Equality"),
      (`!=`, $!=$, "Inequality"),
    ),
    caption: "Language of words",
  )<lang_words>

  #judgement(
    rules: (
      (
        conclusion: $epsilon: W$,
        label: $"Empty"$,
      ),
      (
        premises: $w : W$,
        conclusion: $w.0: W$,
        label: $"Zero"$,
      ),
      (
        premises: $w : W$,
        conclusion: $w.1: W$,
        label: $"One"$,
      ),
    ),
    caption: "Recursive definition of words.",
  )
]<words>


#definition[*Equality* on binary strings is defined recursively.
  #judgement(
    rules: (
      (
        premises: none,
        conclusion: $0 = 0, 1 = 1, 0 != 1$,
      ),
      (
        premises: ($w, w': W, w = w'$),
        conclusion: $w.0 = w'.0, w.1 = w'.1$,
      ),
      (
        premises: $w, w' : W, w.0 = w'.0$,
        conclusion: ($w, w': W, w = w'$),
      ),
      (
        premises: $w, w': W, "not" w = w'$,
        conclusion: $w != w'$,
      ),
    ),
    caption: "Recursive definition of equality.",
  )
]<equality_binary_strings>


#remark[The definition for binary strings, as the remaining recursive
  definitions, serves as a suitable _uniform_ abstraction for data. From a
  physical viewpoint, we cannot _verify_ each finite string, a phenomenon
  related to the notion of "Kripkenstein" @kripke_wittgenstein. However, we
  _can_ provide the template and is more suitable as a definition, and we
  presume these definitions are completely contained (i.e., binary strings are
  defined by a finite combination of _only_ the rules above). On the other hand,
  proof checking will be done in an ultra-finitistic setting and is addressed in
  @bootstrap.
]<kripkenstein>

For simplicity, our primary encoding uses binary. We directly use this in the
notion of a variable in the next section. We review the primary number systems
natively supported by Welkin.


== Untyped Lambda Calculus

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

We first review Church's revised (pure) untyped Lambda Calculus.

#definition(
  [
    The *Untyped Lambda Calculus (ULC)* is given by the following judgements,
    where $Lambda$ is the *set of terms*.

    #judgement(
      rules: (
        (premises: $w : W$, conclusion: $x_w in Lambda$, label: $T_"var"$),
        (
          premises: $tau in Lambda$,
          conclusion: $lambda x_w. tau in Lambda$,
          label: $T_"abs"$,
        ),
        (
          premises: $tau, sigma in Lambda$,
          conclusion: $tau(sigma) in Lambda$,
          label: $T_"app"$,
        ),
      ),
      caption: [Judgement rules that define the ULC.],
    )
  ],
)

== System T

Now, the untyped lambda calculus has non-terminating functions and is therefore
not suitable for proofs on decidability. On the other hand, the simply typed
lambda calculus on its own is too weak for proofs on computability. The solution
is to augment this with induction, via Kurt Gödel's System T @goedel_system_t.
We closely follow Jan Hoffmann's notes @hoffmann_2023_system_t. #footnote([Note
  that the original lecture notes contain some typos, and we fix these as needed.]) This theory consists of four key parts:

- *Terms:* @system_t_terms.

- *Operational Semantics:* @system_t_semantics.

- *Normal forms:* @system_t_normal_form.

#let Var = math.bold("Var")
#let nat = math.text("nat")

#definition[
  The *base language of System T* is
  #lang-def-vertical(
    $L_(B T)$,
    (
      // ($top$, "True"),
      // ($bot$, "False"),
      ($"z"$, $z$, "zero"),
      ($"s"$, $s$, "successor"),
      ($nat$, $NN$, "natural numbers"),
      ("->", $->$, "function"),
      ($"lambda"$, $lambda$, "lambda"),
      ($"rec"$, $"R"$, "recursion"),
      (
        $"(" thin thin thin ")"$,
        $\( thin thin thin \)$,
        "left/right parentheses",
      ),
    ),
  )
  A *type* is given by either $"nat"$, or given types $tau, sigma$, by the
  *function type* $tau -> sigma$.
]<system_t_types>


#definition[
  The *terms* of System T are defined in @system_t_terms.

  #judgement(
    rules: (
      // Base cases
      (conclusion: $"z" : nat$, label: $T_"zero"$),
      (premises: $e : nat$, conclusion: $"s"(e) : nat$, label: $T_"succ"$),
      // (conclusion: $x : tau$, label: $T_"var"$),
      // Recursive steps
      (
        premises: $x : tau, f : tau -> sigma$,
        conclusion: $f(x) : sigma$,
        label: $T_"lambda"$,
      ),
      (
        premises: $x : tau, f(x) : sigma$,
        conclusion: $lambda (x : tau) f(x) : tau -> sigma$,
        label: $T_"apply"$,
      ),
    ),
  )
]<system_t_terms>

We set $0 equiv "z"$ and $1 equiv "s"("z")$.


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
  - $HA$
  - $PA$
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
  *(P1) _Finitistic consistency relies on inductively verifying proof-checkers
  as combinatorial objects._*
]<finitistic_consistency>

This is closely tied to an equivalent notion: proofs on $Sigma^0_1$ statements.
This involves the arithmetic hierarchy, but in short, this is the set of
_partial computable statements_ we wish to verify. With Sergei's theorem, we
obtain:

#corollary[
  $PA$ is *serial-$Sigma^0_1$-sound*, which means that there is a PRF $t$ that,
  given a proof of $Sigma^0_1$ statement in $PA$, $t$ returns a $PA$-proof of
  this statement.
]


With this corollary, in combination to @equi_consistency, we can _definitively
claim_ which statements are proven correctly in the realm of computatbility.
This is key for the reliablity of the method presented in the remaining sections
of this paper. It suffices to examine serial-consistency for this claim, so we
will impose a _constructive proof_ of serial-consistency for theories at least
as strong as $PA$. Computationally, this corresponds to _correctly_ providing
proofs of termination of lambda terms.
