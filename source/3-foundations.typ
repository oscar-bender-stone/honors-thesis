// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

== Rules

[TODO[SMALL]: emphasize that the word slate is important here! Connects to
arbitrary objects!] Units begin as _blank slates_ and may be provided implicit
bindings. This is done _after_ the definition for ease of use.

[TODO[MEDIUM]: address Kripkenstein. Maybe just leave that as implementation
dependent? The sole point is to avoid disagreements or keep things standard.
Might depend ont the notion of arbtiary objects anyways and is determined by the
active users involved?]

[TODO[SMALL]: determine if alphabets should be made clear here.]

[TODO[SMALL]: address equality of binary words. Want to do this elegantly and
quickly!]

#definition[
  A *binary word* is either symbol $0$ or $1$, and if $w$ is a binary word, so
  are $w.0$ and $w.1$, where $.$ stands for *concatenation*.
]<binary-word>

We leave concatenation `.` as an undefined notion. We set concatenation to be
right-associative,

#definition[
  A *unit* is defined recursively as either:
  - A binary word.
  - A representation $a -->^c b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*.
  - A graph, which is defined as either ${u}$
]<unit>

Units satisfy the following rules, inspired by rewriting logic
@twenty_years_rewriting_logic. These may be interpreted as inference rules _and_
computational rules.

[TODO[SMALL]: provide labels/links.]

#definition[
  - *Representation*: apply internal transitivity in each context.
    - *R1. Internal Transitivity*: $a -->^c b$ and $b -->^c d$ imply
      $a -->^c d$.
    - *R2. Lifting:* $a -->^c b$ and $p -->^b q$ implies $p -->^a q in c$.
    - *R3. Idempotency:* ${a, a} = {a}$.
    - *R4. Commutativity:* ${a, b} = {b, a}$.
]<unit-rules>

[TODO[MEDIUM]: double check all parts of proof!]
#theorem[Any partial computable function is definable by a unit.
]
#proof[
  It suffices to show that the $K$ and $S$ combinators are definable as units,
  for if terms $M, N$ in the combinator calculus can be expressed as units,
  $M N$ can be expressed simply as ${M N}$.

  For the $K$ combinator, consider the following construction: $K equiv ?$ We
  must show $K A B = A.$

  Now, for the $S$ combinator, consider: $S equiv ?$.
]
