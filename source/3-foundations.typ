// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": (
  corollary, equation_block, lemma, proof, theorem,
)

= Foundations <foundations>

== Base Rules

[TODO[MEDIUM]: address Kripkenstein. Maybe just leave that as implementation
dependent? The sole point is to avoid disagreements or keep things standard.
Might depend ont the notion of arbtiary objects anyways and is determined by the
active users involved?]

[TODO[SMALL]: address equality of binary words and keys to handles. Want to do
this elegantly and quickly!]

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

[TODO[MEDIUM]: clarify on semantics of @!]

#definition[
  A *unit* is defined recursively as a finite combination of:
  - A handle, see @foundations:handle.
  - A representation $a -->^c b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*.
  - A graph, which is defined as either ${}$ or, for a graph $g$ and unit $u$,
    ${@g, u}$ and ${@g, ~u}$ are graphs, where $@g$ is a new graph called the
    *expansion* of $g$.
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

For notation, we will set $a - c -> b | d$ to mean ${a - c -> b, a - c -> d}$
and $q in c$ to mean $q - c -> q$. Notice that many-to-many relationships are
allowed. Additionally, units satisfy the following rules, inspired by rewriting
logic @twenty_years_rewriting_logic. These may be interpreted as inference rules
_and_ computational rules.

[TODO[SMALL]: provide labels/links.]

[TODO[SMALL]: Maybe reduce the number of meta-variables used for clarity?]

[TODO[SMALL]: Clarify role of global context!]

[TODO[SMALL]: ensure that double contexts are idemptotent! Important!]

#definition[
  Define a new context $C$ called the *global context*. In the global
  environment, the following rules apply to units, recursively stated over
  meta-variables $a, b, c, d, g, p, q$:
  - *R1. Internal Transitivity*: $a -->^c b$ and $b -->^c d$ imply $a -->^c d$.
  - *R2. Contextual Lifting:* $a -->^c b$ and $p -->^b q$ imply $p -->^a q in c$
  - *R3. Empty:* ${@g, {}} <--> g$ and ${{}, ~x} <--> {}$.
  - *R4. Identity:* ${@g, a} <--> g$ if and only if $a - g -> a$. In particular,
    ${a} <--> {a --> a}$.
  - *R5. Additive Expansion:* if $a - g -> a$, then ${@g, b} <-> {@g, a, b}$.
  - *R6. Subtractive Expansion:* if $g <--> {@p, a}$, then
    ${@g, ~a, b} <--> {@p, b}$.
  - *R7. Unit Idempotency:* ${@g, a, a} <--> {@g, a}$.
  - *R8. Arrow Idempotency:* ${@g, a, b, c, a - b -> c} <--> {@g, a - b -> c}$.
  - *R9. Associativity:* ${a, {b, c}} <--> {{a, b}, c}$.
  - *R10. Commutativity:* ${@g, a, b} <--> {@g, b, a}$.
  - *R11. Exclusion.* ${a - {} -> b} <--> {}$.
  - *R12. Singleton:* ${a} <--> a$.
]<unit-rules>

#remark[
  Each of these rules imposes no restrictions on what can be expressed, thanks
  to the presence of contexts. In fact, contexts are _necessary_ for Turing
  completeness, as one must express conditional rules. In the absence of
  contexts _or_ rule *R2*, @unit-rules reduces to simple graph traversal. Rules
  *R3-R6* define expansions. To avoid accidentally excluding information via an
  exclusion $~x$, exclusions are required to be in a separate anonymous graph,
  see ?. Together with rules *R7*-*R10*, this forms a join-semilattice, as a
  useful way to allow information to be repeated multiple times and be
  positionally invariant within a context. These will be used as an
  optimization, see @information-organization. Rule $"R8"$ is used to naturally
  say that the empty context cannot contain any rules or units. Finally, $"R9"$
  is similar to a "Quine atom" in Quine's New Foundations, a variant of set
  theory that includes an ani-foundation axiom. However, note that units are
  _not_ necesarially sets, so the connection may not be applicable in all
  contexts.
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

#definition[
  The *unit recursor* $R$ is defined by $R <--> {R_"base", "Rules"}$, where
  $R_"base"$ is defined recursively, over meta-variables $h, a, b, c$:
  - Includes @foundations:bootstrap-binary-word and
    @foundations:bootstrap-handle-id.
  - ${} - R -> R$.
  - For each handle $h$, $h - R -> R$.
  - For each arrow $a - b -> c$, ${a - b -> c} - R -> R$.
  - *Monotonic:*
    - For each ${@a, b}$, ${@a, b} - R -> a$.
    - For each ${@a, ~b}$, $a - R -> {@a, ~b}$.
]<foundations:recursor>

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


[TODO[MEDIUM]: Provide tabular proofs for these! Want to be very precise! But
need to recognize when we are doing substitutions for meta-variables.]

The following theorems are two parts of the same *Recursion theorem* for Welkin.

#theorem[*(Correctness)* For every unit $u$,
  $u -->^R R$.]<foundations:recursion-correctness>
#proof[]

#theorem[*(Uniqueness)* Let $K$ be any unit such that for any unit $u$,
  $u -->^K K$. Then $K <- R -> R$.]<foundations:recursion-uniqueness>

An important consequence of the recursion theorem is a basic form of
*reflection*.

[TODO: make this precise! Do we strictly *need* this? Need to make this
clearer!]

#corollary[Let $T$ be any unit that extends the rules of Welkin. Then
  ${T --> R} -->^R R$]<foundations:base-reflection>
#proof[
  We proceed by induction, fixing the base to be $R$.
  - *Base Case:* suppose $T$ is a unit exactly with the rules $u - T -> T$ for
    every unit $u$ and the rules in @unit-rules. Then by
    @foundations:recursion-uniqueness, $T <--> R$, completing the base case.
  - *Inductive step:* suppose $T = {T', e}$ for a units $T', e$ where
    $T' --> R$. Now, by monotonicitiy in $R$, $T --> T'$, hence by transitivity,
    $T --> R$.
]


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
