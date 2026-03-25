// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template.typ": (
  elegant-blue-theme, end-slide, pause, t-footnote, title-slide, uncover,
)
#import "compare-list.typ": compare-list, con, info, pro

#show: elegant-blue-theme.with(
  draft: false,
  title: [Designing a Universal Information Language],
  author: [Oscar Bender-Stone],
  date: [March 26, 2026],
)

#title-slide()

// Dynamically inherits text.fill so it can be colored (e.g., red in cons)
#let matched-dash = context math.class(
  "relation",
  box(
    width: 0.764em,
    height: 0.5em,
    align(
      center + horizon,
      line(length: 0.764em, stroke: 0.049em + text.fill),
    ),
  ),
)
#show math.minus: matched-dash

// Scaled down to guarantee no extra blank slides
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

  set text(font: "STIX Two Text", size: 9pt) // Reduced to fit beautifully

  // 95 printable characters (32 to 126)
  let total-chars = 95
  // Dynamically calculate how many rows we need based on columns
  let rows = calc.ceil(total-chars / num-triples)

  table(
    columns: (auto, auto, auto) * num-triples,
    inset: (x: 2pt, y: 1.5pt), // Reduced inset
    align: (col, row) => (right, center, center).at(calc.rem(col, 3)),
    stroke: none,

    // Header Rule
    table.hline(y: 0, stroke: 1.5pt + black),
    table.hline(y: 1, stroke: 0.75pt + black),

    // Bottom Rule
    table.hline(y: rows + 1, stroke: 1.5pt + black),

    // Dynamic Vertical separators
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
            cells += ("", "", "")
          }
        }
        cells
      })
      .flatten(),
  )
}

= Introduction

== Introduction
#pause
- Information helps us *store* and *organize* data #pause
  - Throughout _all_ history: so much data!
  - Want to actually use in, e.g., decisions
- Inquiry: what _is_ information?#pause
  - Depends on who you ask!
  #pause
  - *Ackoff:* Data-to-Wisdom Hierarchy#t-footnote[Ackoff, R. L. (1989). _From
      Data to Wisdom_. J. Appl. Syst. Anal., 16, 3–9.]#pause
    - Data $=>$ Information $=>$ Wisdom
    #pause
  - *Buckland:* Based on usage#t-footnote[Buckland, M. K. (1991). _Information
      as thing_. JASIS, 42(5), 351–360.]#pause
    - Can be a _process_, or _knowledge_
    - Most useful as _thing_
  - *Floridi:* Information is *truthful*#t-footnote[Floridi, L. (2010).
      _Information: A Very Short Introduction_. Oxford University Press.]

== Challenges in Managing Information
#pause
- *Depth:* domain specific data
  - Terminology, kinds of data, etc.#pause
- *Breadth:* wide variety of domains#pause
  - Different principles, methods
  - Example: Physics $!=$ Biology!
- *Standardization:* ambiguous interpretations
  - Related issue: being *interoperable*
    - *Interoperable:* a portable data format
    - Example: U.S. Health records
    - Transfer is hard, even for the _same_ patient

== Existing Solutions
#pause
// Using standard list syntax `- ` with pauses interleaved works flawlessly!
- #compare-list(
    [*Resource Description Language (RDF):*#t-footnote[Hitzler et al. (2009).
        _OWL 2 Web Ontology Language Primer_. W3C.]],
    (
      info[Used in Web Ontology Language *(OWL)*],
      pro[Built to be *interoperable*],
      con[No built-in logic engine],
    ),
  )
#pause
- #compare-list(
    [*Labeled Property Graphs (LPGs):*#t-footnote[Robinson, Webber & Eifrem
        (2015). _Graph Databases_ (2nd ed.). O'Reilly.]],
    (
      info[Stores *properties* (node/edge metadata)],
      pro[Efficient queries],
      // con[Not standardized],
      con[No logic engine. Hacky tooling/scripts],
    ),
  )
#pause
- #compare-list(
    [*Cyc:*#t-footnote[Lenat (1995). _CYC: A large-scale investment in knowledge
        infrastructure_. CACM 38(11).]],
    (
      info[Largest *knowledge base* to date],
      pro[Sophisticated logic engine],
      con[Hard-coded, proprietary rules],
    ),
  )

== Proposed Solution
#pause
- *Welkin*: an information language#pause
  - Pronounced: "VEL-KIN"#pause
  - Old German word, meaning "cloud", "sky"#t-footnote[Oxford English Dictionary
      (2025), s.v. "welkin, n."]#pause
  - Represents _expansive_ nature of language

== Goals
- *Universality:* be completely expressive #pause (*done*)#pause
  - _Any_ computer program#pause
  - _Any_ "reliable" proof#pause
- *Scalability:* work at any size #pause (*In progress*)#pause
  - Be efficient#pause
  - Can add optimizations _in_ Welkin#pause
- *Standardization:* be completely _unambiguous_ #pause (*In progress*)#pause
  - Have a formal specification

= Language Overview

== General Requirements

#pause
+ Express any computer program#pause
  - Need effective operations#pause
  - Established notion: *Turing machines*#t-footnote[Turing, A. M. (1936). On
      Computable Numbers. Proc. Lond. Math. Soc., 42, 230–265.]
+ Enable user-defined meaning#pause
  - Avoid meaningless symbols!#pause
  - Symbol Grounding Problem#t-footnote[Harnad, S. (1990). _The Symbol Grounding
      Problem._ Physica D, 42, 335–346.]#pause
  - Treat as free parameter in theory

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
- Units are *finite programs*
- Built from *Handles*#pause
  - Name origin: file/resource handles (programs)#pause
  - Enables user-defined meaning#pause
  - User's goal: correctly specify!#pause
- Each unit contains its own *context* of representations
  - Written with braces ${a, b, ..., z}$#pause
  - Representations are _also_ units

// TODO: make more complete!
== Information
#pause
- Representations = *Truth*#pause
- Information = *Proofs*#pause
  - Includes simple facts#pause
  - Expands to complex truth systems#pause
- Major result: can express _any_ "reliable" proof#pause
  - More details later! (Metatheory)


#let rule-table(theme-color, rows) = {
  table(
    columns: (0.6fr, 1.8fr, 3fr),
    inset: (x: 10pt, y: 12pt),
    align: (center + horizon, left + horizon, left + horizon),
    stroke: none,
    // Remove all borders for a modern look
    fill: (x, y) => if y == 0 { theme-color.lighten(80%) },

    // Header
    table.header([*ID*], [*Name*], [*Rule*]),

    // Horizontal line under header
    table.hline(stroke: 1.5pt + theme-color),

    ..rows,

    // Bottom line
    table.hline(stroke: 0.5pt + theme-color),
  )
}

== Rules

- Three categories:#pause
  - *Primary:*#pause
    - Transitivity in a context#pause
    - Congruence (build new units)#pause
  - *Empty*#pause
    - Defines empty unit#pause
    - Enables exclusions#pause
  - *Lattice*#pause
    - Makes units position independent#pause
- For details: consult thesis

== Turing Completeness
#pause
- Part of Universality#pause
- *Theorem:* _every unit corresponds to some program, and vice versa._#pause
  - For details: consult thesis
- Later: #pause completeness for *proofs*!

= Syntax

== Syntax

- Two main parts#pause
  - Encoding: characters#pause
    - Building blocks of strings#pause
  - Grammar: strings allowed by language
    - Punctuation
    - How strings are combined

== Encoding

- Characters written in `type-writer font`#t-footnote[Font used: Intel One Mono
    (#link("https://github.com/intel/intel-one-mono")), licensed under OFL 1.1.]

- Define US-ASCII: Printable (codes: 32-126) + `EOF` (code: 127)
- Character classes: refer to thesis

== US-ASCII

#figure(
  printable-ascii-table(),
  caption: [Printable US-ASCII codes and glyphs.],
)<syntax:printable-ascii-codes>


== Grammar
- Build on two papers (details in thesis)#pause
  - First: *Invertible Syntax Descriptions*#t-footnote[Rendel & Ostermann
      (2010). Invertible syntax descriptions. Haskell '10.]
    - Processes strings, forwards and back#pause
  - Second: Edelmann et. al.#t-footnote[Edelmann et al. (2020). _Zippy LL(1)
      parsing with derivatives_. PLDI 2020.]
    - Used in proof of unambiguity#pause
    - Also ensures efficiency#pause
  - *Notes*:#pause
    - Current proofs are done#pause
    - Grammar is *not* finalized

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

= Metatheory

== Formal System Limits

- Many theorems on limit:s#pause
  - *Gödel incompleteness*#pause
    - *First:* PA can't prove everything#pause
    - *Second*: PA cannot prove _own_ consistency#pause
  - Etc.#pause
- Usual approach: _chain of stronger theories_#pause
  - Extend by $"Con"(T)$ (encoding of consistency)#pause
  - Technically: this is enough, WITH non-constructive
    methods#t-footnote[Feferman (1962). Transfinite Recursive Progressions of
      Axiomatic Theories. J. Symb. Log. 27(3).]#pause
  - Problem: want to identify + trust proofs!

#let entails = $⊢$

== Artëmov's Selector Proofs
#pause
- Artëmov _changes_ this paradigm#t-footnote[Artemov (2024). Serial properties,
    selector proofs and the provability of consistency. J. Logic Comput. 35(3).]
  #pause
  - Early Mentions (No Framework): Hilbert, Gödel, etc.#pause
  - Proves a weaker property: *serial-consistency*
- Approach: over a theory $T$, build a computable function _over_ $T$-proofs
  #pause
  + Enumerate through all $T$-proofs in a meta-theory (e.g., $"PA"$)#pause
  + Using $T$, show each $T$-proof $p$ is consistent (no $bot$)#pause
- This works..._almost_#pause
  - Any inconsistency is _finite_
  - Method above aims to show _no_ such example exists#pause
  - Problem: could use $bot$ to prove this!#pause
  - Need to add restriction: *must be constructive*

== Serial-Soundness

#pause
- Extend Artëmov to *serial-soundness:*#pause
  - Secret: _same_ technique!#t-footnote[Consult: Artemov (2024). Serial
      properties, selector proofs and the provability of consistency. J. Logic
      Comput. 35(3).]#pause
- Let $T$ be a first-order, RE theory#pause
- $T$ is *serial-sound*, if for some total function $s$:#pause
  - Accepts all proofs + preserves truth#pause
  - Correctness _cannot_ be proven with:#pause
    - Excluded Middle: $phi or not phi$#pause
    - Explosion: $bot => phi$#pause
- $T$ is *self-verifying* if, _in_ PA, $T$ can prove its own
  serial-soundness#pause
  - Notation: $"PA" attach(entails, br: T) phi$ if $T entails phi$ and $T$
    self-verifying

== Reliable Proofs

#show sym.emptyset: math.diameter

- How to generalize to _any_ theory?#pause
  - Example: Naive Set Theory#pause
    - Can't _fully_ trust b/c Russell's Paradox#pause
    - But can trust, e.g., $x in X <=> x in X$#pause
    - Idea: check for sound _restricted_ theory
- Let $T_1$ be an RE theory, $phi$ a sentence#pause
- *Reliable proof*: a triple $(S, p_S, p_phi)$ s.t:
  - $S supset.eq T_1$, $S != emptyset$#pause
  - $p_S$: constructs some self-verifying $S' supset.eq S$#pause
  - $p_phi$: $S$-proof of $phi$

== Proof Completeness
- *Note:* still has incompleteness!#pause
  - Proofs are limited! (Not surprising)#pause
  - Also: not a _single_ theory suffices#pause
  - However, a theory _can_ be self-verifying!#pause
- How to reach limit on proofs?#pause
  - Basic idea: $"ZFC"$ is self-verifying!#pause
    - Again, same proof from Artëmov!#pause
  - *Huge* leap in power; how to extend it?#pause
  - Answer: comprehension!#pause
  - Details in thesis

= Conclusion

== Conclusion
- Welkin is a universal information language#pause
  - Provided basic rules#pause
  - Provided syntax#pause
  - Provided metatheory#pause
- Goals:#pause
  - Universal (*done*)#pause
  - Scalable (*in progress*)#pause
  - Standardization (*in progress*)

== Comparisons to Existing Solutions
#pause
- *Resource Description Framework:*#pause
  - Similar ideas/terms about representations#pause
  - Welkin:#pause
    - Higher order terms#pause
    - Better logical reasoning#pause
- *Labeled Property Graphs:*#pause
  - Simple core idea + expressive#pause
  - Welkin:#pause
    - Formal definitions and grammar#pause
    - Logical engine
== Comparisons to Existing Solutions (cont')
#pause
- *Cyc:*#pause
  - Similarly depend on contexts#pause
  - Welkin:#pause
    - Flexible data format#pause
    - Open specification


== Future Work
#pause
- Write the Standard#pause
- Create a Fast Implementation#pause
- Information Search Programs#pause
- Revision System#pause
- Package Management#pause


#end-slide()
