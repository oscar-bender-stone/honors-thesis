// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

== Base Rules

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

#definition[
  A _handle_ is given by a *key*, a triple $("UID", "RID", "HID")$, where
  $"UID"$ is a binary word called a *user ID*, $"RID"$ is a binary word called
  the *revision ID*, and $"HID"$ is a binary word called the *handle ID*.
]<foundations:handle>

#definition[
  A *unit* is defined recursively as a finite combination of:
  - A handle, see @foundations:handle.
  - A representation $a -->^c b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*.
  - A graph, which is defined as either ${}$ or, for a graph $g$ and unit $u$,
    ${@g, u}$.
  Nothing else is a unit.#footnote[Practically, we can only guarantee this up to
    a finite bound. We will address this in ?.]
]<unit>

#remark[
  In contrast to the requirement to the beginning of Li and Vitányi (see
  @rationale), the enumeration need _not_ be surjective but only _locally_ so.
  Abstracting away from the implicit meaning, units act as partial computable
  functions, but the latter is strictly _less_ expressive by removing user
  provided meaning.
]

[TODO[SMALL]: maybe define alternation notation later or recursively?]

For notation, we will set $a - c -> b | d$ to mean ${a - c -> b, a - c -> d}$.
Notice that many-to-many relationships are allowed. Additionally, units satisfy
the following rules, inspired by rewriting logic @twenty_years_rewriting_logic.
These may be interpreted as inference rules _and_ computational rules.

[TODO[SMALL]: provide labels/links.]

#definition[
  The following rules apply to units:

  - *R1. Internal Transitivity*: $a -->^c b$ and $b -->^c d$ imply $a -->^c d$.
  - *R2. Lifting:* $a -->^c b$ and $p -->^b q$ imply $p -->^a q in c$.
  - *R3. Empty:* ${@g, {}} <--> g$.
  - *R4. Idempotency:* ${@g, a, a} <--> {@g, a}$.
  - *R5. Commutativity:* $g + {a} + {b} <--> g + {b} + {a}$.
  - *R6. Associativity:* ${a, {b, c}} <--> {{a, b}, c}$.
  - *R7. Explosion.* ${{} -->^c a} <--> {}$
  - *R8. Absorption.* ${a - {} -> b} <--> {}$
  - *R9. Singleton:* ${a} <--> a$.#footnote[In a set-theoretic context, the
      statement ${a} = a$ is similar to a "Quine atom" in Quine's New
      Foundations that includes an anti-foundation axiom @quine:new-foundations.
      However, note that units are _not_ necesarially sets, so the connection
      may not be applicable in all contexts.
    ]
]<unit-rules>


#remark[
  Each of these rules imposes no restrictions on what can be expressed, thanks
  to the presence of contexts. In fact, contexts are _necessary_ for Turing
  completeness, as one must express conditional rules. In the absence of
  contexts _or_ rule *R2*, @unit-rules reduces to simple graph traversal. Now,
  while contexts can remove restrictions, these rules are carefully chosen to
  represent information as that which can be repeated multiple times (per
  context) and is positionally invariant. This allows us to enable _any_ partial
  computable organization of information and, in particular optimize a given
  organization, see @information-organization.
]<foundations:context-remark>


== PRA

For universality, we need an important base construction that is definable in
the theory: the ability to recurse through all IDs. From there, we can easily
enumerate through all _potential_ handles. #figure(
  [
    $"bit" --> 0 | 1$

    $"word" <--> {"head" --> {"bit" | "empty"}, "next" --> "word"}$
  ],
  caption: [Generator for words in Welkin.],
)<foundations:bootstrap-binary-word>

From there, we can define handle IDs through triples, see
@foundations:bootstrap-handle-id.

#figure(
  [
    $"handle" <--> {"UID" --> "word", "RID" --> "word", "HID" --> "word"}$
  ],
  caption: [Generator for handle keys in Welkin.],
)<foundations:bootstrap-handle-id>

Now we can prove the Turing definability of Welkin.

[TODO[MEDIUM]: double check all parts of proof!]

#theorem[Any partial computable function is definable by a unit.
]<universality-theorem>
#proof[
  Define a new context $C$ for this proof, containing $"Pair"$ and $"Tpl"$, as
  defined above. We claim that that any term of the $S K I$ calculus is
  definable as units in Welkin. To this end, if we can construct terms $M$ and
  $N$, then we can represent the composition $M N$ as a pair
  ${{M --> "head", N --> "next"} -->^C N'$ for some $N'$ in $C$, and subsequent
  compositions $M N Q$ as tuples. Thus, it suffices to show this claim $K$ and
  $S$ combinators are definable as units.

  For the $K$ combinator, consider the following construction:
  $K equiv {x, y, }$ in $C$. We must show $K A B$ reduces to $A$, or, more
  precisely,

  ${{{K --> "first", A --> "second"} --> "head", B --> "next"} -->^C N'$

  [TODO(SHORT): clarify even more nested scopes from Lifting!]

  ${A --> "first", B --> "second"} -->^K A$ in $C$.

  ${A --> "first", B --> "second"} -->^? A$.

  Now, for the $S$ combinator, consider $S equiv ?$. We must show $S A B C D$
  reduces to $(x z)(y z)$, i.e.,:
]

== Expressing PRA

== Expressing PA and Feferman Reflection

The goal of this section is to completely define the following: _a proof of
anything expressible as a RE set_. We will then generalize this to more through
handles and mark soundness. Note that, because of Rice's Theorem, this method is
inherently incomplete with computable methods. This theory does, however,
establish a ceiling. As mentioned, we will postpone optimizations until
@information-organization.

== Coherency and Information

#definition[

]<coherency>

#definition[

]<information>
