// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Conclusion <conclusion>

This thesis proposed Welkin, a universal, formalized information language.
@rationale introduced the language design. @foundations developed the recursive
definition of a unit (@foundations:unit), rules on units @table:unit-rules, and
queries (@foundations:query), and information (@foundations:information). This
section also proved that every unit is equivalent to some Turing machine
(@foundations:turing-completeness-section). From there, @syntax developed the
grammar (@syntax:figure-welkin-grammar). The syntax was defined with invertible
operations (@syntax:invertible-descriptions), simultaneously providing _parsing_
and _printing_. The main grammar was proven to be $"LL"(1)$ @syntax:LL1-proof,
thereby showing it is unambiguous. Finally, @metatheory proved that the
definition of information is complete, thereby completing @universal.

The remaining sections provide comparisons to existing approaches, as well as
future work.

== Comparisons to Existing Approaches <conclusion:comparisons>

We compare from the solutions presented in the introduction (@introduction):

- *Resource Description Framework (RDF):* both Welkin and RDF use triple-based
  relationships. Many of the same ideas about representations are included in
  RDF. However, higher order representations are easier in the former, thanks to
  representations being units. Additionally, logical reasoning is significantlly
  more expressive and easier to use in Welkin, thanks to results like
  @foundations:turing-completeness-section and the work in @metatheory. Managing
  diverse sources of information, as well as conflicts, is addressed with
  isolated contexts.

- *Labeled Property Graphs (LPGs):* this technology and Welkin are similarly
  flexible. Properties can be expressed through collections of arcs. The
  definition of containment (@foundations:containment) is straightforward, and
  it is likely to have an efficient implementation. However, in contrast to
  LPGs, Welkin has a more unified definition than LPGs, without affecting
  generality or specificity. Moreovoer, as with RDF, Welkin can easily express
  logical constraints.

- *Cyc:* .

- *fcaR (Formal Concept Analysis in R):* Welkin uses a lattice through
  @table:unit-rules. This is similar to how Formal Concept Analysis (FCA)
  studies a concept lattice. Welkin can also embed core or derived concepts, due
  to the simplicity of @foundations:containment. Nevertheless, Welkin manages to
  enable a simpler lattice and still be completely universal. Certain proofs,
  when naively embedded, may be too large, but these can be adjusted through
  finding better proofs. Contexts also enable easier comparisons across multiple
  data sources.

== Future Work <conclusion:future-work>

The author has several future projects for Welkin in mind. These include:

- *Writing the Standard:* this would be a self contained document that
  describes. The Standard would _bootstrap_ the language, providing step-by-step
  instructions on how to implement a Welkin information base. There would also
  be a core library that enables user created languages that convert _into_
  Welkin. For example, writing _in_ Welkin, a user could define a grammar that
  takes their own syntax and _converts_ it into units.

- *Creating an Efficient Implementation:* as the rules in @table:unit-rules, it
  is plausible that an efficient implementation would be possible. Moreovoer,
  optimizations could be expressed within Welkin itself, using handles for
  specific resources or operations, such as base operations in Python.

- *Revision System:* . These would be similar to a belief revision system,
  introduced in @belief-revision-system.

- *Package Managmeent:* building on revision systems, this would .

- *Creating Query Solvers:* this would involve incorporating an information base
  with a program called a _solver_. Given a query, the solver would first
  confirms if there is enough information in the database. If not, the solver
  runs its own internal methods and heuristics. Moreover, the solvers
  _themselves_ can be specified in Welkin, making them easier to study and
  maintain.

