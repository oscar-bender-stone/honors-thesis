// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": ams_article

#show: ams_article.with(
  title: [Creating a Universal Information Language],
  authors: (
    (
      name: "Oscar Bender-Stone",
      department: [Department of Mathematics],
      organization: [University of Colorado at Boulder],
      location: [Boulder, CO],
      email: "oscar-bender-stone@protonmail.com",
    ),
  ),
  abstract: [Welkin is a formalized programming language to store information.
    We introduce its use cases and rigorously define its syntax and semantics.
    From there, we introduce the bootstrap, making Welkin completely
    self-contained under the meta-theory of Goedel's System T (equi-consistent
    to Peano Arithmetic).],
  bibliography: bibliography("references.bib"),
)

#outline()
#set text(font: "STIX Two Text")

#include "1_introduction.typ"

#include "2_foundations.typ"

#include "3_formal_reasoning.typ"

#include "syntax.typ"

#include "semantics.typ"

#include "bootstrap.typ"

#include "conclusion.typ"
