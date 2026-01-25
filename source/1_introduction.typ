// SPDX-FileCopyrightText: 2025-2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": todo

= Introduction

Knowledge management is an active problem due to the exponential expansion of
new fields. As one major problem, journals are often highly specialized,
requring an immense understanding of the broader concepts involved and
nomenclature used. This is evident in the sciences, as explored in
@hierarchy_science, @specialized_science. Additionally, representing knowledge
can be difficult. In mathematics, for example, several attempts have been made
to catalog major theories and results. [DESCRIBE ATTEMPTS & LIMITATIONS]. In
other subjects, like the social sciences, there are _no_ standard terms, and the
majority of cited references are books, which are not indexed by many databases
@social_sciences_databases. As another challenge, many formats are fragile to
incorrect syntax [EXPLAIN AND ELABORATE]. Each of these issues, a small fraction
of existing barriers, demonstrate the difficulty in creating a knowledge base
with both broad applicability and faithful representations to the original
research.

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

// #todo[REWORD as needed + merge with discussions on FAIR.]
// Information has been extensively studied through _measurements_ in Algorithmic
// Information Theory (AIT). The founding idea of AIT is the Minimum Description
// Length (MDL) principle, that the best definition for an object is the smallest
// description that describes it. To formalize this idea, Kolmogorov defined a
// description as a _program_, and the Kolmogorov complexity of a string as the
// length of the _smallest program_ that computes that string (see
// @intro_kolmogorov_complexity). This program is defined via a Turing-computable
// programming language, and there is a different constant factor depending on the
// language, but AIT focuses on the asymptotic complexity. A cornerstone of this
// framework is providing the reason underlying cause of Gödel's incompleteness
// theorems, Turing's halting problem, Tarski's undefinability of truth, and more:
// _not all information can be compressed into a finite description_. This view was
// articulated by Chaitin on information compression. He defined $Omega$ as the
// probability that a random Turing machine will halt and proved that it cannot be
// compressed computably. This result is a major theme in AIT, to address the
// limits of computation.


// In addition to addressing these limits, Chaitin's results have profound
// consequences for the nature of mathematics. He explains:

// #set quote(block: true)
// #quote[_Mathematics...has infinite complexity, whereas any individual theory
//   would have only finite complexity and could not capture all the richness of
//   the full world of mathematical truth_. @limits_on_reason]

// Chaitin's claim extends beyond mathematics; the extent of research areas are so
// vast that the idea of a _single_ theory would fail to faithfully reproduce these
// disciplines. The study of the areas _themselves_ is needed to faithfully
// represent them. This has been explored in Béziau's field of Universal Logic
// @universal_logic, where the aim is to study _logics_ and not a _single_ logic.
// In short, Chaitin's result, and the works in Universal Logic and others,
// demonstrate that research must be represented _flexibly_ as well as faithfully.

// The problem with a flexible representation system is precisely _how_ to
// accomplish this. AIT provides asymptotic results on information _measurement_,
// but does not provide a guide on the fixed representation to use. Chaitin created
// a LISP variant, designed specifically for the ease of implementation and
// analysis @chaitin_lisp, but this does not address the faithful representations
// of other languages. Additionally, Universal Logic provides a single definition
// of a logic, one which can be tedious in exotic logics. Each of these issues
// underly the importance of _organization_ itself, which emerge in the
// proliferation of general-purpose programming languages.

// To work back in the original logic, a key requirement is _faithfulness_,
// that isomorphisms in a theory must be reflected, a notion called
// "$epsilon$-representation distance" by Meseguer @twenty_years_rewriting_logic.
// However, the researchers surrounding Universal Logic are, too, their own
// community, and have their own broad defnition of a logic, which is distinct from
// those in Categorical Logic, Type Theory, and others.

// An alternative approach is to create an Intermediate Representation (IR) that
// other languages can compile into (_frontends_), and then compiled onto multiple
// machine architectures (_backends_). The driving standard in industry and
// research for this purpose is the LLVM compiler project @llvm_main. However, this
// project faces ongoing challenges, with a brief list including breaking changes
// and a massive packaging task accross different Operating Systems. One approach
// that addresses a subset of these problems is MILR @milr_llvm, another IR to
// abstract away from the original. Implementing these systems for _general_
// programs is not the intent of this thesis, and instead, is to _bridge_
// information _about_ programs. Therefore, we are interested in _unifying
// representations_ of these languages.


The aim of this thesis is to create a universal information language to
standardize _any_ knowledge representation. I call this language *Welkin*, based
on an old German word meaning cloud @dictionary:welkin. This language has the
following goals.

== Goals

- *Goal 1: Universality.* The language must include unspecified, user created
  parameters to accomodate for arbitrary concepts and ideas.

- *Goal 2: Standardization.* The language needs a rigorous and formal
  specification. Moreover, the bootstrap must be formalized, as well as an
  abstract machine model. The grammar and bootstrap must be fixed to ensure
  complete forwards and backwards compatbility.

- *Goal 3: Efficiency.* Local queries in the database, determining if there is
  enough "explicit" information, must be efficient.


== Organization

// TODO: Maybe provide as another table _with_ descriptions?

- Section 2. Foundations: defines the meta-theory use and its
connections to first-order logic and fragments of arithmetic.

- Section 3. Information Organization. Develops the optimal informal system
  (w.r.t to a metric defined in this system) to satisfy Goal 3.

- Section 4. Defines the syntax and semantics.

- Section 5. Bootstraps Welkin by proving that there is a Welkin node that
  contains enough information about the standard. Fulfills Goal 2 with both the
  Standard AND the complete bootstrap.

- Section ?. Prototype. Time permitting, develop a prototype to showcase the
  language, implemented in python with a GUI frontend (Qt) and possibly a
  hand-made LL(1) parser.

- Section 8. Conclusion. Reviews the work done in the previous sections. Then
  outlines several possible applications.

