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
- Information Management: studies how to *store* and *organize* data
  - Throughout _all_ history: so much data!
  - Organize through *information*
- What _is_ information?
  - Depends on who you ask!
  - *Ackoff:* Data-to-Wisdom Hierarchy #footnote[Ackoff, R. L. (1989). _From
      Data to Wisdom_. J. Appl. Syst. Anal., 16, 3–9.
    ]
    - Data $=>$ Information $=>$ Wisdom
  - *Buckland:* Based on usage#footnote[Buckland, M. K. (1991). _Information as
      thing_. JASIS, 42(5), 351–360.
    ]
    - Can be a _process_, or _knowledge_
    - Most useful as _thing_
  - *Floridi:* Information is *truthful*#footnote[Floridi, L. (2010).
      _Information: A Very Short Introduction_. Oxford University Press.
    ]

== Problems

- *Depth*

- *Breadth*

- *Standardization*


== Existing Solutions

#list(
  compare-list([*Resource Description Language (RDF)*], (
    info[Used in Web Ontology Language *(OWL)*],
    pro[Built to be *interoperable*],
    con[No built-in logic engine],
  )),
  compare-list([*Labeled Property Graphs (LPGs)*], (
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
