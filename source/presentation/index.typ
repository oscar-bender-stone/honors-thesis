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

#let matched-dash = math.class(
  "relation",
  box(
    width: 0.764em, // Your measured 7.64 stem width / 10
    height: 0.5em, // Keeps baseline alignment consistent
    align(
      center + horizon,
      line(length: 0.764em, stroke: 0.049em + black), // Your measured 0.49 thickness
    ),
  ),
)
#show math.minus: matched-dash


#let printable-ascii-table(num-triples: 7) = {
  let to-hex(n) = {
    let h = str(n, base: 16)
    if h.len() == 1 { "0" + h } else { h }
  }

  let get-glyph(n) = {
    if n == 32 { [Space] } else if n <= 126 { raw(str.from-unicode(n)) } else {
      ""
    }
  }

  set text(font: "STIX Two Text", size: 12pt)

  // 95 printable characters (32 to 126)
  let total-chars = 95
  // Dynamically calculate how many rows we need based on columns
  let rows = calc.ceil(total-chars / num-triples)

  table(
    columns: (auto, auto, auto) * num-triples,
    inset: (x: 3pt, y: 3pt),
    align: (col, row) => (right, center, center).at(calc.rem(col, 3)),
    stroke: none,

    // Header Rule
    table.hline(y: 0, stroke: 1.5pt + black),
    table.hline(y: 1, stroke: 0.75pt + black),

    // Bottom Rule - now uses the dynamic row count correctly
    table.hline(y: rows + 1, stroke: 1.5pt + black),

    // Dynamic Vertical separators between the triples
    ..range(1, num-triples).map(i => table.vline(
      x: i * 3,
      stroke: 0.5pt + black,
    )),

    // Header Row
    table.header(
      ..range(num-triples).map(_ => ([*Dec.*], [*Hex.*], [*Glyph*])).flatten(),
    ),

    // Data Rows
    ..range(rows)
      .map(r => {
        let cells = ()
        for i in range(num-triples) {
          let n = 32 + r + (i * rows)
          if n <= 126 {
            cells += (str(n), upper(to-hex(n)), get-glyph(n))
          } else {
            // Fill empty cells if the last column is shorter than the rest
            cells += ("", "", "")
          }
        }
        cells
      })
      .flatten(),
  )
}

// Set your desired number of column triples here (e.g., 5 or 6)
#printable-ascii-table(num-triples: 6)

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
  compare-list(
    [*Resource Description Language (RDF):*],
    citation: [Hitzler et al. (2009). _OWL 2 Web Ontology Language Primer_.
      W3C.],
    (
      info[Used in Web Ontology Language *(OWL)*],
      pro[Built to be *interoperable*],
      con[No built-in logic engine],
    ),
  ),
  compare-list(
    [*Labeled Property Graphs (LPGs):*],
    citation: [Robinson, Webber & Eifrem (2015). _Graph Databases_ (2nd ed.).
      O'Reilly.],
    (
      info[Stores *properties* (node/edge metadata)],
      pro[Efficient queries],
      // con[Not standardized],
      con[No logic engine. Hacky tooling/scripts],
    ),
  ),
  compare-list(
    [*Cyc:*],
    citation: [Lenat (1995). _CYC: A large-scale investment in knowledge
      infrastructure_. CACM 38(11).],
    (
      info[Largest *knowledge base* to date],
      pro[Sophisticated logic engine],
      con[Hard-coded, proprietary rules],
    ),
  ),
)

// TODO: fix pausing!
// Doesn't work with this list
== Proposed Solution
#pause
- *Welkin*: an information language
  - Pronounced: "VEL-KIN"
  - Old German word, meaning "cloud", "sky"#footnote[Oxford English Dictionary
      (2025), s.v. "welkin, n."
    ]
- *Goals:*#pause
  - *Universality:* be completely expressive(*done*)
    - _Any_ computer program
    - _Any_ "reliable" proof
  - *Scalability:* work at any size (*WIP*)
    - Be efficient
    - Support: future optimizations
    - Describe improvements _in_ Welkin
  - *Standardization:* be completely _unambiguous_(*WIP*)#pause
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

- Achieve both via *representations*

== Representations

#pause
- Centered around _representing_ things
- $a - c -> b$: $a$ *represents* $b$ *in context* $c$#pause
  - $a$: *sign*#pause
  - $b$: *referent*#pause
  - $c$: *context*#pause
- Track _faithfulness_ of representations via *truth*
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

// TODO: make more complete!
== Information

- Representations #pause $~$ *Truth*#pause
- Information #pause $~$ *Proofs*#pause
  - Includes simple facts
  - Expands to complex truh systems
- Major result: can express _any_ "reliable" proof
  - More details later! (Metatheory)

== Rules

- *Internal Transitivity:*
- *Contextual Lifting:*#pause
- *Lattice Laws:*
  - Units as sets

== Turing Completeness
#pause
- Part of Universality
- *Theorem:* #pause _every unit corresponds to some program, and vice versa._
  - $phi$: some mapping between units and programs
  - Interpretation: #pause $a - c -> b$ iff
    $phi_c (chevron.l phi_a chevron.r) = chevron.l phi_b chevron.r$
  - $chevron.l phi_a chevron.r$: #pause encodes $phi_a$ as a string
- Later: #pause completeness for *proofs*!

= Syntax

== Overview

== Encoding

- Characters written in `type-writer font`#footnote[Font used: Intel One Mono
    (#link(
      "https://github.com/intel/intel-one-mono",
    )), licensed under OFL 1.1 (#link(
      "https://github.com/intel/intel-one-mono/blob/main/OFL.txt",
    )).]

- Define US-ASCII: Printable (codes: 32-126) + `EOF` (code: 127)
- *Token:* collection of contiguous characters
  - Simplifies grammar

== US-ASCII

#figure(
  printable-ascii-table(),
  caption: [Printable US-ASCII codes and glyphs.],
)<syntax:printable-ascii-codes>

== Character Classes

#figure(
  // Using 'auto' for both ensures the table is only as wide as its longest line
  table(
    columns: (auto, auto),
    align: left,
    stroke: none,
    column-gutter: 1.2em,
    // Narrower gap between columns
    inset: (x: 0pt, y: 0.5em),
    // Tighter vertical rows

    // Top boundary - 1pt for a lighter feel than 1.5pt
    table.hline(stroke: 1pt),

    [*Set Name*], [*Characters*],

    // Header separator
    table.hline(stroke: 0.5pt),

    [`PRINTABLE`], [Listed in Table 1],
    [`WHITESPACE`], [`\t` | `\r` | Space],
    [`DELIMITER`], [`{` | `}` | `'` | `"` | `.` | `,`],
    [`RESERVED`], [`DELIMITER` | `*` | `@`],
    [`SQ_CHAR`], [Any `PRINTABLE` except `'` and `\`],
    [`DQ_CHAR`], [Any `PRINTABLE` except `"` and `\`],
    [`ID_CHAR`], [Any `PRINTABLE` not in `RESERVED` or `WHITESPACE`],

    // Bottom boundary
    table.hline(stroke: 1pt),
  ),
  caption: [Key character classes.],
) <syntax:character-classes>

== Building Blocks
- *Invertible Syntax Descriptions:* pairs of functions:#footnote[Rendel &
    Ostermann (2010). Invertible syntax descriptions. Haskell '10.]#pause
  - *Parser*: takes (_consumes_) tokens, converts into a data
    structure#footnote[For computer scientists: this is an AST.]#pause
  - *Printer*: converts a data structure into a string
  - Identity: when parser succeeds, is "reversible" with printer.
- Need *maximal munch:*#pause consume tokens, not characters#pause
  - Simplifies grammar

== The Welkin Grammar
#figure(
  text(size: 13pt)[
    #grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 1.5em,
      align: top,

      // Column 1: Core Rules
      block(inset: 0pt)[
        ```
        start := units - lexeme -> EOF,
        units := "" | {unit - lexeme -> *{"", "," - lexeme -> units}},
        unit := node - lexeme -> *{
          ":=" - lexeme -> choices,
          *{"", arc - lexeme -> chain}
        },
        choices := *{"", "|"} - lexeme -> choices_list,
        choices_list := *{"",
          chain - lexeme -> *{"", "|" - lexeme -> choice_list}
        },
        chain := *{"", "*"} - seq -> path - lexeme -> *{"", arc - lexeme -> chain},
        arc := right_arc | other_arc,
        right_arc := "-" - seq -> node - seq -> "->",
        other_arc := "<-" - seq -> node - seq -> *{"-", "->"},
        ```
      ],

      // Column 2: Graph/Path Logic
      block(inset: 0pt)[
        ```
        node := *{"", "*"} - seq -> path,
        path := *{"", modifiers} - seq -> trailer - seq -> *{"", graph},
        modifiers := *{
          "@",
          "~" - seq -> *{"", "@"}
        },
        trailer := segment - seq -> *{"", "." - seq -> trailer},
        segment := HANDLE - lexeme -> *{"", graph},
        graph :=  "{" - lexeme -> units - lexeme -> "}",
        HANDLE := ID | STRING,
        ```
      ],

      // Column 3: Strings and Identifiers
      block(inset: 0pt)[
        ```
        STRING := SQ_STRING | DQ_STRING,
        SQ_STRING := "'" - seq -> *{SQ_CHAR, "\'"} - seq_many_till -> "'",
        DQ_STRING := '"' - seq -> *{DQ_CHAR, '\"'} - seq_many_till -> '"',
        ID := ID_CHAR - seq_many_till -> *{RESERVED, WHITESPACE}
        ```
      ],
    )
  ],
  caption: [Full Welkin grammar.],
)


// TODO: add details about FIRST/SN-FOLLOW?
== Outline of Unambiguity

- Simple grammar class: $"LL"(1)$#pause
- Desirable properties:
  - Unambiguous: every valid input produces _one_ output#pause
  - Efficient parsing#footnote[
      Consult: Aho et al. (2006). _Compilers: Principles, Techniques, and Tools_
      (2nd ed.).
    ]#pause

- For our parsers, need Edelmann et. al:#pause#footnote[Edelmann et al. (2020).
    _Zippy LL(1) parsing with derivatives_. PLDI 2020.]
  - Involves recursive equations on sets#pause
  - Need: certain sets are djsoint#pause
  - For details, refer to thesis

= Metatheory

= Conclusion

== Comparisons to Existing Solutions

- *Resource Description Framework:*
  - Similar ideas/terms about representations
  - Welkin:
    - Higher order terms
    - Better ogical reasoning
- *Labeled Property Graphs:*
  - Simple core idea + expressive
  - Welkin:
    - Formal definitions and grammar
    - Logical engine
- *Cyc:*
  - Similarly depend on contexts
  - Welkin:
    - Flexible data format
    - Open specification


== Future Work
#pause
- Write the Standard#pause
- Create a Fast Implementation#pause
- Revision System#pause
- Revision System#pause
- Package Management#pause

== Thank you!

Questions?
