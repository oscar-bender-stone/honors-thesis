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
  date: [March 6, 2026],
  abstract: [Welkin is a formalized information language. We introduce its use
    cases and rigorously define its syntax and semantics. From there, we
    introduce the bootstrap, making Welkin completely self-contained. [TODO:
    determine how to phrase soundness and incompleteness. Should we include
    these?].],
  notes: [This thesis used Google Gemini (#link("https://gemini.google.com/"))
    to aid in research and help fix formatting. All the ideas presented are all
    from the author.],
  bibliography: bibliography((
    "references/misc.bib",
    "references/1-introduction.bib",
    "references/2-rationale.bib",
    "references/3-foundations.bib",
    "references/4-metatheory.bib",
    "references/5-syntax.bib",
    "references/7-conclusion.bib",
    "references/general.bib",
  )),
)

#outline()

#include "1-introduction.typ"
#include "2-rationale.typ"
#include "3-foundations.typ"
#include "4-syntax.typ"
#include "5-metatheory.typ"
// #include "5-semantics.typ"
#include "6-information-organization.typ"
#include "7-conclusion.typ"
