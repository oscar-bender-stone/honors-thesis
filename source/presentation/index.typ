// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template.typ": elegant-blue-theme, title-slide
#import "compare-list.typ": compare-list, con, info, pro

#show: elegant-blue-theme.with(
  draft: true,
  title: [Designing a Universal Information Language],
  author: [Oscar Bender-Stone],
  date: [March 26, 2026],
)

#title-slide()

= Introduction

== Background

== Existing Solutions

#list(
  compare-list([*Resource Description Language (RDF)*], (
    info[Used in Web Ontology Language *(OWL)*],
    pro[Built to be *interoperable*],
    con[No built-in logic engine],
  )),
  compare-list([Labeled Property Graphs (*LPGs*)], (
    info[Stores *properties* (node/edge metadata)],
    pro[Efficient queries],
    con[Not standardized],
  )),
  compare-list([*Cyc*], (
    info[Largest *knowledge base* to date],
    pro[Sophisticated logic engine],
    con[Hard-coded, proprietary rules],
  )),
)

= Foundations

= Syntax

= Metatheory

= Conclusion
