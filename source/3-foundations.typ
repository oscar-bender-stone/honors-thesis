// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": matched-dash, tilde-prefix
#show math.minus: matched-dash
#show math.tilde: tilde-prefix

#import "template/ams-article.typ": rule-table
#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": corollary, equation_block, lemma, theorem

#import "template/ams-article.typ": proof, proof-sketch
#import "template/ams-article.typ": end-def
= Foundations <foundations>

This section discuss the foundations of Welkin, as follows:

+ We define words and handles.
+ We define units and their rules.
+ We prove there is a unit that indexes every other unit
  (@foundations:base-recursor).
+ We define queries.


After the base rules, our goal will be to define _as much_ in Welkin as
possible. Definitions will be gradually given in the language.

As a convention, each *Definition* and *Remark* ends with a triangle
($#end-def$). Proofs end with a square ($square.stroked$). We frequently
abbreviate "if and only if" as "iff".

== Words and Handles

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
  handle is a free parameter, and therefore are outside the scope of this
  language.
]<foundations:handle>

Because handles act as free parameters, we work with them through truth. Based
on this, the rest of the thesis will abstract away general units _as_ sets of
axioms. Certain interpretations are used to define Welkin's syntax. For example,
words can be interpreted as handles without external meaning; see @syntax.

Now, we can define equality and inequality between handles. We will reserve $=$
and $!=$ for handles, respectively.

#definition[Consider two handles $h_1$, $h_2$, and let $"ID"_1$ and $"ID"_2$ be
  there their respective IDs. Then:
  - $h_1$ is equal to $h_2$, written $h_1 = h_2$, if and only if
    $"ID"_1 #W-eq "ID"_2$.
  - $h_1$ is not equal to $h_2$, written $h_1 != h_2$, if and only if
    $"ID"_1 #W-neq "ID"_2$.
]<foundations:handle-equality>

== Units

Now we can define units. Roughly, units are finite combinations of handles and
representations. We present the complete definition as follows.

#definition[
  A *unit* is defined recursively as follows and nothing else:
  - *Base case:*
    - The symbol ${}$, the *empty block*.
    - A handle, see @foundations:handle.
  - *Recursive step:* let $u, v, g$ be units and $h$ a handle. Then any finite
    combination of the following are also units:
    - ${u, v}$, the *pair* of $u, v$.
    - $h {u}$, called a *named unit*.
    - $g.v$, a *path*.
    - A *representation* $a - c -> b$, where $a$ is the *sign*, $c$ is the
      *context*, and $b$ is the *referent*. This is read as: $a$ *represents*
      $b$ *in context* $c$.
]<foundations:unit>

We add $a <--> b$ as a shorthand for $a --> b$ and $a <-- b$; this is formally
defined in @syntax. Moreover, we add a symbol $subset.sq.eq$ for *containment*,
where $a subset.eq.sq g$ iff #box[${g, a} <--> a$]. When writing _in_ the
language, we will prefer the latter form, but we will add a unit corresponding
to $subset.eq.sq$ later on, see ?.

[TODO: fix wrapping of long table! Want to make this clearer!]

// TODO: maybe provide technique for unused imports?
// Might JUST want to have for later, not have as part of unit.
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
        content: [${g, {}} <--> g$],
      ),
      (
        name: "Sign Absorption",
        lbl: "r:sign-null",
        content: [${{} - a -> b} --> {}$],
      ),
      (
        name: "Context Absorption",
        lbl: "r:context-null",
        content: [${a - {} -> b} --> {}$],
      ),
      (
        name: "Referent Absorption",
        lbl: "r:referent-null",
        content: [ ${a - b -> {}} --> {}$],
      ),
      (
        name: "Handle Equality",
        lbl: "r:handle-eq",
        content: [If $h_1 = h_2$, then
          $h_1 <--> h_2$],
      ),

      (
        name: "Identity",
        lbl: "r:identity",
        content: [$a <--> {a - a -> a}$],
      ),

      (
        name: "Singleton",
        lbl: "r:singleton",
        content: [
          $a <--> {a}$
        ],
      ),

      // TODO: make this more accurate!
      // We could always add an alias,
      // so what do we _want_ from field access?
      (
        name: "Field",
        lbl: "r:field-access",
        content: [
          ${a - c -> b} subset.eq.sq c$ implies $c.a - c.d -> c.b$
        ],
      ),
      (
        name: "Idempotentcy",
        lbl: "r:idempotent",
        content: [${a, a} <--> {a}$],
      ),
      (
        name: "Associativity",
        lbl: "r:associativity",
        content: [${a, {b, c}} <--> {{a, b}, c}$],
      ),
      (
        name: "Commutativity",
        lbl: "r:commutativity",
        content: [${a, b} <--> {b, a}$],
      ),
    ),
  )
  #figure(
    unit-rule-table,
    caption: "Set of all valid rules in Welkin.",
  )<table:unit-rules>

]<unit-rules>

We review the utility of each rule. Note that rules _between_ contexts is
entirely flexible and user defined. Moreover, only @r:transitivity,
@r:sign-congruence, and @r:context-congruence are needed for Turing
completeness. However, the other rules are in place to help with organizing
units as modules, as well as make it easier to use the language.

[TODO: refer to rules with ranges when appropriate! Much nicer.]

- @r:pair-congruence, @r:transitivity, @r:sign-congruence,
  @r:context-congruence, @r:referent-congruence, @r:context-lift were discussed
  in @rationale:unit.[TODO: maybe review the discussion from earlier? Might be
  useful to reinforce main ideas to reader.]
- @r:refine is explained as follows: suppose $a$ is a unit, and in a block, $a$
  represents two other units $b, d$. Then this block _represents_ ${a --> b}$
  and ${a --> d}$, separately. This provides a mechanism to _refine_ a general
  unit into a more specific one.
//- @r:distribute is used to apply a context over a combination of units. The more
//  verbose form ${a - d -> b} - c -> {a - d -> b}$ is included once, primarily
//  for readability in text. However, we will prefer $c { a - c -> b}$ for
//  brevity. We say that $c$ *owns* (a copy of) $a - c -> b$. See @syntax for more
//  details.
- @r:empty, @r:sign-null, @r:context-null, and @r:referent-null define the
  behavior of the empty unit ${}$, similar to the empty set. @r:sign-null and
  the like specifically states that ${}$ contains _no_ representations. Thus, if
  ${}$ is involved in _any_ representation, it is equivalent to ${}$. In other
  words,representations built from ${}$ carry no meaning. This provides a
  mechanism to _exclude_ units in a context, which we will need for the
  verifier, see @foundations:verify.
- @r:handle-eq enables equality in words and handles to pass through into
  representations. Besides this, note that equivalences on units are entirely
  user defined.
- @r:identity represents identity. Users can take other representations, like
  $a - g -> a$, to be _distinct_ from identity.
- @r:singleton reduces extraneous blocks. Note that this is _not_ the same thing
  as the Quine atom, which states ${a} = a$ in a set theoretic context
  @quine:new-foundations. We interpret ${a}$ as a _wrapper_ around $a$. While
  not useful for handles, it is for specifying blocks of representations, such
  as ${a - b -> c, b - c -> d}$.
- @r:field-access provides a way to access specific units in a scope. The
  notation is entirely inspired by object oriented programming. This style of
  programming has _objects_ that can have data (fields) and functions (methods).
  Note that this is in _one_ direction
- @r:idempotent, @r:associativity, and @r:commutativity ensure that information
  can be repeated and arranged in any order.

As more notation, we write:

- $a - c -> b_1 | b_2 | ... | b_n$ to mean
  ${a - c -> b_1, a - c -> b_2, ..., a - c -> b_n}$.
- $~a$ to mean ${a --> {}}$.
- $*{a_1, ..., a_n} --> b$ means ${a_1 --> b, a_2 --> b, .., a_n --> b}$.

This condenses many definitions. We postpone formally defining the operators $|$
and $~$ to the grammar in @syntax. Moreover, we allow an extra $|$ at the start
or end, e.g., #box($a - c -> | b_1 | b_2$) is synonymous with
$a - c -> b_1 | b_2$. This is useful to break long definitions into separate
lines.

Before we proceed to prove Turing completeness, we introduce the
$"SK"$-combinator calculus. This is an equational theory that is well known to
be Turing complete @curry-grundlagen. As a simplification, we present the
calculus using a *reduction relation* instead of equality.

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

We are now ready to prove the following.

#theorem[Any Turing machine can be represented by some unit.
]<turing-expressible>
#proof[
  We prove that we can embed any term in the $S K$-combinator calculus, defined
  in @foundations:SK-calculus. This proof includes an important technique to
  represent _recursion_, expressed through a unit $L$. For handle IDs, we set:
  - $"ID"_L equiv 0$.
  - $"ID"_K equiv 1$, $"ID"_S equiv 2$.
  - $"ID"_M equiv 3$, $"ID"_N equiv 4$, $"ID"_P equiv 5$.
  Note that these IDs will be reused after this lemma. These are shown to
  demonstrate they _can_ be generated manually.

  For the rules, see @foundations:turing-expressible-L. Note that each rule of
  the form $A --> B$ written in $L$ means $A - L -> B$.
  #footnote[A remark for logicians: these rules are extremely similar to a
    Hilbert-style proof system, with $K$ and $S$ corresponding to the rules
    $(phi => (psi => phi))$ and
    $(phi => (psi => zeta)) => ((phi => zeta) => (psi => zeta))$, respectively.
    This was one of Curry's insights in connecting logic to computation
    @curry-grundlagen.]


  #figure(
    [
      $
        L equiv {
          #align(left)[
            $ L -> K | S, $
            \
            $ M | N | P -> L, $
            \
            $ L -> {N - M -> L}, $
            \
            $ {N - {M - K -> L} -> L} -> M, $
            \
            $ {P - {N - {M - S -> L} -> L} -> L} $
            \
            $ #h(2em) -> {{P - N -> L} - {P - M -> L} -> L} $
          ]
        }
      $
    ],
    caption: [Definition of $L$ [TODO: fix formatting!].],
  )<foundations:turing-expressible-L>

  This definition means:

  - $L$ includes $K$ and $S$ as base cases. Recall that $K | S --> L$ is
    equivalent to $K --> L$ and $S --> L$. We interpret $K --> L$ to mean $K$ is
    a term of $L$.
  - We include variables $M, N, P$ over terms.
  - Composition $M N$ is represented as $N - M -> L$.
  - The remaining representations are for the rules of $K$ and $S$,
    respectively.

  We claim that $L$ represents $#sk-imp$.

  - First, to prove closure under composition, suppose $L --> A$ and $L --> B$.
    Then by @r:transitivity, $M --> A$ and $N --> B$, so by @r:sign-congruence
    and @r:context-congruence, ${N - M -> L} --> {B - A -> L}$. Another
    application of @r:transitivity yields $L --> {B - A -> L}$. The rules
    $L --> K | S$ and $L --> {N - M -> L}$ are the only terms with sign $L$
    (besides $L$ itself), so $L$ contains _exactly_ the terms in the
    SK-calculus.

  - Second, the base axioms for $K$ and $S$ are already included, and
    transitivity is provided by @r:transitivity.
  - Finally, @r:context-congruence entails term congruence: if $M --> M'$, then
    $N - M -> L$ represents $N - M' -> L$. This completes the proof.
]

== The Unit Recursor <foundations:base-recursor>

The proof of @turing-expressible demonstrates how contexts enable powerful
recursive definitions. However, the underlying construction is tedious and
results in verbose terms. IDs are assigned manually, which can easily be error
prone. We will refine the proof with a *recursor* over units. This is a unit
that indexes every unit, as well as every handle. We gradually build this
recursor from smaller parts; specific handles are only assigned in the
bootstrap, see ?.

First, we need to establish some default units in the global context:

- The `welkin` unit. This is defined in @bootstrap-document.

- The `draft` unit, contained in `welkin`. This will be used for the user's
  current unit.

The rest of this thesis will take place in the `welkin` module except where
noted.

Now, we present @foundations:bootstrap-binary-word.

#figure(
  [
    $"epsilon",$

    $"bit" --> 0 | 1,$

    $"word" --> "epsilon" | {"top" --> "bit", "next" --> "word"}$
  ],
  caption: [Generator for words in Welkin.],
)<foundations:bootstrap-binary-word>

This is similar to the Lisp definition of a list. In detail:

- $"epsilon"$ represents the empty word.

- $"bit"$ represents $0$ or $1$.

- $"word"$ is recursively defined, as either $epsilon$, or the pair
  ${"top", "next"}$, where $"top"$ is a $"bit"$ and $"next"$ is a $"word"$.

Note that we do _not_ want $"epsilon" --> {}$, since ${}$ is primarily used to
restrict representations.

#example[
  Consider the word $010$. We can derive this form from $"word"$ by applying
  @r:referent-congruence and @r:refine together:
  $
    "word" &-> "epsilon" | {"top" -> "bit", "next" -> "word"} \
    &-> {"top" -> 0, "next" -> {"top" -> "bit", "next" -> "word"}} \
    &-> {"top" -> 0, "next" -> {"top" -> 1, "next" -> {"top" -> 0, "next" -> "epsilon"}}.
  $
]

From there, we can define handle IDs through triples, see
@foundations:bootstrap-handle-id.

#figure(
  [
    $"handle" --> {"ID" --> "word"}$
  ],
  caption: [Generator for handle keys in Welkin.],
)<foundations:bootstrap-handle-id>

Here, a $"handle"$ is a wrapper around an $"ID"$, which is a word.

We need to include equality as well, refer to @foundations:bootstrap-equality.

[TODO: make sure to enforce closed definitions here! Very important for
equality!]

[TODO: explained closed definitions, i.e., the $:=$ syntax!]

#figure(
  [$"equals" := {\
    "*"{"b1", "b2"} --> "bit",\
    {"b1" <--> "b2"} &<--> {"b1" <--> "0" <--> "b2"} \
    &| {"b1" <--> "1" <--> "b2"}, \
    ~{{"b1" <--> "b2"} &<--> {{"b1", "b2"} <--> {"0", "1"}}}, \
    "*"{"w1", "w2"} --> "word",\
    {"w1" <--> "w2"} &<--> {"w1" <--> "epsilon" <--> "w2"} \
    &| {"w1.top" <--> "w2.top", "w1.next" <--> "w2.next"}, \
    "*"{"h1", "h2"} --> "handle",\
    {"h1" <--> "h2"} &<--> { "h1.ID" <--> "h2.ID" },\
  }
  }$],
  caption: [Definitions of equality in Welkin. [TODO: fix formatting!]],
)<foundations:bootstrap-equality>

[TODO: maybe make proof here more precise?]

To show these constructions are correct, we must prove the following.

#lemma[
  Let $"h1"$ and $"h2"$ be handles, so that $"handle" --> "h1"$ and
  $"handle" --> "h2"$. Then $"h1" <- "equals" -> "h2"$ if and only if
  $"h1" = "h2"$.
]<foundations:bootstrap-equality-correctness>
#proof[Clearly it is sufficient to show that equality on words is correct. To do
  so, we apply a simple proof by induction:
  - *Base case:* immediate.
  - *Inductive step:* correctly handles the the cases for $"top"$ and $"next"$.
]

With handles established, we may proceed to defining the unit recursor. We reuse
an important technique from the proof in @turing-expressible: representing
meta-variables using $u --> c$, where $c$ is the overarching context. #footnote[
  [TODO: discuss how we are allowing the variables to be the same or different!
  Related to bundling in MetaMath + MetaMath Zero [and cite these!].]
]

// TODO: what if we want to do cases? Probably need to address! Important!
#definition[
  The *unit recursor* $"unit"$ include exactly the following rules in context
  $"unit"$:
  - $"unit" --> {}$
  - $"unit" --> "handle"$, see @foundations:bootstrap-handle-id.
  - $"*"{u, v, c} --> "unit"$, which means $u, v, c$ are meta-variables over
    units.
  - $"unit" --> {u, v}$.
  - $"unit" --> {u - c -> v}$.
]<foundations:recursor>

Proving correctness is straightforward and closely aligns with
@foundations:unit.

#lemma[*_(Recursor Correctness)._* For every unit $u$, $u - "unit" -> "unit"$.
]<foundations:recursion-correctness>
#proof[We proceed induction on units:
  - *Base case:* by definition, $"unit" - "unit" -> {}$. Additionally, for each
    handle $h$, $"handle" --> h$, so by @r:transitivity, $"unit" - "unit" -> h$,
    as required.
  - *Inductive step:* there are two cases.
    - *Pairs:* let $a$ and $b$ units, and suppose $"unit" --> a$ and
      $"unit" --> b$, respectively. Then, by @r:refine multiple times, we can
      restrict our attention to $"unit" {u --> a, v --> b, "unit" --> {u, v}}$.
      Applying @r:pair-congruence twice, for $a$ and $b$, shows that
      ${u, v} - "unit" -> {a, b}$, hence by @r:transitivity,
      $"unit" - "unit" -> {a, b}$.
    - *Representations:* similar to the case above, except this uses the
      congruence rules @r:sign-congruence, @r:context-congruence, and
      @r:referent-congruence.
]<foundations:recursor-correctness>

Now, for the rest of the thesis (except the bootstrap), we will drop mentions of
specific handles. These will all be facilitated by $"unit"$. For brevity, we
will write $u --> "unit"$. Notice that this form implies $u - "unit" -> "unit"$,
based on @r:identity and @r:transitivity.

== Base Verifier

Now we will includle a notion for containment. Because Welkin is Turing
expressible, $"unit"$ may not terminate in all cases, such as an infinite
recursive loop. We want to have a mechanism to _check_ certain claims. This is
the role of the verifier.


First, we need to express $subset.eq.sq$. We do this with the unit called
$"part"$.

[TODO: explain that, when saying "defined", implies a *closed* definition! Or
otherwise use figures from here on out. Maybe say "nothing else" to be clearer?]

#definition[
  The unit $"part"$ is defined over units $u, v --> "unit"$:
  - $u --> {@u, v}$.
  - $~{{@u, v} --> u}$.
  - ${@u, ~v} --> u$.
  - $~{u --> {@u, ~v}}$.
]<foundations:bootstrap-in>

[TODO: probably need a negated version as well, just like with word inequality!]

#lemma[$u - "part" -> u'$ iff $u - u' -> u$.]
#proof[
  We proceed by structural induction on units, or $u | u' - "unit" -> "unit"$:
  - *Base case:* we need to prove ${{} - "part" -> u'$ if and only if
    ${} - u' -> {}$.
    - *Base case:* For $u' equiv {}$, clearly both are false.
    - *Inductive step:* There are three cases:
      - *Representations:* immediate.
      - *Expansions:* .
  - *Inductive step:* similar to the base case. [TODO: complete this proof! But
    it is straightforward.]
]<foundations:in-correctness>

Next, we need to express the rules inside Welkin.

#definition[
  The $"rules"$ unit is defined as exactly the things below, over
  $a | b | c | d | g --> "unit"$ and $"h1"| "h2" --> "handle"$. The overarching
  context is $"rules"$.
  - $"R1" <--> {{a - c -> b}, {b - c -> d}} --> {a - c -> d}$
  - $"R2" <--> {{a - c -> b} --> {{a, d} - c -> {b, d}}}$
  - $"R3" <--> {{a - c -> b} --> {{a - g -> d} - c -> {b - g -> d}}}$
  - $"R4" <--> {{a - c -> b} --> {{d - a -> g} - c -> {d - b -> g}}}$
  - $"R5" <--> {{a - c -> b} --> {{d - g -> a} - c -> {d - g -> b}}}$
  - $"R6" <--> {{a - c -> b}, {d - a -> g}} --> {{a - d - g} - "part" -> c}}$
  - $"R7" <--> {{a - c -> b, a - c -> d} --> {a - c -> b}}$
  - $"R8" <--> {{g, {}} <--> g}$
  - $"R9" <--> {{{} - a -> b} --> {}}$
  - $"R10" <--> {{a - {} -> b} --> {}}$
  - $"R11" <--> {{a - b -> {}} --> {}}$
  - $"R12" <--> {{a - {} -> b} <--> {}}$
  - $"R13" <--> {{"h1" <- "equals" -> "h2"} -> {"h1" <--> "h2"}}$
  - $"R14" <--> {a <--> {a - a -> a}}$
  - $"R15" <--> {a <--> {a}}$
  - $"R16" <--> {{{a - c -> b} - "part" -> c} --> {c.a - c.d -> c.b}}$
  - $"R17" <--> {{a, {b, c}} <--> {{a, b}, c}}$
  - $"R18" <--> {{a, b} <--> {b, a}}$
]

#lemma[
  Each of the rules in $"rules"$ is embedded correctly.
]<foundations:rules-correctness>
#proof[
  TBD (mostly tedious).
]

[TODO: decide whether to convert list defs into single equations.]


Finally, we can define the verifier entirely in Welkin. Add new handles
$"accept"$ and $"reject"$, as well as the following unit $"claim"$:

$"claim" <--> {\
  "context" &--> "unit",\
  "query" &--> {"unit" - "unit" -> "unit"},\
  "derivation" &--> "unit"\
}$

[TODO: deal with recursion! Need to ensure it halts! And make sure to establish
a clear induction scheme! And maybe add a pair to store the context and target?
Fill in $\_$!]


#definition[
  The unit $"verify"$ is defined over meta-variables
  $c | u | v | g | d --> "unit"$ and sets $"query" <--> {u - g -> v}$:
  - *Base case:* if $d$ is empty or a handle, then
    ${"context" --> c, "target" --> {a - d -> b}, "derivation" --> p} - "verify" -> "accept"$
    if and only if $d <--> a <--> d <--> b$.
  - *Recursive step:*. suppose $p equiv {p', e - f -> g}$. Then
    ${p,_} - "verify" -> "accept"$ if and only if $p'$ is accepted in context
    $$. [TODO: get the end of $p'$ and wrap it up in the context and target. See
    if that's accepted. Then, add on an extra step and see if it's valid.]
]<foundations:verify>

#lemma[
  For all contexts $c$, targets ${a - b -> d}$, and derivations $p$,
  $"verifier"$ is *sound*; it correctly identifies if $p$ is a derivation of
  ${a - b -> d}$ in $c$.
]<foundations:verifier-correctness>
#proof[
  TBD[FINISH full inductive proof!]
]
Note that this verifier, as simple as it is, will _not_ limit what proofs can be
expressed. We prove this in @metatheory:complete-proof-expressivity.

== Queries and Information

By @turing-expressible, every partial computable can be expressed as a unit.
Additionally, in the construction used, reductions of terms are _also_
represented. This provides a ceiling on what queries we can _express_
computably. For more details, refer to @hopcroft-automata-theory[Ch. 1]. This
asks whether a representation is contained in a context.

#definition[
  Let $c$ be a context. Then a *query over $c$* is a question over fixed units
  $p, q, d$:
  #quote[
    Does ${p - q -> d} - "unit" -> c$ hold?
  ]
]<foundations:query>

We can then apply $"unit"$ in an attempt to evaluate this. In some cases, this
is easy and only uses _direct definitions_. Consider, for example, examining $p$
in context ${p, q}$. We can resolve this with a quick traversal, showing that
$p$ is in fact in ${p, q}$. However, @turing-expressible implies that finding
general derivations are uncomputable.

We want information to _resolve_ a query. Formally, we want information to be
_proof_, not a "yes/no" answer by itself. When the context is finite, like
${p, q}$, there is a direct proof. But what about the general case? Some queries
may reduce _forever_. While we cannot determine _which_ ones reduce to ${}$ or
not, we _can_ find the ceiling of proofs expressible by computable functions.
This process is more involved and is the subject of the next section.

[TODO[MEDIUM]: make this definition self-contained! The goal is to show that
this _is_ complete. That should be independent of the next section!]

#definition[
  *Information* about a query $q$ in context $c$ is a any partial meta-proof in
  $"meta"$ of a derivation of ${@c, q}$.
]<foundations:information>




