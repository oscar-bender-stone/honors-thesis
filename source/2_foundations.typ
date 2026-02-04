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
// rigorous in later sections, but this means we can build knowledge bases on-top of
// information systems using flexible extensions.


= Foundations <foundations>

// TODO: make the connection to the free parameter clearer,
// instead of using the term loosely! Or otherwise clarify!
This section establishes the theory underlying Welkin, centered around
representations. Loosely, a *representation* is a mapping from a *sign* to a
*referrant* via an *interpreter*. Each of these components are defined as
_units_, which are entities referred to by a numeric ID.#footnote[The word unit
  is inspired by a cloud. A cloud can be broken down further or be part of a
  larger group of clouds. Additionally, clouds can be transformed, which is
  reflected in units through operations on their symbols.
] Units have two important properties. First, they can be broken down and
combined. Second, units have a sign that can be manipulated by any partial
computable function. Both of these properties are used to prove universality, in
that any free parameter describlae by a partial computble function can be
described as a unit, see @universality-theorem.

== Motivating Example: Maps

#todo[Draw several figures here.]
We start with a motivating example that equally serves as a useful metaphor:
geographic maps.

Consider a traveler $A$ exploring a new area. To track their journey, they take
a piece of paper and draw a box to represent the landscape. This box is a unit.
As they travel, they record landmarks and paths as their own symbols. Each of
these are units, with an important property: they are denoted through _distinct_
symbols. Without distinct symbols, $A$ could confuse one landmark with another
and become lost. This is a foundational kind of coherency, namely
non-triviality. The map is neither empty nor represents all entities with a
single symbol.

Now, suppose $A$ mistook some shadows for a ravine, and adds a blockade on the
map.#footnote[Credit to Professor Kearnes for inspiring this example.] The map
still accurately represents _some_ of the landmarks, but not the open path where
the symbolic ravine is added. How can this mistake be identified? A direct
approach would be to add _both_ assertions together, that the map is blocked and
not. This makes the combination of a new item incoherent, as the new
representation fails to be faithful. There are multiple ways to then _fix_ the
issue. In one way, the original map, without any checks, can be recorded as a
revision, and then another revision can be made that removes the ravine. This is
addressed more in @information_organization.

== Definitions

Now we develop the formal framework to discuss information in terms of units,
enabling a complete mechanization of Welkin's meta-theory. To keep this section
self-contained, we explicitly provide all recursive definitions.

#definition[
  The *alphabet of binary strings* is $cal(A)_"bit" ::= 0 | 1 | . | w$, where
  $"bit" ::= 0 | 1$. A *binary string* is defined recursively: the symbols $0$
  or $1$ are strings, or if $w$ is a string, then so are $w.0$ and $w.1$. We
  abbreviate $w.w'$ to $w w'$.
]

For simplicity, we extend the alphabet to include decimal and hexadecimal.

#definition[
  The *alphabet of units* is $cal(A)_"unit" = u | cal(A)_"bit"$. A *unit ID* is
  combination of symbols $u_b$, where $b$ is a binary string.
]<unit-ids>

We now define representations using unit IDs as a base notion.

#definition[
  Units are recursively defined:
  - *Base case:* binary strings are units.
  - *Recursive step:*
    - *Parts:*: if $u_1, .., u_n$ are finitely many units, then so is their
      combination.
    - *Representations:* If $u, w, v$ are units, so is $v -> u$. We say $v$
    *refers to* $u$. or conversely, $u$ is *referred to* by $v$.
]

Parts of units are denoted as $u.w$. Scoping is included to provide namespaces.
Moreover, parts enable *interpretations*. We write $v - w -> u$ in case
$u, v in w$ and within $w$, $v -> u$.

Inspired by @twenty_years_rewriting_logic, we prove that scoping is strictly
more expressive than without.

#lemma[Representations with interpretations are undefinable with free
  representations.]

#example[Consider a house with a dog and a cat. We can represent the house as
  unit $H$, the dog as unit $D$, the cat by unit $C$. We can impose that $H$
  contains both $C$ and $D$. We can consider an abstract entity $A$ as well, and
  could say that $A$ represents $C$ and $D$.
]

// TODO: discuss anonymous units
New units can be made as follows:
- Given units $A$ and $B$, ${B, A}$ is a unit.

// TODO: clean up this example.
#example[
  Consider the recursive definition of a binary tree: either it is a leaf node,
  or it contains two distinct nodes, left and right. We can model this as
  follows. We consider a unit $T$ (tree), as well as symbols for $L$ (left), $R$
  (right), and $E$ (end/leaf node). We could also add a symbol for $C$, child.
  $T$ then contains a recursive definition: $E$ represents $T$, and for nodes
  $A, B$, if $A$ represents $T$ and $B$ represents $T$, then so does their
  combination.

  An important idea in this example is that the abstraction could be defined
  _first_, or a concrete model could. For this reason, the choice of how
  entities are represented is flexible.
]

#theorem[
  A unit is coherent relative to a context iff the unit and that context are
  coherent.
]
#remark[This theorem is a natural generalization of consistency in first-order
  logic. We will frequently rely on this result throughout the thesis.]

#definition[Information over a unit $u$ is a unit $u'$ such that $u equiv u'$
  iff $I_u = I_u'$. In other words, information is an invariant for a unit
  modulo $equiv$.
]

#theorem[
  A representation is preserves information modulo $equiv$ iff the
  representation modulo $equiv$ is coherent.
]
#remark[This theorem enables truth management via specific contexts, specified
  as units. The task of finding core truths is then free, left open to
  flexibility accommodate for any truth management.]

#example[First Order Logic]

// == Translations Between First Order Logic

// - Want easy access to first order logic
//   - Review literature. Notable examples:
//     - SMT solvers in Rocq + Lean (via monomorphization of types)
//   - Problem: abstractions are hard to convey! Lots of "bloat"
//   - BUT SMT solvers are very well established, particularly with Gödel's
//     completeness theorem.
//   - How to get best of both worlds? Solution: slates!
// - First step: define extension to first order logic (let's call it, say,
//   FOL(Slate))
//   - Add slates as a special sort, but focuses on first order terms.
//     - Emphasize that there are FOL theories *weaker* than combinators.
//     So, with a coherency argument, argue that FOL can be powerful *precisely
//     because* RE is possible, WITH the combination of the completness theorem.
//     (Not possible in all logics!).
// - Second step: show that FOL(Slate) is equivalent to FOL by treating slates
// as an additional sort.
// - Straightforward, but emphasize rule on slates on making meaningful/useful
// abstractions!
// - IF time allows, provide experiments, but mostly argue why, based
// on the argument for slates, this would work.
// - Argue that you could AT LEAST embed the necessary abstractions via slates.
// And organization will help show this is feasible with a theoretical argument
// (but it's not exponential time. It is (hopefully) ACTUALLY feasible.)

// - Final step: show that there is an equivalent embedding that *preserves*
//   slates.
//   - Important part: preservation up to iso!

== Universal Systems

// TODO: make this more precise!!
#theorem[
  Any computable function can be processed as a representation.
]<universality-theorem>

Note that there are multiple ways to prove @universality-theorem, infinitely in
fact. This motivates the following definition.

// TODO: develop!
#definition[
  A universal representation system is a unit that can represent any
  representation.
]

#theorem[
  A unit is a universal representation system if and only if it can represent
  any partial computable function. Moreover, any universal representation system
  can represent any universal representation system. In particular, representing
  itself is called *reflection*.
]

The term _universal_ is specifically for expressing _representations_
symbolically. The free parameter still needs to be included and is an additional
feature on top of partial comptuable functions. However, the _management_ of
these symbols is done entirely with partial computable functions.

The next section discusses the issue of _managing_ these infinite choices.
