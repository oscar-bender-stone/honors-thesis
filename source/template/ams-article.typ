// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT
//
// Adapted from typst/templates
// under the MIT license:
// https://github.com/typst/templates


// Matched dash so that
// representations can be written
// $a - b -> c$
// WARNING: only works with STIX 2 Math font!
// Pixel measurements done with macOS Preview
// Total width: 8.77 points
// Stem width: 7.64 points
// Thickness: 0.49 points
// Base font size: 10.0002pt
// TODO: improve width
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

// Only used for exclusion operator
// in imports
#let tilde-prefix = math.class(
  "unary",
  move(dy: 0.2pt, scale(80%, $tilde$)),
)

// Sizes used across the template.
#let script-size = 7.97224pt
#let footnote-size = 8.50012pt
#let small-size = 9.24994pt
#let normal-size = 10.00002pt
#let large-size = 11.74988pt
#let text-font = "STIX Two Text"

#let draft = true

#let show-todos = true

#let todo(body, color: orange) = {
  if draft {
    place(
      left,
      dx: 100% + 0.5cm,
      block(
        width: 3.5cm,
        fill: color.lighten(90%),
        stroke: 1pt + color,
        inset: 8pt,
        radius: 4pt,
        outset: (y: 2pt),
        {
          set par(first-line-indent: 0pt, hanging-indent: 0pt, justify: false)
          set align(left)

          text(weight: "bold", fill: color)[TODO:]
          [ ] + body
        },
      ),
    )
  }
}
// This function gets your whole document as its `body` and formats
// it as an article in the style of the American Mathematical Society.
#let ams_article(
  // The article's title.
  title: [Paper title],
  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),
  // Your article's abstract. Can be omitted if you don't have one.
  abstract: none,
  // The article's paper size. Also affects the margins.
  paper-size: "us-letter",
  // The result of a call to the `bibliography` function or `none`.
  bibliography: none,
  // The document's content.
  body,
  // Front Matter Parameters
  // Notes
  notes: none,
  // Author "thanks" (e.g., funding)
  thanks: none,
  // Date of submission
  date: none,
  // 2020 Mathematics Subject Classification
  msc: none,
  // Keywords
  keywords: none,
  // Notes
) = {
  let watermark = if draft {
    rotate(24deg, text(80pt, fill: gray.lighten(70%))[
      *DRAFT*
    ])
  } else {
    none
  }

  // Create a single, shared counter for theorem-like environments
  let theorem-counter = counter("theorem-shared")

  // Formats the author's names in a list with commas and a
  // final "and".
  let names = authors.map(author => author.name)
  let author-string = if authors.len() == 2 {
    names.join(" and ")
  } else {
    names.join(", ", last: ", and ")
  }

  // Set document metadata.
  set document(title: title, author: names)

  // Set the body font.
  set text(size: normal-size, font: "STIX Two Text")

  // NOTE: when run with --root .,
  // won't detect the new font!
  // Might want to file a bug report
  // on a minimum working example.
  show raw: set text(font: "Intel One Mono", weight: "regular")

  // Set equation numbering to (section.equation)
  set math.equation(numbering: "(1.1)")

  // Configure the page.
  set page(
    background: watermark,
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size != "a4" {
      (
        top: (116pt / 279mm) * 100%,
        left: (126pt / 216mm) * 100%,
        right: (128pt / 216mm) * 100%,
        bottom: (94pt / 279mm) * 100%,
      )
    } else {
      (
        top: 117pt,
        left: 118pt,
        right: 119pt,
        bottom: 96pt,
      )
    },

    // The page header should show the page number and list of
    // authors, except on the first page. The page number is on
    // the left for even pages and on the right for odd pages.
    header-ascent: 14pt,
    header: context {
      let i = counter(page).get().first()
      if i == 1 { return }
      set text(size: script-size)
      grid(
        columns: (6em, 1fr, 6em),
        align: (start, center, end),
        if calc.even(i) [#i],
        upper(
          if calc.odd(i) { title } else { author-string },
        ),
        if calc.odd(i) { [#i] },
      )
    },

    // Updated footer for metadata on page 1
    footer-descent: 12pt,
    footer: context {
      let i = counter(page).get().first()
      if i == 1 {
        // Page 1 footer
        // v(1fr) // Push content to bottom of footer area

        // Metadata block
        if (date, msc, keywords, thanks, notes).any(it => it != none) {
          set par(first-line-indent: 0pt)
          set text(script-size)

          // The short line above the metadata
          line(length: 2em)
          v(0.5em)

          if thanks != none {
            show: par.with(first-line-indent: 0pt)
            thanks
            v(0.5em, weak: true)
          }

          if notes != none {
            block(
              inset: 0pt,
              {
                notes
                v(0.5em, weak: true)
              },
            )
          }

          if date != none {
            [#emph[Date:] #date.]
          }
          if msc != none {
            [#emph[2020 Mathematics Subject Classification.] #msc.join(", ").]
          }
          if keywords != none {
            [#emph[Key words and phrases.] #keywords.join(", ").]
          }
        }

        // Page number (always at the very bottom-center)
        v(1em, weak: true)
        align(center, text(size: script-size, [#i]))
      }
    },
  )

  // Configure headings.
  set heading(numbering: "1.")

  // Wrap heading 'show' in a block to fix style "leaking"
  show heading: it => {
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    block({
      set text(size: normal-size, weight: 400)
      set par(first-line-indent: 0em)
      if it.level == 1 {
        set align(center)
        set text(size: normal-size)
        smallcaps[
          #v(15pt, weak: true)
          #number
          #it.body
          #v(normal-size, weak: true)
        ]

        theorem-counter.update(0)
        // Reset equation counter at each new section
        counter(math.equation).update(0)
      } else {
        v(11pt, weak: true)
        number
        let styled = if it.level == 2 { strong } else { emph }
        styled(it.body + [. ])
        h(7pt, weak: true)
      }
    })
  }

  // Configure lists and links.
  set list(
    marker: ([•], [–], [\*], [.]),
    indent: 20pt,
    body-indent: 5pt,
  )
  set enum(
    numbering: "1.(a).(i).(A)",
    indent: 20pt,
    body-indent: 5pt,
  )

  show link: set text(font: text-font)

  // Configure equations (now only sets spacing).
  show math.equation: set block(below: 8pt, above: 9pt)

  // Configure rules to show correctly
  show ref: it => {
    let el = it.element
    if el != none and el.func() == figure and el.kind == "rule" {
      // Get the specific number at the referenced location
      let num = counter(figure.where(kind: "rule")).at(el.location()).first()

      // Construct the reference as a link, using the supplement (your prefix) + number
      link(it.target)[*#el.supplement#num*]
    } else {
      // Return all other references (to sections, equations, etc.) as normal
      it
    }
  }

  // Configure citation and bibliography styles.
  // Adapted from CSL styles,
  // licensed under the
  // Creative Commons Attribution-ShareAlike 3.0 Unported license:
  // https://citationstyles.org/
  set std.bibliography(
    style: "american-mathematical-society-label.csl",
    title: [References],
  )

  // Improvements to tables
  // to look more LaTeX's "booktabs"

  // 1. Globally override all table strokes FIRST.
  // This forces zero vertical lines and handles the top/header rules.
  show table: set table(
    inset: (x: 0.75em, y: 0.5em),
    align: horizon,
    stroke: (x, y) => (
      // Heavy 1.5pt rule at the very top
      // Light 0.5pt rule under the header (row 1)
      // No lines anywhere else (left, right, bottom)
      top: if y == 0 { 1.5pt + black } else if y == 1 { 0.5pt + black } else {
        none
      },
      bottom: none,
      left: none,
      right: none,
    ),
  )

  // 2. Wrap the newly styled tables in a block to add the final heavy bottom rule.
  show table: it => block(
    stroke: (bottom: 1.5pt + black),
    outset: 0pt,
    it,
  )
  // Figures
  set figure(gap: 17pt)
  show figure: set block(above: 12.5pt, below: 15pt)
  show figure: it => {
    // Avoid using "rule" for rule-table
    if it.kind == "rule" {
      return it.body
    }
    // Customize the figure's caption.
    show figure.caption: caption => {
      smallcaps(caption.supplement)
      if caption.numbering != none {
        [ ]
        numbering(caption.numbering, ..caption.counter.at(it.location()))
      }
      [. ]
      caption.body
    }

    // We want a bit of space around tables and images.
    // Do images here,
    // as we already covered tables
    show image: pad.with(x: 23pt)

    // Display the figure's body and caption.
    it
  }

  let format-header(it, is-emph: false) = {
    let content = {
      it.supplement
      if it.numbering != none {
        [ ] + theorem-counter.display(it.numbering)
      }
      if it.caption != none {
        [ (] + it.caption + [)]
      }
      [.]
    }

    if is-emph { emph(content) } else { strong(content) }
  }

  // Override more general 'show figure' above
  show figure.where(kind: "theorem"): set align(start)
  show figure.where(kind: "theorem"): it => block(spacing: 11.5pt, {
    theorem-counter.step()
    format-header(it, is-emph: false)
    [ ] + emph(it.body)
  })

  show figure.where(kind: "definition"): set align(start)
  show figure.where(kind: "definition"): it => block(spacing: 11.5pt, {
    theorem-counter.step()
    format-header(it, is-emph: false)
    [ ] + it.body
  })

  show figure.where(kind: "remark"): set align(start)
  show figure.where(kind: "remark"): it => block(spacing: 11.5pt, {
    theorem-counter.step()
    format-header(it, is-emph: true)
    [ ] + it.body
  })

  // Display the title and authors.
  v(35pt, weak: true)
  align(center, upper({
    text(size: large-size, weight: 700, title)
    v(25pt, weak: true)
    text(size: footnote-size, author-string)
  }))

  // Configure paragraph properties.
  set par(
    spacing: 0.58em,
    first-line-indent: 1.2em,
    justify: true,
    leading: 0.58em,
  )

  // Display the abstract
  if abstract != none {
    block({
      v(20pt, weak: true)
      set text(script-size)
      show: pad.with(x: 35pt)
      smallcaps[Abstract. ]
      abstract
    })
  }

  // Display the article's contents.
  v(29pt, weak: true)
  body

  // Display the bibliography, if any is given.
  if bibliography != none {
    show std.bibliography: set text(footnote-size)
    show std.bibliography: set block(above: 11pt)
    show std.bibliography: pad.with(x: 0.5pt)
    bibliography
  }

  // Display details about the authors at the end.
  block({
    v(12pt, weak: true)
    show: pad.with(x: 11.5pt)
    set par(first-line-indent: 0pt)
    set text(script-size)

    for author in authors {
      let keys = ("department", "organization", "location")

      let dept-str = keys
        .filter(key => key in author)
        .map(key => author.at(key))
        .join(", ")

      smallcaps(dept-str)
      linebreak()

      if "email" in author [
        _Email address:_ #link("mailto:" + author.email) \
      ]

      if "url" in author [
        _URL:_ #link(author.url)
      ]

      v(12pt, weak: true)
    }
  })
}

#let acknowledgment(body) = {
  block({
    set par(first-line-indent: 0em)
    set align(center)
    set text(size: normal-size)
    smallcaps[
      #v(15pt, weak: true)
      Acknowledgments
      #v(normal-size, weak: true)
    ]
  })

  set par(first-line-indent: 1.2em)
  set align(start)
  body
}


// This is the single numbering format all our environments will use
#let theorem-numbering-format = n => counter(heading).display() + [#n]


#let create-theorem(kind, supplement) = (arg1, arg2: none, ..rest) => {
  let (name, body) = if arg2 == none { (none, arg1) } else { (arg1, arg2) }

  figure(
    // We attach the name to the body using metadata
    if name != none {
      (metadata((name: name)), body).join()
    } else {
      body
    },
    kind: kind,
    supplement: supplement,
    numbering: theorem-numbering-format,
  )
}

// Now generate your environment functions
#let theorem = create-theorem("theorem", [Theorem])
#let lemma = create-theorem("theorem", [Lemma])
#let corollary = create-theorem("theorem", [Corollary])
#let definition = create-theorem("definition", [Definition])
#let example = create-theorem("definition", [Example])
#let remark = create-theorem("remark", [Remark])
#let experiment = create-theorem("definition", [Experiment])
// === NEW DEFINITIONS ADDED HERE ===

#let recursion(base_case, recursive_step) = [
  - *Base case:* #base_case
  - *Recursive step:* #recursive_step
]


#let induction(base_case, inductive_step) = proof[
  - *Base case:* #base_case
  - *Inductive step:* #inductive_step
]

// === END OF NEW DEFINITIONS ===


// This function creates a scoped environment for a list of equations.
#let equation_block(prefix: "E", body) = {
  let counter = counter("block-eq-counter")
  counter.update(0)

  let marker-func = {
    let label = "(" + prefix + context (counter.display()) + ")"
    counter.step()

    box(align(left, strong(label)), width: 3em)
  }

  set list(
    marker: marker-func,
    indent: 0em,
    body-indent: 1.5em,
  )

  block(body)
}

// This function remains backwards-compatible.
// Its local `set math.equation` rule overrides the global "(1.1)" style.
#let labeled_equation(label: "I", content) = {
  set math.equation(numbering: none, supplement: none)

  let final_label = "(" + label + ")"
  let label_box = box(align(left, strong(final_label)), width: 3em)

  block({
    grid(
      columns: (4.5em, auto, 1fr),
      align: (center + horizon),
      label_box, content, [],
    )
  })
}

#let proof(body) = block(spacing: 11.5pt, {
  emph[Proof.]
  [ ]
  body
  h(1fr)

  sym.wj
  sym.space.nobreak

  $square.stroked$
})


#let proof-sketch(body) = block(spacing: 11.5pt, {
  emph[Proof Sketch.]
  [ ]
  body
  h(1fr)

  sym.wj
  sym.space.nobreak

  $square.stroked$
})


#let lang-def-vertical(
  notation,
  symbols-data,
  caption: none,
) = {
  let column-count = 5

  let lang-table = table(
    align: (center, center),
    stroke: none,
    columns: column-count,

    [],
    [],
    [*Symbol*],
    [*Notation*],
    [*Name*],

    ..for (
      i,
      (symbol-str, notation-str, name-str),
    ) in symbols-data.enumerate() {
      if i == 0 {
        (
          [ $#notation$ ],
          [ $:=$],
          [ $#symbol-str$ ],
          [ #notation-str ],
          [ *#name-str* ],
        )
      } else {
        (
          [],
          [$|$],
          [ $#symbol-str$ ],
          [ $#notation-str$],
          [ *#name-str* ],
        )
      }
    },
  )
  figure(
    lang-table,
    caption: caption,
  )
}

#let lang-def-horizontal(
  lang,
  symbols-data,
  anon-symbols: none,
  caption: none,
) = {
  let column-count = 12

  let symbol-keys = symbols-data.keys()
  let symbol-names = symbols-data.values().map(name => strong[#name])

  let symbol-rows = ((lang, $:=$) + symbol-keys).chunks(column-count)
  let name-rows = symbol-names.chunks(column-count).map(arr => ("", "") + arr)

  let symbol-chunks = symbol-rows.zip(name-rows)

  let anon-symbol-row = ("", "") + anon-symbols

  let lang-table = table(
    columns: column-count,
    rows: 2,
    align: (center, center),
    stroke: none,

    ..for chunk in symbol-chunks {
      for item in chunk {
        item
      }
    },

    ..anon-symbol-row
  )

  figure(
    lang-table,
    caption: caption,
  )
}

#let rule-table(prefix: "R", entries) = {
  // 1. Reset the counter
  counter(figure.where(kind: "rule")).update(0)

  // 2. Build the flat array of cells manually
  let cells = ()

  for entry in entries {
    // Define the figure with an empty body [] to satisfy the syntax
    let fig = figure(kind: "rule", supplement: [#prefix], caption: none, [])

    // Push these three cells into the flat list.
    // This creates 3 cells per iteration, keeping the structure strictly flat.
    cells.push([
      #fig #label(entry.lbl)
      *#link(label(entry.lbl))[#prefix#context {
          str(counter(figure.where(kind: "rule")).get().first())
        }]*
    ])
    cells.push([*#entry.name*])
    cells.push(entry.content)
  }

  // 3. Render the table
  table(
    columns: (auto, auto, 1fr),
    align: (left, left, left),
    table.header([*Rule*], [*Name*], [*Content*]),
    ..cells,
    // This spreads the flat array into the table arguments
  )
}
