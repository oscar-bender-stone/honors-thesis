// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

== Rules

[TODO[SMALL]: emphasize that the word slate is important here! Connects to
arbitrary objects!]

Units begin as _blank slates_ and may be provided implicit bindings. This is
done _after_ the definition for ease of use.

[TODO[MEDIUM]: address Kripkenstein. Maybe just leave that as implementation
dependent? The sole point is to avoid disagreements or keep things standard.
Might depend ont the notion of arbtiary objects anyways and is determined by the
active users involved?]

[TODO[SMALL]: address equality of binary words. Want to do this elegantly and
quickly!]

#definition[
  A *binary word* is either the symbol $0$ or $1$, and if $w$ is a binary word,
  so are $w.0$ and $w.1$, where $.$ the symbol for *concatenation* (an undefined
  notion).
]<binary-word>

We will postpone to associativity to maintain the flow of new concepts.

[TODO[MEDIUM]: define in a compact way what "enumeration over all binary words
is." Not sure if this _itself_ should be done with symbolic units or is related
to them?]

#definition[
  A _handle_ is given by a pair $(i, E)$, with $i$ being a binary word called a
  *user ID* and $E$ is an enumeration of all binary words.
]<foundations:handle>

[TODO[SMALL]: explain what user provided enumeration means! Emphasis on being
"blank slates", in a certain sense, so _assignable_, but not necesarially so.
Here we can put custom/implicit meaning, and let this be _opaque_. Can be broken
down further, or stand on its own. This represents what one would need to
_understand_ something!]

#definition[
  A *unit* is defined recursively as one of:
  - A _literal_ binary word, denoted by $"0b"w$.
  - A _handle_, see @foundations:handle.
  - A representation $a -->^c b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*.
  - A graph, which is defined as either ${}$ or, for a graph $g$ and unit $u$,
    $g + {u}$.
]<unit>

#remark[
  In contrast to the requirement to the beginning of Li and Vitányi (see
  @rationale), the enumeration need _not_ be surjective but only _locally_ so.
  Abstracting away from the implicit meaning, units act as partial computable
  functions, but the latter is strictly _less_ expressive by removing user
  provided meaning.
]

Units satisfy the following rules, inspired by rewriting logic
@twenty_years_rewriting_logic. These may be interpreted as inference rules _and_
computational rules.

[TODO[SMALL]: provide labels/links.] [TODO[MEDIUM]: explain role of handles in
the theory. How do they affect rules?]

#definition[
  - *Representation*: apply internal transitivity in each context.
    - *R1. Internal Transitivity*: $a -->^c b$ and $b -->^c d$ imply
      $a -->^c d$.
    - *R2. Lifting:* $a -->^c b$ and $p -->^b q$ implies $p -->^a q in c$.
    - *R3. Idempotency:* ${a, a} = {a}$.
    - *R4. Commutativity:* ${a, b} = {b, a}$.
]<unit-rules>

#remark[
  If one restricts @unit to include representations _without_ contexts, then
  clearly not all partial computable functions are definable, because conditions
  cannot be directly expressed. But representations _across_ contexts is
  necessary as well. This corresponds computationally to _switching_ between
  contexts, which is impossible with the removal of R2. Now, rules R3 and R4 are
  meant to make information position independent per contexts: information can
  be repeated as manny times or in different orders. Creating restrictions, as
  _any_ condition in Welkin due to @universality-theorem, can be done through
  multiple contexts.
]

[TODO[MEDIUM]: double check all parts of proof!] #theorem[Any partial computable
  function is definable by a unit.
]<universality-theorem>
#proof[
  It suffices to show that the $K$ and $S$ combinators are definable as units,
  for if terms $M, N$ in the combinator calculus can be expressed as units,
  $M N$ can be expressed simply as ${M N}$.

  For the $K$ combinator, consider the following construction: $K equiv ?$ We
  must show $K A B = A.$

  Now, for the $S$ combinator, consider: $S equiv ?$.
]


== Coherency and Information

#definition[

]<coherency>

#definition[

]<information>
