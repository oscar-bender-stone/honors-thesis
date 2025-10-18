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
) = {
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

    // On the first page, the footer should contain the page number.
    footer-descent: 12pt,
    footer: context {
      let i = counter(page).get().first()
      if i == 1 {
        align(center, text(size: script-size, [#i]))
      }
    },
  )

  // Configure headings.
  set heading(numbering: "1.")
  show heading: it => {
    // Create the heading numbering.
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    // Level 1 headings are centered and smallcaps.
    // The other ones are run-in.
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
      counter(figure.where(kind: "theorem")).update(0)
    } else {
      v(11pt, weak: true)
      number
      let styled = if it.level == 2 { strong } else { emph }
      styled(it.body + [. ])
      h(7pt, weak: true)
    }
  }

  // Configure lists and links.
  set list(indent: 24pt, body-indent: 5pt)
  set enum(indent: 24pt, body-indent: 5pt)
  show link: set text(font: text_font)

  // Configure equations.
  show math.equation: set block(below: 8pt, above: 9pt)
  show math.equation: set text(weight: 400)

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

  show figure.where(kind: "theorem"): set align(start)
  show figure.where(kind: "theorem"): it => block(spacing: 11.5pt, {
    strong({
      it.supplement
      if it.numbering != none {
        [ ]
        it.counter.display(it.numbering)
      }
      [.]
    })
    [ ]
    it.body
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
    v(20pt, weak: true)
    set text(script-size)
    show: pad.with(x: 35pt)
    smallcaps[Abstract. ]
    abstract
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
}
#let figure_block(style, supplement, body, numbered: true) = {
  let styled_body = {
    set text(style: style)
    body
  }

  figure(
    styled_body,
    kind: "theorem",
    supplement: supplement,
    numbering: if numbered { n => counter(heading).display() + [#n] },
  )
}


#let theorem(body, numbered: true) = figure_block(
  "italic",
  [Theorem],
  body,
  numbered: numbered,
)
#let lemma(body, numbered: true) = figure_block(
  "italic",
  [Lemma],
  body,
  numbered: numbered,
)
#let corollary(body, numbered: true) = figure_block(
  "italic",
  [Corollary],
  body,
  numbered: numbered,
)
#let definition(body, numbered: true) = figure_block(
  "normal",
  [Definition],
  body,
  numbered: numbered,
)
#let remark(body, numbered: true) = figure_block(
  "normal",
  [Remark],
  body,
  numbered: numbered,
)


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
    indent: 0em, // No overall block indent
    body-indent: 1.5em, // Space between the label and the equation
  )

  block(body)
}

#let labeled_equation(label: "I", content) = {
  set math.equation(numbering: none, supplement: none)

  let final_label = "(" + label + ")"
  let label_box = box(align(left, strong(final_label)), width: 3em)

  block({
    grid(
      columns: (4.5em, auto, 1fr),
      // Left buffer, equation content, label width
      align: (center + horizon),
      label_box, content, [],
    )
  })
}


// And a function for a proof.
#let proof(body) = block(spacing: 11.5pt, {
  emph[Proof.]
  [ ]
  body
  h(1fr)

  // Add a word-joiner so that the proof square and the last word before the
  // 1fr spacing are kept together.
  sym.wj

  // Add a non-breaking space to ensure a minimum amount of space between the
  // text and the proof square.
  sym.space.nobreak

  $square.stroked$
})
