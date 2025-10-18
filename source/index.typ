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
  abstract: lorem(5),
  bibliography: bibliography("references.bib"),
)

#set text(font: "STIX Two Text")

#include "introduction.typ"

#include "foundations.typ"
