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

== Rationale <rationale>

We justify why the language is focused on representations. First, to mechanize
the information language, we allow only total computable functions, with
computability being a well established notion. Second, to enable clarity in
concepts, we need to resolve the Symbol Grounding Problem, so as to avoid
treating all symbols as being "empty", as discussed in @liu-grounding. We must
therefore include a notion of representation, which, in particular, can
represent partial computable functions. Finally, we claim that expressing _any
computable representation_ is sufficient for a universally expressible
information system. Attempting to provide a self-contained definition of the
notion "any" is problematic, as shown from the introdution. We instead define
"any" with the _least_ restrictions possible, which means, by the first point,
ensuring that a given provided input is accepted by _some_ computable function.
It is important that Welkin includes _every_ computable function in this
definition, which we prove in @universality-theorem.

== ASTs

Given the rationale, we explain how the Abstract Syntax Tree (AST) is processed
for the syntax. The AST provides an intermediate step before the final data
structure.


#figure(
  table(
    columns: (auto, auto, auto),
    [*Hexadecimal*], [*Decimal*], [*Binary*],
    [0], [0], [0],
    [1], [1], [1],
    [2], [2], [10],
    [3], [3], [11],
    [4], [4], [100],
    [5], [5], [101],
    [6], [6], [110],
    [7], [7], [111],
    [8], [8], [1000],
    [9], [9], [1001],
    [A], [10], [1010],
    [B], [11], [1011],
    [C], [12], [1100],
    [D], [13], [1101],
    [E], [14], [1110],
    [F], [15], [1111],
  ),
  caption: "Conversions of digits between different bases.",
)<digit-conversions>

Note that for words, we add a conversion from decimal and hexadecimal into
binary via @digit-conversions. We provide the explicit recursive definiton based
on this table in @word-conversions, where `a <--> b` means that `a` is converted
into `b` and vice versa. This is a restriction on the notion of representations
that will be addressed in @bootstrap.

// TODO: determine if "0x0".something should mean string concatenation.
// Might be nice to have?
// But then we have to distinguish with our notation,
// so maybe use seomthing *besides* . for contaenation?
// TODO: complete!
#figure(
  ```
  ```,
  caption: "Recursive definition for converting words between bases.",
)<word-conversions>

#figure(
  ```
  "0".word <--> word
  "0b0".word <--> "0b".word
  "0x0".word <--> "0x".word
  ```,
  caption: "Conversions with leading zeros.",
)<leading-zeros>


// TODO: define scoping rules with @.
// Important to preserve *original* files when possible.
// Will need @ by default to import things
#definition[The AST is recursively defined from the parse tree as follows:
  - *Arc:* Converts a chain into a list of tuples of the form (sign, context,
    referant). Renders each edge as a left and right arrow.
  - *Graph:* The terms are collected into two parts: a list of parts and a list
    of arcs.
  - *Path:*
    - The number of dots is counted for the relative paths.
    - Star imports are denoted by a special node All.
    - A path is converted into a list of its contents,
    which are pairs containing the relative path number and either Unit or All.
  // TODO: determine if the name of a welkn file could be
  // defined in the file itself. Might be useful?
  The terms in the top-level are put into a Graph node containing a unique, user
  given ID.
]<ast>

#definition[An AST is *valid* if the relative imports does not exceed the number
  of available parents.
]<validation>
#remark[
  An earlier revision of this thesis forbid repetitions of arcs and units.
  However, this restriction was removed to provide greater flexibility. This
  will be tracked, see ?.
]<remark:validation-repetition>

== Faithful Representations and Truth Management

Based on @rationale, a crucial question is to answer _how_ representations can
be used in the language. A representation at least contains two components: a
_sign_ that represents a _referant_. However, this is not sufficient to express
any computable function, because we lack conditional checks. A key insight in
this thesis is showing that having these conditions is equivalent to having a
_context_, which we incorporate into our mechanism for namespaces. This proves
an informal claim made in Meseguer @twenty_years_rewriting_logic, which claims
that rewriting logics without conditional rules are "strictly less" expressive
than those with conditions.

// TODO: discuss connection of not being able to define all computable
// functions and not having a heory that proves everything.
// Can enumerate through all *partial* computable functions,
// but undecidable to get all the computable ones.
// This relates to the inability to show all functions
// are computable in a single, RE theory
Now, a key component of this argument, as well as our truth management system,
is proving _true_ things about computable functions. We develop the machinery
through Welkin's meta-theory.

// TODO: write out this outline
- Key Points:
  - In this thesis, infological systems from Burgin are represented as context
  - A unit $u$ is *information* about $v$ if $I(s) != s$ for some $s in v$.
    Highlight that this correpsonds to

Units are enumerated through symbols $u_i$, where $i$ is a binary word. We say
$i$ is the *ID* of $u_i$.

// TODO: define how the AST is converted
// into a WIG.
#definition[A *Welkin Information Graph* is defined recursively.
]<WIG>

We set $(u -->^v w) in x <=> x(u) -->^(x(v)) x(w)$, where $x(u)$ is $x.u$ if
$u in x$ or $u$ otherwise.

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
  // TODO: add a condition that the left and right trees are distinct,
  // to show this is possible!
  - Next, we write,
    `tree { nil --> .tree, left..tree, right..tree, {.left, .right} --> .tree}`.
    Notice that we refer to the _namespace_ via a relative path, `.tree`,
    thereby enabling recursion.
  // TODO: fix this up! Show a counter-example
  // and how this is not coherent with the definition
  - We can test this out in Welkin with:
    `my_tree {.tree.left --> {nil --> .tree}, .tree.right {nil --> .tree} }`.
    This is then coherent with the previous definition.

  // TODO: develop useful derivations + coherency!
  Are are two important ideas in this example. First, an abstraction can be
  defined prior to a concrete model. The other way is possible as well, showing
  how developing representations are flexible in Welkin. Second, the derivations
  of trees can now be formulated. So we can defie childs and ancestors, and test
  against the coherency of the tree.
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
