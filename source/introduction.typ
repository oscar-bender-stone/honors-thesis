// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


= Introduction

Humanity produces a colossal amount of data each year. According to the
International Data Corporation, there is currently 163 zettabytes of digital
data in the world. Given that the average human can read, on average, 200 words
per minute, and approximating a word as 8 bytes, this would require _billions_
of years ($7.8675 * 10^9$ minutes). Even in restricted areas, such as academia,
the amount of data available cannot be consumed individually. On JSTOR alone,
there are over 2800 journals, translating to around 12 _million_ articles.
Taking the average size of an article to be 5000 words, this amounts to
_hundreds_ of years ($3 * 10^8$ minutes) for a _single_ journal provider. These
current estimates, as well as exceedingly large predictions, represents the
sheer complexity of digital data.

In an attempt to tame these large data sets, a key concept called _information_
emerged. Within modern databases, this is pronounced in the way data is
organized and the relations between them, with recent integration with AI
systems. The most prominent ones are *ontologies*, particularly OWL, or
*knowledge graphs*, e.g., John Sowa's Conceptual Graphs. More recently, AI
systems are being more deeply integrated with databases, providing an easier way
for users to query across a large amount of websites or resources at a time.
However, most approaches focus on information via a _theory_, connecting data by
true relations and facts. The potential for contradictory facts can compromise
the reliability of a knowledge base, though there are some promising approaches,
including using paraconsistent logics. Additionally, research done in AI aims to
provide a good "average"; the amount of fake data produced is a concern, as
noted in @Romano2025SyntheticGD.

Analyzing this problem from a theoretical lens, the natural question arises:
_why_ is there so much information present? Could it be _compressed_ into a
smaller form? The leading two theories on the matter provide hard limitations on
compression, each with their own notion of "information" that face certain
limitations:

- *Shannon entropy:* Claude Shannon founded information theory and defined
  information as the "reduction of uncertainty", measured in a probablistic
  setting. However, this applies to _noisy channels_, such as passing $010$ to a
  receiver (with a probability of success). This is distinct from the
  _structural_ view of information, such as a deterministic total of a data set.

- *Kolmogorov complexity:* Andrey Kolomogorov founded Algorithmic Information
  Theory, independently connecting Shannon's work to computability. This is
  defined on the *Minimum Description Length (MDL)* principle, that the best
  representation of a string is the smallest one possible. Kolmogorov formalized
  this idea with Kolmogorov complexity, the size of the smallest Turing machine
  that accepts a string. While this is more structural in nature

- *Scott domains:* Dana Scott introduced an algebraic structure to represent
  information and described how information can be consistent with one another.
  These structures come close to providing a semantic basis, but ultimately
  focus on the _hierarchies on pieces of information_, and not the _connections
  between information_.


This thesis proposes to re-examine the notion of information. Using the
etymology in Latin, "to form", this thesis develops a formalized programming
language to organize information.This provides the missing link to the
_semantics_ of information, more so than labels within Knowledge Graphs or ones
commonly used in AI.

== Goals

The aim of this thesis is to create a formalized programming language, called
Welkin, originating from the German word _wolke_ (cloud) @dictionary:welkin. The
following goals resolve the deficiencies observed in the formalisms above:

- *Universality (G1):* we provide a theory to work with _any_ partial computable
  function. Thus, we ensure that checking a certificate is always decidable, and
  encode appropriately (for set theory, type theories, etc.).

- *Standardization (G2):* the language must be specified by an unambiguous
  standard and have a reliable *Trusted Computing Base*. To ensure this, the
  language must have an unambiguous syntax and semantics, as well as a reliable
  meta-theory.

- *Encoding (G3):* information must be encoded in an optimal yet efficient way
  (effective linear-time checking). We provide a 64-bit hashing scheme for most
  implementations, as this ensures enough unique IDs while being efficient on
  modern hardware.

== Outline


#let outline = table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([Section], [Description]),
  [@foundations],
  [Discusses foundations, providing the meta-theory based on Gödel's System T to
    more easily encode computability and have a theory equi-consistent to Peano
    Arithmetic.
  ],

  [@information_theory],
  [Defines information and the optimal encoding proven in this thesis. This is
    optimal w.r.t. to a certain efficiently computable class of encodings.
  ],

  [@syntax],
  [Introduces the LL(1) grammar for Welkin, a graph-based language that
    naturally encodes lambda terms.],

  [@semantics],
  [Explains the semantics of terms in the theory and finalizes the encoding.
    This also introduces the 64-bit hashing scheme.],

  [@bootstrap],
  [Reviews the Welkin Standard and justifies why Welkin is "strong enough" to
    "encode itself".],

  [@conclusion],
  [Reviews the work in this thesis and provides insights to applications for
    formal verification and creating custom languages that compile into Welkin.
  ],
)

This thesis is organized linearly, shown in @outline. Note that this thesis
serves as a _high-level_, but precise, guide to the Welkin language. The
_precise_ specification is the Standard itself, with _minimal_ abbreviations and
all details explicitly mentioned.


#figure(
  outline,
  caption: [Outline of the thesis.],
)<outline>

