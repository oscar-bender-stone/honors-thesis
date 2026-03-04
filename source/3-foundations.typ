// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": matched-dash
#show math.minus: matched-dash

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": (
  corollary, equation_block, lemma, proof, theorem,
)

= Foundations <foundations>

This section discuss the foundations of Welkin, as follows:

+ We discuss the connection to Algorithmic Information theory. This section can
  be entirely skipped but may provide context for theoretical computer
  scientists.
+ We define units and their rules.
+ We define information.

== Discussion: Extending Algorithmic Information Theory

The main purpose of an information base is to store information and enable user
queries based on the available information. To make this idea precise, we
dissect the approach taken by Algorithmic Information Theory, specifically
through a well known book by Li and Vitányi @intro_kolmogorov_complexity. Their
book focuses on the _information content_ of a description, which they summarize
as follows:

[TODO[SMALL] still resolve how pages should be mentioned!]

#set quote(block: true)
#quote(attribution: [@intro_kolmogorov_complexity, pages 101-102])[
  _We require both an agreed-upon universal description method and an
  agreed-upon mechanism to produce the object from its alleged description. This
  would appear to make the information content of an object depend on whether it
  is particularly favored by the description method we have selected. By ‘favor’
  we mean to produce short descriptions in terms of bits._]

They express this idea with an enumeration $D$ from _objects_ to _descriptions_,
written as strings of symbols. To ensure that their measure is _minimal_ and can
be mechanized, $D$ is a partial computable function. The authors proceed define
the _information content_ of a string through Kolmogorov complexity, the size of
the smallest description that accepts an object, or in other words, the smallest
program that accepts a string. From there, they prove multiple foundational
results for Algorithmic Information Theory, including that Kolmogorov complexity
is uncomputable. This quantity can be approximated by several means, which is
closely involved to compression algorithms.

However, Li and Vitányi's approach does not generally reflect the ways people
disseminate and create new information. The term "object" is a vague term that
is vastly different between disciplines and can be difficult to model for
entities. For example, consider a dynamic biological systems. If objects have
well defined boundaries, what would the "boundary" be of an evolving system?
Another issue is well known in the knowledge management literature as the Symbol
Grounding Problem, formulated by Harnard @harnard-symbol-grounding. As an
example, Harnard considers a person expecting to learn Chinese as their first
language with _only_ a Chinese dictionary. How does the person ground their
symbols in concrete meanings? An information base cannot practically store the
denotations of a word, such as storing animals, so how _original meaning_ is
obtained is unclear.

To make matters worse, the undecidabilty of grounding has been established by
@liu-algorithmic-symbol-grounding, precisely using Kolmogorov complexity. To
address symbol grounding, we systematically create handles and enable user
expansions. We require rigorous proofs to ensure soundness, or that truth is
preserved according to the context defined therein.

Despite the presence of the Symbol Grounding Problem, we emphasize that an
information base is a _tool_ that is useful when _mechanized_. As such,
information bases are not for resolving philosophical inquiries on the existence
or absence of things or abilities. Information itself is used for _predictions_:
a person that translates the sentence "It will rain today" in Chinese to convey
a semantic property of the world, that there will be rain. This scales to larger
examples, with major theorems providing even more refined or general properties
_given_ a set of assumptions. Note that this is different form Shanon's seminal
work on Information Theory, in which methods are found to convey the _exact_
bits of strings in noisy channels. Because communication _itself_ does not carry
the physical entities, relationships are key to effectively conveying ideas. A
recent work bridges this gap with Shannon's work to express meaning through
finite models in first-order logic @liu-theory-based-symbol-grounding, so that
two strings are considered equivalent if they are that are provably equivalent
as first order sentences are in fact equal, regardless if the strings have
distinct bits.

== Base Rules

For notation, we will write $a equiv b$ to mean that $a$ is definitionally
equivalent to $b$. Moreover, we will distinguish between _defining_ a term as
finite and _practically enforcing_ it is finite. For a thorough discussion, see
?.

#definition[
  A *bit* is the symbols $0$ or $1$. A *binary word* is either the symbol
  $epsilon$ (the *empty word*), and if $w$ is a finite binary word, so are $w.0$
  and $w.1$, where $.$ the symbol for *concatenation*. Nothing else is a word.
]<binary-word>

#definition[
  Equality $=$ and inequality $!=$ on words $w_1, w_2$ is defined recursively:
  - *Base case:* $epsilon = epsilon$
  - *Recursive step:* suppose $w_1 = b_1.w_1'$ and $w_2 = b_2.w_2'$, where
    $b_1, b_2$ as bits and $w_1', w_2'$
  are words. Then $w_1 = w_2$ if and only if $b_1 = b_2$ and $w'_1 = w'2$.
  Moreover, $w_1 != w_2$ if and only if $b_1 != b_2$ or $w'_1 != w'_2$.
]<foundations:binary-word-equality>
#remark[@foundations:binary-word-equality is given constructively to ensure that
  if two finite words are unequal, then an explicit bit can act as a certificate
  for this inequality.]

[TODO[SMALL]: without getting into typing, enforce that equality has to be done
on two words or two handles. Maybe lift to the latter to make sense?]
#definition[
  A _handle_ is given by a *key*, a triple $("UID", "RID", "HID")$, where
  $"UID"$ is a binary word called a *user ID*, $"RID"$ is a binary word called
  the *revision ID*, and $"HID"$ is a binary word called the *handle ID*. Two
  handles
  $h_1 equiv ("UID"_1, "RID"_1, "HID"_1), h_2 equiv ("UID"_2, "RID"_2, "HID"_2)$
  are equal, written $h_1 = h_2$, if and only if $"UID"_1 = "UID"_2$,
  $"RID"_1 = "RID"_2$, and $"HID"_1 = "HID"_2$. Analogously, $h_1$ is not equal
  to $h_2$, written $h_1 != h_2$, if and only if at least one of the following
  hold: $"UID"_1 != "UID"_2$, $"RID"_1 != "RID"_2$, or $"HID"_1 != "HID"_2$
]<foundations:handle>

#definition[
  A *unit* is defined recursively as a finite combination of:
  - A handle, see @foundations:handle.
  - A representation $a -->^c b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*.
  - A block, which is defined as one of the following:
    - ${}$
    - Given a block $g$ and unit $u$, ${g, u}$, ${@g, u}$, and ${@g, ~u}$ are
      glocks, where $@g$ is a new blocks called the *expansion* of $g$ and $~u$
      is called the *exclusion of u*.
  Nothing else is a unit.
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

[TODO[MEDIUM]: decide whether to use math font or code font for writing terms!
Important!]


[TODO[SMALL]: note importance of using axioms to define essentially bound/free
variables! Not as easy with just assuming sets as they are; easier to express
the tree structure *first*.] #definition[The relation $u' < u$ is defined
  recursively...]<subunit>

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

[TODO[MEDIUM]: show that R *correctly* distinguishes between all units!]
#definition[
  The *unit recursor* $R$ is defined by $R <--> {R_"base", "Rules"}$, where
  $R_"base"$ is defined recursively, over meta-variables $h, a, b, c$:
  - Includes @foundations:bootstrap-binary-word and
    @foundations:bootstrap-handle-id.
  - ${} - R -> R$.
  - For each handle $h$, $h - R -> R$.
  - For each arrow $a - b -> c$, if $a, b, c in R$, then
    ${a - b -> c} - R -> R$.
  - *Monotonic:* for each $a, b$ with $a - R -> R$ and $b - R -> R$, the
    following hold:
    - $a - R -> {a, b}$.
    - $a - R -> {@a, b}$.
    - ${@a, ~b} - R -> a$.
]<foundations:recursor>

[TODO: make this discussion complete!] One interpretation of
@foundations:recursor is defining @subunit _within_ a unit, so $R$ could be
written as $<$ in the language. Moreover, $R$ acts as the _least super bound_ of
all units.

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

#theorem[*(Correctness)* For every unit $u$, $u -->^R R$, and if $u < u'$, then
  $u --> u'$ and not $u' --> u$ in $R$.]<foundations:recursion-correctness>
#proof[We proceed on induction by units $u$:
  - *Base case:* this is immediate, as ${}$ and all handles are included.
  - *Inductive step:* there are four main cases:
    - ${a - b -> c} - R -> R$: this is immediate in context $R$.
    - ${g, e} - R -> R$: suppose $g --> R$ and $e --> R$ in $R$. FINISH.
    - ${@g, e} - R -> R$: suppose $g --> R$ and $e --> R$ in $R$. FINISH. use
      lifting?
    - ${@g, ~e} - R -> R$: assume $g - R -> R$. Then, because
      ${@g, e} - R -> g$, transitivity implies ${@g, ~e} - R -> R$.
]

[TODO[MEDIUM]: complete! And is this in the global context? Is this extensional
equality or so?] #theorem[*(Uniqueness)* Let $K$ that contains exactly
  $u -->^K u$ for each unit $u$. Then
  $K <- R -> R$.]<foundations:recursion-uniqueness>
#proof[
  Assume for all units $u$, $u -->^K K$. Then $R -->^R R$. Thus, for any
  $p - K -> q$ in $K$, ${C − K -> K, p − K -> q} − K -> (p - C -> q in K)$

]

An important consequence of the recursion theorem is a basic form of
*reflection*.

[TODO: make this precise! What does it mean for $T$ to "contain the rules of
Welkin"?]

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
