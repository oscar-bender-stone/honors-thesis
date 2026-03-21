// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-FileContributor: Gemini (Google)
// SPDX-License-Identifier: MIT

#let printable-ascii-table() = {
  let to-hex(n) = {
    let h = str(n, base: 16)
    if h.len() == 1 { "0" + h } else { h }
  }

  let get-glyph(n) = {
    if n == 32 { [Space] } else if n <= 126 { raw(str.from-unicode(n)) } else {
      ""
    }
  }

  set text(font: "STIX Two Text", size: 8pt)

  // 95 printable characters (32 to 126).
  // 95 / 4 = 23.75 -> We'll use 24 rows.
  let rows = 24

  table(
    columns: (auto, auto, 1fr) * 4,
    inset: (x: 3pt, y: 3pt),
    align: (col, row) => (right, center, center).at(calc.rem(col, 3)),
    stroke: none,

    // LaTeX style rules
    table.hline(y: 0, stroke: 1.5pt + black),
    table.hline(y: 1, stroke: 0.75pt + black),
    table.hline(y: rows + 1, stroke: 1.5pt + black),

    // Vertical separators
    table.vline(x: 3, stroke: 0.5pt + black),
    table.vline(x: 6, stroke: 0.5pt + black),
    table.vline(x: 9, stroke: 0.5pt + black),

    table.header(
      ..range(4).map(_ => ([*Dec.*], [*Hex.*], [*Glyph*])).flatten()
    ),

    ..range(rows)
      .map(r => {
        let result = ()
        for i in range(4) {
          let n = 32 + r + (i * rows)
          if n <= 126 {
            result += (str(n), upper(to-hex(n)), get-glyph(n))
          } else {
            result += ("", "", "")
          }
        }
        result
      })
      .flatten(),
  )
}
