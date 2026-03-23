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

// TODO: remove extra slide due to ASCII table!
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
    ]

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
  - *Universality:* be completely expressive (*done*)
    - _Any_ computer program
    - _Any_ "reliable" proof
  - *Scalability:* work at any size (*WIP*)
    - Be efficient
    - Support: future optimizations
    - Describe improvements _in_ Welkin
  - *Standardization:* be completely _unambiguous_ (*WIP*)#pause
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
  - Avoid hollow symbols!#pause
  - Symbol Grounding Problem#footnote[Harnad, S. (1990). _The Symbol Grounding
      Problem._ Physica D, 42, 335–346.
    ]#pause

- Achieve both via *representations*

== Representations

#pause
- Centered around _representing_ things #pause
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
#pause
- Representations #pause $~$ *Truth*#pause
- Information #pause $~$ *Proofs*#pause
  - Includes simple facts#pause
  - Expands to complex truth systems#pause
- Major result: can express _any_ "reliable" proof#pause
  - More details later! (Metatheory)

== Rules

- *Internal Transitivity:* $a - c -> b$ and $b - c -> d$ imply $a - c -> d$
- *Contextual Lifting:*#pause
- *Lattice Laws:*
  - Units as sets

== Turing Completeness
#pause
- Part of Universality#pause
- *Theorem:* #pause _every unit corresponds to some program, and vice versa._
  - $phi$: some mapping between units and programs#pause
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

== Building Blocks (cont')

- `A, B`: general rules#pause
- `A - seq -> B`:#pause
  - *Parser:* apply `A`, then `B`.#pause
  - *Printer:* prints `AB`.#pause
- `A - seq_many_till -> B`:#pause
  - *Parser:* Apply `A` zero more times, _until_ the `B` accepts input#pause
  - *Printer:* prints zero or more `A`, then `B`#pause
- `A - lexeme -> B`:#pause
  - Same as `seq`, but whitespace allowed#pause
- `A - lex_many_till -> B`:#pause
  - Same as `seq_many_till`, but whitespace allowed#pause

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
- Desirable properties:#footnote[
    Consult: Aho et al. (2006). _Compilers: Principles, Techniques, and Tools_
    (2nd ed.).

  ]
  - Unambiguous: every valid input produces _one_ output#pause
  - Efficient parsing
- For our parsers, need Edelmann et. al:#footnote[Edelmann et al. (2020). _Zippy
    LL(1) parsing with derivatives_. PLDI 2020.]#pause
  - Involves recursive equations on sets#pause
  - Need: certain sets are djsoint#pause
  - For details, refer to thesis

= Metatheory

#let entails = $⊢$

== Primer
#pause
- Terminology
  - *First Order Logic:*#pause
    - Propositional logic (and, or, not)#pause
    - Quantifiers (forall, exists)
  - *Peano Arithmetic* (PA): natural numbers + induction
  - Important: corresponds to a Turing machine, $"TM"_"PA"$
  - *Consistency:* no proofs contain falsehood ($bot$)
- Many theorems on limit:s#pause
  - *Gödel incompleteness*#pause
    - *First:* PA can't prove everything#pause
    - *Second*: PA cannot prove _own_ consistency#pause
  - Tarski undefinability#pause
  - Etc.#pause
// TODO: maybe break up
- Usual approach: _chain of stronger theories_#pause
  - Keep adding $"Con" ("PA")$#pause
  - _Technically_ enough, based on Feferman's work[TODO: cite!]#pause
  - Problem: want _constructive_ & _solid_ foundations

== Artëmov's Selector Proofs
#pause
- Artëmov _changes_ this paradigm#pause
  - There is a _weaker_ proof: *selectors*#pause
- *Selector:* algorithm that takes proofs as inputs#pause
  1. Takes in _any_ proof#pause
  2. If it accepts a proof, no $bot$ appears#pause
- Artëmov

== Serial-Soundness

#pause
- Extend Artëmov to *serial-soundness:*
  - Secret: _same_ technique!
  - Use Tarski's *partial truh predicates*#footnote[
      TODO: cite

    ]
  - Partial truth predicate: [TODO: define!]
- *Serial soundness:* a RE theory $T supset.eq "PA"$ with a selector s.t.:
  - Accepts all proofs + preserves truth#pause
  - _cannot_ be proven with:
    - Excluded Middle: $phi or not phi$#pause
    - Explosion: $bot => phi$#pause
- *Self-verifying*: _in_ PA, $T$ can prove its own serial-soundness
  - $"PA" attach(entails, br: T) phi$ if $T entails phi$, $T$ self-verifying

== Reliable Proofs

- How to generalize to _any_ theory?#pause
  - Example: Naive Set Theory#pause
    - Can't _fully_ trust b/c, e.g., Russell's Paradox#pause
    - But can trust, e.g., $x in X <=> x in X$#pause
    - Idea: check for sound _restricted_ theory
- Let $T_1 supset.eq "PA"$, $phi$ a sentence#pause
- *Reliable proof*: a triple $(S, p_S, p_phi)$ s.t:
  - $S supset.eq T_1$#pause
  - $p_S$: constructs some self-verifying $S' supset.eq S$#pause
  - $p_phi$: $S$-proof of $phi$

== Proof Completeness
- *Note:* still has incompletness!#pause
  - Proofs are limited! (Not surprising)#pause
  - Also: not a _single_ theory suffices#pause
  - But, a theories _can_ be self-verifying!#pause
- How to prove?
  - Basic idea: $"ZFC"$ is self-verifying!
    - Again, same proof from Artëmov!
  - HUGE leap; how to generalize?
  - Answer: comprehension!

// TODO: add citations!
== Crash Course: Recursive Ordinals
- Roughly: certain transitive sets ($x in y in z => x in z$)#pause
  - Contents can be enumerated by some program#pause
- Limit: *Church Kleene Ordinal* ($omega^"CK"_1$)#pause
- *Proof-theoretic ordinal:* measures theory strength
  - Important: this is recursive if $T$ is RE _and_ sound#pause
  - Bounded below $omega^"CK"_1$!#pause

// TODO: cite!
== Proof Completeness (con't)
- Need to construct comprehension
  - Use Simpson's comprehension axiom:
    $ exists X. forall n. lr((n in X <=> Phi(n))) $
  - $Phi$: very complex formula ($Delta^1_1$)
- Let:
  - $lambda$ be limit of recursive $beta_1, beta_2, ...$
  - Each $T_beta_i$ self-verifying
  - $T' = union.big_(beta <lambda) T_beta$
  - $"Comp"_lambda (Delta^1_1) = exists X_(phi, lambda). forall n. lr(
      (n in X_(phi, lambda) <=> "PA" attach(entails, br: T') phi(n))
    )
    )$
- Our construction: $T_lambda$
  - ✔️ Eventually reaches limit
  - ✔️ Self-verifying
  - ✔️ *Constructive*
- TL;DR: Artëmov + Simpson + Reliability = Proofs 💯



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
- Query Solvers#pause
- Revision System#pause
- Package Management#pause

== Thank you!

Questions?
