// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": matched-dash, tilde-prefix
#show math.minus: matched-dash
#show math.tilde: tilde-prefix

#import "template/ams-article.typ": rule-table
#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": corollary, equation_block, lemma, theorem

#import "template/ams-article.typ": proof, proof-sketch
#import "template/ams-article.typ": induction
#import "template/ams-article.typ": end-def

= Foundations <foundations>

This section discuss the foundations of Welkin, outlined in
@<foundations:overview>:

#figure(
  table(
    columns: (20%, 25%, 55%),
    align: left,
    table.header([*Section Number*], [*Title*], [*Description*]),
    [*@foundations:words-and-handles*],
    [*Words and #linebreak() Handles*],
    [Introduces binary words and handles.],

    [*@foundations:units-section*],
    [*Units*],
    [Recursively defines units @foundations:unit as their rules @unit-rules.],

    [*@foundations:turing-completeness-section*],
    [*Turing #linebreak() Completeness*],
    [Proves that there is a natural correspondence between untis in Welkin and
      Turing machines.],

    [*@foundations:queries-and-information*],
    [*Queries and #linebreak() Information*],
    [Defines queries (@foundations:query) and information
      (@foundations:information)],
  ),
  caption: [Overview of @syntax.],
)<foundations:overview>

For this thesis, definitions and proofs will be given at a high level.
Additionally, we adopt several conventions:

- Each *Definition* and *Remark* ends with a triangle ($#end-def$).
- Each proof ends with a square ($square.stroked$).
- We frequently abbreviate "if and only if" as "iff".

== Words and Handles <foundations:words-and-handles>

// TODO: replace equiv with a delta equiv

For high-level notation, we write $a equiv b$ to mean that $a$ is definitionally
equivalent to $b$. High level notation will _not_ be stated in the syntax unless
where noted. We will be pedantic in most notation for complete precision.
Moreover, implementation details are outside the scope of this thesis. This
includes, e.g., practically restricting user input by fixed upper bounds.

#definition[
  A *bit* is the symbols $0$ or $1$. A *binary word* is either the symbol
  $epsilon$ (the *empty word*), and if $w$ is a finite binary word, so are $w 0$
  and $w 1$, where the juxtaposition of symbols denote *concatenation*. Nothing
  else is a word.
]<foundations:word>

We also require a notion of equality on bits. To ensure this is constructive, we
provide a _separate_ definition of inequality as well. The latter provides an
explicit certificate, a bit that shows how two words are distinct.

#let W-eq = math.attach($=$, br: "W")
#let W-neq = math.attach($!=$, br: "W")

#definition[
  Equality $#W-eq$ and inequality $#W-neq$ on words $w_1, w_2$ is defined
  recursively and as nothing else:
  - *Base case:* $epsilon = epsilon$.
  - *Recursive step:* suppose $w_1 #W-eq b_1w_1'$ and $w_2 #W-eq b_2w_2'$, where
    $b_1, b_2$ as bits and $w_1', w_2'$ are words. Then $w_1 #W-eq w_2$ if and
    only if $b_1, b_2$ are both $0$ or $1$, and $w'_1 #W-eq w'_2$. Moreover,
    $w_1 #W-neq w_2$ if and only if $b_1$ is $0$ and $b_2$ is $1$, $b_1$ is $1$
    and $b_2$ is $0$, or $w'_1 #W-neq w'_2$.
]<foundations:binary-word-equality>

Words alone do not carry meaning. Instead, meaning is provided through
*handles*.

#definition[
  A *handle* is given by an *ID*, which is a word. The interpretation of a given
  handle is a free parameter, and therefore outside the scope of this language.
]<foundations:handle>

Because handles act as free parameters, we work with them through truth. Based
on this, the rest of the thesis will abstract away general units _as_ sets of
axioms. Certain interpretations are used to define Welkin's syntax. For example,
words can be interpreted as handles without external meaning.

Now, we can define equality and inequality between handles. We will reserve $=$
and $!=$ for handles, respectively.

#definition[Consider two handles $h_1$, $h_2$, and let $"ID"_1$ and $"ID"_2$ be
  their respective IDs. Then:
  - $h_1$ is *equal* to $h_2$, written $h_1 = h_2$, if and only if
    $"ID"_1 #W-eq "ID"_2$.
  - $h_1$ is *not equal* to $h_2$, written $h_1 != h_2$, if and only if
    $"ID"_1 #W-neq "ID"_2$.
]<foundations:handle-equality>

== Units <foundations:units-section>

Now we can define units. Roughly, units are finite combinations of handles and
representations. We present the complete definition as follows.

#definition[
  A *unit* is defined recursively as follows and nothing else:
  - *Base case:*
    - The symbol ${}$, the *empty block*.
    - A handle, defined in @foundations:handle.
  - *Recursive step:* let $u, v, g$ be units and $h$ a handle. Then any finite
    combination of the following are also units:
    - A *pair* ${u, v}$.
    - A *representation* $a - c -> b$, where $a$ is the *sign*, $c$ is the
      *context*, and $b$ is the *referent*. This is read as: $a$ *represents*
      $b$ *in context* $c$.
]<foundations:unit>

We add several abbreviations, most of which will appear in @syntax:

- ${a}$ denotes ${a, {}}$.

- $a <- c -> b$ denotes that both $a - c -> b$ and $a <- c - b$ hold.

- We add a symbol $subset.sq.eq$ for *containment*, where $a subset.eq.sq g$ iff
  #box[$a - g -> a$]. When writing _in_ the language, we will prefer the latter
  form.

Now we may introduce the rules on units.

#definition[
  All rules in @table:unit-rules hold, stated over meta-variables
  $a, b, c, d, g$ for units and $h_1, h_2$ for handles.
  #let unit-rule-table = rule-table(
    prefix: "R",
    (
      (
        name: "Internal Transitivity",
        lbl: "r:transitivity",
        content: [$a - c -> b$ and $b - c -> d$ imply $a - c -> d$],
      ),
      (
        name: "Pair Congruence",
        lbl: "r:pair-congruence",
        content: [
          If $a - c -> b$, then
          #box[${a, d} - c -> {b, d}$]
        ],
      ),
      // TODO: combine congruence axioms into one
      (
        name: "Sign Congruence",
        lbl: "r:sign-congruence",
        content: [
          If $a - c -> b$, then #box[${a - g -> d} - c -> {b - g -> d}$]
        ],
      ),
      (
        name: "Context Congruence",
        lbl: "r:context-congruence",
        content: [
          If $a - c -> b$, then
          #box[${d - a -> g} - c -> {d - b -> g}$]
        ],
      ),
      (
        name: "Referent Congruence",
        lbl: "r:referent-congruence",
        content: [
          If $a - c -> b$, then
          #box[${d - g -> a} - c -> {d - g -> b}$]
        ],
      ),

      (
        name: "Contextual Lifting",
        lbl: "r:context-lift",
        content: [$a - c -> b$ and $d - a -> g$ imply
          #box[${d - b -> g} subset.sq.eq c$]],
      ),
      (
        name: "Refinement",
        lbl: "r:refine",
        content: [
          #box[${a - c -> b, a - c -> d} --> {a - c -> b}$]
        ],
      ),
      (
        name: "Empty",
        lbl: "r:empty",
        content: [${g, {}} <- c -> g$],
      ),
      (
        name: "Sign Absorption",
        lbl: "r:sign-null",
        content: [${{} - a -> b} - c -> {}$],
      ),
      (
        name: "Context Absorption",
        lbl: "r:context-null",
        content: [${a - {} -> b} - c -> {}$],
      ),
      (
        name: "Referent Absorption",
        lbl: "r:referent-null",
        content: [ ${a - b -> {}} - c -> {}$],
      ),
      (
        name: "Handle Equality",
        lbl: "r:handle-eq",
        content: [If $h_1 = h_2$, then
          $h_1 <-c-> h_2$],
      ),
      (
        name: "Containment",
        lbl: "r:a",
        content: [
          #box[${a - g -> a} <- c -> {{g, a} <--> g}$]
        ],
      ),
      (
        name: "Idempotentcy",
        lbl: "r:idempotent",
        content: [${a, a} <-c-> a$],
      ),
      (
        name: "Associativity",
        lbl: "r:associativity",
        content: [${a, {b, c}} <-c-> {{a, b}, c}$],
      ),
      (
        name: "Commutativity",
        lbl: "r:commutativity",
        content: [${a, b} <-c-> {b, a}$],
      ),
    ),
  )
  #figure(
    unit-rule-table,
    caption: "Set of all valid rules in Welkin.",
  )<table:unit-rules>

]<unit-rules>

We review the utility of each rule. Note @r:context-lift is the only rule
_between_ contexts; the rest is entirely user defined. Moreover, only
@r:transitivity, @r:sign-congruence, and @r:context-congruence are needed for
Turing completeness. However, the other rules are in place to help with
organizing units as modules, as well as make it easier to use the language.

[TODO: refer to rules with ranges when appropriate! Much nicer.]

- @r:transitivity, @r:pair-congruence, @r:sign-congruence,
  @r:context-congruence, @r:referent-congruence, @r:context-lift were discussed
  in @rationale:unit.[TODO: maybe review the discussion from earlier? Might be
  useful to reinforce main ideas to reader.]
- @r:refine is explained as follows: suppose $a$ is a unit, and in a block, $a$
  represents two other units $b, d$. Then this block _represents_ ${a --> b}$
  and ${a --> d}$, separately. This provides a mechanism to _refine_ a general
  unit into a more specific one.
- @r:empty, @r:sign-null, @r:context-null, and @r:referent-null define the
  behavior of the empty unit ${}$, similar to the empty set. @r:sign-null and
  the like specifically states that ${}$ contains _no_ representations. Thus, if
  a representation has a component that is ${}$, then it carries no meaning.
  This provides a mechanism to _exclude_ units in a context. This is useful for
  imposing invariants.
- @r:handle-eq enables equality in words and handles to pass through into
  representations. Besides this, note that equivalences on units are entirely
  user defined.
- @r:idempotent, @r:associativity, and @r:commutativity ensure that information
  can be repeated and arranged in any order. Mathematically, this means that
  units have a *semi-lattice* structure.

#remark[The rules in @unit-rules use few meta-variables, which may _or_ may not
  equal each other. This is connected to variables as managed by the proof
  checker MetaMath Zero @mm0. In first-order logic, variables in quantifiers are
  assumed to be distinct. To _allow_ for equality as well, these must be
  separately included, but this quickly explodes in size. All of this means that
  Welkin, similar to MetaMath Zero, achieves a significant level of compression.
  However, _direct_ conversions to first-order theories may not be feasible.
]

As more notation, we write:

- $"*"{a_1, ..., a_n} - c -> b$ for
  ${a_1 - c -> b, a_2 - c -> b, .., a_n - c -> b}$.
- $a - c -> "*"{b_1, ..., b_n}$ for ${a --> b_1, a --> b_2, .., a --> b_n}$.

We will officially add $"*"$ to the grammar in @syntax.

== Turing Completeness <foundations:turing-completeness-section>

This section shows that Welkin is Turing complete. For background, there are
many papers, e.g., @sipser-theory-ofcomputation[Ch. 3].

We want to demonstrate that every unit corresponds to some Turing machine, and
vice versa. More precisely, we want to find a one-to-one mapping $phi$ from
units $c$ to a Turing machine $phi_c$ such that

#set math.equation(numbering: _ => $(#math.star.filled)$)
$ a - c -> b #math.text("if and only if") phi_c (⟨phi_a⟩) = ⟨phi_b⟩. $

Here, $⟨phi_a⟩$ denotes a standard encoding of a Turing machine as a string
(refer to @sipser-theory-ofcomputation[Ch 3.3, pg. 185]). We also require that
$phi$ is surjective, i.e., each Turing machine $T$ can be expressed as $phi_u$
for some unit $u$. The purpose of $phi$ is to provide a computational
interpretation of units _as_ programs, or operators. Note that handles can have
implicit, user-defined meaning (outlined in @foundations:handle). Practically,
we will maintain this interpretation, as representations are managed
mechanically through truth
#footnote[
  In connection to linguistics, this is the difference between a formal
  semantics, what is stated in the language, and pragmatics, the intension or
  purpose of a term.]

At this point, we are concerned with showing _some_ $phi$ exists, thereby
validating Goal 1 [TODO: provide a link to this]. We are not concerned about
efficiency; this will be left for a future work, refer to @conclusion. To
construct $phi$, we want to create an embedding into the $"SK"$-combinator
calculus. This is an equational theory, first developed by Schönfinkel
@schoenfinkel-combinators, and independently discovered by Curry
@curry-grundlagen. In this theory, a *combinator* is a higher-order function: a
function that takes in other functions as inputs. #footnote[A remark for
  logicians: this calculus is extremely similar to a Hilbert-style proof system,
  with $K$ and $S$ corresponding to the rules $(phi => (psi => phi))$ and
  $(phi => (psi => zeta)) => ((phi => zeta) => (psi => zeta))$, respectively.
  This was one of Curry's insights in connecting logic to computation
  @curry-grundlagen.] As a simplification, we present this calculus using a
*reduction relation* instead of equality.

#let sk-imp = math.attach($=>$, br: "SK")

#definition[
  The $"SK"$-combinator calculus consists of the following:
  - A *term* is defined recursively as either $K$ or $S$, and if $M, N$ are
    terms, so is $(M)$ and their *application* $M N$.
  - Evaluation: $M$ *reduces* to $N$, written $M #sk-imp N$, if their equality
    can be deduced from the following axioms.
    - *Base Axioms:* for all terms $A, B, P$:
      - $((K A) B) #sk-imp M$
      - $(((S A) B) P) #sk-imp (A P) (B P)$.
    - *Transitivity:* if $M_1 #sk-imp M_2$ and $M_2 #sk-imp M_3$, then
      $M_1 #sk-imp M_3$.
    - *Congruence:* if $M_1 #sk-imp M_2$ and $N_1 #sk-imp N_2$, then
      $M_1 N_1 #sk-imp M_2 N_2$.
]<foundations:SK-calculus>

Now, Welkin can be embedded into this calculus. We discuss this embedding at a
high level:

- Each unit @foundations:unit can be built from handles, or by finite
  combinations of pairs and representations. These can be represented as
  combinators through suitable encodings of positive integers and finite tuples,
  respectively. For more details, refer to
  @turner-applicative-languages-combinators.

- Each rule in @unit-rules are themselves finite, ranging over a finite number
  of meta-variables. These, too, can be encoded as combinators through if/else
  statements.

It remains to show that every combinator is included in this embedding. For
this, we prove the following. Our proof technique uses recursion within Welkin.

#theorem[Let $T$ be a term in the $"SK"$-combinator calculus. Then there is some
  unit $u$ such that $T = phi_u$.
]<foundations:turing-expressible>
#proof[
  We prove there is a unit $L$ that can generate a unit $u_T$ for each term of
  the $"SK"$ calculus. To this end, we use $K$ and $S$ to represent the
  corresponding combinators in @foundations:SK-calculus, as well as $M$, $N$,
  $P$ to represent meta-variables. With these, $L$ is defined with exactly the
  following:

  - $L - L -> *{K, S}$: recall that this is equivalent to $L - L -> K$ and
    $L - L -> S$. These units represent that $K$ and $S$, respectively, are
    terms.

  - $"*"{M, N, P} - L -> L$: recall that this is equivalent to $M - L -> L$,
    $N - L -> L$, and $P - L -> L$. Each of these represent meta-variables
    through @r:transitivity. For example, $M - L -> K$ holds, but also
    $M - L -> S$. In other words, $M$ can _potentially hold_ $K$ or $S$.

  - $L - {N - M -> L}$: composition $M N$ of two terms $M, N$ is represented as
    ${N - M -> L}$, which itself is a term.

  - ${N - {M - K -> L} -> L} - L -> M$: represents the reduction rule for $K$.

  - ${P - {N - {M - S -> L} -> L} -> L} - L -> {N - {M - K -> L} -> L}$:
    represents the reduction rule for $S$.

  We claim that $L$ represents $#sk-imp$. First, to prove closure under
  composition, suppose $L - L -> A$ and $L - L -> B$. Then by @r:transitivity,
  $M - L -> A$ and $N - L -> B$, so by @r:sign-congruence and
  @r:context-congruence, ${N - M -> L} - L -> {B - A -> L}$. Another application
  of @r:transitivity yields $L --> {B - A -> L}$. The rules $L --> K | S$ and
  $L - L -> {N - M -> L}$ are the only terms with sign $L$ (besides $L$ itself),
  so $L$ contains _exactly_ the terms in the SK-calculus.

  Second, the base axioms for $K$ and $S$ are already included, and transitivity
  is provided by @r:transitivity.

  Finally, @r:context-congruence entails term congruence: if $M - L -> M'$, then
  $N - M -> L$ represents $N - M' -> L$. Because $=>_"SK"$ and any term can be
  represented in $L$, this completes the proof.
]

Taken together, we have completed _one_ part of Goal 1 [LINK]. The other part
will be addressed in the next section.

== Queries and Information <foundations:queries-and-information>

By @foundations:turing-expressible, every partial computable can be expressed as
a unit. Additionally, in the construction used, reductions of terms are _also_
represented. This provides a ceiling on what queries we can _express_
computably. For more details, refer to @hopcroft-automata-theory[Ch. 1]. This
asks whether a representation is contained in a context.

#definition[
  Let $c$ and $q$ be units. A *query over* $c$ is the following question: does
  $q subset.eq.sq c$ hold?
]<foundations:query>

Certain queries are easy and rely on _direct definitions_. Consider, for
example, we can quickly verify that $p$ is in context ${p, q}$ using
@foundations:unit. However, in general, this will be uncomputable, due to
@foundations:turing-expressible. In fact, this problem is is $"RE"$-complete,
i.e., determining whether any Turing machine halts can be determined through a
query in Welkin.

Based on the uncomputability of general queries, what is a valid _certificate_
of a query? As it turns out, a valid derivation suffices.

#definition[
  Let $c$ and $q$ be units.

  - A *derivation over* $c$ is a unit ${u_1 - c -> u_2 ... - c -> u_n}$ such
    that each $u_i$ is either a) already in
  $c$, or b) an application of a rule in @unit-rules from previous units
  $u_1, ..., u_j$.
  - We say $u$ *contains information* about a query $q$ in context $c$ if it
    contains a derivation that ends with the unit ${q - c -> q}$. Moreovoer, we
    say it *is* information if it only contains derivations ending in
    ${q - c -> q}$.
]<foundations:information>

Our work in @metatheory proves that this definition is _complete_, or that _any_
proof accepted by a turing machine is accepted by Welkin.



