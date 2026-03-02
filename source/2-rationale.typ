// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Rationale <rationale>

#import "template/ams-article.typ": example

In this section, we justify the design of Welkin.


== Information Content

The main purpose of an information base is to store information and enable user
queries based on the available information. To make this idea precise, we
dissect the approach taken by Algorithmic Information Theory, specifically
through a well known book by Li and Vitányi @intro_kolmogorov_complexity. Their
book focuses on the _information content_ of a description, which they summarize
as follows:

[TODO[SMALL] still resolve how pages should be mentioned!]

#set quote(block: true)
#quote(attribution: [@intro_kolmogorov_complexity, pages 101-102])[
  _We require both an agreed-upon universal description method and an
  agreed-upon mechanism to produce the object from its alleged description. This
  would appear to make the information content of an object depend on whether it
  is particularly favored by the description method we have selected. By ‘favor’
  we mean to produce short descriptions in terms of bits._]

They express this idea with an enumeration $D$ from _objects_ to _descriptions_,
written as strings of symbols. To ensure that their measure is _minimal_ and can
be mechanized, $D$ is a partial computable function. The authors proceed define
the _information content_ of a string through Kolmogorov complexity, the size of
the smallest description that accepts an object, or in other words, the smallest
program that accepts a string. From there, they prove multiple foundational
results for Algorithmic Information Theory, including that Kolmogorov complexity
is uncomputable. This quantity can be approximated by several means, which is
closely involved to compression algorithms.

However, Li and Vitányi's approach does not generally reflect the ways people
disseminate and create new information. The term "object" is a vague term that
is vastly different between disciplines and can be difficult to model for
entities. For example, consider a dynamic biological systems. If objects have
well defined boundaries, what would the "boundary" be of an evolving system?
Another issue is well known in the knowledge management literature as the Symbol
Grounding Problem, formulated by Harnard @harnard-symbol-grounding. As an
example, Harnard considers a person expecting to learn Chinese as their first
language with _only_ a Chinese dictionary. How does the person ground their
symbols in concrete meanings? An information base cannot practically store the
denotations of a word, such as storing animals, so how _original meaning_ is
obtained is unclear.

Several solutions have been proposed to resolve the Symbol Grounding Problem...
Ultimately, however, he problem even arises when modeled with _solely_ formal
entities. For instance, Liu @liu-theory-based-symbol-grounding models symbol
grounding as axioms in a general deductive system, and uses a Gödelian-based
diagonalization argument to show that the grounding predicate, indicating which
symbols are grounded, is undefinable in a single system. In a related work,
symbol grounding can be modeled directly through Kolmogorov complexity
@liu-algorithmic-symbol-grounding, demonstrating the same impossibility of
completely grounding a system of symbols through a fixed grounding set. These
results demonstrate that we need a looser approach, less fixated on
philosophical condrums and more oriented to _practical_ considerations.

== Units

Despite the presence of the Symbol Grounding Problem, we emphasize that an
information base is a _tool_ that is useful when _mechanized_. As such,
information bases are not for resolving philosophical inquiries on the existence
or absence of things or abilities. Information itself is used for _predictions_:
a person that translates the sentence "It will rain today" in Chinese to convey
a semantic property of the world, that there will be rain. This scales to larger
examples, with major theorems providing even more refined or general properties
_given_ a set of assumptions. Note that this is different form Shanon's seminal
work on Information Theory, in which methods are found to convey the _exact_
bits of strings in noisy channels. Because communication _itself_ does not carry
the physical entities, relationships are key to effectively conveying ideas. A
recent work bridges this gap with Shannon's work to express meaning through
finite models in first-order logic @liu-theory-based-symbol-grounding, so that
two strings are considered equivalent if they are that are provably equivalent
as first order sentences are in fact equal, regardless if the strings have
distinct bits.

[TODO[MEDIUM]: go back and ensure this explanation makes sense!]

Taking inspiration from @information-logical-semantics, this thesis completely
generalizes their approach using a notion of _handles_. Handles provide a dual
relationship between a user and information base through a *representation*, in
which a *sign* represents a *referent*. Handles are left as free parameters in
the theory, analogous to how key notions are left undefined in Hilbert's
formalism of geometry, and are characterized by their relationships to other
handles. The user expresses these representations to seek _clarity_ on their
entity of study, to make better predictions, and so forth. To do this, the user
must determine if a set of representations are _faithful_ or actually represent
the study of interest.Thus, declaring representations is equivalent to stating
axioms about handles. Users can refine these through *revisions*, enabling
belief revision.

Given the flexibility of handles to the user, how are they processed in an
information base? There are two key components:


- First, they are handled through IDs, directly inspired by
database theory. They are identified with triples $("UUID", "RID", "HID")$,
whose contents are the *user ID*, *revision ID*, and *handle ID*, respectively.
Revisions ensure that storing axioms is *immutable*, or that a particular handle
does not change over time. This is _not_ a restriction on dynamic entities, but
rather an indictation in the base to determine a particular version of a handle.
Each of these IDs also support _namespaces_, so that two users can have the same
name for a unit and be distinguished.

- Second, handles are characterized precisely by their relationships, which one
can interpret how they are _not_ restricted. This idea is directly inspired from
Fine's idea of arbitrary objects @fine-arbitrary-objects, and connects to the
necessity of induction for formal systems. As a common example, consider how one
can explain the Pythagorean theorem is true about all right triangles. Instead
of drawing _every_ single such triangle, one represents all right triangles with
an _abstracted_ right triangle, using only the properties necessary to show
$a^2 + b^2 = c^2$. The only restriction here is that the triangle must contain a
right angle, but besides this, _nothing_ else is assumed nor required.
Symbolically, this is deeply tied to having _induction_, so that a finite proof
of a base case and inductive invariant can show a claim for _all_ finite cases.
The threshold for "effective" communication is left to the user and tweaked
according to their needs.

Within a fixed revision, handles, by being defined by how they are restricted,
are _exactly_ described by the consequences of their relationships. This can be
interpreted as truth, but we only prove that the language is _expressive enough_
to represent any truth management system. Here, we define a truth management
system to consist of a set of axioms along with inference rules, whose
derivations are accepted by some partial computable function. This is closely
connected to defining what "computbly provable" properties are, akin to defining
an RE set as any set that can be acccepted by a Turing machine. For more
details, see @rationale:bootstrap.

Our core building block to explain this system is through *units*. A unit is
provided by a set of user-defined handles and representations. Units can be
broken down, build new units, or act on other units via representations. Our
approach is slightly more general than the enumerations defined by Li and
Vitányi, see @unit, and they allow _arbitrary_ ways to express formal systems
relative to partial computable functions, see @rationale:bootstrap.
Operationally, units can be used as partial computable functions, but the former
are strictly more expressive, due to user-defined handles and the presence of
induction through handle IDs. Moreover, units contain their own *context*, or a
set of *subunits* and *internal representations*. This is improtant for proving
universality, as the lack of contexts means the theory is _not_ Turing complete.
For more details, see @foundations:context-remark, and that contexts enable an
efficient caching mechanism [TODO: link to this result once it's done!]. We will
use the word context as synonymous for unit, particularly to emphasize the
_contents_ of a unit.

[TODO: make this clear? Can't a unit *be* itself information?]

From the notion of a unit, we practically define information on a unit $v$ as a
unit $u$ which _correctly identifies $v$ from any other unit_. We formalize this
as an invariant based on an equivalence relation on units, determined by the
given set of representations (see @semantics). This notion corresponds to
Burgin's idea of information as an _operator_ that transforms a system, and is
closely to Bateson's famous quote that "information is a difference that makes a
difference" @bateson-ecology-of-mind. Our practical distinction between
information and knowledge is that we _use_ information, but users can assert
their own notions of these terms by creating restricted contexts. We connect our
notion of information back through Algorithmic Information Theory by showing
that the theoretical notion of conditional information content _precisely_
coincides with the size of information, counted in bits (up to a constant)
[TODO: link to this result. Important! And confirm this result! Currently
unchecked.].

[TODO[MEDIUM]: probably provide an example of higher order logic or so? Would be
nice! Shows that we don't need _exactly_ a thing. But do emphasize that getting
_exact_ data formats can make information dissemination easier!]
#example[
  In a scientific experiment, a handle could be an observation or experimental
  data. The unit is then written as a symbol, say $u$, and is _implicitly_ bound
  to this meaning. To distinguish from other symbols, say $v$, the computational
  content is analyzed.[TODO[MEDIUM]: expand out this example!]
]

#example[
  A more looser example is a user written journal for therapy sessions,
  containing information about daily habits and emotions. While neither of these
  are stored in the information base, their handles are, via units $"habit"$ and
  $"emotions"$ in a context $"journal"$. Moreover, multiple revisions of the
  journal can be made with dates or other unique IDs.
]

[TODO[SMALL]: use better names for entities/businesses/etc]
#example[
  A business could represent their operations using a unit $"business"$ that
  contains units for their workers and ledgers. This allows another unit, say
  $"business2"$, to contain its _own_ label $"workers"$ that is separate from
  the one in $"business"$. In addition to separate labels, these contexts can
  have _distinct_ rules, such as those for how business operations are
  performed.
]

There are two primary inference rules, which we informally describe now (and
postpone nested contexts until @semantics):

- *Internal Transitivity:* if $u$ represents $v$ in context $c$ and $v$
  represents $x$ in context $c$, then $u$ represents $x$ in context $c$.

- *Lifting:* if $u$ represents $v$ in context $c$ and $p$ represents $q$ in
  context $v$, then within context $c$, $p$ represents $q$ in _nested_ context
  $u$.

Transitivity is a common axiom in many systems, and its use this contexts is
supported experimentally by existing projects... Lifting is a notion closely
tied to McCarthy's notion of lifting, but formulated with representations. The
idea is, if $a$ represents $b$ in context $c$, then $a$ provides an
_abstraction_ for $b$ relative to $c$. Wherever $b$ is involved in a
relationship, $a$ can be used _instead_, acting as a proxy relative to $c$.
Contexts provide an import mechanism as well, thereby provding Welkin a module
based system. We provide a simplified version of one McCarthy's examples below.
For more existing examples in the literature, refer to
@declarative-formalization-knowledge-translation.

#example[*(McCarthy's Above Theory).* Consider a set of physical blocks. Denote
  the unit `above` to represent the relation `block A is above block B`. We want
  to say this could be `on` to mean `block A is on block B`, or `floating_above`
  to mean `block A is floating above block B`. One way to state is as two
  axioms: and we could state as an axiom: `A - on -> B` implies `A - above -> B`
  and `A - floating_above -> B` implies `A - floating_above -> B`. Lifting
  provides a more economical approach _without_ needing to provide explicit
  terms, or provides a "point-free" rendering. We could that, within `above`,
  `above` represents `on` and `above` represents `floating_above`. In other
  words, `above` _precisely abstracts_ from the precise relationship between the
  two blocks.]

Another example concerns contexts in the prescence of unique objects.

#example[Consider a biological survey of home pets, denoted by context `Survey`.
  Suppose there are two units in `Mammal`, say a dog `Fido` and a cat `Lucy`. We
  could state that `Fido` _represents_ `Mammal`, to say that `Fido` acts as a
  stand-in for a mammal in the survey. The same could be said with `Lucy`
  representing `Mammal`. Note that, depending on the context, the referent need
  _not_ be more refined than the sign; this is an intenional design choice for
  flexibility. With a another context `Taxonomy`, we may naturally state that
  `Mammal - Taxonomy -> Animal`, and we could say
  `Survey - instanceof -> Taxonomy`. Thus, the lifting rule implies in context
  `instanceof`, `Mammal - Survey -> Animal`. Using transitivity, we obtain
  `Fido - Survey -> Animal` and `Lucy - Survey -> Animal` in context
  `instanceof`. We can interpert this example as saying that the _relationsihps_
  of a general taxonomy are witnessed by a specific taxonomy, namely `Survey`,
  and that they propagate through contexts.#footnote[In programming languages,
    particularly C++ @stroustrup-cpp-lang and Java, this property is known as
    "upcasting", with a less refined base class being replaced with a more
    refined subclass. The reverse is "downcasting". Both are supported by Welkin
    for full expressivity.]
]

The remaining rules are primarily for efficiency, enabling users to have
positionally invariant information, see @unit.

== Base Operations

Now, units and information themselves could be expressed in infinitely many
languages, with slightly different syntax or semantics. Welkin is carefully
designed to be a _minimal_ expression of these concepts, with minimal friction
to express any other universal information base. These include:

- Intuitive arrow notation for representations, expressed in ASCII as
  `a - b -> c`. These can be interpreted _as_ rewrite rules, depending on the
  context.

- Traditional braces `{ }` to denote closed definitions of contexts, inspired by
  the C programming language.

- Paths via dots `.` that is inspired by the Python programming language.
  Relative paths are denoted with multiple dots `...`, and absolute imports are
  prefixed with `#`. Subsets of units can be written via `u.{v, x}`, or even
  `u.{v --> x}` to refer to a subset of representations.

- Imports are done through `@u`, which takes all subunits of `u` and puts them
  into the current scope. In other words, the implementation _implicitly_ adds
  denotations `v <--> a.v` for each subunit `v` of `u`. This is motivated by the
  abundance of boolean logic in classical mathematics and computer science, as
  any finite circuit can be expressed in terms of `and` and `not`. Selecting
  specific subunits can be done via `@u.{v, x}`.

- Imports can be _negated_ via the notation `~@u`, and specific units can be
  negated through `~u`. This is an uncommon feature of most programming
  languages, appearing primarily in Haskell and CSS. While potentially opaque,
  Welkin provides robust definitions to ensure that negated forms can be easily
  translated into more explicit ones _and_ back again. [TODO[SMALL]: provide
  link, probably to bootstrap or so?]

- Comments _are_ strings can be treated as any unit. No comments need to be
  removed in the files and can _enhance_ the study of new
  subjects.#footnote[Contexts can mimic regular comments, but Welkin aims to be
    inspectable by users. Encapsulation or private information can be enforced
    through _rejecting_ specific contexts or only accepting certain ones.] These
  units can _then_ be analyzed by others to promote translations to other human
  languages, or be studied through the _overaching relationships_ in the units.

In general, the minimal restricted keywords is crucial for providing support for
other languages. An implementation of Welkin will contain a small section of
ASCII encoding for easier standardization, but the rest of the prgoram can be
done _entirely_ in the user's native language. This is a novel feature in most
programming languages, which are either predominantly English or are fine tuned
for specific human languages. [TODO: cite source on this about most programming
languages being in English, as well as programming languages written in
_different_ human languages. Would be useful to have.]

== Bootstrapping <rationale:bootstrap>

There are two important questions for implementing Welkin:

- How do we practically implement the operations?

- How do we enable any "computably checkable proof"?

On the first issue, the author previously went to manually describing the syntax
and semantics, introducing notions from parsing theory and compilers. While this
format is traditional for a programming language, this postponed the main rules
and made the language specification harder to follow. Moreover, the author
sought to explain the minimal set of axioms required for the system. This
connects to the second issue in a larger way, closely tied into formal methods.

In the formal methods literature, a *Trusted Computing Base (TCB)* is the set of
axioms and code used to implement a program. Axiomatically, most existing proof
assistants have a fixed set of rules, with early proponents arguments towards
having a fixed TCB (see )...

To effectively create any formal system, having _some_ notion of IDs is
necessary in a Trusted Computing Base. Checking the trace of a Turing machine
can be done with a finite certificate, _but_ checking for non-halting in the
general case requires a level of induction, expressed through IDs. Without IDs,
we cannot even _state_ essential constructs or theorems, including the Gödel
encodings.

To resolve both issues, they are combined into approach analogous to dependent
type theory in the sense of "proofs as programs", but in a simpler way. We call
this process "bootstrapping", analogous to bootstrapping a programming language
from another through successive iterations, with each iteration building upon
previous ones to define new language features. We also define the notion of
"computably checkable proof" through reflection, providing a partial translation
from Feferman's work (partial in the sense of not requiring the _same_ semantics
as first order logic) @feferman-reflection. While a _single_ formal system
cannot enumerate through these proofs by Gödel incompletness theorem, our theory
provides the most flexibility and enables the _potential_ of expressing any
recursive ordinal, i.e., the set of axioms allowed is _not_ fixed but depends on
context.

Taken together, the steps for bootstrapping Welkin are:

+ Formalize the base rules on units. Using English as our meta-language, we
  prove that our rules can define the $S$ and $K$ combinators as any combination
  of terms, and thus is Turing complete. Having Turing completeness ensures the
  language is expressive enough (as per Goal 1), but we will use more direct
  notions in terms of the rules for ease of presentation. Another rule we add is
  for a specific verifier for proofs, which we can prove in the system is
  correct. We will later show this is _not_ a restriction and applies to any
  computably checkable proof.

+ Provide the base meta-theory for the language _in_ Welkin. This will be PRA,
  written in a combinator based form. We will show the main axioms of PRA hold.

+ Prove that Peano Arithmetic is provably sound in a weak sense using a method
  developed by Artemov @artemov_serial_consistency. From there, we carry out
  Feferman's Reflection theorem written with our notions.

+ Defin handles and information. We also justify information organization to
  promote the _most_ optimal paths to prove things, _if_ proofs are provided.
  This is deeply connected to Blum's speedup theorem and is essential for
  proving Goal 2.

+ Define the rules for path resolution and global IDs. These use a similar
  result to syntax descriptions and are significantly easier to read. [NOTE:
  emphasis on WIP here! Not yet developed in thesis !]

+ Finally, define the syntax through an _invertible syntax description_. This
  idea, pioneered by Rendel and Ostermann @invertible-syntax-descriptions,
  provides a combinator approach to define how concrete syntax, that is user
  written, is converted into abstract syntax, an abstracted form, _and back_.
  Along with the syntax, the encoding is given _itself_ through a
  representation, namely a table provided in this thesis.

