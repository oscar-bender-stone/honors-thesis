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

For notation, we will write $a equiv b$ to mean that $a$ is definitionally
equivalent to $b$. Moreover, we will distinguish between _defining_ a term as
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
  - A representation $a - c -> b$ of units $a, b, c$, where $a$ is the *sign*,
    $c$ is the *context*, and $b$ is the *referent*.
  - A block, which is defined as one of the following:
    - ${}$
    - Given a block $g$ and unit $u$, ${g, u}$, ${@g, u}$, and
      ${@g, tilde.op u}$ are blocks, where $@g$ is a new blocks called the
      *expansion* of $g$ and $~u$ is called the *exclusion* u.
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
allowed.

[TODO[SMALL]: provide labels/links.]

[TODO[SMALL]: Maybe reduce the number of meta-variables used for clarity?]

[TODO[SMALL]: Clarify role of global context!]

#definition[
  The following rules apply, stated over meta-variables $a, b, c, d, g, p, q$:
  - *R1. Internal Transitivity:* $a - c -> b$ and $b - c -> d$ imply
    $a - c -> d$.
  - *R2. Contextual Lifting:* $a - c -> b$ and $p - b -> q$ imply
    $p - a -> q in c$.
  - *R3. Empty:* ${@g, {}} <--> g$.
  - *R4. Membership:* ${@g, a} <--> g$ if and only if $a - g -> a$.
  - *R5. Singleton:* ${a} <--> a$.
  // NOTE: this does add arrows. For clarity,
  // could make this redundant  and add a - g -> b here.
  - *R6. Expansion:* if $a - g -> b$, then ${@g, p} <-> {{{@g, a}, b}, p}$.
  - *R7. Exclusion:* if $g <--> {@p, a}$, then ${{@g, ~a}, b} <--> {@p, b}$.
  - *R8. Associativity:* ${a, {b, c}} <--> {{a, b}, c}$.
  - *R9. Commutativity:* ${{@g, a}, b} <--> {{@g, b}, a}$.
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
  is _not_ required in every unit.
- *R5* reduces extraneous blocks. Note that this is _not_ the same thing as the
  Quine atom, which states ${a} = a$ in a set theoretic context
  @quine:new-foundations. We do _not_ mean $a in a$, but instead, ${a}$ is a
  _wrapper_ around $a$. Notationally, we use extra blocks to identify _groups_
  of representations, such as ${a - b -> c, b - c -> d}$.
- *R6* and *R7* define how imports in the language work. An *import* is the
  process of joining the contents of one unit into another. *R6* says how
  imports work. *R7* provides a mechanism to _exclude_ specified contents in
  $g$, which can themselves be arrows.
- *R-R* ensure that information can be repeated and is positionally invariant.

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

  We express recursion via a unit $L$, see @foundations:turing-expressible-L.
  Note that each rule of the form $A --> B$ written in $L$ means $A - L -> B$.
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
recursive definitions. However, the underlying construction is artificial and
results in extreme verbose terms. We will refine the proof with the a recursor
over units.

An important part of the $S K$-calculus is composition, the ability to gradually
build up terms. We wish to replicate this by ensuring our recursion maintains an
increasing containment relation. Containment is defined below.

#definition[The relation $u_1$ is *contained in* $u_2$, denoted $u_1 < u_2$, is
  defined recursively:
  - *Base case:* for all units $u, v$:
    - $not(u < {})$.
    - if $u != v$, then ${u} < {u, v}$.
  - *Inductive step:* given units $u_1$ and $u_2 equiv {@g_1, a_2}$, $u_1 < u_2$
    if and only if either $u_1 < @g_1$, or for some $b in g$,
    $u_1 < {{@g_1, ~b}, a}$.
]<unit-containment>

The recursor needs to index through all possible keys. We first need to define a
unit to recurse over binary words. We present a natural definition in
@foundations:bootstrap-binary-word.

#figure(
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
[TODO[SMALL]: remove meta-variables.] #definition[
  The *unit recursor* $R$ is defined by $R <--> {R_"base", "Rules"}$, where
  $R_"base"$ is defined recursively:
  - Includes @foundations:bootstrap-binary-word and
    @foundations:bootstrap-handle-id.
  - $h - R -> "handle"$,
  - $a - R -> R$, $a - R -> R$
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
@foundations:recursor is defining @unit-containment _within_ a unit, so $R$
could be written as $<$ in the language. Moreover, $R$ acts as the _least super
bound_ of all units.

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

[TODO[SMALL]: determine whether to add extensionality or not.]
#theorem[*(Uniqueness)* Let $K$ that contains exactly $u -->^K u$ for each unit
  $u$. Then $K <- R -> R$.]<foundations:recursion-uniqueness>
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
