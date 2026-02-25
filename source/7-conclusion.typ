// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Conclusion <conclusion>

[TODO: reformat this to write: foundations, syntax, semantics.] This thesis
introduced Welkin, a universal, formalized information language. The syntax
(@syntax) was defined rigorously with a small EBNF, shown to be accepted by an
LL(1) grammar, showing that parsing is unambiguous. The semantics (@semantics)
were provided with several passes to convert parse trees into units, which
contain both a hierarchical and relational structure for scoping and direct
representations, respectively. Units have key properties that enable them to
express any partial computable function @universality-theorem, in conjungtion
with expressing any truth management system, demonstrates *universality* of the
system. This is practically demonstrated by showing that all the major paradigms
in Information Management and Knowledge Management are expressible within
Welkin. Moreover, it was shown that there is a way to best organize the language
given available information @information-organization, showing *scalability*.
Finally, the bootstrap in @foundations self-hosts the language within a bounded
64 variant, whose complete Unambiguity (as well as the grammar's prior)
establishes *standardization*. Revisions further enhance this by

The remaining sections show several areas for future work. This list is not
exhaustive and, by the previous arguments, and can be applied to _any_ subject
with computable representations (essentially, any human subject).

== Programming Languages and Formal Verification <conclusion:programming>

[TODO: add discussions on supporting interoperability with languages, providing
more robust and unified implementations of core libraries, compilers, and
operating systems.]

Taking the enable custom hardware implementations for checking and reduce the
surface area for attacks on verifying certifications for many applications,
including cryptography.

Moreover, the proposed architecture could use an LLM as an oracle.

== Mathematical and Scientific Knowledge

[TODO: discuss more applications of Welkin in depth.]

There are several possible projects to pursue in mathematics and scientific
research. For mathematics, there are several existing rojects for storing
mathematical information (see @review-math-knowledge-management for more
details). Older proposals, including the QED Manifesto @qed-reloaded and the
Module system for Mathematical Theories (MMT), aimed to be more general and have
seen limited success. More centralized systems, like `mathlib` in the Lean proof
assistant @lean-mathlib, have seen adoption but do not give equal coverage nor
are interoperable with other systems. Welkin enables this interopreeable through
gradual translations, and with @information-organization, one can always
determine if there is enough _direct_ information to complete a translation.
This will help facilitate reusability among major tools, and aid in formal
verification (@conclusion:programming) well.

Along with mathematics, Welkin could provide more rigorous frameworks for the
sciences, with are currently scattered with different proposals. One prominent
proposal is the Findable Accessible Interoperable Reusable (FAIR) guidelines
@FAIR_guiding_science. Instead of providing a concrete specification or
implementation, FAIR provides best practices for storing scientific information.
However, multiple papers have outlined problems with these overarching
principles, including missing checks on data quality @FAIR-data-quality, missing
expressiveness for ethics frameworks @FAIR-and-CARE, and severe ambiguities that
affect implementations @FAIR-implementation. Welkin addresses these by using
contexts strategically. Experiments can be compared using revisions, and
disagreements between experts can be analyzed using separate contexts. These
contexts can then _distinguish_ between different theories, and scientists can
select the unit with the best or most comprehensive evidence. Metrics for such
evidence can be _representable_ to a certain point, but at a minimum, they can
be more effectively analyzed.


== Humanities

[TODO: significantly expand.]

Information Management in the humanities has few models, including an adaption
of FAIR @ALLEA-FAIR-humanities and discipline specific, linked databases in the
PARNTHEOS project @digital-humanities-foresight. Welkin could assist by
providing a space to help standardize this and localize different publication
styles and literary theories.
