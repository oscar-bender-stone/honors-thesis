// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Introduction

- Engineering Research has empowered humanity for centuries.

  - Provide examples (mechanics, steam engine, medicine, transistors, etc).

  - Cite history of research, with STEM in mind. (Maybe mention liberal arts?).

- Research _communities_ are extremely diverse.

  - Examples: many concentrations in CS, Math, etc.

  - Discuss pervasive issues in _bridging_ research.

    - Different languages, approaches, journals, even subtly distinct
      definitions!

    - Maybe cite original example of BSM + UDGs, in which combinatorialists
    operate separately from SMT-LIB, even though both can support the other.

    - Another example: My Cryptographic professor and
    a CS researcher that has made a cryptographic tool are not aware of each
    other!

  - My realization: lots of _potential_ for collaboration, BUT can be difficult.
    Cite Madhusdan P. in my first meeting with him, in which he said that PL
    communities are separate for a reason.

    - Also cite work on Universal Logic; discuss history of not a _single_ logic
      prevailing, but instead many. Same thing with structures, computational
      models, and other mathematical objects.

    - Mention Meseguer's work with rewriting logic and how representations can
      be difficult! Also outline potential missing elements in rewriting logic.

- Develop the idea of a _framework_: shift from a _universal theory_ to
  _universal "building blocks"_

  - Original idea (pre-20th century): there is a _single_ theory/object we must
    mold everything else into. (Draw a picture!)

  - Shaken up by the foundational crises in the 20th century, but also in
    _every_ field in different ways. Physics with quantum mechanics, biology
    with diversity of organisms, etc.

  - Highlight: communities NEED to keep their notions! This is a _strength_ -
    people have done great things with this philosophy!

  - New idea: _every_ formal object is _made_ of the same content, but in
    different ways.

    - This allows communities to shape their own notions _differently_, but this
      can be compared precisely because they are made of the _same_ things.
      Highlight an analogy with atoms.

    - My aim: show that _information_ is precisely this building block,
      restricted to a computable setting.

- Review past results in Information theory. Possibly expand upon in a separate
  section.

  - Main theories:

    - Shannon + entropy:

      - Main founder of information theory

      - Information = "reduced uncertainty"

      - primarily probabilistic and based on _communication of bits_. Not enough
        for _semantics_!

      - Takeaway: information is _used_ in communication

    - Kolomogorov + complexity:

      - Minimum Description Length (MDL): we should describe objects with the
        smallest description possible.

      - Kolmogorov complexity = length of _smallest_ program accepting a string

      - Practical problem: not computable!

      - Bigger problem: _measures_ information, but does not _define it_

      - Takeaway: provides a _computational_ lens for information

    - Scott domains:

      - Introduced information systems!

      - Problem: divergence from . Also divergence from information in other
        senses, like ontology (OWL, etc.)

    - Ontologies:

      - Frameworks: OWL, Conceptual Graphs, etc.

      - Problem: pretty restricted! Might only be first-order.


- Synthesis of information theory + past paragraph

  - First: _define things by how they are checked_.

    - To simplify this: we have _verifiers_/_checkers_
    that take in binary strings called _certificates_. Correct certificates are
    accepted by the checker, and rejected otherwise.

    - Checking _must be computable_. This is the whole point!

      - BUT, finding a certificate is _not_ guaranteed, e.g., finding a proof of
        a theorem in first order logic.

      - Use Turing machines as a universal, standard notion!

    - This is the _property_ we want to hold.
    But it's not the _thing_ we want to study itself, per se. It's the shadow of
    the thing itself.

    - Need to start somewhere! We'll capture _what_
    this checker is doing next.

  - Second: establish the building blocks are (pieces of) _information_.
  This is _the_ univeral abstraction.

  - We can define _broad_ pieces of information, but anything we
  do in formal reasoning is actually based on information!

  - And ultimately, even in informal settings, we
  have to store this _as_ information someway or another!

  - Note that information here is formalized.
  So intangible things, like perceptions or feelings, are _not_ considered to be
  information (at least, not _formal_ information, which we default to using).



