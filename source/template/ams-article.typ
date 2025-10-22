// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT
//
// Adapted from typst/templates
// under the MIT license:
// https://github.com/typst/templates

// Sizes used across the template.
#let script-size = 7.97224pt
#let footnote-size = 8.50012pt
#let small-size = 9.24994pt
#let normal-size = 10.00002pt
#let large-size = 11.74988pt
#let text_font = "STIX Two Text"



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
  // Author "thanks" (e.g., funding)
  thanks: none,
  // Date of submission
  date: none,
  // 2020 Mathematics Subject Classification
  msc: none,
  // Keywords
  keywords: none,
) = {
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
  set text(size: normal-size, font: text_font)

  // Set equation numbering to (section.equation)
  set math.equation(numbering: "(1.1)")

  // Configure the page.
  set page(
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
        v(1fr) // Push content to bottom of footer area

        // Metadata block
        if (date, msc, keywords, thanks).any(it => it != none) {
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

  show link: set text(font: text_font)

  // Configure equations (now only sets spacing).
  show math.equation: set block(below: 8pt, above: 9pt)

  // Configure citation and bibliography styles.
  set std.bibliography(style: "springer-mathphys", title: [References])

  set figure(gap: 17pt)
  show figure: set block(above: 12.5pt, below: 15pt)
  show figure: it => {
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
    show selector.or(table, image): pad.with(x: 23pt)

    // Display the figure's body and caption.
    it
  }

  // Rule for Theorems, Lemmas, Corollaries (italic body, bold supplement)
  show figure.where(kind: "theorem"): set align(start)
  show figure.where(kind: "theorem"): it => block(spacing: 11.5pt, {
    theorem-counter.step()
    strong({
      // Bold supplement
      it.supplement
      if it.numbering != none {
        [ ]
        theorem-counter.display(it.numbering)
      }
      [.]
    })
    [ ]
    {
      show strong: s => text(weight: 700, style: "normal", s.body)
      emph(it.body)
    }
  })

  // Rule for Definitions (normal body, bold supplement)
  show figure.where(kind: "definition"): set align(start)
  show figure.where(kind: "definition"): it => block(spacing: 11.5pt, {
    theorem-counter.step()
    strong({
      // Bold supplement
      it.supplement
      if it.numbering != none {
        [ ]
        theorem-counter.display(it.numbering)
      }
      [.]
    })
    [ ]
    it.body
  })

  // === FIX IS HERE ===
  // Rule for Remarks (normal body, italic supplement name, upright number)
  show figure.where(kind: "remark"): set align(start)
  show figure.where(kind: "remark"): it => block(spacing: 11.5pt, {
    theorem-counter.step()
    // Italicize ONLY the supplement word, not the number.
    emph(it.supplement)
    if it.numbering != none {
      [ ] // Add a space
      // Number is upright (not bold)
      theorem-counter.display(it.numbering)
    }
    [.] // Add the period
    [ ] // Add a space after the supplement
    it.body
  })
  // === END OF FIX ===


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

// This is the single numbering format all our environments will use
#let thm-numbering-format = n => counter(heading).display() + [#n]

#let theorem(body, numbered: true) = figure(
  body,
  kind: "theorem",
  supplement: [Theorem],
  numbering: if numbered { thm-numbering-format },
)
#let lemma(body, numbered: true) = figure(
  body,
  kind: "theorem",
  supplement: [Lemma],
  numbering: if numbered { thm-numbering-format },
)
#let corollary(body, numbered: true) = figure(
  body,
  kind: "theorem",
  supplement: [Corollary],
  numbering: if numbered { thm-numbering-format },
)
#let definition(body, numbered: true) = figure(
  body,
  kind: "definition",
  supplement: [Definition],
  numbering: if numbered { thm-numbering-format },
)

#let remark(body, numbered: true) = figure(
  body,
  kind: "remark",
  supplement: [Remark],
  numbering: if numbered { thm-numbering-format },
)

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
