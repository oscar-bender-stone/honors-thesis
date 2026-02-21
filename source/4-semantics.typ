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

This section describes several phases to transform parse trees into more refined
forms called *Internal Representations (IR)*. These phases are:

- Abstract Syntax Trees (ASTs): simplifies the parse tree
and removes punctuation.
- Lexographic Ordering: Lexographically orders graphs by names and anonymous
  graph
content.
- Unique IDs: Assigns IDs to all names and resolves absolute and relative paths.
- Merging: merges units and defines the final scopes.

How ASTs are processed and validated. We postpone information organization to
@information-organization.

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
// TODO: determine nice way to describe conversion from parse tree to AST.
#definition[The AST is recursively defined from the parse tree of
  @welkin-grammar as follows:
  - *Terms:* Converted into a list, which is empty if `EPS` is matched.
  - *Term:* either a Root, Arc, Graph, Group, or Path.
  - *Root:* simply stores the corresponding unit.
  - *Arc:* This is converted into a list. The first item is $(s_0, c_0 r_0)$,
    the first triple that occurs in the chain. Then, the remaining triples are
    added to the list.
    - Left arrows are added as $(r_0, c_0, r_0)$. Edges and double arrows are
      added as both a left and right arrow.
  - *Graph:* The terms are collected into two parts: a list of parts and a list
    of arcs. Each graph has a name; when no name is provided, it is `""`.
  // TODO: determine if lists are needed
  - *Group:* The terms are collected into two parts: a list of parts and a list
    of arcs.
  - *Path:*
    - The number of dots is counted for the relative paths.
    - Star imports are denoted by a special node All.
    - A path is converted into a list of its contents,
    which are pairs containing the relative path number and either Unit or All.
    - The `unit` is added at the end.
  - *ID:* converted into strings.
  - *String:* Wraps around the contents.
  // TODO: clarify + make precise!
  - *Number:* converts decimal and hexadecimal into binary, recursively over
    words according to @digit-conversions.
  The terms in the top-level are put into a Graph node containing a unique, user
  given ID.
]<ast>

// TODO: fill in!
#definition[
  AST Equality...
]<ast-equality>


#figure(
  table(
    columns: (auto,) * 17,
    [*Hex*],
    [0],
    [1],
    [2],
    [3],
    [4],
    [5],
    [6],
    [7],
    [8],
    [9],
    [A],
    [B],
    [C],
    [D],
    [E],
    [F],

    [*Dec*],
    [0],
    [1],
    [2],
    [3],
    [4],
    [5],
    [6],
    [7],
    [8],
    [9],
    [10],
    [11],
    [12],
    [13],
    [14],
    [15],

    [*Bin*],
    [0],
    [1],
    [10],
    [11],
    [100],
    [101],
    [110],
    [111],
    [1000],
    [1001],
    [1010],
    [1011],
    [1100],
    [1101],
    [1110],
    [1111],
  ),
  caption: "Conversions of digits between different bases.",
)<digit-conversions>


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
any computable function, because we do not have _conditional_ representations. A
key insight in this thesis is showing that expressing conditions is equivalent
to having _contexts_, which we incorporate into our mechanism for namespaces and
generalizes Burgin's notion of infological systems @burgin-information-book.
This proves an informal claim made in Meseguer @twenty_years_rewriting_logic,
which claims that rewriting logics without conditional rules are "strictly less"
expressive than those with conditions, see @definability-conditions.

We define a _unit_ as an extendible component in a representation that can be
broken down, build new units, or act on other units. Computationally, we can
treat units as IDs to partial computable functions, but we permit _implicit
bindings_ to non-symbolic things (a term made vague for flexibility). From
there, we practically formalize information being _contained_ in a unit,
enabling change in a context through checking for some _non_-fixed point. This
connects to Burgin's analogy of information as energy, as well as Bateson's
famous quote that "information is a difference that makes a difference"
@bateson-ecology-of-mind.

// TODO: take AST and provide merging mechanisms,
// primarily for nodes of the form @b {@.a.*}.
// This means to extend @b *with* the contents of a.
// TODO: mention enumeration of all units. Crucial!
// Will need to mention in the bootstrap.
#definition[
  Create new symbols $"ID"_w$ for each binary word $w$. A *unit* is defined from
  the AST as follows:
  - *Graph*: take each node defined in the graph, and transform it into a unit.
  Take these units and add them to the list of names. Then, take the
  representations and add them to the naes. Apply the import rule at this stage.
  - *Representation*: apply internal transitivity in each context.

  The following rules are applied:
  - *Internal Transitivity*: $a -->^b c$ and $c -->^b$ imply $d => a -->^b d$.
  - Each $@u$ takes each sub-unit $v$ of $u$
  and adds the rule $v --> u.v$ in the current scope.


  The *combination* of units $u, u'$, denoted by $u + u'$ is defined to be the
  pairwise union of components across. Note that is different from the *disjoint
  union*, in which a new top level node is made with children $u$ and $u'$.
]<unit>

Note that, in Welkin, $u + u'$ is definable as $@u {@u'}$.

// TODO: define notion of "or" in this context!
// We need it to be that we can *always* generate a certificate, computably!
#lemma[
  - $a -->^(c+d) b <=> a -->^c b or a -->^d b$.
]<rules-sum>

// TODO: maybe connect back to import notation?
// Woudl something like x.@s be reasonable?
We set $(u -->^v w) in x <=> x(u) -->^(x(v)) x(w)$, where $x(s)$ is the local
extension of $s$ in $x$. We interpret $u -->^c v$ as: the *sign* $u$ represents
*referant* $v$ in *context* $c$. Through @universality-theorem, we will present
the following computational interpretation:

#align(center, block[
  $u -->^v w "iff" phi_u (v) "evaluates to" w$,
])
where $phi_u$ is the partial computable function given by the ID of $u$. Note
that the "iff" above is strictly a logical correspondence; the former is
strictly _more_ expressive, due to implicit bindings.

#definition[
  A unit $u$ is *non-trivial* if it is non-empty and has a non-complete
  representation graph. A unit $u$ is *coherent relative to a context* $u'$ if
  $u + u'$, the union of these units, is non-trivial.
]
#remark[This definition is a natural generalization of consistency in
  first-order logic. We will frequently rely on this result throughout the
  thesis.]

#definition[Let $u, v$ be units. Then $u$ *contains information* $v$ if for some
  $s in v$, $u[s] != s$.]<information>

// TODO: address _why_ information in this way
// enables for more flexibility in choosing axioms.
// What we want in, e.g., formal verification,
// is to check the axioms hold in the first place!
Our notion of information helps with one key issue: the general undefinability
of non-trivial classes of partial computable functions in formal system. This
connects with the absence of a universal _single_ formal system that can prove
any claim about, e.g., Peano Arithmetic.

// TODO: clean up this example.
// Want to emphasize what is information here,
// so, e.g., we may say left and right nodes don't
// have information about each other, in general
#example[
  Trees.
  // #example[
  //   Consider the recursive definition of a binary tree: either it is a null (leaf)
  //   node, or it contains two nodes, left and right. We can model this as follows:
  //   - First, create units for each of the notions: `tree {null, left, right}`.
  //   // TODO: add a condition that the left and right trees are distinct,
  //   // to show this is possible!
  //   - Next, we write,
  //     `tree { nil --> .tree, left..tree, right..tree, {.left, .right} --> .tree}`.
  //     Notice that we refer to the _namespace_ via a relative path, `.tree`,
  //     thereby enabling recursion.
  //   // TODO: fix this up! Show a counter-example
  //   // and how this is not coherent with the definition
  //   - We can test this out in Welkin with:
  //     `my_tree {.tree.left --> {nil --> .tree}, .tree.right {nil --> .tree} }`.
  //     This is then coherent with the previous definition.

  //   // TODO: develop useful derivations + coherency!
  //   Are are two important ideas in this example. First, an abstraction can be
  //   defined prior to a concrete model. The other way is possible as well, showing
  //   how developing representations are flexible in Welkin. Second, the derivations
  //   of trees can now be formulated. So we can defie childs and ancestors, and test
  //   against the coherency of the tree.
  // ]
]

A key technique in managing information and truth through contexts is through
the following theorem. FIXME: this is currently a stub! Need to create the
*correct* condition. Use this as a starting point:
//
/// #theorem[
//   A representation is preserves information modulo $equiv$ iff the
//   representation modulo $equiv$ is coherent.
// ]
#theorem[
  A unit $u$ contains information about $v$ iff $u + v$ is coherent.
]<information-and-coherency>


#theorem[
  Representations with contexts cannot be expressed with those without.
]<definability-conditions>
#proof[
  The largest class expressible with unconditional representations are
  context-free grammars, because... Thus, not all partial computable functions
  are included, completing the proof.
]

== Universal Systems



#theorem[

]<universality-theorem>

As a consequence, we immediately obtain the following corollary.

// TODO: define truth management systems!
#corollary[
  Every truth management system, accepted by some computable function, is
  definable as a unit.
]


Note that there are multiple ways to prove @universality-theorem, infinitely in
fact. This motivates the following definition.

// TODO: develop!
#definition[
  A universal representation system (URS) is a unit that can represent any
  representation.
]


// TODO: Make this more precise and complete proof.
#theorem[
  A unit is a universal representation system if and only if it can represent
  any partial computable function. Moreover, any universal representation system
  can represent any universal representation system. In particular, representing
  itself is called *reflection*.
]

// TODO: dissue axiomatic systems!
// Want to emphasize the relevant *process* (per context) is important!
// That is, the journey to discover new things.
// ONLY FI the specification is complete in some way (or "finalized"),
// it is then that axiomatic systems *can* help.
// Expand this discussion into a paragraph or two.


The term _universal_ is specifically for expressing _representations_
symbolically. The free parameter still needs to be included and is an additional
feature on top of partial comptuable functions. However, the _management_ of
these symbols is done entirely with partial computable functions.

The next section discusses the issue of _managing_ the infinitely many choices
for URSs.

