// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Introduction

// TODO: create a stronger connection the fact that the papers I read WERE online.
// This is crucial!
Undergraduates are taught many things in lecture, books, and papers, but there
is one unspoken truth: researchers have extremely _diverse_ communities. Each
community has their own approaches, their own conferences, and their own
formatting. They even have a distinct preference to chalk, dry erase marker, or
neither. For a long time, I didn't notice this aspect about research. I started
my mathematics journey in secondary education, independently reading papers from
set theory, logic, and more. I was fortunate to have vast archives available on
the internet, but my ability to _collaborate_ in research was limited. This
quickly changed in college[TODO: maybe make this a stronger sentence?].
Everywhere I went, I saw the multitude of research groups, from those mentioned
in lecture to the experiences I worked in to the faculty panels in the COSMOS
math club. I worked in several research groups and found how rich and fulfilling
each was. This _changed_ my perception of research as a whole. I recognize now
that diversity _drives_ research, including in the sciences, liberal arts, and
many more subjects I have hardly explored.

Because of how diverse research is, these communities are extremely independent
and have separate results. For example, I wrote a poster for a cryptography
class, concerning an MIT researcher who created programs of common crytographic
schemes and mathematically proved their correctness. I met this researcher at a
conference and discovered that _neither_ knew about the other! They provided
their own contributions, but I initially assumed that _everyone_ contributing to
cryptography work on common projects. As another example, at my time in the
Budapest Semesters in Mathematics, I explored a key tool in program verification
to find proofs for a combinatorial problem. According to my advisor, that
approach had _never_ been considered before. The boundaries between these
communities isn't so clear, and it seems to take years to begin to _remotely_
find them.

// TODO: cite main claims about journals/research communities/etc as needed
The separation of these communities raises a key question: _can_ knowledge
across disciplines be bridged together? Publications have become more widely
available thanks to the internet, even behind a paywall or subscriptions.
However, there are more challenges to storing the knowledge therein, as
recognized by several papers, including @FAIR_guiding_science. Firstly, journals
are usually highly specialized, require an immense understanding of the broader
concepts involved and nomenclature used. This is clear in the sciences, as
explored in @hierarchy_science, @specialized_science. Additionally, representing
knowledge can be difficult. In mathematics, for example, several attempts have
been made to catalog major theories and results. [DESCRIBE ATTEMPTS &
LIMITATIONS]. In other subjects, like the social sciences, there are _no_
standard terms, and the majority of cited references are books, which are not
indexed by many databases @social_sciences_databases. These are [challenging
synonym] for existing tools @hierarchy_science. As another challenge, many
formats are fragile to incorrect syntax [EXPLAIN AND ELABORATE]. Each of these
challenges, a small fraction of existing barriers, demonstrate the difficulty in
creating a knowledge base with both broad applicability and faithful
representations to the original research.

// TODO: finish main problems. THEN get into ontologies as one proposals, and then explore other options possibly? Maybe just ontologies
There is one existing approach to these problems: ontologies. [Explain use of AI
AND how it doesn't work well with, e.g., logical formulas or such, IF this is
true. Or maybe this IS still limited?]

To create a suitable knowledge base, truth needs to be managed as well. This is
a whole topic in of itself and would not be done justice here. What can be done
is addressing _information_, the storage of the _asserted_ facts themselves,
regardless of truth. As one example, suppose a scientist claims, "X is true
about Y". One could debate the veracity of that claim, but what we can say is,
"This scientist claims, 'X is true about Y'". Even if we doubt that, we could
do: "This claim can be formulated: 'This scientist claims 'X is true about Y''".
By using these justifications, stating that a claim is expressible, the
_syntactic expression_ of the claim can be separated from its _semantic truth
value_.#footnote[One might be worried about a paradox, such as "This claim is
  expressible: this claim is not expressible." We will avoid this using a clear
  separation of the overarching metatheory and object theory, with the former
  being syntactical in nature. To express this separation, we write quotes
  around the claim itself.] I will make this more rigorous in later sections,
but this enables a truth checking to be a _flexible extension_ to an information
system.

// TODO: I like mentioning information earlier. But then we really need to get to information theory pretty quickly! Do we *need* these two paragraphs? Might be worth noting in conclusion
// TODO: make sure to talk about FAIR from one of the papers listed! Very important!]
// TODO: revise as necessary. WHY are we now talking about OS's? This is a bit of a sudden shift and should be explained why, e.g., machine architectures are relevant.Maybe we should talk about program language semantics? Seems like we should still talk about proof assistants *somewhere*, and probably on solvers
Our inquiry can now shift onto a formal representation of information. Formal
representations, in general, are sets of strings that are computable, i.e.,
accepted by a computer. The standard notion of computability is being computed
by a Turing machine, and by taking this, we are now _exactly_ discussing the
problem of interoperability of programming languages. These, too, are extremely
distinct and built for different purposes. Semantic preserving and reflecting
translations between these, also known as _transpilations_, are incredibly
difficult, as they are generally equivalent to the Halting Problem. An
alternative approach is to create an Intermediate Representation (IR) that other
languages can compile into (_frontends_), and then compiled onto multiple
machine architectures (_backends_). The driving standard in industry and
research for this purpose is the LLVM compiler project @llvm_main. However, this
project faces ongoing challenges, with a brief list including breaking changes
and a massive packaging task accross different Operating Systems. One approach
that addresses a subset of these problems is MILR @milr_llvm, another IR to
abstract away from the original. Implementing these systems for _general_
programs is not the intent of this thesis, and instead, is to _bridge_
information _about_ programs. Therefore, we are interested in _unifying
representations_ of these languages.

// TODO: determine languages
// for the example.
// Do we *want* proof assistants here?
// We should get straight to the point and quickly wrap up this part of the intro
// TODO: configure syntax highlighting to be accessible
To demonstrate the difficulty of a unified representation, we provide an example
with Python and C @transpilation_example. [PROVIDE DETAILS ON EXAMPLE] Using
LLVM IR would not remove this issue. The fundamental differences in memory
management would persist, and while this is possible to some extent, it's not
completely seamless. Manual work is generally required. [TODO: what manual work?
Why?]

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


// TODO: explain WHY we need a change in perspective. This is key!
// Maybe we can *bridge* this with the example to say that translations are unnatural. For instance, in python, you have to use the whole C specific translations in order to get into memory issues! But this itself is fragile...
Creating bridges beetween formal representations does require a historical
change in perspective: _embracing reflection rather than focusing on a single
theory_. This train of thought comes from Universal Logic, initiated by Béziau
@universal_logic. Previously, during the rapid expansion of foundations in the
20th century, logicians sought the "one true logic", a system to be the basis
for all mathematics. Such a system was quickly shown to be impossible by Gödel's
incompleteness theorems, with certain results requiring an infinite chain of
increasingly more powerful theories. But this was a symptom of a larger problem:
translating into the _exact_ language of a base logic can be unnatural, just as
it is unnatural to represent quotient types in Rocq without an additional theory
ontop. To work back in the original logic, a key requirement is _faithfulness_,
that isomorphisms in a theory must be reflected, a notion called
"$epsilon$-representation distance" by Meseguer @twenty_years_rewriting_logic.
However, the researchers surrounding Universal Logic are, too, their own
community, and have their own broad defnition of a logic, which is distinct from
those in Categorical Logic, Type Theory, and others.


Beyond Universal Logic, a further leap is needed, from the idea a _universal
theory_ to _universal building blocks_. To support the wide diversity of
languages, a spectrum of these building blocks, which we consider to be
_information_. This thesis creates a universal information language for this
purpose, to express information about _any formal representation_. This includes
improving the representation itself!
// TODO: conclude this paragraph!


// TODO: put this somewhere
// This is EXACTLY what we want to systematically implement!
According to Chaitin, "A useful theory is a compression of the data; compression
is comprehension".

- Summarize information theory here. Let's get the intro done in one place
  (besides goals and organization)! May be easier to focus on AIT (Algorithmic
  Information Theory) for our purposes.

  - Main problem: _how_ do we manage information? This thesis is ALL about the
    organization of information! That is, reuse! This is exactly in line with
    compression, but the _how_!

    - Connects back to Turing machines - we can _use_ Turing machines as our
    "generalized theories". Main philosophy: represent things by how they are
    _checked_. So this is done by a total Turing machine!

    - We also need _computable_ ways to encode, which is what Chaitin's theory
      describes. But it doesn't show us _how_ to organize things!

    - Also helps to explain overhead in representing things. Might be different
      depending on base representation used. Chaitin says this doesn't matter in
      the limit (CITE.) *The goal of this thesis is to RESOLVE this problem, on
      the query end!*

  - Why is Chaitin's work so useful here? Because it explains WHAT EXACTLY we
    need in the metatheory! *Enough information to encode itself to talk about
    all other theories!*

    - Address Trusted Computing Base here or in next paragraph!

Our overarching architecture is based on a key idea: separate _cheap queries_
from _expensive search_. We develop the entire theory of queries and enable
arbitrary extensions to the search prcoedures. This is inspired by and
generalizes DPLL(T) @dpll_t for SMT-LIB solvers. In DPLL(T), the goal is to find
a proof of a first-order statement into two parts: solve propositional
statements in a SAT solver, and solve theory-specific problems with theory
solvers. // TODO: clean this up and make this more detailed but concise!

In addition to this architecture, we establish a small Trusted Computing Base
(TCB). In our base logic, uses a a novel technique: Artemov's Logic of Proofs
@artemov_lp. This establishes our metatheory, which is equi-consistent to [TODO:
find this!] (@foundations). [TODO: talk about prototype! Key!]


== Goals

The aim of this thesis is to create a universal information language to
standardize _all_ formal representations. I call this language *Welkin*, an old
German word meaning cloud @dictionary:welkin. This aim will be made more precise
in the later sections, where we will formally define a verifier for a
programming language.
- *Goal 1:* universality. This language applies to ANY checker. Needs to be
  extremely flexible towards this goal, so we can ONLY assume, at most, we are
  getting a TM as an input, or it's somehow programmed.

- *Goal 2:* standardized. Needs to be rigorously and formally specified.

- *Goal 3:* optimal reuse. With respect to some critierion, enable _as much_
  reuse on information as possible.

- *Goal 4:* efficiency. Checking if we have enough information _given_ a
  database much be efficient!


== Organization

// TODO: Maybe provide as another table _with_ descriptions?

- Section 2. Foundations: define the meta-theory used + verifiers. Also outline
  the Trusted Computing Base. // TODO: maybe introduce this term beforehand?

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

