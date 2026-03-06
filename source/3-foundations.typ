// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": matched-dash, tilde-prefix
#show math.minus: matched-dash
#show math.tilde: tilde-prefix

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": corollary, equation_block, lemma, theorem

#import "template/ams-article.typ": proof, proof-sketch

#let tilde-prefix = math.class(
  "unary",
  box(baseline: -20%, scale(75%, $tilde$)),
)
#show math.tilde: tilde-prefix

= Foundations <foundations>

This section discuss the foundations of Welkin, as follows:

+ We define units and their rules.
+ We prove there is a unit that indexes every other unit
  (@foundations:base-recursor).
+ We show that Welkin's base theory is equivalent to a weak fragment of
  arithmetic, $I Delta_0$. This section is optional.
+ We define queries.

== Base Rules

As high-level notation, we write $a equiv b$ to mean that $a$ is definitionally
equivalent to $b$. Note that $equiv$ will not be introduced in the syntax, see
@rationale:bootstrap. Moreover, we will distinguish between _defining_ a term as
finite and _practically enforcing_ it is finite. For a thorough discussion, see
?.

#definition[
  A *bit* is the symbols $0$ or $1$. A *binary word* is either the symbol
  $epsilon$ (the *empty word*), and if $w$ is a finite binary word, so are $w.0$
  and $w.1$, where $.$ is the symbol for *concatenation*. Nothing else is a
  word.
]<binary-word>

#definition[
  Equality $=$ and inequality $!=$ on words $w_1, w_2$ is defined recursively:
  - *Base case:* $epsilon = epsilon$.
  - *Recursive step:* suppose $w_1 = b_1.w_1'$ and $w_2 = b_2.w_2'$, where
    $b_1, b_2$ as bits and $w_1', w_2'$ are words. Then $w_1 = w_2$ if and only
    if $b_1 = b_2$ and $w'_1 = w'2$. Moreover, $w_1 != w_2$ if and only if
    $b_1 != b_2$ or $w'_1 != w'_2$.
]<foundations:binary-word-equality>
#remark[@foundations:binary-word-equality is given constructively to ensure that
  if two finite words are unequal, then an explicit bit can act as a certificate
  for this inequality.]

#definition[
  A _handle_ is given by a *key*, a triple $("UID", "RID", "HID")$, where
  $"UID"$ is a binary word called a *user ID*, $"RID"$ is a binary word called
  the *revision ID*, and $"HID"$ is a binary word called the *handle ID*. The
  interpretation of keys are left as free parameters, and therefore are outside
  the scope of this language.
]<foundations:handle>

#remark[
  Because handles act as free parameters, we work with them through truth. Based
  on this, the rest of the thesis will abstract away general units _as_ sets of
  axioms. Free parameters are used to define Welkin itself, however, see
  @syntax.
]

[TODO[SMALL]: without getting into typing, enforce that equality has to be done
on two words or two handles. Maybe lift to the latter to make sense?]
#definition[Consider two handles
  $h_1 equiv ("UID"_1, "RID"_1, "HID"_1), h_2 equiv ("UID"_2, "RID"_2, "HID"_2)$.
  - $h_1$ and $h_2$ are equal, written $h_1 = h_2$, if and only if
    $"UID"_1 = "UID"_2$, $"RID"_1 = "RID"_2$, and $"HID"_1 = "HID"_2$.
  - $h_1$ is not equal to $h_2$, written $h_1 != h_2$, if and only if at least
    one of the following hold: $"UID"_1 != "UID"_2$, $"RID"_1 != "RID"_2$, or
    $"HID"_1 != "HID"_2$.
]<foundations:handle-equality>

To simplify the use of handle equality, we will ensure all defined handles are
unique.

#definition[
  A *unit* is defined recursively as a finite combination of the following and
  nothing else:
  - A handle, see @foundations:handle.
  - A *block*, which is one of the following:
    - The symbol ${}$, the *empty block*.
    - Given a units $g, u$, ${g, u}$, ${@g, u}$, and ${@g, tilde.op u}$ are
      blocks, where $@g$ is a unit called the *expansion* of $g$ and $~u$ is
      called the *exclusion* of $u$.
  - A representation $a - c -> b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*. This is read as: $a$
    *represents* $b$ *in context* $c$.
]<foundations:unit>

We will intentionally _avoid_ defining equality on units and postpone this until
@foundations:base-recursor.

[TODO[SMALL]: make sure to define this notation $|$ recursively!]

As more notation, we write:

- $a - c -> b_1 | b_2 | ... | b_n$ to mean
  ${a - c -> b_1, a - c -> b_2, ..., a - c -> b_n}$.
- $a_1 | ... | a_n - c -> d$ to mean ${a_1 - c -> d, ..., a_n - c -> d}$.
- $q in c$ if $q - c -> q$.

This simplifies the presentation of the rules. We postpone formally defining the
operator $|$ to the syntax in @syntax.

[TODO[SMALL]: provide labels/links.]

[TODO[SMALL]: Clarify role of global context!]

#definition[
  The following rules apply, stated over meta-variables $a, b, c, d, g$ for
  units and $h_1, h_2$ for handles:
  - *R1. Internal Transitivity:* $a - c -> b$ and $b - c -> d$ imply
    $a - c -> d$.
  - *R2. Contextual Lifting:* $a - c -> b$ and $d - b -> g$ imply
    ${d - a -> g} - c -> {d - a -> g}$.
  - *R3. Empty:* ${@g, {}} <--> g$.
  - *R4. Membership:* ${@g, a} <--> g$ if and only if $a - g -> a$.
  - *R5. Identity:* ${a} <--> {a - a -> a} <--> a$.
  // NOTE: this does add arrows. For clarity,
  // could make this redundant and add a - g -> b here.
  - *R6. Expansion:* if $a - g -> b$, then ${@g, c} <-> {{{@g, a}, b}, c}$.
  - *R7. Exclusion:* if $g <--> {@g, a}$, then ${{@g, ~a}, b} <--> {@d, b}$.
  - *R8. Associativity:* ${a, {b, c}} <--> {{a, b}, c}$.
  - *R9. Commutativity:* ${{a, b}, c} <--> {{a, c}, b}$.
  - *R10. Null:* ${a - {} -> b} --> {}$.

  - *R11. Handle Substitution:* if handle $h_1$ is equal to handle $h_2$, then
    $h_1 <--> h_2$.

]<unit-rules>

We review the utility of each rule. Note that rules _between_ contexts is
entirely flexible and user defined. Moreover, only ? are needed for Turing
completeness. We will show, however, that the remaining axioms are optimal when
organizing information, see @information-organization.

- *R1* and *R2* were discussed in @rationale:unit.
- *R3* define the behavior of the empty unit ${}$, similar to the empty set.
- *R4* provides a way to represent $a in g$ through the representation
  $a - g -> a$. Because of this, $a - g -> a$ may be a non-trivial path, so it
  is _not_ required in every unit. Identity is expressed instead by
  ${a - a -> a}$, see the discussion below.
- *R5* reduces extraneous blocks. Note that this is _not_ the same thing as the
  Quine atom, which states ${a} = a$ in a set theoretic context
  @quine:new-foundations. We do _not_ mean $a in a$, but instead, ${a}$ is a
  _wrapper_ around $a$. While not useful for handles, it is for specifying
  blocks of representations, such as ${a - b -> c, b - c -> d}$.
- *R6* and *R7* define how imports in the language work. An *import* is the
  process of joining the contents of one unit into another. *R6* says how an
  import can add new units in a block. *R7* provides a mechanism to _exclude_
  specified contents in $g$, which can themselves be representations. For
  example, ${@{a - b -> c, d}, ~{a - b -> c}}$ reduces to ${d}$.
- *R8* and *R9* ensure that information can be repeated and is positionally
  invariant.
- *R10* provides a way to prevent representations in a block. We interpret this
  rule as stating: ${}$ contains nothing, so it cannot contain any
  representation, including $a - {} -> b$. We will use this rule to represent
  negation. Note that this is _distinct_ from exclusion, as the latter is
  restricted to imports.
- *R11* enables equality in handles to pass through into representations.
  Besides this, note that equivalences on units are _entirely_ user defined.


Before we proceed to prove Turing completeness, we introduce the
$"SK"$-combinator calculus. This is an equational theory that is well known to
be Turing complete @curry-grundlagen. We provide a full definition as follows.

#definition[
  The $"SK"$-combinator calculus consists of the following:

  - A *term* is defined recursively as either $K$ or $S$, and if $M, N$ are
    terms, so is $(M)$ and their *application* $M N$.
  - Evaluation: two terms $M, N$ are *equal*, written $M = N$, if they can be
    deduced from the following axioms:
    - *Base Rules:* for all terms $M, N, P$:
      - $K M N = M$
      - $S M N P = M P (N P)$.
    - *Congruence:* if $M_1 = M_2$ and $M_2 = N = 2$, then $M_1 M_2 = N_1 N_2$.
    - *Equivalence:* $=$ forms an equivalence relation, which means for all
      $M, N, P$:
      - $M = M$.
      - $M = N$ if and only if $N = M$.
      - $M = N$ and $N = P$ imply $M = P$.

]<foundations:sk-calculus>

[TODO[SMALLL]: create boxes for remarks and important notes?]

#theorem[Any partial computable function can be expressed as some unit.
]<turing-expressible>
#proof[
  We prove that we can embed any term in the $S K$-combinator calculus, defined
  in @foundations:sk-calculus. This proof includes an important technique to
  represent _recursion_,

  We express recursion via a unit $L$. For keys, we set:
  - $L equiv (1, 0, 0)$.
  - $K equiv (1, 0, 1)$, $S equiv (1, 0, 2)$.
  - $M equiv (1, 0, 3)$, $N equiv (1, 0, 4)$ $P equiv (1, 0, 5)$.

  For the rules, see @foundations:turing-expressible-L. Note that each rule of
  the form $A --> B$ written in $L$ means $A - L -> B$.
  #footnote[As a note for logicians: these rules are extremely similar to a
    Hilbert-style proof system, with $K$ and $S$ corresponding to the rules
    $(phi => (psi => phi))$ and
    $(phi => (psi => zeta)) => ((phi => zeta) => (psi => zeta))$, respectively.
    This was one of Curry's insights in connecting logic to computation
    @curry-grundlagen.]

  #figure(
    [
      $L equiv lr(
        \{
        (
          K --> L, S --> L,\
          {M --> L} --> L,\
          {N --> L} --> L,\
          {P --> L} --> L,\
          C <--> {N - M -> L},\
          C --> {M --> L},\
          C --> {N --> L},\
          {Y - {X - K -> L} -> L} - L -> X, \
          {P - {N - {M - S -> L} -> L} -> L} - L -> {{P - N -> L} - {P - M -> L} -> L}
        )
        \}
      )$
    ],
    caption: [Definition of $L$ [TODO: fix formatting!].],
  )<foundations:turing-expressible-L>

  This definition means:

  - $L$ includes $K$ and $S$ as base cases. We interpret $K - L -> L$ to mean
    $K$ is a term of $L$.
  - We include variables $M, N, P$ over terms. The statement
    ${M - L -> L} - L -> L$ wraps around any term.
  - Composition $M N$ is represented as $N - M -> L$. Moreover, compositions
    $M N$ can be broken down into its constituent parts $M, N$.

  - The remaining representations are for the rule of $K$ and $S$, respectively.

  Now, $L$ already includes the base rules for $K$ and $S$. It remains to be
  shown that $L$ is closed under composition: $M - L -> L$ and $N - L -> L$
  imply $C - L -> L$, where $C <--> (N - M -> L)$. By using *R1* on
  $C - L -> (M - L -> L)$ and $(M - L -> L) - L -> L$, we obtain $C - L -> L$,
  completing the proof.
]

== Base Recursor <foundations:base-recursor>

The proof of @turing-expressible demonstrates how contexts enable powerful
recursive definitions. However, the underlying construction is tedious and
results in extremely verbose terms. Keys are assigned manually, which can easily
be error prone. We will refine the proof with a *recursor* over units. This is a
unit that indexes every unit, as well as every handle.

The recursor needs to index through all possible keys. We first need to define a
unit to recurse over binary words; we provide a natural definition in
@foundations:bootstrap-binary-word.

[TODO[SMALL]: enforce that scopes create new names!] #figure(
  [
    $"bit" --> 0 | 1$

    $"word" <--> "empty" | {"top" --> "bit", "next" --> "word"}$
  ],
  caption: [Generator for words in Welkin.],
)<foundations:bootstrap-binary-word>

This is similar to the Lisp definition of a list. In detail:

- $"bit"$ represents $0$ or $1$.

- $"word"$ is recursively defined, as either $"empty"$ or the pair
  ${"top", "next"}$, where $"top"$ is a $"bit"$ and $"next"$ is a $"word"$.

We need to include equality as well, refer to @foundations:handle-equality:

[TODO[SMALL]]

#figure(
  [$"equality" <--> {\
    "0" <--> "0",\
    "1" <--> "1",\
    "0" <- {} -> "1",\
    "w1" | "w2" --> "word",\
    {"w1" <--> "w2"} <--> {"w1" <--> "empty" <--> "w2"} \
    | {}, \
    "h1" | "h2" --> "handle",\
  }$],
  caption: [Definitions of equality in Welkin.],
)<foundations:bootstrap-equality>

#lemma[
  @foundations:bootstrap-equality correctly implements equality. In particular,
  this definition expresses every word.
]
#proof[TBD.]

From there, we can define handle IDs through triples, see
@foundations:bootstrap-handle-id.

#figure(
  [
    $"handle" <--> {"UID" --> "word", "RID" --> "word", "HID" --> "word"}$
  ],
  caption: [Generator for handle keys in Welkin.],
)<foundations:bootstrap-handle-id>

Here, a $"handle"$ is simply a pair ${"UID", "RID", "HID"}$, where $"UID"$,
$"RID"$, $"HID"$ are words. This handles indexing all handles, _except_ for the
ones in the bootstrap. We will leave details about that in the bootstrap, see ?.
For now, we will assume new names are created with unique handles, all on a
fixed revision.

Now, in @unit-rules, we needed enough _separate_ meta-variables. To do this in
Welkin, we use representations of the form $"u" --> "unit"$. This appeared
frequently when defining terms in @turing-expressible.


[TODO[SMALL]: maybe separate with a different unit $"in"$ and $"contains"$? This
might be clearer to define monotonicity.] #definition[
  The *unit recursor* $"unit"$ includes all rules in @unit-rules, as well as the
  following in context $"unit"$:
  - $"handle" --> "unit"$, see @foundations:bootstrap-handle-id.
  - ${} | u | v | c --> "unit"$.
  - ${u - c -> v} --> "unit"$.
  - ${u, v} | {@u, v} | {@u, ~v} --> "unit"$.
  - *Monotonicity:*
    - $u --> {@u, v}$.
    - ${@u, v} - {} -> u$.
    - ${@u, ~v} --> u$.
    - $u - {} -> {@u, ~v}$.
]<foundations:recursor>

#remark[One interpretation of @foundations:recursor is defining the notion of
  _containment_ between units, so $"unit"$ could be written as $<$ in the
  language. Moreover, $"unit"$ acts as the _maximum_ of all units. Introducing
  monotoncitiy will be effective for optimizations, see
  @information-organization.]

The following statements are two parts of the same *Recursion theorem* for
Welkin. The first is straightforward; their proofs closely aligns with the
definitions written in the meta-language (English).

#lemma[*_(Correctness)._* For every unit $u$, $u - "unit" -> "unit"$.
]<foundations:recursion-correctness>
#proof[Fix the context to be $"unit"$. We proceed induction on units:
  - *Base case:* this is immediate, as ${}$ and all handles are included.
  - *Inductive step:* immediate; $"unit"$ includes representations $a - b -> c$,
    as well as cases for ${g, u}$, ${@g, u}$, and ${@g, ~u}$.
]<foundations:recursor-correctness>

The last part behind the Recursion theorem underlies why $"unit"$ is enough to
embed the Welkin inside itself.

#lemma[*_(Uniqueness)_* Suppose unit $T$ contains exactly $u - T -> u$ for each
  unit $u$. Then $T <- R -> R$.]<foundations:recursion-uniqueness>
#proof[
  Clearly $T - "unit" -> "unit"$, and $"unit" - "unit" -> T$ follows from
  observing that ${"unit" - "unit" -> T} in T$.
]

[TODO[MEDIUM]: clarify how $"unit"$ is a verifier!]

An important consequence of the recursion theorem is a basic form of
*reflection*. Most importantly, this theorem establishes that _any_ way to
characterize Welkin can be reduced to including the recursor $"unit"$. This
establishes that $"unit"$ is the _smallest_ set of foundations for Welkin. Note
that $"unit"$ acts as _both_ a recursive procedure _and_ verifier over units.

#theorem[*_(Base Reflection)._* Let $T$ be any unit extends $"unit"$. Then
  ${T --> "unit"} - "unit" -> "unit"$.]<foundations:base-reflection>
#proof[
  We proceed by induction, fixing the base to be $"unit"$.
  - *Base Case:* suppose $T$ is a unit exactly with the rules $u - T -> T$ for
    every unit $u$ and the rules in @unit-rules. Then by
    @foundations:recursion-uniqueness, $T <--> "unit"$, completing the base
    case.
  - *Inductive step:* suppose $T = {T', e}$ for a units $T', e$ where
    $T' --> "unit"$. Now, by monotonicitiy in $"unit"$, $T --> T'$, hence by
    transitivity, $T --> "unit"$.
]

== Equivalence to $I Delta_0$

To compare Welkin against other theories, we show Welkin can be translated to
$I Delta_0$, a weak fragment of arithmetic, and vice versa. This subsection is
optional.

[TODO[MEDIUM]: make this more rigorous. ]
#lemma[
  The "unit" recursor is definable in $"I" Delta_0$.
]
#proof-sketch[
  First, we argue that the inductive definitions can be written in $I Delta_0$.
  Clearly every handle can be expressed, indexing each triple of functions with
  Cantor's pairing function, sending triples $("UID", "RID", "HID")$ to natural
  numbers. Similarly, representations can be indexed by a pairing argument. It
  remains to show that blocks can be defined as well. We claim that an extended
  pairing function can be made that is defined inductively. [TODO: define this
  function!]

  Second, it can be easily shown that each rule in @unit-rules are definable by
  induction, in at most 5 variables.
]

#lemma[
  Welkin can embed Robinson Arithmetic as a unit.
]
#proof[
  [TODO[MEDIUM]]
]

#theorem[
  Welkin proves that $"unit"$ and $I Delta_0$ are equivalent.
]
#proof[
  [TODO[MEDIUM]: explain how combinators can be used here to simplify the use of
  quantifiers.]
]

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




