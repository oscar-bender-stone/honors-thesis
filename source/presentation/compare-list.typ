// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#let info(body) = (type: "info", body: body)
#let pro(body) = (type: "pro", body: body)
#let con(body) = (type: "con", body: body)

#let compare-list(title, items, citation: none) = {
  let mk(content, color: black) = box(
    width: 0.8em,
    align(center + horizon, text(fill: color, weight: "bold", content)),
  )

  let markers = (
    info: mk([‣]),
    pro: mk([+], color: green.darken(15%)),
    con: mk([#sym.minus], color: red.darken(15%)),
  )

  [
    #title #if citation != none { footnote(citation) }
    #v(0.4em, weak: true)

    #pad(left: 1.5em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.7em,
        row-gutter: 0.6em,
        ..items
          .map(it => {
            let item = if type(it) == str { info(it) } else { it }
            (markers.at(item.type), item.body)
          })
          .flatten()
      )
    ]
    #v(0.2em, weak: true)
  ]
}
