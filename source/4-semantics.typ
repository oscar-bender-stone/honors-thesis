// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
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


= Semantics

== ASTs
- Semantics on ASTs
  - Terms: graphs
  - For ease of use, include a null node
  that is the root of the tree. This represents the module itself.
- For information organization: integrate with previous section
  - Emphasize how this is a useful tool and can ensure
  *new* information content is being created (at least, that can be distnguished
  from the current module). If already existing, but that doesn't match the
  user's expectations, they need to refine it! OR, maybe it *does* match
  similarly with something else! (e.g., hidden connections between math and
  music)
- Emphasize pragmatics as well, via units

== Representations

Now we develop the formal framework to discuss information in terms of units,
enabling a complete mechanization of Welkin's meta-theory. To keep this section
self-contained, we explicitly provide all recursive definitions.


#definition[
  The *alphabet of units* is $cal(A)_"unit" = u | cal(A)_"word"$. A *unit ID* is
  combination of symbols $u_w$, where $w in "word"$.
]<unit-ids>

#definition[A *free parameter* is a parameter given an associated ID. No further
  restrictions are imposed.]<free-parameters.>

We now define representations recursively, using unit IDs and free parameters as
the base case.

// TODO: incorporate references.
// Can we instead define representations *via* references (with free parameters)?
#definition[
  Units are recursively defined:
  - *Base case:* IDs and free parameters are units.
  - *Recursive step:*
    - *Parts:*: if $u_1, .., u_n$ are finitely many units, then so is their
      combination ${u_1, ..., u_n}$. A combination defined without a provided ID
      is called an *anonymous unit*.
    - *Representations:* If $u, w, v$ are units, so is $v --> u$. We say $v$
      *represents* $u$. or conversely, $u$ is *represented by* $v$.
]

Key equalities:
- $u.{} = u$. Acts as a sort of \* operator from other languages.
  - To use one level up: $.u$
- $(u -->^v w) in x <=> x(u) -->^(x(v)) x(w)$, where $x(u)$ is $x.u$ if $u in x$
  or $u$ otherwise.

#example[Consider a house with a dog, a cat, and a person. We can represent the
  house as unit `house`, the dog as unit `dog`, the cat by unit `cat`, and the
  person by unit `person`. In our Welkin file, we add,
  `house { dog, cat, person}`. The `person` has an internal concept of `pet` and
  uses it to represent both the `dog` and `cat`, which we write as
  `person { animal --> dog, animal --> cat}`, under the scope of `house`.
]

Parts of units are denoted as $u.u'$. Scoping is included to provide namespaces.
Moreover, parts enable *interpretations*. We write $u -->^v u'$ in case
$u, v, (u --> v) in u'$, so $u$ represents $v$ *via* $u'$. In this case, we say
$u'$ is a *context* to $u --> v$. Note that unlabeled representations can have
multiple contexts.

// TODO: clean up this example.
#example[
  Consider the recursive definition of a binary tree: either it is a null (leaf)
  node, or it contains two nodes, left and right. We can model this as follows:
  - First, create units for each of the notions: `tree {null, left, right}`.
  - Next, we write,
    `tree { null --> .tree, .tree --> left, .tree --> right, {.left, .right} --> .tree}`.
    Notice that we refer to the _namespace_, thereby enabling recursion. By our
    scoping rules, writing `tree` would be a _new_ unit.
  - To impose that the left subtree is _distinct_ from the right one, we can use
    symbols.

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

Inspired by @twenty_years_rewriting_logic, we prove that scoping is strictly
more expressive than without.

#lemma[Representations with interpretations are undefinable in terms of free
  representations.]


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
