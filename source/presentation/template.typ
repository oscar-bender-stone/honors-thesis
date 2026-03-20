// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "@preview/touying:0.6.3"

// --- RE-EXPORTS ---
// Pointing specifically to where title-slide actually lives!
#let pause = touying.pause
#let title-slide = touying.themes.stargazer.title-slide

// --- THEME DEFINITION ---
#let elegant-blue-theme(
  title: none,
  subtitle: none,
  author: none,
  date: datetime.today(),
  draft: false,
  body,
) = {
  // Tiling pattern for the dots
  let dot-tiling = tiling(size: (12pt, 12pt))[
    #place(dx: 6pt, dy: 6pt)[
      #circle(radius: 1.2pt, fill: rgb("#ffffff50"))
    ]
  ]

  // Pure, true blues (No green/cyan/teal)
  let pure-blue-gradient = gradient.linear(
    rgb("#0033aa"), // Deep true blue
    rgb("#3388ff"), // Bright true blue
    dir: rtl,
  )

  // Draft Watermark Logic
  let draft-watermark = if draft {
    align(center + horizon)[
      #rotate(-35deg)[
        #text(
          size: 140pt,
          fill: rgb("#1a1a2410"),
          weight: "bold",
          font: "STIX Two Text",
        )[DRAFT]
      ]
    ]
  } else {
    none
  }

  show: touying.themes.stargazer.stargazer-theme.with(
    touying.config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
    ),
    touying.config-colors(
      primary: rgb("#0033aa"), // Matched to the dark end of the true blue gradient
      secondary: rgb("#3388ff"), // Matched to the bright end
      tertiary: rgb("#0033aa"), // Footer matches the banner (no green)
    ),
    touying.config-page(
      background: draft-watermark,
    ),
    touying.config-store(
      header: self => {
        // Dotted Progress Bar
        let dotted-progress = touying.utils.touying-progress(ratio => {
          block(
            width: ratio * 100%,
            height: 6pt,
            fill: rgb("#001a66"), // Very dark true blue for contrast
            clip: true,
          )[
            #rect(width: 100%, height: 100%, fill: dot-tiling)
          ]
        })

        block(
          width: 100%,
          height: 100%,
          fill: pure-blue-gradient,
          outset: (x: 2em, top: 4em),
        )[
          // Banner Dots
          #place(
            dx: -2em,
            dy: -4em,
            block(width: 100% + 4em, height: 100% + 4em, fill: dot-tiling),
          )
          // Progress bar at the top
          #place(top + left, dx: -2em, dy: -4em, dotted-progress)

          // Slide Title
          #align(bottom + left)[
            #pad(bottom: 0.6em)[
              #text(
                fill: white,
                weight: "bold",
                size: 1.3em,
                touying.utils.display-current-heading(level: 1),
              )
            ]
          ]
        ]
      },
    ),
  )

  // STIX Two Typography
  set text(font: "STIX Two Text", size: 22pt, fill: rgb("#1a1a24"))
  show math.equation: set text(font: "STIX Two Math")

  body
}
