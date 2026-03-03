// SPDX-FileCopyrightText: 2025-2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": todo

= Introduction

Information Management is the study of systematically storing and organizing
digital data. The conceptual foundation for this process often traces back to
Ackoff @ackoff-wisdom. His data-to-wisdom hierarchy that information is the
process of transforming raw data into structured content. In turn, this content
can be used to answer user queries. However, the term "information" has not been
standardized in the literature and has gained multiple meanings beyond Ackoff's
hierarchy. For example, Buckland points out the ... Instead, his formalsim
includes ... Another author, Floridi, reinforces this approach by defining
information as true, meanginful data @floridi-information-2010. Framing
information this way also aligns with the quantitative mathematical theory
developed by Shannon @shannon-theory-communication. He developed a metric to
quantify the reliablilty of information passed through a physical network
@shannon-theory-communication.


Despite its successful use in active projects, Information Management faces
ongoing problems. One of these issues is the _depth_ of domains. For example, at
major retailers like Amazon, inventory and recommendation systems use immense
amounts of data to power personalized recommendations to users
@amazon-large-data-report. Another issue is the immense breadth of different
subjects. As a well known example, Wikipedia struggles to constantly update its
vast and interconnected web of knowledge [?]. Along with the depth and breadth
of different disciplines, standardization is increasingly difficult, with
limited options for interoperabiity or transferring information from one
solution to another. These problems continue to be a challenge in Information
and Knowledge Management.

In light of these issues, several solutions partially resolve some of them, but
not completely.

- On the internet, a pervasive standard is the Ontology Web Language (OWL).
  Topics are indexed by Resource Description Framework
(RDF), another major internet standard. Users can provide relationships in the
form `subject - verb -> object`. OWL provides a machine readable format to store
information and enable user queries, with wide spread adoption across the web.
However, OWL fails to effectively scale with real world datasets, especially
those containing contradictions @hitzler-review-semantic-webs.

- Another existing program is the proprietary Cyc database, the largest
  knowledge base known to date. . Despite being the
largest knowledge base to date, .

This thesis introduces a language to resolve these issues for Information _and_
Knowledge Management. I call this language *Welkin*, based on an old German word
meaning cloud @dictionary:welkin. This word represents the expansive nature of
the language.

The core result of this thesis is proving that Welkin fulfills three goals: it
is *universal*, *scalable*, and *standardized*. For details, see @goals. The
fundamental building block is based on *representations*, containing a
relationships between a *sign* representing a *sign* in a
*context*.#footnote[There are similarities with this triple and Peirce's
  semiotics, or the study of the relationship between a symbol, the object it
  represents, and the interpreter or interpretation that provides it that
  meaning @sep-peirce-semiotics. Our notion is different in that contexts
  general interpretant.] Contexts provide flexibility to define domain
terminology, and are provided rules inspired by McCarthy's work in AI systems
@mccarthy-contexts. Moreover, truth is defined relative to contexts and enables
the user to recognize _under which conditions_ a statement is true. In this way,
the information base keeps conflicting claims contained, providing a clear
separation from other contexts.

Building on representations, information is defined as a property preserved
under equivalences relative to a context. To make the information base scalable,
the base operations are kept as simple as possible, and a procedure to
adaptively organize information. The simplicity of the language aids in
standardization as well. For the highest reassurance, we create a restricted
subset of the language for use in practical implementations. This subset
enhances both both ease of implementation and use.

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
    [Concludes with comparisons to existing theories and possible applications,
      particularly in programming languages and broader academic knowledge
      management.],
  ),
  caption: [Organization for the thesis.],
)<thesis-organization>
