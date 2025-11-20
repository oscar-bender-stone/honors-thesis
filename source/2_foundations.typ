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

We introduce the base theory needed for this thesis. Our work builds on deep
inference, developed by Strassburger @deep_inference_to_proof_nets. and many
others. We formally define a formal system and then proceed to show this can be
encompassed in a deep inference framework. These sections are closely replicated
as steps in the bootstrap (see @bootstrap).

We will keep this self-contained; additional references will be provided in each
sub-section. For general notation, we write $:=$ to mean "defined as".

== Base Notions

Before continuing, we must introduce some fundamental notions. We introduce
*alphabets*, using three columns: the first is the symbol name, in monospace
font; the second is the mathematical notation used; and the third is the
symbol's name. See @alphabet for the template. Note that we informally use
natural numbers. However, each definition is self-contained. See @kripkenstein
for a related discussion. Additionally, sometimes our symbols may be _multiple_
tokens; this is addressed in @syntax.


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

Recursive definitions are given in the form of a *judgement* (@judgement),
consisting of *premises* on top and a *conclusion* on the bottom.

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
  The *language of words* $LW$ is provided in @lang_words. A *word* $w in W$ is
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
        conclusion: $epsilon in W$,
        label: $"Empty"$,
      ),
      (
        premises: $w in W$,
        conclusion: $w.0 in W$,
        label: $"Zero"$,
      ),
      (
        premises: $w in W$,
        conclusion: $w.1 in W$,
        label: $"One"$,
      ),
    ),
    caption: "Recursive definition of words.",
  )
]<words>


// #definition[*Equality* on binary strings is defined recursively.
//   #judgement(
//     rules: (
//       (
//         conclusion: $0 = 0$,
//       ),
//       (
//         conclusion: $1 = 1$,
//       ),
//       (
//         conclusion: $0 != 1$,
//       ),
//       (
//         premises: ($w, w': W, w = w'$),
//         conclusion: $w.0 = w'.0, w.1 = w'.1$,
//       ),
//       (
//         premises: $w, w' : W, w.0 = w'.0$,
//         conclusion: ($w, w': W, w = w'$),
//       ),
//       // (
//       //   premises: $w, w': W, "not" w = w'$,
//       //   conclusion: $w != w'$,
//       // ),
//     ),
//     caption: "Recursive definition of equality.",
//   )
// ]<equality_binary_strings>


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

Natively, our encoding uses binary. But to simplify this notation, we introduce
shorthands using two other number systems.


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

== System T
