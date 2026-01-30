// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo

// Old draft of paragraph on truth contexts:
//
// In addition to this [FIRST CLASS OF PROBLEMS NAME], another major hurdle is
// truth management. [DISCUSS Problems with truth + corrections from papers don't
// propagate!] What can be done is addressing _information_, the storage of the
// _asserted_ facts themselves, regardless of truth. As one example, suppose a
// scientist claims, "X is true about Y". One could debate the veracity of that
// claim, but what we can say is, "This scientist claims, 'X is true about Y'".
// Even if we doubt that, we could do: "This claim can be formulated: 'This
// scientist claims 'X is true about Y''". By using these justifications, stating
// that a claim is expressible, the _syntactic expression_ of the claim can be
// separated from its _semantic truth value_.#footnote[One might be worried about a
//   paradox, such as "This claim is expressible: this claim is not expressible."
//   We will avoid this using a clear separation of the overarching metatheory and
//   object theory, with the former being syntactical in nature. To express this
//   separation, we write quotes around the claim itself.] I will make this more
// rigorous in later sections, but this means we can build knowledge bases ontop of
// information systems using flexible extensions.


= Foundations <foundations>

This section establishes the theory underlying Welkin, capturing
representations, consisting of an entity, a symbol, and an intepreter. We
develop representations using _units_, or arbitrary entities that are denoted
through its ID, a symbol.#footnote[The word unit is inspired by a cloud. A cloud
  can be broken down further or be part of a larger group of clouds.
  Additionally, clouds can be transformed, which is reflected in units through
  operations on their symbols.
] Units have two important properties. First, they can be be broken down further
or form larger units. Second, their respective symbol can be manipulated by a
partial computable function. We impose no implementations on these properties,
but instead analyze their usefulness through the coherency of a unit, or how
much structure it distinguishes.

== Motivating Example: Maps

#todo[Draw several figures here! Will be easier to keep track.]
We start with a motivating example that equally serves as a useful metaphor:
geographic maps. Consider a traveler $A$ exploring a new area. To track their
journey, they take a piece of paper and draw a box to represent the landscape.
This box is a unit. As they travel, they record landmarks and paths as their own
symbols. Each of these are units, with an important property: they are denoted
through _distinct_ symbols. Without distinct symbols, $A$ could confuse one
landmark with another and become lost. This is a foundational kind of coherency,
namely non-triviality. The map is neither empty nor represents all entities with
a single symbol.

Suppose, now, that $A$ meets another traveler $B$, drawing a different
non-trivial map. They compare maps and find they wrote down different landmarks,
but agree on their overlapping paths. With this, $A$ and $B$ could settle on
some notation and combine their maps. For instance, to identify their specific
landmarks, they could apply a special prefix, say $A$ and $B$, respectively. The
_combination_ of these maps are then coherent, because it faithfully encode the
map, now with more information than before.

The scenario with $A$ and $B$ is a straightforward case. But we want to
investigate more difficult ones. Consider a third traveler, $C$, with a
completely divergent map.

In this specific context, the geographically distinguished landmarks may be more
appropriate for travel than the random marks of the latter. However, suppose
these marks distinguished an artistically relevant feature, or possibly a hidden
treasure. How would the latter communicate this to the former?

To communicate between these maps, we need an appropriate notion of coherency.

== Definitions

Now we develop the formal framework to discuss information in terms of units,
enabling a complete mechanization of our theory.

#definition[
  The *alphabet of binary strings* is $cal(A)_"bit" ::= 0 | 1 | . | w$. A
  *binary string* is either the symbol $0$ or $1$, or if $w$ is a string, then
  $w.0$ and $w.1$ is a string. We abbreviate $w.w'$ to $w w'$.
]

#definition[
  The *alphabet of units* is $cal(A)_"unit" = u$. A *unit ID* is combination of
  symbols $u_b$, where $b$ is a binary string.
]

#theorem[
  A unit is coherent relative to a context iff the unit and that context are
  coherent.
]
#remark[This theorem is a natural generalization of consistency in first-order
  logic. We will frequently rely on this result throughout the thesis.]

#definition[Information over a unit $u$ is a unit $u'$ such that $u equiv u'$
  iff $v_u = v_u'$. In other words, information is an invariant for a unit
  modulo $equiv$.
]

#theorem[
  A representation is preserves information modulo $equiv$ iff the
  representation modulo $equiv$ is coherent.
]

== Coherency
- Definability
  - Show that this generalizes Padoa definability
    - Classic exapmle where this is used:
    showing congruence is not definable in terms of betweeness
    - On the reals, $x |-> 2x$ is monotonic but
    does not preserve congruence.
    - In HOL, only one direction shows. Determine
    how to strengthen to claim to ensure equivalence
  - Basic idea: notion A is definable via notion B
  iff every map that preserves B also preserves B
  - Want to use this basic idea to talk
  about information preservation
- Coherency of a System
  - What systems are *useful* or can talk about other systems?
    - Don't want: empty system or one with ALL The rules. These are
    will have low usefulness
    - Want: complex, intricate structures. Problem is,
    lots of notions for this! Need to determine a general notion, using slates!
  - Use coherency as basis for information organization

== Translations Between First Order Logic

- Want easy access to first order logic
  - Review literature. Notable examples:
    - SMT solvers in Rocq + Lean (via monomorphization of types)
  - Problem: abstractions are hard to convey! Lots of "bloat"
  - BUT SMT solvers are very well established, particularly with Gödel's
    completeness theorem.
  - How to get best of both worlds? Solution: slates!
- First step: define extension to first order logic (let's call it, say,
  FOL(Slate))
  - Add slates as a special sort, but focuses on first order terms.
    - Emphasize that there are FOL theories *weaker* than combinators.
    So, with a coherency argument, argue that FOL can be powerful *precisely
    because* RE is possible, WITH the combination of the completness theorem.
    (Not possible in all logics!).
- Second step: show that FOL(Slate) is equivalent to FOL by treating slates
as an additional sort.
- Straightforward, but emphasize rule on slates on making meanginful/useful
abstractions!
- IF time allows, provide experiments, but mostly argue why, based
on the argument for slates, this would work.
- Argue that you could AT LEAST embed the necessary abstractions via slates.
And organization will help show this is feasible with a theoretical argument
(but it's not exponential time. It is (hopefully) ACTUALLY feasible.)

- Final step: show that there is an equivalent embedding that *preserves*
  slates.
  - Important part: preservation up to iso!
  - Maybe bring up Jose Mesegeru's "epsilon-representation distance" notion

= Universal Systems

- Provide previous section (translation to FOL) as a major example
- Generalize from the case of a formal system from an earlier draft
  - Earlier definition: (D, R), with D a grammar and R a set of RE rules
  - Universal system: U = (D_U, R_U) is universal if, for each formal system S,
  there is a term t in D_U such that derivations in S are reflected and
  preserved via t in D_U. So they are faithfully encoded
  - Earlier proof: a system is universal iff it induces a comptuable, RE
  full sub-category of the category of formal systems.
  - Refine these ideas to use slates + coherency from before.
  Can involve more ambitious encodings!
  - Also develop reflection!
- Hint at topic of next section, or smooth out transition. Next
section is discussing *which* universal system to use or how to effectively
translate between them


