// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": matched-dash, tilde-prefix
#show math.minus: matched-dash
#show math.tilde: tilde-prefix

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": (
  corollary, equation_block, lemma, proof, theorem,
)


#let tilde-prefix = math.class(
  "unary",
  box(baseline: -20%, scale(75%, $tilde$)),
)
#show math.tilde: tilde-prefix

= Foundations <foundations>

This section discuss the foundations of Welkin, as follows:

+ We define units and their rules.
+ We define information.

== Base Rules

As high-level notation, we write:

- $a equiv b$ to mean that $a$ is definitionally equivalent to $b$.

- $not P$ means that assertion $P$ does not true.

Note that this will not be defined in the syntax, see @rationale:bootstrap.
Moreover, we will distinguish between _defining_ a term as finite and
_practically enforcing_ it is finite. For a thorough discussion, see ?.

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
  the *revision ID*, and $"HID"$ is a binary word called the *handle ID*.
]<foundations:handle>

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

#definition[
  A *unit* is defined recursively as a finite combination of the following and
  nothing else:
  - A handle, see @foundations:handle.
  - A *block*, which is one of the following:
    - The symbol *{}*, the *empty block*
    - Given a units $g, u$, ${g, u}$, ${@g, u}$, and ${@g, tilde.op u}$ are
      blocks, where $@g$ is a unit called the *expansion* of $g$ and $~u$ is
      called the *exclusion* of $u$.
  - A representation $a - c -> b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*.
]<foundations:unit>

[TODO[SMALL]: make sure to define this notation $|$ recursively!]

For notation, we will set $a - c -> b | d$ to mean ${a - c -> b, a - c -> d}$,
and $a | b - c -> d$ to mean ${a - c -> d, b - c -> d}$. This simplifies the
presentation of the rules; we postpone introducing the operator $|$ into the
syntax until @syntax. Moreover, we write $q in c$ to mean $q - c -> q$. Notice
that many-to-many relationships are allowed.

[TODO[SMALL]: provide labels/links.]

[TODO[SMALL]: Clarify role of global context!]

#definition[
  The following rules apply, stated over meta-variables $a, b, c, d, g$:
  - *R1. Internal Transitivity:* $a - c -> b$ and $b - c -> d$ imply
    $a - c -> d$.
  - *R2. Contextual Lifting:* $a - c -> b$ and $d - b -> g$ imply
    ${d - a -> g} in c$.
  - *R3. Empty:* ${@g, {}} <--> g$.
  - *R4. Membership:* ${@g, a} <--> g$ if and only if $a - g -> a$.
  - *R5. Identity:* ${a} <--> {a - a -> a} <--> a$.
  // NOTE: this does add arrows. For clarity,
  // could make this redundant and add a - g -> b here.
  - *R6. Expansion:* if $a - g -> b$, then ${@g, c} <-> {{{@g, a}, b}, c}$.
  - *R7. Exclusion:* if $g <--> {@g, a}$, then ${{@g, ~a}, b} <--> {@d, b}$.
  - *R8. Associativity:* ${a, {b, c}} <--> {{a, b}, c}$.
  - *R9. Commutativity:* ${{a, b}, c} <--> {{a, c}, b}$.
  - *R10. Null:* ${a - {} -> b} <--> {}$.
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
- *R8-R9* ensure that information can be repeated and is positionally invariant.
- *R10* provides a way to prevent representations in a block. We interpret this
  rule as stating: ${}$ contains nothing, so it cannot contain any
  representation, including $a - {} -> b$.

// [TODO[SMALL]: note importance of using axioms to define essentially bound/free
// variables! Not as easy with just assuming sets as they are; easier to express
// the tree structure *first*.]

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
  - $L equiv (1, 0, 0)$
  - $K equiv (1, 0, 1)$
  - $S equiv (1, 0, 2)$
  - $M equiv (1, 0, 3)$
  - $N equiv (1, 0, 4)$
  - $M equiv (1, 0, 5)$

  For the rules, see @foundations:turing-expressible-L. Note that each rule of
  the form $A --> B$ written in $L$ means $A - L -> B$.
  #footnote[As a note for logicians: these rules are extremely similar to a
    Hilbert-style proof system, with $K$ and $S$ corresponding to the rules
    $(phi => (psi => phi))$ and
    $(phi => (psi => zeta)) => ((phi => zeta) => (psi => zeta))$, respectively.
    This was one of the important insights clarified by Curry, in connecting
    logic to computation @curry-grundlagen.]

  [TODO[SMALL]: fix formatting!]

  [TODO[SMALL]: clarify on global representations!]

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
    caption: [Definition of $L$.],
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
  imply $C - L -> L$, where $C <--> (X - Y -> L)$. By using *R1* on
  $C - L -> (M - L -> L)$ and $(M - L -> L) - L -> L$, we obtain $C - L -> L$,
  completing the proof.
]

== Base Recursor

The proof of @turing-expressible demonstrates how contexts enable powerful
recursive definitions. However, the underlying construction is tedious and
results in extremely verbose terms. Keys are assigned manually, which can easily
be error prone. We will refine the proof with a *recursor* over units. This is a
unit that indexes every unit, as well as every handle.

An important part of the $S K$-calculus is composition, the ability to gradually
build up terms. We wish to replicate this by ensuring our recursion maintains an
increasing containment relation. Containment is defined below.

#definition[The relation $u_1$ is *contained in* $u_2$, denoted $u_1 < u_2$, is
  defined recursively:
  - *Base case:* for all units $u, v$:
    - $not(u < {})$.
    - if $u != v$, then ${u} < {u, v}$.
  - *Recursive step:* given units $u_1$ and $u_2 equiv {@g_1, a_2}$, $u_1 < u_2$
    if and only if either $u_1 < @g_1$, or for some $b in g$,
    $u_1 < {{@g_1, ~b}, a}$.
]<foundations:unit-containment>

// #definition[Two units $u_1, u_2$ are *extensionally equal* if for all $p, q$,
//   $p - u_1 -> q$ if and only if $p - u_2 -> q$.]<foundations:unit-equality>

The recursor needs to index through all possible keys. We first need to define a
unit to recurse over binary words; we provide a natural definition in
@foundations:bootstrap-binary-word.

#figure(
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

From there, we can define handle IDs through triples, see
@foundations:bootstrap-handle-id.

#figure(
  [
    $"handle" <--> {"UID" --> "word", "RID" --> "word", "HID" --> "word"}$
  ],
  caption: [Generator for handle keys in Welkin.],
)<foundations:bootstrap-handle-id>

Here, a $"handle"$ is simply a pair ${"UID", "RID", "HID"}$, where $"UID"$,
$"RID"$, $"HID"$ are words.

Now, in @unit-rules, we needed enough _separate_ meta-variables. To do this in
Welkin, we use representations of the form $"u" --> "unit"$. This appeared
frequently when defining terms in @turing-expressible.

#definition[
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

[TODO: make this discussion complete!] One interpretation of
@foundations:recursor is defining @foundations:unit-containment _within_ a unit,
so $R$ could be written as $<$ in the language. Moreover, $R$ acts as the
_maximum_ of all units.

The following statements are three parts of the same *Recursion theorem* for
Welkin. The first two are straightforward; their proofs closely aligns with the
definitions written in the meta-language (English).

#lemma[*_(Correctness)._* For every unit $u$, $u - "unit" -> "unit"$.
]<foundations:recursion-correctness>
#proof[Fix the context to be $"unit"$. We proceed induction on units:
  - *Base case:* this is immediate, as ${}$ and all handles are included.
  - *Inductive step:* immediate; $"unit"$ includes representations $a - b -> c$,
    as well as cases for ${g, u}$, ${@g, u}$, and ${@g, ~u}$.
]<foundations:recursor-correctness>


#lemma[*_(Monotonicity)_.* For every unit $u, u'$, if $u < u'$, then
  $u - "unit" -> u'$ and $not(u' - "unit" -> u)$.
]
#proof[We proceed by induction on units:
  - *Base case:* we need to demonstrate $not(u --> {})$. In $"unit"$,
    $u - {} -> {@u, ~u}$. By *R7 (Exclusion))* and *R3 (Empty)*,
    ${@{u}, ~u} <--> {}$. Combining this with *R2 (Transitivity)* results in
    $u - {} -> {}$. Hence, no instance of $u --> {}$ is included in $"unit"$.
  - *Inductive step:* suppose $u_1$ and $u_2 equiv {@g, a}$ are units. There are
    two cases:
    - $u_1 < @g$:
    - [TODO[SMALL]: finish this case!]
]


[TODO[SMALL]: determine whether to add extensionality or not.]

#lemma[*_(Uniqueness)_* Let $K$ that contains exactly $u -->^K u$ for each unit
  $u$. Then $K <- R -> R$.]<foundations:recursion-uniqueness>
#proof[
  Assume for all units $u$, $u -->^K K$. Then $R -->^R R$. Thus, for any
  $p - K -> q$ in $K$, ${C − K -> K, p − K -> q} − K -> (p - C -> q in K)$

]

An important consequence of the recursion theorem is a basic form of
*reflection*. Most importantly, this theorem establishes that _any_ way to
characterize Welkin can be reduced to including the recursor $"unit"$. This
establishes that $"unit"$ is the _smallest_ set of foundations for Welkin.

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

== Information

This section provides the definition of information in Welkin. We will write
this as a high-level, but the bootstrap will define this as a unit, see ?.

#definition[
  Let $u, v$ be units. Then $u$ has *information about* $v$ if .
]

