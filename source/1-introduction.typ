// SPDX-FileCopyrightText: 2025-2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": todo

= Introduction


Information Management provides systematic approaches to storing and organizing
digital assets in a variety of domains. Early large scale systems worked as
databases, but many projects saw benefits in extending these to be information
bases, in which both data and relationships can be stored. Many businesses have
benefited from storing information in more effective ways, increasingly more
with deeper integrations to AI-driven systems.

In many active projects, Information Management faces ongoing problems. One of
these issues is the _depth_ of domains. For example, at major retailers like
Amazon, inventory and recommendation systems use immense amounts of data to
power personalized recommendations to users @amazon-large-data-report.



In the rise of these projects, many issues arise and make Information Magnement
an open subject. One of these issues with the depth of different subjects. In
finance, for instance, a business could record ... Another issue is the immense
breadth of subjects. As one example, ... Along with depth and breadth,
standardization is non-existent in most information bases. In addition to depth
and breadth, as a result of the depth and breadth of disciplines. It

In addition to domain specific proposals, there are approaches for general IM
which still fail to resolve all issues. One prominent example is Burgin's
General Theory of Information @burgin-information-book that comprehensively
includes many separate areas for IM, including the complexity-based Algorithmic
Information Theory, through a free parameter called an "infological system",
which encompasses domain specific terminology and concepts. In contrast to other
approaches, Burgin's generalized theory is flexible and enables greater coverage
of different kinds of information @mark-burgin-legacy. Despite this coverage
Burgin does not closely tie the free parameter with his formal analysis of
Algorithmic Information Theory, making it unclear how to use this in a practical
implementation. Burgin's Theory of Information, along with broad proposals, have
severe shortcomings, highlighting major obstacles for IM.

This thesis introduces a language to resolve these issues for both IM and KM. I
call this language *Welkin*, based on an old German word meaning cloud
@dictionary:welkin. The core result of this thesis is proving that Welkin
fulfills three goals: it is *universal*, *scalable*, and *standardized*. For
details, see @goals. The core idea is to generalize Burgin's free parameter and
enable arbitrary representations in the theory, controlled by a computable
system. A representation is represented a triple: a *sign* represents a
*referent* within a *context*. This generalizes RDF triples and relations by
allowing the context to incorporate scope and be a general, partial computable
operator.#footnote[There are similarities with this triple and Peirce's
  semiotics, or the study of the relationship between a symbol, the object it
  represents, and the interpreter or interpretation that provides it that
  meaning @sep-peirce-semiotics. Our notion is different in that contexts
  general interpretant.] Moreover, to address queries on the validity of truth,
we use a relative notion that includes a context managed by a formal system,
whose ideas are independently developed from @mccarthy-contexts are enhanced
with representations. Truth can then be determined on an individual basis,
providing flexibility to any discipline. The focus then shifts to the usefulness
of representaitons based on a topological notion of how "foldable" a structure
is, which we call *coherency*. This approach is inspired by coherentism, a
philosophical position that states truth is determined in comparison to other
truths. @bradley-principles-of-logic. We incorporate ideas from coherentism to
identify which representations identify their corresponding objects, and we
define information as an invariant under these coherent representations. We
include definitions on a _working_ basis as what is most practical, not an
epistemological stance that can be further clarified in truth systems.
Additionally, we keep the theory as simple as possible to make scalability and
standardization straight-forward. Furthermore, we enhance standardization using
a finite variant of the language, providing a self-contained, small area of
trusted software and hardware needed, or Trusted Computing Base in the
programming languages literature @rushby-trusted-computing-base.


#figure(
  table(
    columns: (auto, auto, auto),
    align: left,
    [*Goal 1*],
    [*Universality*],
    [The language must enable any user created parameters, whose symbolic
      representation is accepted a computable function. Every computable
      function must be definable in the language.],

    [*Goal 2*],
    [*Scalability*],
    [
      The database must appropriately scale to broad representations of
      information. Local queries must be efficient. Certificates must be
      available to prove cases where optimal representations have been achieved.
    ],

    [*Goal 3*],
    [*Standardization*],
    [The language needs a rigorous and formal specification. Moreover, the
      bootstrap must be formalized, as well as an abstract machine model. The
      grammar and bootstrap must be fixed to ensure complete forwards and
      backwards compatibility. Certificates must be reliably checked and rely on
      a low level of trust, or a small Trusted Computing Base.
    ],
  ),
  caption: "Goals for the Welkin language.",
)<goals>

This thesis is organized according to @thesis-organization.

#figure(
  table(
    columns: (auto, auto, auto),
    align: left,
    // table.header([*Section Number*], [*Title*], [*Description*]),
    [*@rationale*],
    [*Rationale*],
    [Introduces Welkin at a high level, with guiding examples.],

    [*@foundations*],
    [*Foundations*],
    [Introduces the core theory behind Welkin, which is the starting point to
      specify the user-facing language.],

    [*@syntax*],
    [*Syntax*],
    [Provides the grammar and proof that it is unambiguous.],

    [*@semantics*],
    [*Semantics*],
    [Explains how ASTs are validated and processed. Develops representations and
      coherency, and connects these to a working definition of information.],

    [*@information-organization*],
    [*Information Organization*],
    [Develops a Greedy algorithm to locally optimize information. Creates a
      certificate that demonstrates when a representation is optimal relative to
      the current information database.],

    [*@conclusion*],
    [*Conclusion*],
    [Concludes with possible applications, particularly in programming languages
      and broader academic knowledge management.],
  ),
  caption: [Organization for the thesis.],
)<thesis-organization>
