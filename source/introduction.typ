// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


= Introduction

Humanity produces a colossal amount of data each year. According to the
International Data Corporation, there is currently 163 zettabytes of digital
data in the world. Given that the average human can read, on average, 200 words
per minute, and approximating a word as 8 bytes, this would require _billions_
of years ($7.8675 * 10^9$ minutes). Even in restricted areas, such as academa,
the amount of data available cannot be consumed individually. On JSTOR alone,
there are over 2800 journals, translating to around 12 _million_ articles.
Taking the average size of an article to be 5000 words, this amounts to
_hundreds_ of years ($3 * 10^8$ minutes) for a _single_ jounral provider. The
sheer scale of this data coincides with the trends in increased complexity, with
little further predictions rapidly increasing this total.

In an attempt to tame these large data sets, a key concept called _information_
emerged. Within modern databases, this is pronounced in the way data is
organized and the relations between them. In modern formalizations, this is best
represented by Knowledge Graphs, particulrly OWL and John Sowa's Conceptual
Graphs. More recently, AI systems are being more deeply integrated with
databases, providing an easier way for users to query accross a large amount of
websites or resources at a time. However, most formluations miss on the
_underlying structure_ behind the data, providing a "shadow" through a model
instead of the "thing itself". Additionally, research done in AI aims to provide
a good "average"; the amount of fake data produced is a concern, as noted in
@Romano2025SyntheticGD.

Analyzing this problem from a theoretical lens, the natural question arises:
_why_ is there so much information present? Could it be _compressed_ into a
smaller form? The leading two theories on the matter provide hard limitations on
compression, each with their own notion of "information":

- *Shannon entropy:* Claude Shannon founded information theory and defined
  informatoin as the "reduction of uncertainty", measured in a probablistic
  setting.

- *Kolmogorov complexity:* Andrey Kolomogorov founded Algorithmic Information
  Theory, independently connecting Shannon's work to computability.


However, these theories lack a suitable _semantics_. These were expanded upon in
Scott domains, which have been succesful in projects like Prolog. Nevertheless
_none_ of these theories adequaltey explain what _information_ is:

- *Knowledge Graphs* _encode_ this structure through First Order Logic, but fall
  apart through contradictions or fallacious axioms. These can be recitied
  through logics like Relevant logic, but the emphasis is placed on _truth_
  rather than _structure_. This falis to provide the notion that information can
  be false.

- *Shannon entropy* and *Kolmogorov complexity* provide a _measure_ of
  information, not an exact notion of information itself. In the former, this is
  measured with random strings and focuses on binary strings, whereas the latter
  gets closer to computation yet studies a _minimum size_, not the properties of
  a Turnig machine witnessing this bound.

- *Scott domains* come close to providing a semantic basis, but ultimately focus
  on the _hierarchical structure_, and not the _connections between domains_.

This thesis proposes to rexamine a topic in the literature: the notion of
_information_. Using the etymology in Latin, "to form", this thesis develops a
formalized programming language to organize information.This provides the
missing link to the _semantics_ of information, more so than labels within
Knowledge Graphs or ones commonly used in AI.

== Goals

The aim of this thesis is to create a formalized programing language, called
Welkin, derived from an archaic German word meaning "sky, heavens". The key
goals outline the defecincies bserved in the formalisms above:

-

-

-
