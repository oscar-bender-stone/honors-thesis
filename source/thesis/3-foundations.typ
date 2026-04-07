// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": matched-dash, tilde-prefix
#show math.minus: matched-dash
#show math.tilde: tilde-prefix

#import "template/ams-article.typ": label-table
#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": corollary, equation_block, lemma, theorem

#import "template/ams-article.typ": proof, proof-sketch
#import "template/ams-article.typ": induction, recursion
#import "template/ams-article.typ": end-def

= Foundations <foundations>

This section discuss the foundations of Welkin, outlined in
@foundations:overview.

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
    [Recursively defines units @foundations:unit as their rules
      (@table:unit-rules).],

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
- Each _Proof_ ends with a square ($square.stroked$).
- We frequently abbreviate "if and only if" as "iff".

== Words and Handles <foundations:words-and-handles>

For high-level notation, we write $a equiv b$ to mean that $a$ is definitionally
equivalent to $b$. High level notation will _not_ be stated in the syntax unless
where noted. We will be pedantic in most notation for complete precision.
Moreover, implementation details are outside the scope of this thesis. This
includes, e.g., practically restricting the size of user input to a maximum
bound.

#definition[
  A *bit* is either one of the symbols $0$ or $1$. A *binary word* is defined
  recursively: $epsilon$ is a word (the *empty word*), and if $w$ is a finite
  binary word, so are $w 0$ and $w 1$, where the juxtaposition of symbols denote
  *concatenation*. Nothing else is a word.
]<foundations:word>

We also require a notion of equality on bits. To ensure this is constructive, we
provide a _separate_ definition of inequality as well. The latter provides an
explicit certificate, a bit that shows how two words are distinct.

#let W-eq = math.attach($=$, br: "W")
#let W-neq = math.attach($!=$, br: "W")

#definition[
  Equality $#W-eq$ and inequality $#W-neq$ on words $w_1, w_2$ is defined
  recursively and as nothing else:
  - *Base case:* $epsilon #W-eq epsilon$.
  - *Recursive step:* suppose $w_1 #W-eq b_1w_1'$ and $w_2 #W-eq b_2w_2'$, where
    $b_1, b_2$ are bits and $w_1', w_2'$ are words. Then $w_1 #W-eq w_2$ if and
    only if $b_1, b_2$ are both $b_1 equiv 0 equiv b_2$ or
    $b_1 equiv 1 equiv b_2$, and $w'_1 #W-eq w'_2$. Moreover, $w_1 #W-neq w_2$
    if and only if $b_1$ and $b_2$ are distinct bits or $w'_1 #W-neq w'_2$.
]<foundations:binary-word-equality>

Words alone do not carry meaning. Instead, meaning is provided through
*handles*.

#definition[
  A *handle* is given by an *ID*, which is a word. The interpretation of a given
  handle is a free parameter, and therefore outside the scope of this language.
]<foundations:handle>

Because handles act as free parameters, we work with them through truth. Based
on this, the rest of the thesis will abstract away general units _as_ sets of
axioms.

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
    - A *representation* or *arc* $a - c -> b$, where $a$ is the *sign*, $c$ is
      the *context*, and $b$ is the *referent*. This is read as: $a$
      *represents* $b$ *in context* $c$.
]<foundations:unit>

#let derives = $prec.curly.eq$
#let derivedby = $prec.curly.eq$

We require more notation. First, we define $a <- c -> b$ to mean that both
$a - c -> b$ and $a <- c - b$ hold. Second, we add a symbol $prec.curly.eq$ for
*derives*, where $a derivedby g$ iff #box[$a - g -> a$]. The relation
$a derivedby g$ is read as either "$a$ is derived by $g$," or "$g$ derives $a$".

Now we may introduce the rules on units. These are provided in
@table:unit-rules, stated over stated over meta-variables $a, b, c, d, g$ for
units and $h_1, h_2$ for handles.

#let unit-rule-table = label-table(
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
        #box[${d - b -> g} prec.curly.eq c$]],
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
      name: "Derivation",
      lbl: "r:derivation",
      content: [
        #box[${a - g -> a} <- c -> {{g, a} <- c -> g}$]
      ],
    ),
    (
      name: "Idempotency",
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

#show figure: set block(breakable: true)
#figure(
  unit-rule-table,
  caption: "Set of all valid rules in Welkin.",
)<table:unit-rules>

We review the utility of each rule. Note @r:context-lift is the only rule
_between_ contexts; the rest is entirely user defined. Moreover, only
@r:transitivity, @r:sign-congruence, and @r:context-congruence are needed for
Turing completeness. However, the other rules are in place to help with
organizing units as modules, as well as make it easier to use the language.

- @r:transitivity ensures that each context is closed under transitivity. This
  makes it easier to reason _within_ a context. Truth systems with
  non-transitive rules can be expressed through combining contexts.
- *@r:pair-congruence\-@r:referent-congruence* enable the transfer of arcs onto
  pairs and other arcs.
- @r:context-lift was previously discussed in @design:mechanizing-information.
  This provides a mechanism to test the reliability of certain representations.
  That is, if $a$ represents $b$ in context $c$, then $a$ is a *surrogate* for
  $b$. This means that all representations contained in $a$ can be transferred
  onto $b$, _within_ $c$.
- @r:refine is explained as follows: suppose $a$ is a unit, and in a block, $a$
  represents two other units $b, d$. Then this block _represents_ ${a --> b}$
  and ${a --> d}$, separately. This provides a mechanism to _refine_ a general
  unit into a more specific one.
- *@r:empty\-@r:referent-null* define the behavior of the empty unit ${}$,
  similar to the empty set. @r:sign-null\-@r:referent-null specifically states
  that ${}$ contains _no_ representations. Thus, if a representation has a
  component that is ${}$, then it carries no meaning. This provides a mechanism
  to _exclude_ units in a context. This is useful for imposing invariants.
- @r:handle-eq enables equality in words and handles to pass through into
  representations. Besides this, note that equivalences on units are entirely
  user defined.
- @r:derivation characterizes $a prec.curly.eq g$ as ${g, a} <--> g$. This is
  closely related to the *semi-lattice* structure formed by units; refer to the
  point below.
- *@r:idempotent\-@r:commutativity* ensure that information can be repeated and
  arranged in any order. Together with @r:transitivity, this means that units
  have a *semi-lattice* structure, a term first introduced by Birkhoff
  @birkhoff-1967-lattice. Moreover, $prec.curly.eq$ is the corresponding partial
  order, which is a relation that is transitive ($x prec.curly.eq y$ and
  $y prec.curly.eq z$ entail $x prec.curly.eq z$) and reflexive
  ($x prec.curly.eq x$).

#remark[The rules in @table:unit-rules use few, independent meta-variables,
  which may be equal or distinct. This phenomena is called "bundling", and it
  appears in the proof checker MetaMath Zero for first-order logic @mm0[Sect.
    1.2.1]. In first-order logic, the statement
  $forall x. forall y. #h(0.1em) x = y$ has two different meanings, depending on
  whether $x$ and $y$ denote the same meta-variable. Presenting these meanings
  requires _two_ statements in first-order logic, and with slightly larger
  examples, this quickly explodes in size. All of this means that Welkin,
  similar to MetaMath Zero, achieves a significant level of compression.
  However, _direct_ conversions to tools based on first-order logic may not be
  feasible.
]

In addition to @table:unit-rules, we need a form of *containment*.

#definition[
  Let $u$ and $c$ be units. Then $u$ is *contained in* $c$, denoted
  $u subset.eq.sq c$, if, for some unit $v$, $c <--> {u, v}$.
]<foundations:containment>

One can easily verify that $u subset.eq.sq v$ implies $u derives v$.

Finally, we add more notation. We write:

- $"*"{a_1, ..., a_n} - c -> b$ for
  ${a_1 - c -> b, a_2 - c -> b, .., a_n - c -> b}$.
- $a - c -> "*"{b_1, ..., b_n}$ for ${a --> b_1, a --> b_2, .., a --> b_n}$.

Note that $"*"$ is officially defined in the grammar, refer to
@syntax:welkin-grammar.

== Turing Completeness <foundations:turing-completeness-section>

This section shows that Welkin is Turing complete. For background, there are
many resources, e.g., @sipser-theory-ofcomputation[Ch. 3].

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
mechanically through truth.
#footnote[
  In connection to linguistics, this is the difference between a formal
  semantics, what is stated in the language, and pragmatics, the intension or
  purpose of a term.]

At this point, we are concerned with showing _some_ $phi$ exists, necessary to
fulfill @universal (Universality). We are not concerned about efficiency; this
will be left for a future work, refer to @conclusion. To construct $phi$, we
want to create an embedding into the $"SK"$-combinator calculus. This is an
equational theory, first developed by Schönfinkel @schoenfinkel-combinators, and
independently discovered by Curry @curry-grundlagen. In this theory, a
*combinator* is a higher-order function: a function that takes in other
functions as inputs. #footnote[A remark for logicians: this calculus is
  extremely similar to a Hilbert-style proof system, with $K$ and $S$
  corresponding to the rules $(phi => (psi => phi))$ and
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
    can be deduced from the following axioms, defined over meta-variables
    $A, B, P, Q$:
    - *Base Axioms:*
      - $((K A) B) #sk-imp M$.
      - $(((S A) B) P) #sk-imp (A P) (B P)$.
    - *Transitivity:* if $A #sk-imp B$ and $B #sk-imp P$, then $A #sk-imp P$.
    - *Congruence:* if $A #sk-imp P$ and $B #sk-imp Q$, then $A B #sk-imp P Q$.
]<foundations:SK-calculus>

Now, Welkin can be embedded into this calculus. We discuss this embedding at a
high level:

- Each unit @foundations:unit can be built from handles, or by finite
  combinations of pairs and representations. These can be represented as
  combinators through suitable encodings of positive integers and finite tuples,
  respectively. For more details, refer to
  @turner-applicative-languages-combinators.

- Each rule in @table:unit-rules is finite, ranging over a finite number of
  meta-variables. These, too, can be encoded as combinators through if/else
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

  - $L - L -> "*"{K, S}$: recall that this is equivalent to $L - L -> K$ and
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
  of @r:transitivity yields $L --> {B - A -> L}$. The rules $L - L -> "*"{K, S}$
  and $L - L -> {N - M -> L}$ are the only terms with sign $L$ (besides $L$
  itself), so $L$ contains _exactly_ the terms in the SK-calculus.

  Second, the base axioms for $K$ and $S$ are already included, and transitivity
  is provided by @r:transitivity.

  Finally, @r:context-congruence entails term congruence: if $M - L -> M'$, then
  $N - M -> L$ represents $N - M' -> L$. Because $#sk-imp$ and any term can be
  represented in $L$, this completes the proof.
]

Taken together, we have completed one part of @universal. The other part will be
addressed in the next section.

== Queries and Information <foundations:queries-and-information>

By @foundations:turing-expressible, any Turing machine can defined by a unit.
Additionally, the construction _also_ represents reductions of terms. This
provides a ceiling on what queries we can express computably. For more details,
refer to @hopcroft-automata-theory[Ch. 1].

#definition[
  Let $c$ and $q$ be units. A *query over* $c$ is the following question: is $q$
  derived by $c$?]<foundations:query>

Certain queries are easy, particular those restricted to containment. Consider,
for example, we immediately have that $p subset.eq.sq c equiv {p, q}$, hence
$p prec.curly.eq c$. However, in general, this will be uncomputable, due to
@foundations:turing-expressible. In fact, this problem is is $"RE"$-complete,
i.e., determining whether any Turing machine halts can be determined through a
query in Welkin.

Although general queries are uncomputable, we can verify _certificates_. These
provide a specific derivation, which demonstrates a query is true or false. In
Welkin, this is exactly a derivation involving $q - c -> q$.

#definition[
  Let $c$ and $q$ be units.

  - A *derivation over* $c$ is a unit
    ${u_1 - c -> u_2, u_2 - c -> u_3, ..., u_(n-1) - c -> u_n}$ such that for
    each $u_i$, either a) $u_i$ is contained in $c$, or b) $u_i$ is an
    application of a rule in @table:unit-rules from previous units
    $u_1, ..., u_j$.
  - We say $u$ *contains information* about a query $q$ in context $c$ if it
    contains a derivation that ends with the unit ${q - c -> q}$. Moreover, we
    say it *is information* if it only contains derivations ending in
    ${q - c -> q}$.
]<foundations:information>

Our work in @metatheory proves that this definition is _complete_, or that _any_
proof accepted by a Turing machine is accepted by Welkin. Note that this is
possible thanks to contextual lifting (@r:context-lift). Additionally, this
enables proofs that certain queries are _not_ possible. Nevertheless, this
method is inherently incomplete, due to limitations in Turing machines. For more
details, consult @metatheory.



