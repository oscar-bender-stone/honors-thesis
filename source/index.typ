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
    self-contained under a meta-theory based on combinators, equivalent to a
    provably minimal fragment of arithmetic.],
  bibliography: bibliography((
    "references/misc.bib",
    "references/1-introduction.bib",
    "references/2-foundations.bib",
    "references/general.bib",
  )),
)

#outline()

#include "1-introduction.typ"
#include "2-motivating-example.typ"
#include "3-foundations.typ"
#include "4-syntax.typ"
#include "5-semantics.typ"
#include "6-information-organization.typ"
#include "7-bootstrap.typ"
#include "8-conclusion.typ"
