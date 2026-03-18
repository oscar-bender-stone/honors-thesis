// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": ams_article

#show: ams_article.with(
  title: [Designing a Universal Information Language],
  authors: (
    (
      name: "Oscar Bender-Stone",
      department: [Department of Mathematics],
      organization: [University of Colorado at Boulder],
      location: [Boulder, CO],
      email: "osbe6746@colorado.edu",
    ),
  ),
  date: [March 18, 2026],
  abstract: [This thesis proposes a universal information language called
    Welkin. We introduce its use cases and rigorously define its underlying
    theory and syntax. We prove that the syntax is unambiguous, and that Welkin
    can express any concept and proof recognized by some computer program. We
    conclude with future work, including standardization and revision
    management.],
  notes: [This thesis used Google Gemini (#link("https://gemini.google.com/"))
    for the following tasks: reviewing the iterature, discussing conjectures,
    clarifying new concepts, evaluating new language features, and creating
    templates for tables and figures. All ideas presented come from the
    author.],
  bibliography: bibliography((
    "references/misc.bib",
    "references/1-introduction.bib",
    "references/2-rationale.bib",
    "references/3-foundations.bib",
    "references/4-metatheory.bib",
    "references/5-syntax.bib",
    "references/general.bib",
  )),
)

// TODO: add appendix header in single outline!
#outline()


#include "1-introduction.typ"
#include "2-rationale.typ"
#include "3-foundations.typ"
#include "4-syntax.typ"
#include "5-metatheory.typ"
#include "6-conclusion.typ"

