// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block
#import "template/ams-article.typ": corollary, lemma, proof, theorem
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


= Semantics <semantics>

This section describes how ASTs are processed and validated. We postpone
information organization to @information-organization.

== ASTs
- Semantics on ASTs
  - Terms: graphs
  - For ease of use, include a null node
  that is the root of the tree. This represents the module itself.

== Representations

To introduce our foundations, we need to ensure the language is _expressive_
enough. As an information language, the core design is to mechanize the storage
and retrieval of information, so we generally say that this must be processed as
a computable function, which is a well estalished notion. Thus, at the very
least, we must express all computable function; this is shown in
@universality-theorem.

#todo[Prove the claim for partial computable functions and IO!]
However, we need more than computable functions: we seek _clarity_ in concepts.
We need to include meaning into the symbols, so we at least need
representations. This encompasses partial computable functions as well by
modelling non-termination as a unit, as well as Input/Output mechanisms.

Given these two components, managing information with computable functions and
including representations, we argue that Welkin precisely captures anything
_representable by a computable representation_. Practically, we impose defining
things based on the _least_ restrictions. Having a _self-contained_ definition
of "anything", or a definition with _no_ restrictions, is problematic, as shown
in the introduction. But the least _practical_ restriction is precisely having
representations accepted by a computable function. This provides a best of both
worlds: the flexibility for any (reasonable) concept, and guarantees
mechanically feasible operations on representations.

Now, given that computable representations are sufficiently expressive for a
mechanical information base, a cruical inquiry is to study _how to represent
representations themselves_. At the very least, a _sign_ represents a
_referant_. #footnote[Part of our terminology and concepts originate from
  Peirce's philosophical theory of semiotics. Note that this thesis focuses on
  representing representations, though it does make some of Peirce's ideas more
  precise.
] However, this is not sufficient to express any computable function, because we
lack conditional checks. A key insight in this thesis is showing that having
these conditions is equivalent to having a general namespace mechanism.

Now, a key component of this argument, as well as our truth management system,
is proving _true_ things about computable functions. We develop the machinery
through Welkin's meta-theory.

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

#definition[
  A unit $u$ is *non-trivial* if it is non-empty and does not contain all
  relations. A unit $u$ is *coherent relative to a context* $u'$ if $u + u'$,
  the union of these units, is non-trivial.
]
#remark[This definition is a natural generalization of consistency in
  first-order logic. We will frequently rely on this result throughout the
  thesis.]

#theorem[
  A representation is preserves information modulo $equiv$ iff the
  representation modulo $equiv$ is coherent.
]
#remark[This theorem enables truth management via specific contexts, specified
  as units. The task of finding core truths is then free, left open to
  flexibility accommodate for any truth management.]



== Truth Management


Welkin manages truth through a flexible interface, grounded in the true
properties on computable functions. The term "properties on computable
functions" needs to be carefully defined. Do we only restrict this to a well
established theory of arithmetic, like Peano Arithmetic, or permit larger
notions, like infinite ordinals like ZFC?


...


#todo[Come up with a term for "observations representable by computable
  functions".]
#corollary[
  Any truth management system representable by computable functions can be
  represented in Welkin.
]




== Universal Systems

Inspired by @twenty_years_rewriting_logic, we prove that scoping is strictly
more expressive than without.

#todo[TODO: define the generalization to Padoa's Method clearer.]
#lemma[Representations with interpretations are undefinable in terms of
  unlabeled representations.]
#proof[
  It suffices to note that representing partial computable functions requires
  combinations. But every transformation under unlabeled representations does
  not preserve these conditions, hence, representations with interpretations are
  not definable.
]

Note that there are multiple ways to prove @universality-theorem, infinitely in
fact. This motivates the following definition.

// TODO: develop!
#definition[
  A universal representation system (URS) is a unit that can represent any
  representation.
]

#todo[Make this more precise and complete proof.]
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

The next section discusses the issue of _managing_ the infinitely many choices
for URSs.

#theorem[

]<universality-theorem>
