// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": todo

= Introduction

Research is culiminated through _diverse_ communities. At a glance, each
community has their own groups, conferences, and communication styles. They even
have a distinct preference to chalk, dry erase marker, or neither. But beyond
these apparent differences, there are more subtle dimensions, including distinct
problems, approaches, and methods. In many cases, communities are specialized to
particular topics, with specific terminology and theory. Specialization has
promoted progress in multiple fields, including biology, engineering, and the
social sciences. In any case, specialized or not, understanding these
communities is pivotal to understanding the research they produce, as well as
future research directions.

#todo[Discuss specific examples.]
As a result of this diversity, research is fragmented, even between
subdisciplines.

#todo[Discuss QED here + why faithful representations are difficult to do. Also
  discuss information prior to work on Chaitin!]
Among issues in interdisciplinary research, a key problem is the common storage
of knowledge.

#todo[REWORD as needed + merge with discussions on FAIR.]
Information has been extensively studied through _measurements_ in Algorithmic
Information Theory (AIT). The founding idea of AIT is the Minimum Description
Length (MDL) principle, that the best definition for an object is the smallest
description that describes it. To formalize this idea, Kolmogorov defined a
description as a _program_, and the Kolmogorov complexity of a string as the
length of the _smallest program_ that computes that string (see
@intro_kolmogorov_complexity). This program is defined via a Turing-computable
programming language, and there is a different constant factor depending on the
language, but AIT focuses on the asymptotic complexity. A cornerstone of this
framework is providing the reason underlying cause of Gödel's incompleteness
theorems, Turing's halting problem, Tarski's undefinability of truth, and more:
_not all information can be compressed into a finite description_. This view was
articulated by Chaitin on information compression. He defined $Omega$ as the
probability that a random Turing machine will halt and proved that it cannot be
compressed computably. This result is a major theme in AIT, to address the
limits of computation.


In addition to addressing these limits, Chaitin's results have profound
consequences for the nature of mathematics. He explains:

#set quote(block: true)
#quote[_Mathematics...has infinite complexity, whereas any individual theory
  would have only finite complexity and could not capture all the richness of
  the full world of mathematical truth_. @limits_on_reason]

#todo(
  [Explain why we need universal building blocks. A key example is, e.g.,
    non-deterministic Turing machines. Not effectively described by
    deterministic ones! How do we talk about the building blocks of new things?
    That is key!],
)

Chaitin's claim extends beyond mathematics; the extent of research areas are so
vast that the idea of a _single_ theory would fail to faithfully reproduce these
disciplines. The study of the areas _themselves_ is needed to faithfully
represent them. This has been explored in Béziau's field of Universal Logic
@universal_logic, where the aim is to study _logics_ and not a _single_ logic.
In short, Chaitin's result, and the works in Universal Logic and others,
demonstrate that research must be represented _flexibly_ as well as faithfully.

#todo[Explain all claims concretely but concisely, as well as cite other
  possibilities (e.g., HoTT for logics)! And add anything else besides AIT and
  Universal Logic. MAYBE ontologies?]
The problem with a flexible representation system is precisely _how_ to
accomplish this. AIT provides asymptotic results on information _measurement_,
but does not provide a guide on the fixed representation to use. Chaitin created
a LISP variant, designed specifically for the ease of implementation and
analysis @chaitin_lisp, but this does not address the faithful representations
of other languages. Additionally, Universal Logic provides a single definition
of a logic, one which can be tedious in exotic logics. Each of these issues
underly the importance of _organization_ itself, which emerge in the
proliferation of general-purpose programming languages.

#todo[Finish transpilation example! Just show we care about _storing_ the
  underlying semantics.]
As a concrete example of organizational challenges, consider a Python program in
@transpilation_example.

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      ```c
      int main() {
        return 0;
      }
      ```
    ],
    [
      ```python
      def main():
        pass

      if __init__ == "__main__":
        pass

      ```
    ],
  ),
  caption: "Example programs in C (left) and Python (right).",
)<transpilation_example>



// To work back in the original logic, a key requirement is _faithfulness_,
// that isomorphisms in a theory must be reflected, a notion called
// "$epsilon$-representation distance" by Meseguer @twenty_years_rewriting_logic.
// However, the researchers surrounding Universal Logic are, too, their own
// community, and have their own broad defnition of a logic, which is distinct from
// those in Categorical Logic, Type Theory, and others.

// An alternative approach is to create an Intermediate Representation (IR) that
// other languages can compile into (_frontends_), and then compiled onto multiple
// machine architectures (_backends_). The driving standard in industry and
// research for this purpose is the LLVM compiler project @llvm_main. However, this
// project faces ongoing challenges, with a brief list including breaking changes
// and a massive packaging task accross different Operating Systems. One approach
// that addresses a subset of these problems is MILR @milr_llvm, another IR to
// abstract away from the original. Implementing these systems for _general_
// programs is not the intent of this thesis, and instead, is to _bridge_
// information _about_ programs. Therefore, we are interested in _unifying
// representations_ of these languages.


In light of the persistence of organizational issues, another step is required
beyond Chaitin's reasoning: we must consider _universal building blocks_
themselves. Sticking to Turing machines is sufficient in AIT and studying
asymptotics, but the _actual_ storage must take place. This is the motivation
and driving force of this thesis.

== Goals

The aim of this thesis is to create a universal information language to
standardize _all_ formal representations. I call this language *Welkin*, based
on the old German word _welkin_ meaning cloud @dictionary:welkin. This aim will
be made more precise in the later sections, where we will formally define a
verifier for a programming language.
- *Goal 1:* universality. This language applies to ANY checker. Needs to be
  extremely flexible towards this goal, so we can ONLY assume, at most, we are
  getting a TM as an input, or it's somehow programmed.

- *Goal 2:* standardized. Needs to be rigorously and formally specified.

- *Goal 3:* optimal reuse. With respect to some critierion, enable _as much_
  reuse on information as possible.

- *Goal 4:* efficiency. Checking if we have enough information _given_ a
  database much be efficient!


== Organization

#todo[Maybe provide as another table _with_ descriptions?]

- Section 2. Foundations: define the meta-theory used + verifiers. Also outline
  the Trusted Computing Base. // TODO: maybe introduce this term beforehand?

- Section 3. Information Systems: explore information in the context of
  verifiers. Then synthesize a definition to satisfy Goal 1.

  - Want to cover _why_ we want to use our system. For minmality, want to start
    with the least necessary in RE sets. This is exactly outlined in Peirce's
    Reduction Thesis, with previous artitifical formalisms proving this resolved
    in @koshkin-peirce-reduction-thesis.

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

