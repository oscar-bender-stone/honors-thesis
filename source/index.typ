// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": ams_article

#show: ams_article.with(
  draft: true,
  defense-copy: false,
  title: [Designing a Universal Information Language],
  authors: (
    (
      name: "Oscar Bender-Stone",
      department: [Mathematics],
      organization: [University of Colorado at Boulder],
      location: [Boulder, CO],
      email: "osbe6746@colorado.edu",
    ),
  ),
  // date: [March 18, 2026],
  defense-date: [March 26, 2026],
  committee: (
    (
      name: "Keith Kearnes",
      dept: "Mathematics",
      role: "Thesis Advisor",
    ),
    (
      name: "Nathaniel Thiem",
      dept: "Mathematics",
      role: "Honors Council Representative",
    ),
    (
      name: "Gowtham Kaki",
      dept: "Computer Science",
      role: "Outside Reader",
    ),
  ),
  abstract: [This thesis proposes a universal information language called
    Welkin. We introduce its use cases, as well rigorusly define its rules and
    syntax. We prove that the syntax is unambiguous, and that Welkin can express
    any concept and proof recognized by some computer program. We conclude with
    future work, including standardization and revision management.],
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
    "references/4-syntax.bib",
    "references/5-metatheory.bib",
    "references/6-conclusion.bib",
    "references/general.bib",
  )),
)


#outline()

#include "1-introduction.typ"
#include "2-rationale.typ"
#include "3-foundations.typ"
#include "4-syntax.typ"
#include "5-metatheory.typ"
#include "6-conclusion.typ"

