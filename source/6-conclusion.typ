// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Conclusion <conclusion>

[TODO: update conclusion.]

This thesis introduced Welkin, a universal, formalized information language. The
foundations were developed rigorousl. Moreovoer, the syntax (@syntax) was
defined with invertible operations, simultaneously defining _parsing_ and
_printing_. The main grammar was proven to be unambiguous through a suitable
transformation (@syntax:proof-unambiguous). Finally, @metatheory proved that the
definition of information is complete, thereby completing Goal 1 [TODO: add link
to goal]. dthe to be accepted by an LL(1) grammar, showing that parsing is
unambiguous. The semantics (@foundations) were provided with several passes to
convert parse trees into units, which contain both a hierarchical and relational
structure for scoping and direct representations, respectively. Units have key
properties that enable them to express any partial computable function
@foundations:turing-expressible, in conjungtion with expressing any truth
management system, demonstrates *universality* of the system. This is
practically demonstrated by showing that all the major paradigms in Information
Management and Knowledge Management are expressible within Welkin. Finally, the
bootstrap in @foundations self-hosts the language within a bounded 64 variant,
whose complete Unambiguity (as well as the grammar's prior) establishes
*standardization*. Revisions further enhance this by

The remaining sections show several areas for future work. This list is not
exhaustive and, by the previous arguments, and can be applied to _any_ subject
with computable representations (essentially, any human subject).

== Comparisons to Existing Literature <conclusion:comparisons>

In addition to domain specific proposals, there are approaches for general IM
which still fail to resolve all issues. One prominent example is Burgin's
General Theory of Information @burgin-information-book that comprehensively
includes many separate areas for IM, including the complexity-based Algorithmic
Information Theory, through a free parameter called an "infological system",
which encompasses domain specific terminology and concepts. In contrast to other
approaches, Burgin's generalized theory is flexible and enables greater coverage
of different kinds of information @mark-burgin-legacy. Despite this coverage
Burgin does not closely tie the free parameter with his formal analysis of
Algorithmic Information Theory, making it unclear how to use this in a practical
implementation. Burgin's Theory of Information, along with broad proposals, have
severe shortcomings, highlighting major obstacles for IM.

== Future Work <conclusion:future-work>


