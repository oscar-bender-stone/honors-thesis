// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let info(body) = (type: "info", body: body)
#let pro(body) = (type: "pro", body: body)
#let con(body) = (type: "con", body: body)

#let compare-list(title, items) = {
  // We use a fixed width for markers to ensure vertical alignment
  let mk(content, color: black) = box(
    width: 0.8em,
    align(center + horizon, text(fill: color, weight: "bold", content)),
  )

  let markers = (
    info: mk([‣]), // Standard Level-2 Triangle
    pro: mk([+], color: green.darken(15%)),
    con: mk([#sym.minus], color: red.darken(15%)),
  )

  list.item[
    #title
    // Adjust this value to change the gap between title and first child
    #v(0.4em, weak: true)

    // Adjust 'left' to match your document's standard nesting indentation
    #pad(left: 1.5em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.7em, // Space between marker and text
        row-gutter: 0.6em, // Space between items
        ..items
          .map(it => {
            let item = if type(it) == str { info(it) } else { it }
            (markers.at(item.type), item.body)
          })
          .flatten()
      )
    ]
    // Adds a tiny bit of breathing room after the grid
    #v(0.2em, weak: true)
  ]
}
