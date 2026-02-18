// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-FileContributor: Gemini (Google)
// SPDX-License-Identifier: MIT

#let ascii-table() = {
  // --- Helpers ---
  let to-hex(n) = {
    let h = str(n, base: 16)
    if h.len() == 1 { "0" + h } else { h }
  }

  let control-names = (
    "NUL",
    "SOH",
    "STX",
    "ETX",
    "EOT",
    "ENQ",
    "ACK",
    "BEL",
    "BS",
    "HT",
    "LF",
    "VT",
    "FF",
    "CR",
    "SO",
    "SI",
    "DLE",
    "DC1",
    "DC2",
    "DC3",
    "DC4",
    "NAK",
    "SYN",
    "ETB",
    "CAN",
    "EM",
    "SUB",
    "ESC",
    "FS",
    "GS",
    "RS",
    "US",
  )

  let get-glyph(n) = {
    if n < 32 { control-names.at(n) } else if n == 127 { "DEL" } else if (
      n == 32
    ) { "Space" } else { raw(str.from-unicode(n)) }
  }

  // --- Main Table Block ---
  // Using a Serif font (like New Computer Modern) enhances the LaTeX look
  // TODO: move back to default font. Probably will use 8pt font though.
  // TODO: add some of table formatting into template!
  set text(font: "New Computer Modern", size: 8pt)

  table(
    // 12 Columns: 4 groups of (Dec, Hex, Glyph)
    // auto: fits the number exactly
    // 1fr: gives the Glyph column a bit more breathing room
    columns: (
      auto,
      auto,
      1fr,
      auto,
      auto,
      1fr,
      auto,
      auto,
      1fr,
      auto,
      auto,
      1fr,
    ),

    inset: (x: 3pt, y: 3pt),
    align: (col, row) => (right, center, center).at(calc.rem(col, 3)),

    // Disable the default grid strokes (classic LaTeX tables are cleaner)
    stroke: none,

    // --- LaTeX-Style Horizontal Rules ---
    // Top Rule (Bold)
    table.hline(y: 0, stroke: 1.5pt + black),
    // Mid Rule (Under Header)
    table.hline(y: 1, stroke: 0.75pt + black),
    // Bottom Rule (Bold) - Index 33 is after the last row (32 data + 1 header)
    table.hline(y: 33, stroke: 1.5pt + black),

    // --- Vertical Separators ---
    // Placed strictly AFTER columns 2, 5, and 8.
    // They naturally span the exact height of the table.
    table.vline(x: 3, stroke: 0.5pt + black),
    table.vline(x: 6, stroke: 0.5pt + black),
    table.vline(x: 9, stroke: 0.5pt + black),

    // --- Header ---
    table.header(
      ..range(4)
        .map(_ => (
          [*Dec.*],
          [*Hex.*],
          [*Glyph*],
        ))
        .flatten(),
    ),

    // --- Data Rows ---
    // We loop 0 to 31. For each row `r`, we generate the columns for
    // r, r+32, r+64, and r+96 simultaneously.
    ..range(32)
      .map(r => {
        (
          // Group 1 (0-31)
          str(r),
          upper(to-hex(r)),
          get-glyph(r),
          // Group 2 (32-63)
          str(r + 32),
          upper(to-hex(r + 32)),
          get-glyph(r + 32),
          // Group 3 (64-95)
          str(r + 64),
          upper(to-hex(r + 64)),
          get-glyph(r + 64),
          // Group 4 (96-127)
          str(r + 96),
          upper(to-hex(r + 96)),
          get-glyph(r + 96),
        )
      })
      .flatten(),
  )
}
