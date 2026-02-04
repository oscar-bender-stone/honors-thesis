// SPDX-FileCopyrightText: 2025-2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": todo

= Introduction

// TODO: add more explicit references to broader fields,
// so like liberal arts and such. Ensure good coverage!
Information Management (IM) is an open area of research as a result of the depth
and breadth of disciplines. In terms of depth, many areas are often specialized,
requiring an immense understanding of the broader concepts involved and
nomenclature used. This is evident in the sciences, as explored in
@hierarchy_science, @specialized_science. Additionally, in terms of breadth,
creating common representations shared across sub-disciplines can be difficult.
In mathematics, for example, has extremely diverse disciplines, and connecting
these areas is an open problem in scalability @big-math-problems. Moreover,
creating a standardized form across communities is challenging. In other
subjects, like the social sciences, there are no standard terms, and the
majority of cited references are books, which are not indexed by many databases
@social_sciences_databases. More broadly, IM _itself_ is divided from distinct
approaches that lack interoperability @information-management-frameworks. Some
authors equate IM to Knowledge Management (KM) and assert that information must
be true @information-and-knowledge-management. These problems posed by broadly
and faithfully capturing subjects demonstrate the enormous task of effective IM.

In attempt to address these challenges, several solutions have been proposed,
but none completely fix these issues. In the sciences, a group of researchers
created the Findable Accessible Interoperable Resuable (FAIR) guidelines
@FAIR_guiding_science. Instead of providing a concrete specification or
implementation, FAIR provides suggestions to encourage better storage of
scientific information. However, multiple papers have outlined problems with
these overarching principles, including missing checks on data quality
@FAIR-data-quality, missing expressiveness for ethics frameworks @FAIR-and-CARE,
and severe ambiguities that affect implementations @FAIR-implementation. Along
with the sciences, there are several proposals in mathematics, including QED
project and the OpenLogic Project. ... While they have advanced storage for
mathematical information, OpenLogic these project has focused primarily on logic
... These proposals, even focused on specific fields, fail to accommodate for
all of the mentioned challenges.

In addition to these proposals, Burgin's work on a theory of information
@burgin-information-book, @burgin-information-book comprehensively includes many
separate areas for IM as a whole. He provides flexible definitions through a
free parameter, an "infological system" that encompasses domain specific
terminology and concepts. He then proceeds to mention many areas in the natural
sciences, and connects his theory back to related mathematical studies,
including Algorithmic Information Theory. Despite the large coverage of fields,
Burgin does not closely tie the free parameter with his formal analysis, making
it unclear how to use this in a practical implementation. Each of these
proposals has severe shortcomings and highlights major obstacles for IM.

This thesis introduces a language to resolve these issues. I call this language
*Welkin*, based on an old German word meaning cloud @dictionary:welkin. The core
result of this thesis is proving that Welkin is a) *universal*, b) *scalable*,
and c) *standardized*, see @goals. The core idea is to generalize Burgin's free
parameter and enable arbitrary representations in the theory, controlled by a
computable system. The notion of representation builds on Peirce's semiotics, or
the study of the relationship between a symbol, the object it represents, and
the interpreter or interpretation that provides it that meaning
@sep-peirce-semiotics. Moreover, to address queries on the validity of truth, we
use a relative notion that includes a context managed by a formal system. Truth
can then be determined on an individual basis, providing flexibility to any
discipline. The focus then shifts to the usefulness of representaitons based on
a topological notion of "collapse" or "coherency". This approach is inspired by
coherentism, a philosophical position that states truth is determined in
comparison to other truths. @bradley-principles-of-logic. We incorporate ideas
from coherentism to identify which representations identify their corresponding
objects, and we define information as an invariant under these coherent
representations. We include definitions on a _working_ basis as what is most
practical, not an epistemological stance that can be further clarified in truth
systems.

#todo[Determine if this is now unnecessary.]
== Goals <goals>

- *Goal 1: Universal.* The language must include unspecified, user created
  parameters to accomodate for arbitrary concepts and ideas.

- *Goal 2: Scalable.*
  Local queries in the database, determining if there is enough "explicit"
  information, must be efficient. Certificates must be available to prove cases
  where optimal representations have been achieved.

- *Goal 3: Standardized.* The language needs a rigorous and formal
  specification. Moreover, the bootstrap must be formalized, as well as an
  abstract machine model. The grammar and bootstrap must be fixed to ensure
  complete forwards and backwards compatbility.

== Organization

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

