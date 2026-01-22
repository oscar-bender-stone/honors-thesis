// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

== Abstract Objects/Slates

- Brief philosophical discussion
  - Discuss Kit Fine's arbtirary objects.
    - Address symbol groundin problem + circularity: Fine uses FOL to define a
      notion *used* to construct FOL
    -
  - Emphasize *pragmatism*, echoing intro. It matters how we can *use it*
  for this language, *not* epistemological statements or certainty (what "is" or
  "isn't")
- Establish notion of a slate
  - Bring up notion of "tabula rasa"
  - Want a "clean slate" that can be "assigned an interpretation" arbitrarily
    - Make main defense as to why this is universal; need to allow *any*
      extensions, so need to be arbitrarily imbued by interpreters/oracles.
    - Note: no guarantees on what interpreters there "are" or limiations,
    e.g., humans have finite lifespans.
    - Main point: to ensure arbitrary interpretation,
    need clean slates! Argue this is pragmatic (i.e., useful practically)
  - This is completely informal and depends on the interpreter.
  - Idea for formalization: treat *handles/ids* slates as the discrete objects
    - Analogy: sorting through an inventory of dishes. Will connect back to
      organization!
    - THEN can use formal systems/computable functions around those IDs
    to make formal claims
    - Why formal systems? Because we want to assert claims! Important
      pragmatically! Just like keeping track of inventory or specific points! Or
      being a historian!
    - Use to define information! Expand on how this improves notion of infons
    - Powerful aspect: can shape AROUND new slates! Provide examples in Slate
      Logic

== Slate Logic

- Definition
  - Define binary strings. Assign these to slates.
    - Have a designated *slate variable*. This is our entry
    point into arbitrary interpreters.
- Examples
  - Sorting dishes (analogy from before)
  - Map analogy, with places as IDs AND paths
    - Emphasize that new objects can be given
    IDs arbitrarily; that is why we need (countably) infinitely many IDs!

== Translations Between First Order Logic
