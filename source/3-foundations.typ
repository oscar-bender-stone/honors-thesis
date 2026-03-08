// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import "template/ams-article.typ": matched-dash, tilde-prefix
#show math.minus: matched-dash
#show math.tilde: tilde-prefix

#import "template/ams-article.typ": rule-table
#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": corollary, equation_block, lemma, theorem

#import "template/ams-article.typ": proof, proof-sketch

#let tilde-prefix = math.class(
  "unary",
  box(baseline: -20%, scale(80%, $tilde$)),
)
#show math.tilde: tilde-prefix

= Foundations <foundations>

This section discuss the foundations of Welkin, as follows:

+ We define units and their rules.
+ We prove there is a unit that indexes every other unit
  (@foundations:base-recursor).
+ We define queries.

== Base Rules

As high-level notation, we write $a equiv b$ to mean that $a$ is definitionally
equivalent to $b$. High level notation will _not_ be stated in the syntax unless
where noted. Moreover, we will distinguish between _defining_ a term as finite
and _practically enforcing_ it is finite. For a thorough discussion, see ?.

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
  A _handle_ is given by a *key*, a triple $("MID", "RID", "HID")$, where
  $"MID"$ is a binary word called a *user ID*, $"RID"$ is a binary word called
  the *revision ID*, and $"HID"$ is a binary word called the *handle ID*. The
  interpretation of keys are left as free parameters, and therefore are outside
  the scope of this language.
]<foundations:handle>

#remark[
  Because handles act as free parameters, we work with them through truth. Based
  on this, the rest of the thesis will abstract away general units _as_ sets of
  axioms. Free parameters are used to define Welkin itself, however; see
  @syntax.
]<foundations:remark-handle-binding>

[TODO[SMALL]: without getting into typing, enforce that equality has to be done
on two words or two handles. Maybe lift to the latter to make sense?]
#definition[Consider two handles
  $h_1 equiv ("MID"_1, "RID"_1, "SYM"_1), h_2 equiv ("MID"_2, "RID"_2, "HID"_2)$.
  - $h_1$ and $h_2$ are equal, written $h_1 = h_2$, if and only if
    $"MID"_1 = "MID"_2$, $"RID"_1 = "RID"_2$, and $"SYM"_1 = "SYM"_2$.
  - $h_1$ is not equal to $h_2$, written $h_1 != h_2$, if and only if at least
    one of the following hold: $"MID"_1 != "MID"_2$, $"RID"_1 != "RID"_2$, or
    $"SYM"_1 != "SYM"_2$.
]<foundations:handle-equality>

We reserve an important symbol as notation, used outside of the language: $G$
for the *global context*. This can be interpreted as the combination of _all_
possible units, with any string ID. This, too, is left as a free parameter in
the theory. The global context may range from anything to a local folder with
welkin modules, to an entire global registry. [TODO: maybe make this more
clear?]

Now we can define units.

#definition[
  A *unit* is defined recursively as follows and nothing else:
  - *Base case:*
    - A handle, see @foundations:handle.
    - The symbol ${}$, the *empty block*.
  - *Recursive step:* let $u, v, g$ be units and $h$ a handle. Then any finite
    combination of the following are also units:
    - $@u$, the *expansion* of $u$.
    - ${u, v}$, the *pair* of $u, v$.
    - An *import block*, defined as ${@g}$ for a unit $g$, or as ${b, @u}$,
      ${b, ~u}$, or ${~u, b}$ for an import block $b$. In ${b, ~u}$, $~u$ is the
      *exclusion* of $u$.
    - $g.v$, the *access of $v$ on $g$*.
    // TODO: make the current working context clear!
    - A *representation* $a - c -> b$, where $a$ is the *sign*, $c$ is the
      *context*, and $b$ is the *referent*. This is read as: $a$ *represents*
      $b$ *in context* $c$.
]<foundations:unit>

We will intentionally _avoid_ defining equality on units and postpone this until
@foundations:base-recursor.

#definition[
  The following rules apply, stated over meta-variables $a, b, c, d, g$ for
  units and $h_1, h_2$ for handles:
  #rule-table(
    prefix: "R",
    (
      (
        name: "Internal Transitivity",
        lbl: "r:transitivity",
        content: [$a - c -> b$ and $b - c -> d$ imply $a - c -> d$.],
      ),
      (
        name: "Contextual Lifting",
        lbl: "r:context-lift",
        content: [$a - c -> b$ and $d - b -> g$ imply
          #box[$\{d - a -> g\} - c -> \{d - a -> g\}$]],
      ),
      (
        name: "Empty",
        lbl: "r:empty",
        content: [$\{\@g, \{\}\} <--> g$],
      ),
      (
        name: "Null",
        lbl: "r:null",
        content: [$\{a - \{\} -> b\} <--> \{\}$],
      ),
      (
        name: "Handle Substitution",
        lbl: "r:handle-sub",
        content: [If handle $h_1$ is equal to handle $h_2$, then
          $h_1 <--> h_2$.],
      ),

      (
        name: "Identity",
        lbl: "r:identity",
        content: [$a <--> \{a - a -> a\}$],
      ),

      (
        name: "Singleton",
        lbl: "r:singleton",
        content: [
          $a <--> \{a\}$.
        ],
      ),

      // NOTE: may say this does add arrows?
      (
        name: "Membership",
        lbl: "r:membership",
        content: [
          $\{\@g, a\} <--> g$ if and only if $a - g -> a$.
        ],
      ),

      // TODO: ensure this is clear! Need to distinguish from what
      // we write in the syntax! Also, probably need to ensure
      // this is *valid*, so with anonymous blocks, can't
      // add new things! Wouldn't make sense! It would
      // be a *whole* new thing.
      (
        name: "Field Access",
        lbl: "r:field-access",
        content: [
          $g.a <--> a$ if and only if $a - g -> a$.
          // TODO: make it clear what the current working context is!
        ],
      ),
      (
        name: "Expansion",
        lbl: "r:expansion",
        content: [if $a - g -> b$, then
          #box[$\{\@g, c\} <--> \{\{\{\@g, a\}, b\}, c\}$]],
      ),
      (
        name: "Exclusion",
        lbl: "r:exclusion",
        content: [if $g <--> \{\@g, a\}$, then
          #box[$\{\{\@g, "~"a\}, b\} <--> \{\@d, b\}$]],
      ),
      // TODO: show that there's a form of associativity
      // and commutativity for import blocks!
      (
        name: "Associativity",
        lbl: "r:associativity",
        content: [$\{a, \{b, c\}\} <--> \{\{a, b\}, c\}$],
      ),
      (
        name: "Commutativity",
        lbl: "r:commutativity",
        content: [$\{a, b\} <--> \{b, a\}$ and $$],
      ),

      (
        name: "Import Commutativity",
        lbl: "r:import-commutativity",
        content: [$\{@g, ~u\} <--> \{~u, @g\}$ and $$],
      ),
    ),
  )

]<unit-rules>


We review the utility of each rule. Note that rules _between_ contexts is
entirely flexible and user defined. Moreover, only *R1* is needed for Turing
completeness. However, the other rules are in place to help with organizing
units as modules, as well as make it easier to use the language.

- @r:transitivity and @r:context-lift were discussed in @rationale:unit.[TODO:
  maybe review the discussion from earlier? Might be useful to reinforce main
  ideas to reader.]
- @r:empty and @r:null define the behavior of the empty unit ${}$, similar to
  the empty set. @r:null specifically states that ${}$ contains _no_
  representations, so any term $a - {} -> b$ may be written.
- @r:handle-sub enables equality in handles to pass through into
  representations. Besides this, note that equivalences on units are _entirely_
  user defined.
- @r:identity represents identity. This is _not_ the same as $a - g -> a$, see
  the discussion below.
// - @r:module ensures that a _given_ module is unique. This is only accessible at
//   the highest scope in a file, see @syntax.
- @r:singleton reduces extraneous blocks. Note that this is _not_ the same thing
  as the Quine atom, which states ${a} = a$ in a set theoretic context
  @quine:new-foundations. We interpret ${a}$ as a _wrapper_ around $a$. While
  not useful for handles, it is for specifying blocks of representations, such
  as ${a - b -> c, b - c -> d}$.
- @r:membership provides a way to represent $a in g$ through the representation
  $a - g -> a$. Because of this, $a - g -> a$ may be a non-trivial path, _not_
  identity.
- @r:field-access provides a mechanism to access specific units in a scope. The
  notation is entirely inspired by object oriented programming.
- @r:expansion and @r:exclusion define how imports in the language work. An
  *import* is the process of joining the contents of one unit into another.
  @r:expansion says how an import can add new units in a block. @r:exclusion
  provides a mechanism to _exclude_ specified contents in $g$, which can
  themselves be representations. For example,
  ${@{a - b -> c, d}, ~{a - b -> c}}$ reduces to ${d}$. This also enables a way
  to disable _any_ rule in Welkin, based on user preference. This is
  intentionally restricted _per context_, so the rules are enacted by default.
  Also note that exclusions *must* be used in the presence of an expansion.
  Otherwise, terms like ${a, {b, ~a}}$ would be allowed, so certain units could
  never be expanded!
- @r:associativity, @r:commutativity, and @r:import-commutativity ensure that
  information can be repeated and can be put into any order. Note that this does
  *not* mean ${a, {@g, ~b}} <--> {@g, {a, ~b}}$ for general units $a, b$. If
  this were the case, then one could write ${a, {@{a}, ~a}}$ and produce ${}$,
  so extending certain units would be impossible!

We provide some reoccurring properties in the lemma below.

#lemma[
  - For every unit $u$, there exists a unit $u'$ with at least one more entity
    than $u$. [TODO: make this more clear! This says units can always be
    extended to new ones!]
  - Import blocks are locally associative. More precisely, given import blocks
    $m_1, m_2$ and units $u, v$, #box[${m_1, {m_2, ~u}} <--> {m_2, {m_1, ~u}}$].
]<foundations:lemma-properties>


As more notation, we write:

- $a - c -> b_1 | b_2 | ... | b_n$ to mean
  ${a - c -> b_1, a - c -> b_2, ..., a - c -> b_n}$.
- $a_1 | ... | a_n - c -> d$ to mean ${a_1 - c -> d, ..., a_n - c -> d}$.

This simplifies the presentation of the rules. We postpone formally defining the
operator $|$ to the syntax in @syntax.

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

]<foundations:SK-calculus>

#theorem[Any partial computable function can be expressed as some unit.
]<turing-expressible>
#proof[
  We prove that we can embed any term in the $S K$-combinator calculus, defined
  in @foundations:SK-calculus. This proof includes an important technique to
  represent _recursion_,

  We express recursion via a unit $L$. For keys, we set:
  - $L equiv (1, 0, 0)$.
  - $K equiv (1, 0, 1)$, $S equiv (1, 0, 2)$.
  - $M equiv (1, 0, 3)$, $N equiv (1, 0, 4)$ $P equiv (1, 0, 5)$.
  Note that these IDs will be reused after this lemma, as this just shows its
  _possible_ to store into an information base.

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
      $
        L equiv {
          #align(left)[
            $ K -> L, quad S -> L, $
            \
            $ {M -> L} -> L, $
            \
            $ {N -> L} -> L, $
            \
            $ {P -> L} -> L, $
            \
            $ C <-> {N - M -> L}, $
            \
            $ C -> {M -> L}, $
            \
            $ C -> {N -> L}, $
            \
            $ {N - {M - K -> L} -> L} -> {M -> L}, $
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

  - $L$ includes $K$ and $S$ as base cases. We interpret $K --> L$ to mean $K$
    is a term of $L$.
  - We include variables $M, N, P$ over terms. The statement ${M --> L} --> L$
    wraps around any term.
  - Composition $M N$ is represented as $N - M -> L$. Moreover, $M N$ can be
    broken down into its constituent parts $M, N$.

  - The remaining representations are for the rule of $K$ and $S$, respectively.

  [TODO: maybe present SK-calculus based on reductions, not equality? We can get
  equality easily through transitivity, but do discuss.]

  Now, $L$ already includes the base rules for $K$ and $S$. It remains to be
  shown that $L$ is closed under composition: $M --> L$ and $N --> L$ imply
  $C --> L$, where $C <--> {N - M -> L}$. By using *R1* on $C --> {M --> L}$ and
  ${M --> L} --> L$, we obtain $C --> L$, completing the proof.
]

== The Unit Recursor <foundations:base-recursor>

The proof of @turing-expressible demonstrates how contexts enable powerful
recursive definitions. However, the underlying construction is tedious and
results in extremely verbose terms. Keys are assigned manually, which can easily
be error prone. We will refine the proof with a *recursor* over units. This is a
unit that indexes every unit, as well as every handle. We gradually build
$"unit"$ based on notions for $"word"$ and $"handle"$. Note that we will
manually index new handles within the final bootstrap, see ?.

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
    $"handle" <--> {"MID" --> "word", "RID" --> "word", "SYM" --> "word"}$
  ],
  caption: [Generator for handle keys in Welkin.],
)<foundations:bootstrap-handle-id>

Here, a $"handle"$ is simply a pair ${"MID", "RID", "SYM"}$, where $"MID"$,
$"RID"$, $"SYM"$ are words.

We need to include equality as well, refer to @foundations:handle-equality:

#figure(
  [$"equals" <--> {\
    "0" <--> "0",\
    "1" <--> "1",\
    ~{"0" <--> "1"},\
    "w1" | "w2" --> "word",\
    {"w1" <--> "w2"} <--> {"w1" <--> "empty" <--> "w2"} \
    | {"w1.top" <--> "w2.top", "w1.next" <--> "w2.next"}, \
    "h1" | "h2" --> "handle",\
    {"h1" <--> "h2"} <--> \
    {\
      "h1.UID" <--> "h2.MID",\
      "h1.RID" <--> "h1.RID" \
      "h1.SYM" <--> "h1.SYM" \
    }
  }$],
  caption: [Definitions of equality in Welkin.],
)<foundations:bootstrap-equality>



To show these constructions are correct, we must prove the following.

#lemma[
  Let $"h1"$ and $"h2"$ be handles. Then $"h1" <- "equals" -> "h2"$ if and only
  if $h_1 = h_2$.
]<foundations:bootstrap-equality-correctness>
#proof[Clearly it is sufficient to show that equality on words is correct. To do
  so, we apply a simple proof by induction:
  - *Base case:* immediate.
  - *Inductive step:* correctly handles the the cases for $"top"$ and $"next"$.
]

Now, in @unit-rules, we needed enough _separate_ meta-variables. To do this in
Welkin, we use representations of the form $"u" --> "unit"$. This appeared
frequently when defining terms in @turing-expressible.
#footnote[
  [TODO: discuss how we are allowing the variables to be the same or different!
  Related to bundling in MetaMath + MetaMath Zero [and cite these!].]
]
[TODO: maybe remove the cases of pairs for simplicity? Shouldn't these simplify
due to associativity, so we _only_ need expansions?]

#definition[
  The *unit recursor* $"unit"$ includes all rules in @unit-rules, as well as the
  following in context $"unit"$:
  - $"handle" --> "unit"$, see @foundations:bootstrap-handle-id.
  - ${} | u | v | c --> "unit"$.
  - $@u --> "unit"$.
  - ${u, v} | {@u, ~v} --> "unit"$.
  - ${u - c -> v} --> "unit"$.
]<foundations:recursor>

The following statements are two parts of the same *Recursion theorem* for
Welkin. The first is straightforward; their proofs closely aligns with the
definitions written in the meta-language (English).

#lemma[*_(Correctness)._* For every unit $u$, $u - "unit" -> "unit"$.
]<foundations:recursion-correctness>
#proof[Fix the context to be $"unit"$. We proceed induction on units:
  - *Base case:* this is immediate, as ${}$ and all handles are included.
  - *Inductive step:* immediate; $"unit"$ includes representations $a - b -> c$,
    as well as cases for $@g$, ${g, u}$, and ${@g, ~u}$.
]<foundations:recursor-correctness>


Now, for the rest of the thesis (except bootstrap), we will drop mentions of
specific handles. These will all be facilitated by $"unit"$. Moreover, if
$u --> "unit"$, then $u - "unit" -> "unit"$, based on @r:identity and
@r:transitivity. We will use this shorter form for brevity.

== Base Verifier

Now we will includle a notion for containment. Because Welkin is Turing
expressible, $"unit"$ may not terminate in all cases, such as an infinite
recursive loop. We want to have a mechanism to _check_ certain claims. This is
the role of the verifier, built upon $"part"$. We will later on use $"part"$ for
useful optimizations, see @information-organization.

[TODO: start converting list defs into single equations.]

#definition[
  The unit $"part"$ is defined over units $u, v --> "unit"$:
  - $u --> {@u, v}$.
  - $~{{@u, v} --> u}$.
  - ${@u, ~v} --> u$.
  - $~{u --> {@u, ~v}}$.
]<foundations:bootstrap-in>

#lemma[$u - "part" -> u'$ if and only if $u - u' -> u$.]
#proof[
  We proceed by structural induction on units, or $u | u' - "unit" -> "unit"$:
  - *Base case:* we need to prove ${{} - "part" -> u'$ if and only if
    ${} - u' -> {}$.
    - *Base case:* For $u' equiv {}$, clearly both are false.
    - *Inductive step:* There are three cases:
      - *Representations:* immediate.
      - *Expansions:* .
      - *Exclusions:* .
  - *Inductive step:* similar to the base case. [TODO: complete this proof! But
    it is straightforward.]
]<foundations:in-correctness>

We can now define the verifier entirely in Welkin. Add new handles $"accept"$
and $"reject"$.

[TODO: deal with recursion! Need to ensure it halts! And make sure to establish
a clear induction scheme! And maybe add a pair to store the context and target?
Fill in $\_$!]

#definition[
  The unit $"verify"$ is defined over a context $c$, a unit ${a - d -> b}$
  called the *target*, and a unit $p$ called a *derivation*. We define this by
  recursion on $p$.
  - *Base case:* if $p$,
    ${"context" --> c, "target" --> {a - d -> b}, "derivation" --> p} - "verify" -> "accepts"$
    holds if and only if ${a - d -> b} <- "part" -> p$. Similarly, $"reject"$ if
    and only if $~{{a - d -> b} - "part" -> p}$.
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




