// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block
#import "template/ams-article.typ": corollary, lemma, proof, theorem
#import "template/ams-article.typ": todo


= Semantics <semantics>

This section describes several phases to transform parse trees into more refined
forms called *Internal Representations (IR)*. These phases are:

- Abstract Syntax Trees (ASTs): simplifies the parse tree
and removes punctuation.
- Lexicographic Ordering: Lexicographically orders graphs by names and anonymous
  graph
content.
- Unique IDs: Assigns IDs to all names and resolves absolute and relative paths.
- Merging: merges units and defines the final scopes.

How ASTs are processed and validated. We postpone information organization to
@information-organization.

== Abstract Syntax Tree (ASTs)

Given the rationale, we explain how the Abstract Syntax Tree (AST) is processed
for the syntax. The AST provides an intermediate step before the final data
structure.


// TODO: define scoping rules with @.
// Important to preserve *original* files when possible.
// Will need @ by default to import things
// TODO: determine nice way to describe conversion from parse tree to AST.
#definition[The *Abstract Syntax Tree* is recursively defined from the parse
  tree of @welkin-grammar as follows:
  - *Terms:* Converted into a list, which is empty if `EPS` is matched.
  - *Term:* either a Root, Arc, Graph, Group, or Path, with two additional
    fields:
    - *Position:* a pair $("Line", "Column")$, where $"Line"$ is the first
  number of newline ("\n") characters occurring before the term and $"Column"$
  is the position of this term on the line. Both of these are stored as bytes.
  - *Root:* simply stores the corresponding unit.
  - *Arc:* This is converted into a list. The first item is $(s_0, c_0 r_0)$,
    the first triple that occurs in the chain. Then, the remaining triples are
    added to the list.
    - Left arrows are added as $(r_0, c_0, r_0)$. Edges and double arrows are
      added as both a left and right arrow.
  - *Graph:* The terms are collected into two parts: a list of parts and a list
    of arcs. Each graph has a name; when no name is provided, it is `""`.
  - *Tuple:* The terms are organized recursively, with the base case starting
  at `item` and the recursive step at the label `next`. Note that tuples have
  *closed* definitions and will create copies when accessed or used in an arc.
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

[TODO[SHORT]: determine nice way to merge this with @word-equality!] #figure(
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


// TODO: complete! Need to address @, ~@, and ~
#definition[An Abstract Syntax Tree is *valid* if the following holds:
  - A Root term must exist. Moreover, there must not be conflicting Root term
    names.
  - Relative imports does not exceed the number of available parents.
]<validation>
#remark[
  An earlier revision of this thesis forbid repetitions of arcs and units.
  However, this restriction was removed to provide greater flexibility. This
  will be tracked, see ?.
]<remark:validation-repetition>

== Unified IDs

This phase first lexicographically orders the graph by its labels. Anonymous
graphs are lexicographically ordered by contents, with arcs treated as triples
and lexicographically ordered accordingly. Then, IDs are assigned. The
lexicographic ordering ensures the ID is _exactly_ the same for two strings that
are positionally different. This shows that Welkin is positionally invariant.

== Unification

This phase merges the units into the final data structure.


[TODO[SHORT]: add link to quote!]
#remark[
  In contrast to the requirement to the beginning of Li and Vitány (see
  @rationale), the enumeration need _not_ be surjective but only _locally_ so.
  Abstracting away from the implicit meaning, units act as partial computable
  functions, but the latter is strictly _less_ expressive by removing user
  provided meaning.
]

[TODO: ensure this definition is general enough! We will need to tackle the
third rule, having unspecified parameters, more in depth. Does this mean an
implementation defined feature? Or does it generalize it?] However, this is only
one component: we also must prove we can represent _any_ truth management
system. This is made possible through contexts. We define a *truth management
system* generally as a partial computable function augmented with parameters
that denote the truth of base statements or *axioms*. These are intentionally
left undefined, in the same vein as *R3*. In fact, by *R3* and
@universality-theorem, we obtain the following.

#corollary[
  Any computable truth management system can be represented as a
]<universality-truth-management>

Note that it is essential to have contexts via *R2*, as shown by the following.

#theorem[
  Representations with contexts cannot be expressed with those without.
]<definability-conditions>
#proof[
  The largest class expressible with unconditional representations are
  context-free grammars, because... Thus, not all partial computable functions
  are included, completing the proof.
]

== Queries and Information
We set $(u -->^v w) in x <=> x(u) -->^(x(v)) x(w)$, where $x(s)$ is the local
extension of $s$ in $x$. We interpret $u -->^c v$ as: the *sign* $u$ represents
*referent* $v$ in *context* $c$. Through @universality-theorem, we will present
the following computational interpretation:

#align(center, block[
  $u -->^v w "iff" phi_u (v) "evaluates to" w$,
])
where $phi_u$ is the partial computable function given by the ID of $u$. Note
that this is _only_ logical equivalence; the former is strictly _more_
expressive, due to implicit bindings.

#definition[
  A unit $u$ is *non-trivial* if it is non-empty and has a non-complete
  representation graph. A unit $u$ is *coherent relative to a context* $u'$ if
  $u + u'$, the union of these units, is non-trivial.
]
#remark[This definition is a natural generalization of consistency in
  first-order logic. We will frequently rely on this result throughout the
  thesis.]

// TODO: complete!
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

[TODO: clean up this example. Want to emphasize what is information here, so,
e.g., we may say left and right nodes don't have information about each other,
in general]
#example[
  Consider the recursive definition of a binary tree: either it is a null (leaf)
  node, or it contains two nodes, left and right. We can model this as follows:
  - First, create units for each of the notions: `tree {null, left, right}`.
  [TODO: add a condition that the left and right trees are distinct, to show
  this is possible!]
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
  of trees can now be formulated. So we can define descendants and ancestors,
  and test against the coherency of the tree.
]

A key technique in managing information and truth through contexts is through
the following theorem. FIXME: this is currently a stub! Need to create the
*correct* condition. Use this as a starting point:

#theorem[
  A unit $u$ contains information about $v$ iff $u + v$ is coherent.
]<information-and-coherency>

[TODO: Develop the notion of a query and its relation to information.
Ultimately, we want to define information based on how useful it is for querying
the database. We want to define a query to be anything we can inquire _about_ a
database that we we can (partially) computably represent. Information should
then follow quickly from there as a _partial_ answer. Having _enough direct_
information means being able to _fully_ solve the query. Moreover, the goal will
be to use that this notion of enough is efficient, so checking for this should
be efficient, say $O(n)$ or $O(n^2)$. This will likely be based on rewrite
rules, in combination with axiom *R3*.]

[TODO: a core part of queries is *indirect* information, or information that may
not be directly visible by immediately applying rewrite rules. This relates to
my earlier attempts on a universal progress theorem. What I want is to know if
query is "well-posed" or _can_ be solved by a computable representation. This
well-posedness needs to be _defined_ in the truth system itself, and part of
this may be undecidable. However, most of this should be converted to
_finitistic properties of comptuable functions_. This will be my new version of
"universal progress", and I may provide an example where introducing _bridging_
representations may be effective, such as through mathematics and music (which
is _not_ necesarially a homomorphism between proof systems.)]
