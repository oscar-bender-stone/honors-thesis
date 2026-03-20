// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// 1. Import the module for internal use
#import "@preview/touying:0.6.3"
// 2. Explicitly import these so they automatically re-export to the main file!
#import "@preview/touying:0.6.3": pause

#let elegant-blue-theme(
  title: none,
  subtitle: none,
  author: none,
  date: datetime.today(),
  draft: false, // NEW: The draft toggle
  body,
) = {
  // Tiling pattern
  let dot-tiling = tiling(size: (12pt, 12pt))[
    #place(dx: 6pt, dy: 6pt)[
      #circle(radius: 1.2pt, fill: rgb("#ffffff50"))
    ]
  ]

  // Light, vibrant blue gradient
  let light-blue-gradient = gradient.linear(
    rgb("#0077b6"),
    rgb("#00b4d8"),
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
      primary: rgb("#0077b6"),
      secondary: rgb("#00b4d8"),
      tertiary: rgb("#0077b6"),
    ),
    // NEW: Inject the watermark into the background of every page
    touying.config-page(
      background: draft-watermark,
    ),
    touying.config-store(
      header: self => {
        // The Dotted Progress Bar
        let dotted-progress = touying.utils.touying-progress(ratio => {
          block(
            width: ratio * 100%,
            height: 6pt,
            fill: rgb("#023e8a"),
            clip: true,
          )[
            #rect(width: 100%, height: 100%, fill: dot-tiling)
          ]
        })

        block(
          width: 100%,
          height: 100%,
          fill: light-blue-gradient,
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
