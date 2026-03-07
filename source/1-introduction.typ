// SPDX-FileCopyrightText: 2025-2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": matched-dash
#show math.minus: matched-dash


= Introduction

[TODO[MEDIUM]: determine if the phrase: "see Section ?" should be used, or
"refer to" instead, to fully include all readers.]

Information Management is the study of systematically storing and organizing
data. With the massive growth of data, particularly on the web, simply storing
data to _use_ it. Raw databases are increasingly structured into organized
_information bases_ to prove context surrounding the source and nature of data.
The conceptual foundation for this process often traces back to Ackoff
@ackoff-wisdom. His data-to-wisdom hierarchy posits that information is the
process of transforming raw data into structured content. In turn, this content
can be used to answer user queries. However, the term "information" has not been
standardized in the literature and is used with distinct meanings. For example,
Buckland @buckland-information-as-thing recognizes three different ways
information is interpreted: as a _process_, as _knowledge_, and as _a thing_.
While each of these are important, Buckland emphasizes that to _use_
information, one must work with information as a thing—a tangible record like a
document or digital file. Another author, Floridi, builds upon this tangible
idea by requiring data be truthful @floridi-information-2010. Information must
not only be in concrete records, but also accurately represent a topic of
interest. As shown in this small sample of authors, information is a rich term,
with an active pursuits to best manage it.

Despite these extensive ideas, applying Information Management in real world
projects reveals ongoing problems. One of these issues is the _depth_ of
domains. For example, at major retailers like Amazon, inventory and
recommendation systems use immense amounts of data to power personalized
recommendations to users @amazon-large-data-report. Another issue is the immense
breadth of different subjects. As a well known example, Wikipedia struggles to
constantly update its vast and interconnected web of knowledge
@mesgari-research-review-on-wikipedia. Along with the depth and breadth of
different disciplines, standardization is complex. Most systems have their own
unique data formats, so making *interoperable* formats is hard, which is the
ability to transfer one data format to another. For instance, transferring
information between two medical platforms is notoriously difficult, even if they
store the _same_ information about a patient @reisman-interoperable-data. These
problems continue to be a challenge in effectively utilizing frameworks for
information.

In consideration of these issues, several solutions partially resolve some of
them, but not completely. The following provides a small list of major existing
solutions. Reading these is optional and not required to understand this thesis.
We will not revisit these until the conclusion, see @conclusion:comparisons.

- *Resource Description Framework (RDF) Triple Stores:* These systems serve as
  the primary implementations of an internet standard called the Web Ontology
  Language (OWL) @OWL2. This system stores information as triples
  $"subject"-"predicate"->"object"$. From there, the language can enforce rules
  and ensure new relationships are derived _only_ from from previous ones. OWL
  has been highly successful in providing a machine-readable format to websites
  across the internet @hitzler-review-the-semantic-web. However, despite their
  widespread adoption, RDF stores struggle with extensive sources of data.
  Enforcing logical rules can be expensive @owl-approximate-reasoning.
  Additionally, because OWL treats missing sources of data as _unknown_ rather
  than _false_, it often fails to resolve conflicts between two sources
  @hitzler-review-the-semantic-web.

- *Labeled Property Graphs (LPGs):* This is an architecture defined by its
  ability to store rich, internal metadata within its components. Building on a
  network, consisting of nodes and edges between them, LPGs enable both nodes
  (entities) and edges (relationships) to possess a set of key-value pairs known
  as _properties_ @angles-property-graph-database-model. The internal metadata
  allows systems to efficiently traverse networks, as attributes can be filtered
  and weighed on a single query pass. Due to their operational efficiency, LPGs
  are the primary choice in large scale commercial products, particularly
  real-time fraud detection tools and recommendation systems
  @robinson-graph-databases. Although LPGs are widely used, they are siloed by
  the lack of standards, making interoperability between databases challenging.
  Furthermore, LPGs lack an extensive logical engine, resulting in external
  tooling or complex query scripts @robinson-graph-databases.

- *Cyc:* Designed to encompass broad subjects, Cyc is the largest proprietary
  database of knowledge, or _knowledge base_, known to date @lenat-cyc-1995. It
  achieves reliable queries by providing a logical engine, based on millions of
  hard coded "common sense" rules. However, despite its impressive scope, it
  relies on human experts to manually encode every rule. This limits how well
  the database scales @automated-scientific-semantic-knowledge-framework.
  Another issue is the absence of an active open standard, a result of the
  publicly available version, OpenCyc, being discontinued in 2017
  @kbpedia-opencyc.

- *fcaR (Formal Concept Analysis in R):* This tool is a modern implementation
  for the field of Formal Concept Analysis (FCA). FCA studies relationships
  through _formal concepts_. The central idea is the _concept lattice_, a
  hierarchical data structure that maps objects to attributes in a fixed domain.
  Given only a database, fcaR can automatically identify the underlying core
  concepts and derived concepts @fcaR-package-2026. While being highly effective
  in specialized domains, concept lattices can become impractically large as the
  number of attributes increases @formal-concept-analysis-trends. This makes it
  difficult to interpret results when applied to large-scale databases or when
  bridging disparate domains @formal-concept-analysis-trends.

This thesis introduces a language to resolve these issues for Information
Management. I call this language *Welkin*, based on an old German word meaning
cloud @dictionary:welkin. This word represents the expansive nature of the
language.

The core result of this thesis is proving that Welkin fulfills three goals: it
is *universal*, *scalable*, and *standardized*. For details, see @goals. The
fundamental building block is based on *representations*, containing a
relationships between a *sign* representing a *sign* in a
*context*.#footnote[There are similarities with representations and Peirce's
  semiotics. This theory studies the relationship between a symbol, the object
  it represents, and the interpretation that provides that meaning
  @sep-peirce-semiotics. Our notion is different in that contexts are a
  generalized interpretant, see @rationale:unit.] Contexts provide flexibility
to define domain terminology, and are provided rules inspired by McCarthy's work
in AI systems @mccarthy-contexts. Moreover, truth is defined relative to
contexts and enables the user to recognize _under which conditions_ a statement
is true. In this way, the information base keeps conflicting claims contained,
providing a clear separation from other contexts.

Building on representations, information is defined as a property preserved
under equivalences relative to a context. To make the information base scalable,
the base operations are kept as simple as possible, and a procedure to
adaptively organize information. The simplicity of the language aids in
standardization as well. For the highest reassurance, we create a restricted,
finite subset of the language. This subset facilitates proofs in this thesis and
enables ease of implementation.

#figure(
  table(
    columns: (auto, auto, auto),
    align: left,
    table.header([*Goal*], [*Name*], [*Description*]),
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
    columns: (20%, 25%, 55%),
    align: left,
    table.header([*Section Number*], [*Title*], [*Description*]),
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

    [*@metatheory*],
    [*Metatheory*],
    [Proves that Welkin can express any proof.],

    [*@information-organization*],
    [#set text(hyphenate: false); *Organizing Information*],
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
