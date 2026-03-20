// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template.typ": elegant-blue-theme, pause, title-slide, uncover
#import "compare-list.typ": compare-list, con, info, pro

#show: elegant-blue-theme.with(
  draft: true,
  title: [Designing a Universal Information Language],
  author: [Oscar Bender-Stone],
  date: [March 26, 2026],
)


#show hide: it => {
  show footnote: none
  it
}

#title-slide()

= Introduction

// TODO: fix pauses between bullets at same level!
== Background
#pause
- Information Management: studies how to *store* and *organize* data#pause
  #pause
  - Throughout _all_ history: so much data!
  - Organize through *information*#pause
- What _is_ information?#pause
  - Depends on who you ask!
  #pause
  - *Ackoff:* Data-to-Wisdom Hierarchy #footnote[Ackoff, R. L. (1989). _From
      Data to Wisdom_. J. Appl. Syst. Anal., 16, 3–9.
    ]#pause
    - Data $=>$ Information $=>$ Wisdom
    #pause
  - *Buckland:* Based on usage#footnote[Buckland, M. K. (1991). _Information as
      thing_. JASIS, 42(5), 351–360.
    ]#pause
    - Can be a _process_, or _knowledge_
    - Most useful as _thing_
  - *Floridi:* Information is *truthful*#footnote[Floridi, L. (2010).
      _Information: A Very Short Introduction_. Oxford University Press.
    ]#pause

== Problems
#pause
- How to _actually_ manage information?
  - *Information base:* a database of information
- *Depth:* domain specific data
  - Example: Amazon (product suggestions)#footnote[Smith & Linden (2017). Two
      Decades of Recommender Systems at Amazon.com. IEEE Internet Comput. 21(3).
    ]#pause
- *Breadth:* different kinds of data#pause
  - Example: Wikipedia#footnote[Mesgari, M., et al. (2015). "The sum of all
      human knowledge": A systematic review of Wikipedia. JASIST, 66(2).
    ]#pause
- *Standardization:* ambiguous interpretations
  - Related issue: being *interoperable*
  - *Interoperable:* a portable data format
  - Example: US health records#footnote[Reisman, M. (2017). EHRs: The challenge
      of making electronic data usable. P & T, 42(9), 572–575.
    ]

== Existing Solutions
#pause
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

== Proposed Solution
#pause
- *Welkin*: an information language
  #pause
  - Pronounced: "VEL-KIN"
  #pause
  - Old German word, meaning "cloud", "sky"
#pause
- *Goals:* #pause
  - *Universality:* be completely expressive#pause
    - _Any_ computer program#pause
    - _Any_ "reliable" proof#pause
  - *Scalability:* work at any size#pause
    - Be efficient#pause
    - Support: future optimizations
    - Describe improvements _in_ Welkin#pause
  - *Standardization:* be completely _unambiguous_#pause
    - Have a formal specification

= Language Overview

== General Requirements
#pause
+ Express any computer program#pause
  - Need effective operations#pause
  - Established notion: *Turing machines*#footnote[Turing, A. M. (1936). On
      Computable Numbers. Proc. Lond. Math. Soc., 42, 230–265.
    ]
+ Enable user-defined _meaning_#pause
  - Avoid empty symbols!#pause
  - Symbol Grounding Problem#footnote[Harnad, S. (1990). _The Symbol Grounding
      Problem._ Physica D, 42, 335–346.
    ]#pause

- Achieve both through *representations*

== Representations
#pause
- Centered around _representing_ things
- $a - c -> b$: $a$ *represents* $b$ *in context* $c$#pause
  - $a$: *sign*#pause
  - $b$: *referent*#pause
  - $c$: *context*#pause
- Track _faithfulness_ of representations through *truth*
== Units
#pause
- *Finitely defined*#pause
- Can be broken down, combined
  - Written with braces ${a, b, ..., z}$#pause
- Built from *Handles*#pause
  - Name origin: file/resource handles (programs)#pause
  - Enables user-defined meaning#pause
  - User's goal: correctly specify!#pause
- Representations are units#pause
- Each unit has its own *context*

== Information

== Turing Completeness

= Syntax

== Overview

== Encoding

== Invertible Syntax Descriptions

== The Welkin Grammar

== Outline of Unambiguity

= Metatheory

= Conclusion
