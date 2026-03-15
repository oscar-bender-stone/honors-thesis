// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": induction, lemma, proof

= Bootstrap <bootstrap>

[TODO: decide where proofs should go. Likely this section]

This section proves that there is a file, which we call `weklin.welkin`, that
contains enough information to _represent_ Welkin. We do not bootstrap proofs in
this thesis, but that could easily be a future extension.

== The Unit Recursor <foundations:base-recursor>

The proof of @foundations:turing-expressible demonstrates how contexts enable
powerful recursive definitions. However, the underlying construction is tedious
and results in verbose terms. IDs are assigned manually, which can easily be
error prone. We will refine the proof with a *recursor* over units. This is a
unit that indexes every unit, as well as every handle. We gradually build this
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
    $"handle" <--> {"ID" --> "word"}$
  ],
  caption: [Generator for handle keys in Welkin.],
)<foundations:bootstrap-handle-id>

Here, a $"handle"$ is a wrapper around an $"ID"$, which is a word.

#lemma[
  Every handle $h$ is represented by some unit $h'$.
]<foundations:bootstrap-handle-correctness>
#proof[
  It suffices to show that every word is represented by some unit. We proceed by
  induction:
  #induction(
    [immediate, as $"epsilon"$ represents $epsilon$ and $"bit"$ represents
      either $0$ or $1$.],
    [suppose $w$ is represented by some word $w'$. Then there are two cases:
      - $0w$, which is represented by ${"top" --> "0", "next" --> w'}$.
      - $1w$, which is represented by ${"top"--> "1", "next" --> w'}$.
    ],
  )
  This completes the proof.
]

With handles established, we may proceed to defining the unit recursor. We reuse
an important technique from the proof in @foundations:turing-expressible:
representing meta-variables using $u --> c$, where $c$ is the overarching
context. #footnote[
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
    $"unit"$.
  - $"unit" --> {u, v} | {u - c -> v}$.
]<foundations:recursor>

Proving correctness is straightforward and closely aligns with
@foundations:unit.

#lemma[*_(Recursor Correctness)._* For every unit $u$, $u - "unit" -> "unit"$.
]<foundations:recursion-correctness>
#proof[We proceed induction on units:
  - *Base case:* by definition, $"unit" - "unit" -> {}$. Additionally, let $h$
    be a handle. By @foundations:bootstrap-handle-correctness, $"handle" --> h$,
    Thus, by @r:transitivity, $"unit" - "unit" -> h$.
  - *Inductive step:* there are three cases. We will prove the one for paths.
    The remaining cases areas the rest are similar, only using different
    congruence rules.
    - *Paths:* let $a$ and $b$ units, and suppose $"unit" --> a$ and
      $"unit" --> b$, respectively. Then, by repeated application of @r:refine,
      we derive $"unit" {u --> a, v --> b, "unit" --> {u, v}}$. Applying
      @r:pair-congruence twice, for $a$ and $b$, shows that
      ${u, v} - "unit" -> {a, b}$, hence by @r:transitivity,
      $"unit" - "unit" -> {a, b}$.
]<foundations:recursor-correctness>

Now, for the rest of the thesis (except the bootstrap), we will drop mentions of
specific handles. These will all be facilitated by $"unit"$. For brevity, we
will write $u --> "unit"$. Notice that this form implies $u - "unit" -> "unit"$,
based on $"unit" - "unit" -> "unit"$ and @r:transitivity.

== Base Verifier

Now we will includle a notion for containment. Because Welkin is Turing
expressible, $"unit"$ may not terminate in all cases, such as an infinite
recursive loop. We want to have a mechanism to _check_ certain claims. This is
the role of the verifier. We gradually build up the verifier from smaller
pieces. The lemmas may be read before reading the proofs. Note that this section
slowly incorporates syntax from Welkin, as one way to illustrate the language.

First, we need to express $subset.eq.sq$. We do this with the unit called
$"part"$.

// [TODO: explain that, when saying "defined", implies a *closed* definition! Or
// otherwise use figures from here on out. Maybe say "nothing else" to be clearer?]

#definition[
  The unit $"part"$ is defined over units $u, v$ and as nothing else:
  - $u --> {u, v}$.
]<foundations:bootstrap-in>

Notice that we have kept the definition of $"part"$ minimal. This is useful for
the bootstrap, but it does require more checks. We start with a helper lemma.

[TODO: make sure to add derivations with precise steps! Might be helpful to use
tables here.]

#lemma[
  For all units $u$, ${} - "part" -> u$.
]<foundations:bootstrap-part-basis>
#proof[We prove this by induction on $u$.
  #induction[
    For $v equiv {}$, the former is true by definition, while the latter is a
    consequence of @r:empty.
  ][
    There are three cases.
    - *Paths:* immediate.
    - *Pairs:* suppose $u_1, u_2$ are units with ${} - "part" -> u_1$ and
      ${} - "part" -> u_2$. Then
      ${} - "part" -> {} <--> {{}, {}} - "part" -> {u_1, u_2}$.
    - *Representations:* similar to the case above, except with the congruence
      on representations.
  ]

]

Now we can prove the general case.

#lemma[For all units $u$ and $v$, $u - "part" -> v$ iff $u subset.eq.sq v$.]
#proof[
  Let $I(u, v)$ denote the stated invariant: $u - "part" -> v$ iff
  $u subset.eq.sq v$. We proceed by induction on units $u, v$:
  - *Base case:* by @r:empty, ${} subset.sq.eq u$ is true for all units, so the
    invariant holds by @foundations:bootstrap-part-basis.
  - *Inductive step:* there are three cases.
    - *Paths:* immediate.
    - *Pairs:* suppose $u_1, v_1, u_2, v_2$ are units such that $I(u_1, v_1)$
      and $I(u_2, v_2)$. Apply @r:pair-congruence twice to produce
      $I({u_1, u_2}, {v_1, v_2})$, as desired.
    - *Representations:* similar to the case above.
]<foundations:in-correctness>

We need to include equality as well, refer to @foundations:bootstrap-equality.

[TODO: maybe make proof here more precise?]

[TODO: explained closed definitions, i.e., the $:=$ syntax!]

#figure(
  [$"equals" := {\
    "*"{"b1", "b2"} --> "bit",\
    {"b1" <--> "b2"} &<--> \
    &| {"b1" <--> "0" <--> "b2"} \
    &| {"b1" <--> "1" <--> "b2"}, \
    ~{{"b1" <--> "b2"} &<--> {{"b1", "b2"} <--> {"0", "1"}}}, \
    "*"{"w1", "w2"} --> "word",\
    {"w1" <--> "w2"} &<--> \
    &| {"w1" <--> "epsilon" <--> "w2"} \
    &| {\
      "w1" &<--> {"top" --> "top1", "next" --> "next1"},\
      "w2" &<--> {"top" --> "top2", "next" --> "next2"},\
      "top1" &<--> "top2",\
      "next1" &<--> "next2"\
    }, \
    "*"{"h1", "h2"} --> "handle",\
    {"h1" <--> "h2"} &<--> {\
      "h1" <--> {"ID" <--> "n1"},\
      "h2" <--> {"ID" <--> "n2"},\
      "n1" <--> "n2"\
    },\
  }
  }$],
  caption: [Definitions of equality in Welkin. [TODO: fix formatting!]],
)<foundations:bootstrap-equality>


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

[TODO: decide whether to convert list defs into single equations.]

Now, the rules in @table:unit-rules are already stated in Welkin. The formal
embedding is provided in @bootstrap-document. Using this and $"part"$, we can
define the verifier entirely in Welkin. We need to build the unification
algorithm.

We need a helper to avoid non-determinism.#footnote[For rewrite theorists: this
  is a technique for defining confluence.]

#lemma[
  Let $a,b,c,d$ be units. Then ${a - c -> b, {a - c -> d} --> *{b --> d | {}}}$
  normalizes to ${a - c -> b}$ modulo alpha conversion. (TODO: what we want to
  say is that ${a - c -> b}$ is always contained and NO other possibility.).
  Thus, this expresses that a refernt is *unique* in a given representation.
]

#definition[
  The unit $"unify"$ is defined as follows, with
  $"map"(D, V, A, s) equiv {D := "derivation" --> "unit", V := "variables" --> "unit", A := "axiom" --> "rules", s := "step" --> "unit"}$:
  - $"map"(D, V, {}, {})$
  - $"map"(D, V, h, h)$, with $h --> "handle"$
  - *Pairs:* $"map"(D, V, h, h) - {V_1 <--> V_2} -> "map"()$
  - *Representations:* TBD.
]


Finally, add new handles $"accept"$ and $"reject"$, as well as the following
unit $"claim"$:

$"claim" <--> {\
  "context" &--> "unit",\
  "query" &--> {"unit" - "unit" -> "unit"},\
  "derivation" &--> "unit"\
}$

[TODO: deal with recursion! Need to ensure it halts! And make sure to establish
a clear induction scheme! And maybe add a pair to store the context and target?
Fill in $\_$!]


// TODO: add unify here to check if a step contains an axiom! Important!
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



// == Welkin64 <welkin64>

// As mentioned in the start of @syntax, we address a major practical concern:
// determining the truth of a claim in Welkin, such as whether a string is accepted
// by the grammar or whether a database contains enough information to solve a
// query. The notion of "finite" is limited by implementations ability to check for
// correctness up to a certain bound. This phenomena is known as "Kripkenstein"
// @kripke_wittgenstein and poses a major problem with creating a reliable Trusted
// Computing Base.

// [TODO: create this boolean formula! Do we *include* parsing in this or *only*
// involve units and a specific, efficient implementation for a global ID system
// with arcs?] For our use case, we define 64 bit hashes. This can be defined by a
// predetermined boolean formula.







== Self-Contained Standard

This section is self-contained and defines _everything_ necessary about Welkin.
The complete bootstrap is in appendix ?.


// TODO: emphasize that Welkin is
// homo-iconic, similar to lisp!
// Very powerful!
// TODO: double check grammar!
// Decide whether to use LL(1) grammar.
// Also removes needed for EBNF (for simplicity)
// FIXME: remove ANY traces of EBNF in this bootstrap
// #let bootstrap-text = ```welkin
// "TODO: make sure this is complete! It is NOT currently",
// #welkin,

// radix {
//   bit --> 0 | 1,
//   digit --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9,
//   nibble --> decimal | A | B | C | D | E | F,
// }

// word {
//   @radix,

//   . --> "0b".binary) | decimal | "0x".hex,
//   binary --> bit | binary.bit,
//   decimal --> digit | decimal.digit,
//   hex --> nibble | hex.nibble,
//   {
//     {w, w', w''} --> binary | decimal | hex,
//     (w.w').w'' <--> w.(w'.w'')
//   }
// }

// ASCII {

// }

// character_classes {
//   PRINTABLE,
//   DELIMITERS,
// }

// grammar {
//   @word,
//   @character_classes,

//   start --> terms,
//   terms --> term ("," term)* ","? | EPS
//   term  --> arc | graph | group | path
//   arc   --> (term ("-" | "<-") term ("-" | "->"))+ term
//   graph --> path? "{" terms "}"
//   group --> path? ("(" terms ")" | "[" terms "]")
//   path --> MODIFIER? path_segment* unit
//   path_segment --> unit | ".*" | "."+,
//   unit --> ID | STRING,

//   MODIFIER --> "#" | "@" | "~@" | "&",
//   ID --> ID_CHAR | ID_CHAR ID,
//   ID_CHAR --> {.PRINTABLE, ~@{.DELIMITERS, .WHITESPACE}},
//   DELIMITERS --> "," | "." | "-" | "<" | ">" | "*" | "(" | ")" | "[" | "]" | "{" | "}"
//   STRING --> SQ_STRING | DQ_STRING,
//   SQ_STRING --> '"' SQ_CONTENTS '"',
//   DQ_STRING ::= "'" DQ_CONTENTS "'",
//   SQ_CONTENTS --> SQ_CHAR | SQ_CHAR.DQ_CONTENTS,
//   DQ_CONTENTS --> DQ_CHAR | DQ_CHAR.DQ_CONTENTS,
//   SQ_CHAR --> {.PRINTABLE, ~"'"},
//   DQ_CHAR --> {.PRINTABLE, ~'"'},
//   ESCAPE_SQ --> "\'" | "\\",
//   ESCAPE_DQ --> '\"' | '\\',
//   EPS --> ""
// }

// AST {
//   "Abstract Syntax Tree" --> .,

// }

// evaluation {

// }

// organization {


// }


// revision {

// }

// ```

// // TODO: make this neater!
// // Probably set as an appendix?
// #block(bootstrap-text, breakable: true),
