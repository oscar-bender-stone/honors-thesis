// SPDX-FileCopyrightText: 2025-2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": todo

= Introduction

Information Management (IM) is an open area of research as a result of the depth
and breadth of disciplines. In terms of depth, many areas are often specialized,
requiring an immense understanding of the broader concepts involved and
nomenclature used. This specialization is evident in the sciences, as explored
in @hierarchy_science, @specialized_science. Additionally, in terms of breadth,
creating common representations shared across sub-disciplines can be difficult.
For example, mathematics has extremely diverse disciplines, and connecting these
areas is an open problem in scalability @big-math-problems. Moreover, creating a
standardized form across communities is challenging. In other subjects, like the
social sciences, there are no standard terms @social_sciences_databases, and in
the humanities, representing certain artifacts as data is involved
@ALLEA-FAIR-humanities. More broadly, IM _itself_ is divided from distinct
approaches that lack interoperability @information-management-frameworks.
Certain frameworks equate IM to Knowledge Management (KM) and assert that
information must be true @information-and-knowledge-management. These problems,
in both faithfully and broadly storing information, demonstrate the enormous
task of effective IM.

// TODO: determine whether to address several general IM approaches,
// or just focus on Burgin's GTI
In response to these challenges, several solutions have been proposed, but none
have been fully successful. In the sciences, a group of researchers created the
Findable Accessible Interoperable Resuable (FAIR) guidelines
@FAIR_guiding_science. Instead of providing a concrete specification or
implementation, FAIR provides best practices for storing scientific information.
However, multiple papers have outlined problems with these overarching
principles, including missing checks on data quality @FAIR-data-quality, missing
expressiveness for ethics frameworks @FAIR-and-CARE, and severe ambiguities that
affect implementations @FAIR-implementation. Along with the sciences, there are
several projects for storing mathematical information (see
@review-math-knowledge-management for more details). Older proposals, including
the QED Manifesto @qed-reloaded and the Module system for Mathematical Theories
(MMT), aimed to be more general and have seen limited success. More centralized
systems, like mathlib in the Lean proof assistant @lean-mathlib, have seen
adoption but do not give equal coverage nor are interoperable with other
systems. Beyond more "hard" fields, IM in the humanities has few models,
including aan adaption of FAIR @ALLEA-FAIR-humanities and discipline specific,
linked databases in the PARNTHEOS project @digital-humanities-foresight. Each of
these proposals, even within speciic fields, fail to accommodate for all of the
mentioned challenges.

In addition to domain specific proposals, there are approaches for general IM
which still fail to resolve all issues. One prominent example is Burgin's theory
of information @burgin-information-book that comprehensively includes many
separate areas for IM, including the complexity-based Algorithmic Information
Theory (AIT), through a free parameter called an "infological system", which
encompasses domain specific terminology and concepts. In contrast to other
approaches, Burgin's generalized theory is flexible and enables greater coverage
of different kinds of information @mark-burgin-legacy. Despite this coverage
Burgin does not closely tie the free parameter with his formal analysis of AIT,
making it unclear how to use this in a practical implementation. Broad
frameworks for IM, along with the specific proposals, have severe shortcomings,
highlighting major obstacles for IM.

This thesis introduces a language to resolve these issues. I call this language
*Welkin*, based on an old German word meaning cloud @dictionary:welkin. The core
result of this thesis is proving that Welkin satifies three goals: is
*universal*, *scalable*, and *standardized*. For details, see @goals. The core
idea is to generalize Burgin's free parameter and enable arbitrary
representations in the theory, controlled by a computable system. The notion of
representation builds on Peirce's semiotics, or the study of the relationship
between a symbol, the object it represents, and the interpreter or
interpretation that provides it that meaning @sep-peirce-semiotics. Moreover, to
address queries on the validity of truth, we use a relative notion that includes
a context managed by a formal system. Truth can then be determined on an
individual basis, providing flexibility to any discipline. The focus then shifts
to the usefulness of representaitons based on a topological notion of
"collapse", which we call *coherency*. This approach is inspired by coherentism,
a philosophical position that states truth is determined in comparison to other
truths. @bradley-principles-of-logic. We incorporate ideas from coherentism to
identify which representations identify their corresponding objects, and we
define information as an invariant under these coherent representations. We
include definitions on a _working_ basis as what is most practical, not an
epistemological stance that can be further clarified in truth systems.
Additionally, we keep the theory as simple as possible to make scalability and
standardization straight-forward.

== Goals <goals>

- *Goal 1: Universality.* The language must include unspecified, user created
  parameters to accomodate for arbitrary concepts and ideas.

- *Goal 2: Scalablility.*
  Local queries in the database, determining if there is enough "explicit"
  information, must be efficient. Certificates must be available to prove cases
  where optimal representations have been achieved.

- *Goal 3: Standardization.* The language needs a rigorous and formal
  specification. Moreover, the bootstrap must be formalized, as well as an
  abstract machine model. The grammar and bootstrap must be fixed to ensure
  complete forwards and backwards compatbility.

== Organization

This thesis is organized as follows.

// TODO: Maybe provide as another table _with_ descriptions?

- Section 2. Foundations: defines the meta-theory use and its connections to
  first-order logic and fragments of arithmetic.

- Section 3. Information Organization. Develops the optimal information system
  (w.r.t. to a metric defined in this system) to satisfy Goal 3.

- Section 4. Defines the syntax and semantics.

- Section 5. Bootstraps Welkin by proving that there is a Welkin node that
  contains enough information about the standard. Fulfills Goal 2 with both the
  Standard AND the complete bootstrap.

- Section ?. Prototype. Time permitting, develop a prototype to showcase the
  language, implemented in python with a GUI frontend (Qt) and possibly a
  hand-made LL(1) parser.

- Section 8. Conclusion. Reviews the work done in the previous sections. Then
  outlines several possible applications.

