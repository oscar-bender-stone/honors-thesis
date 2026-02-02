// SPDX-FileCopyrightText: 2025-2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": todo

= Introduction

Information Management (IM) is an open area of research as a result of the depth
and breadth of disciplines. In terms of depth, many areas are often specialized,
requring an immense understanding of the broader concepts involved and
nomenclature used. This is evident in the sciences, as explored in
@hierarchy_science and @specialized_science. Additionally, in terms of breadth,
creating common representations shared accross subdisciplines can be difficult.
In mathematics, for example, has extremely diverse disciplines, and connecting
these is an open problem in scalability @big-math-problems. Moreover, creating a
standardized form accross communities is challenging. In other subjects, like
the social sciences, there are no standard terms, and the majority of cited
references are books, which are not indexed by many databases
@social_sciences_databases. More broadly, IM _itself_ is divided from distinct
approaches [CITE]. Some authors equate IM to Knowledge Management (KM) and
assert that information must be true. These problems posed by broadly and
faithfully capturing subjects demonstrate the enormous task of effective IM.

In attempt to address these challenges, several solutions have been proposed,
but none completely fix these issues. In the sciences, a group of researchers
created the Findable Accessible Interoperable Resuable (FAIR) guidelines
@FAIR_guiding_science. . However, . Another proposal is . Unfortunately, this
project has focused primarly on logic . In addition to ..., Burgin's work on a
theory of information @burgin-information-book, @burgin-information-book
comprehensively includes many separate areas. He provides flexible definitions
through a free parameter, an "infological system" that encompasses domain
specific terminology and concepts. He then proceeds to mention many areas in the
natural sciences, and connects his theory back to related mathematical studies,
including Algorithmic Information Theory. Despite the large coverage of fields,
Burgin does not closely tie the free parameter with his formal analysis, making
it unclear how to use this in a practical implementation. Each of these
proposals has severe shortcomings and highlights major obstacles for IM.

This thesis introduces a language to resolve these issues. I call this language
*Welkin*, based on an old German word meaning cloud @dictionary:welkin. The core
result of this thesis is proving that Welkin is a) universal, b) scalable, and
c) standardized. The core idea is to generalize Burgin's free parameter and
enable arbtitrary representations in the theory, controlled by a computable
system. The notion of representaiton builds on Peirce's semiotics, or the study
of the relationship between a symbol, the object it represents, and the
intepreter or interpretation that provides it that meaning
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

- Section 2. Foundations: defines the meta-theory use and its connections to
  first-order logic and fragments of arithmetic.

- Section 3. Information Organization. Develops the optimal informal system
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

