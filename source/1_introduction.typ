// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Introduction

Undergraduates are taught many things in lecture, books, and papers, but there
is one unspoken truth: researchers have extremely _diverse_ communities. Each
community has their own approaches, their own conferences, and their own
communication style. I didn't notice in my early mathematical journey; I wanted
to absorb a wide range of papers, from number theory to set theory. At the time,
I did research on my own, with few people to actively talk to. CU changed this
experience for me and look forward to collaboration. This diversity is
fundamental to research as a whole, even in the many subjects I cannot comment
on, including the sciences, liberal arts, and more.

With research being diverse as is, I started to notice how independent
communities can be. For example, I wrote a poster for a Cryptography class,
concerning an MIT research who created programs of common crytographic schemes
and mathematically proved their correctness. I met this researcher at a
conference and discovered that _neither_ knew about the other! As another
example, at my time in the Budapest Semesters in Mathematics, I explored using
SMT solvers, a key tool in program verification. According to my advisor, that
approach had _never_ been considered before.

- My realization: lots of _potential_ for collaboration, BUT can be difficult.
  Cite Madhusdan P. in my first meeting with him, in which he said that PL
  communities are separate for a reason.

  - Also cite work on Universal Logic; discuss history of not a _single_ logic
    prevailing, but instead many. Same thing with structures, computational
    models, and other mathematical objects.

  - Mention Meseguer's work with rewriting logic and how representations can be
    difficult! Also outline potential missing elements in rewriting logic.

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

      - Primarily probabilistic and based on _communication of bits_. Not enough
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

  - Section 2. Foundations: define the meta-theory used + verifiers.

  - Section 3. Information Systems: explore information in the context of
    verifiers. Then synthesize a definition to satisfy Goal 1.

  - Section 4. Information Reuse. Develops the optimal informal system (w.r.t to
    a metric defined in this system) to satisfy Goal 3.

  - Section 5. Syntax: Go over the simple LL(1) grammar, which is similar to
    JSON and uses python syntax for modules.

  - Section 6. Semantics: Defines information graphs and their correspondence
    with the optimal informal system in Section 3.

  - Section 7. Bootstrap. Fulfill Goal 2 with both the Standard AND the complete
    bootstrap.

  - Section ?. Prototype. Time permitting, develop a prototype to showcase the
    language, implemented in python with a GUI frontend (Qt) and possibly a
    hand-made LL(1) parser.

  - Section 8. Conclusion. Reviews the work done in the previous sections. Then
    outlines several possible applications.

