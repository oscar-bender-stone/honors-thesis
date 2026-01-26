// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem
#import "template/ams-article.typ": todo

= Foundations <foundations>

This section establishes the meta-theory for Welkin, capturing the major
components of symbolic systems. The meta-theory consists of two interconnected
parts:
- The computational part, which can express
any partial computable function via combinators.
- The logical part, which enables checking on properties of symbols and
  certificates on normal forms.

This approach generalizes Fefermans' Explicit Mathematics framework
@feferman_arithmetic_metamath, which intentionally separates computation from
logic. We build upon this framework by incorporating slates, as well as having a
robust model of trust through work done by Artemov @artemov_serial_consistency.

== Minimal Trusted Computing Base

We first need to establish the logical machinery underlying the theory.

== Philosophy Behind Slates

Slates are inspired by several theories. The most prominent arises in Burgin's
theory of information @burgin-foundations-information, @burgin-information-book.
Given an information system $*R*$, he specifies an infological system
$"IF"(*R*)$ as a free or unspecified parameter to $*R*$, meant as a way to
tailor the system to domain specific terminology. For example, if $*R*$
represents an AI agent, then $"IF"(*R*)$ could be the knowledge associated to
$*R*$. From this notion, he defines information as follows:

#set quote(block: true)
"information for a system R is the capacity of objects to produce changes into
an infological system $"IF"(*R*)$ of $*R*$".

However, Burgin does not develop rules to work with these parameters, and the
rest of his results exacerbate a divide between these and his formal semantics.
We want a broader notion of information that can bridge these divides and spread
accross infological systems.

#todo[Finish writing up this paragraph + ensure accuracy!]
Seeking to augment Burgin's approach, we examine Kit Fine's notion of arbtirary
objects @fine-arbitrary-objects. In his seminal work, he formalizes Cantor's
definition of numbers via "Cantorian abstraction". Instead of defining a number
through a Fregean set of all things with that quantity, or an artifical
construct like Von Neumann ordinals, Cantor defined a number as a set of
abstract entities. Fine proceeds to formalize this within a first-order logic.
Several papers have explored this in different ways, including
@shapiro-arbtirary-objects. However, Valaris
@valaris-induction-arbitrary-objects provides a key objection to using
induction... We address this with a powerful symbolic rule for slates that make
slates themselves rules, in a specific sense.#todo[Write up details in next
  section! Make sure this is accurate!]

== Slate Logic

- Definition
  - Define binary strings. Assign these to slates.
    - Have *slate variables*. This is our entry
    point into arbitrary interpreters.
    - Can change meaning based on interpretation/context!
    Emphasize how there can be a many to one relationship, and we need to
    increase formal systems available to distinguish between them!
    - Emphasize need for a function that can enumerate these slate
    variables. So NOT just one slate variable. Maybe provide lemma on
    impossibility of doing more (within a formal system?)
  - Combinators
    - Want a *simple* presentation to define theory.
    We do require substitution (variables are important here!), but want to
    present theory with combinators.
    - Emphasize that this is a bootstrap/easier way to start.
    Just like starting somehwere on a map and then relocating (make this
    clearer!)
  - Justifications: what we can assert about *formal objects*
    - Inspired by Artemov's logic of proofs. Will connect back in
    next two sections with serial consistency!
- Examples
  - Sorting dishes (analogy from before)
  - Map analogy, with places as IDs AND paths
    - Emphasize that new objects can be given
    IDs arbitrarily; that is why we need (countably) infinitely many IDs!

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


