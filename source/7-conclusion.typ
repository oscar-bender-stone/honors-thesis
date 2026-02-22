// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Conclusion <conclusion>

This thesis introduced Welkin, a universal, formalized information language. The
syntax (@syntax) was defined rigorously with a small EBNF, shown to be accepted
by an LL(1) grammar, showing that parsing is unambiguous. The semantics
(@semantics) were provided with several passes to convert parse trees into
units, which contain both a hierarchical and relational structure for scoping
and direct representations, respectively. Units have key properties that enable
them to express any partial computable function @universality-theorem, in
conjungtion with expressing any truth management system, demonstrates
*universality* of the system. This is practically demonstrated by showing that
all the major paradigms in Information Management and Knowledge Management are
expressible within Welkin. Moreover, it was shown that there is a way to best
organize the language given available information @information-organization,
showing *scalability*. Finally, the bootstrap in @bootstrap self-hosts the
language within a bounded 64 variant, whose complete Unambiguity (as well as the
grammar's prior) establishes *standardization*. Revisions further enhance this
by

The remaining sections show several areas for future work. This list is not
exhaustive and, by the previous arguments, and can be applied to _any_ subject
with computable representations (essentially, any human subject).

== Programming Languages and Formal Verification

Moreover, the proposed architecture could use an LLM as an oracle.

== Mathematical and Scientific Knowledge

In response to these challenges, several solutions have been proposed, but none
have been fully successful. In the sciences, a group of researchers created the
Findable Accessible Interoperable Reusable (FAIR) guidelines
@FAIR_guiding_science. Instead of providing a concrete specification or
implementation, FAIR provides best practices for storing scientific information.
However, multiple papers have outlined problems with these overarching
principles, including missing checks on data quality @FAIR-data-quality, missing
expressiveness for ethics frameworks @FAIR-and-CARE, and severe ambiguities that
affect implementations @FAIR-implementation.

== Humanities

IM in the humanities has few models, including aan adaption of FAIR
@ALLEA-FAIR-humanities and discipline specific, linked databases in the
PARNTHEOS project @digital-humanities-foresight. Welkin could assist by
providing a space to help standardize this and localize different publication
styles and literary theories.
