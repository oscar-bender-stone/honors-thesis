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

  - We want to explore _information_ as a universal framework.

    - Major goal: address information _on_ information.

      - Motivation: transfer between different things!

        - Logics: proofs!

        - Models: properties!

        - Solvers: techniques and checkpoints! Reduces computation!

        - And more!

  - But what _is_ information?

    - We'll exclude less tangible notions, like perception or emotions.

    - Ultimately, even in an informal setting,
    will need to store (tangible) information as a computable string!

    - So many examples: hard to know where we should go!

      - Algorithmic ideas.

      - Specific formulations in logics.

      - High level properties.

      - Probabilistic information.

    - Need to do some detective work - that's part of this thesis!

    - _Can_ start at an indirect approach to ensure we don't
    miss anything: indirectly define things by how they are _checked_. This
    checker/verifier MUST be a Turing machine (using a standard notion!).

    - Emphasize: finding a certificate is _not_ guaranteed, e.g., finding a
      proof of a theorem in first order logic.


    - To simplify this: we have _verifiers_/_checkers_ that take in binary
      strings called _certificates_. Correct certificates are accepted by the
      checker, and rejected otherwise.

    - _Use this definition to justify universality!_

- Aim of thesis: create a universal information language to store information in
  a standardized way.

  - Goal 1: universality. This language applies to ANY checker.

  - Goal 2: standardized. Needs to be rigorously and formally specified.

  - Goal 3: optimal reuse. With respect to some critierion, enable _as much_
    reuse on information as possible.

  - Goal 4: efficiency. Checking if we have enough information _given_ a
    database much be efficient!


- Organization (Maybe provide as another table _with_ descriptions?)

  - Section 2. Base Notions: define the meta-theory used + verifiers.

  - Section 3. .

  - Section 4.

