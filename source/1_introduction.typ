// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Introduction

Undergraduates are taught many things in lecture, books, and papers, but there
is one unspoken truth: researchers have extremely _diverse_ communities. Each
community has their own approaches, their own conferences, and even their
preference of chalk, dry-erase marker, or neither. I didn't notice in my early
mathematical journey; I wanted to absorb a wide range of papers, from number
theory to set theory. At the time, I was in secondary education and was around
few active researchers. CU changed this experience for me and look forward to
collaboration. This diversity is fundamental to research as a whole, even in the
many subjects I have not deeply explored, including the sciences, liberal arts,
and more.

With research being diverse as is, I started to notice how independent
communities can be. For example, I wrote a poster for a cryptography class,
concerning an MIT research who created programs of common crytographic schemes
and mathematically proved their correctness. I met this researcher at a
conference and discovered that _neither_ knew about the other! They provided
their own contributions, but I initially assumed that _everyone_ in
cryptography. This does depend on the community, but even a key topic like this
can have separate communities. As another example, at my time in the Budapest
Semesters in Mathematics, I explored a key tool in program verification to find
proofs for a combinatorial problem. According to my advisor, that approach had
_never_ been considered before. The boundaries between these communities isn't
so clear, and it seems to take years to begin to _remotely_ find them.

The separation of these communities raises a key question: _can_ research
results be bridged together? Can they be written in _one_ place for retrieval,
similar to how the internet is the standard for global communication? This is
more vague for certain disciplines, such as connecting two distinct areas in
philosophy, but we can focus on their _representations_ instead: binary strings.
Specifically, we can consider _formalized representations_, so sets of strings
that are computable, i.e., accepted by a computer. By taking computable to mean
the standard notion, Turing computable, our inquiry is now exactly about the
proliferation of programming languages. These, too, are extremely distinct and
built for different purposes. Translations between these, also known as
_transpilation_, is incredibly difficult, as this is generally equivalent to the
Halting Problem. A major project towards this goal is LLVM @llvm_main, a
compiler library for other programming languages. Languages can implement in an
intermediate form called LLVM IR. While being an industry and research standard
LLVM has faced numerous challenges, with a brief list including breaking changes
and maintence difficulties accross systems, with one approach to a subset of
these problems being MILR @milr_llvm as another IR to abstract away from the
original. Implementing these systems for _general_ programs is beyond the scope
of this thesis. We will instead focus on proof assistants, which are still
difficult to translate between.


To illustrate the challenge in translations between two proof assistants,
consider quotient types in Lean4 vs Rocq. [TODO: complete + cite relevant
literature!]

Creating bridges beetween formal representations does require a historical
change in perspective: _embracing reflection rather than focusing on a single
theory_. This train of thought comes from Universal Logic, initiated by Béziau
@universal_logic. Previously, in the twentith century, logicians sought the "one
true logic", a system to be the basis for all mathematics. Such a system was
quickly shown to be impossible by Gödel's incompleteness theorems, with certain
results requiring an infinite chain of increasingly more powerful theories. But
this was a symptom of a larger problem: translating into the _exact_ language of
a base logic can be unnatural. To work back in the original logic, a key
requirement is _faithfulness_, that isomorphisms in a theory must be reflected,
a notion called "$epsilon$-representation distance" by Meseguer
@twenty_years_rewriting_logic. However, the researchers surrounding Universal
Logic are, too, their own community, and have their own broad defnition of a
logic, which is distinct from those in Categorical Logic, Type Theory, and
others.


Beyond Universal Logic, a further leap is needed, from the idea a _universal
theory_ to _universal building blocks_. To support the wide diversity of
languages, a spectrum of these building blocks, which we consider to be
_information_. This thesis creates a universal information language for this
purpose, to express information about _any formal representation_. This includes
improving the representation itself!
// TODO: conclude this paragraph!

== Background on Information Theory

Given the desire to _use_ information, how do we define it? Information Theory
has established several different major trains of thoughts:

- Shannon + entropy:

  - Main founder of information theory

  - Information = "reduced uncertainty"

  - Primarily probabilistic and based on _communication of bits_. Not enough for
    _semantics_!

  - Takeaway: information is _used_ in communication

- Kolomogorov + complexity:

  - Minimum Description Length (MDL): we should describe objects with the
    smallest description possible.

  - Kolmogorov complexity = length of _smallest_ program accepting a string

  - Practical problem: not computable!

  - Bigger problem: _measures_ information, but does not _define it_

  - Takeaway: provides a _computational_ lens for information

- Scott domains:

  - Introduced information systems, but in the context of programming language
    semantics.

  - Problem: provides the axioms and key models, but not clearly tied to the
    other theories. Also divergence from information in other senses, like
    ontology (OWL, etc.)

- Ontologies:

  - Frameworks: OWL, Conceptual Graphs, etc.

  - Problem: pretty restricted! Most theories are only first-order, so difficult
    for certain type theories, e.g., dependently typed.

- Synthesis of information theory + past paragraph

  - We want to explore _information_ as a universal framework.

    - Major goal: address information _on_ information.

      - Motivation: transfer between different things!

        - Logics: proofs!

        - Models: properties!

        - Solvers: techniques and checkpoints! Reduces computation!

        - And more!

  - But what _is_ information?

    - So many examples: hard to know where we should go!

      - Algorithmic ideas.

      - Specific formulations in logics.

      - High level properties.

      - Probabilistic information.


    // TODO: refine this! This is almost the PREMISE of what we're doing
    - _Can_ start at an indirect approach to ensure we don't
    miss anything: indirectly define things by how they are _checked_. This
    checker/verifier MUST be a Turing machine (using a standard notion!).

    - Emphasize: finding a certificate is _not_ guaranteed, e.g., finding a
      proof of a theorem in first order logic.


    - To simplify this: we have _verifiers_/_checkers_ that take in binary
      strings called _certificates_. Correct certificates are accepted by the
      checker, and rejected otherwise.

    - _Use this definition to justify universality!_

== Goals

The aim of this thesis is to create a universal information language to
standardize _all_ formal representations. I call this language *Welkin*, an old
German word meaning cloud @dictionary:welkin. This aim will be made more precise
in the later sections, where we will formally define a verifier for a
programming language.
- *Goal 1:* universality. This language applies to ANY checker.

- *Goal 2:* standardized. Needs to be rigorously and formally specified.

- *Goal 3:* optimal reuse. With respect to some critierion, enable _as much_
  reuse on information as possible.

- *Goal 4:* efficiency. Checking if we have enough information _given_ a
  database much be efficient!


== Organization

// TODO: Maybe provide as another table _with_ descriptions?

- Section 2. Foundations: define the meta-theory used + verifiers.

- Section 3. Information Systems: explore information in the context of
  verifiers. Then synthesize a definition to satisfy Goal 1.

- Section 4. Information Reuse. Develops the optimal informal system (w.r.t to a
  metric defined in this system) to satisfy Goal 3.

- Section 5. Syntax: Go over the simple LL(1) grammar, which is similar to JSON
  and uses python syntax for modules.

- Section 6. Semantics: Defines information graphs and their correspondence with
  the optimal informal system in Section 3.

- Section 7. Bootstrap. Fulfill Goal 2 with both the Standard AND the complete
  bootstrap.

- Section ?. Prototype. Time permitting, develop a prototype to showcase the
  language, implemented in python with a GUI frontend (Qt) and possibly a
  hand-made LL(1) parser.

- Section 8. Conclusion. Reviews the work done in the previous sections. Then
  outlines several possible applications.

