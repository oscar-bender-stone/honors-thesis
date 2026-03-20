// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "@preview/touying:0.6.3"

// --- RE-EXPORTS ---
#let pause = touying.pause
#let title-slide = touying.themes.stargazer.title-slide
#let focus-slide = touying.themes.stargazer.focus-slide

// --- THEME DEFINITION ---
#let elegant-blue-theme(
  title: none,
  subtitle: none,
  author: none,
  date: datetime.today(),
  draft: false,
  body,
) = {
  // 1. The Natural Sky Palette (Simplified to 2 panel colors, dark saturated blue text)
  let palette = (
    primary: rgb("#4da6ff"), // Natural Sky Blue
    secondary: rgb("#80ccff"), // Soft Light Sky
    text-main: rgb("#0044cc"), // Dark, saturated blue for text
  )

  let sky-gradient = gradient.linear(
    palette.primary,
    palette.secondary,
    dir: rtl,
  )

  // 2. Define the dot pattern for the top and bottom panels
  let dot-pattern = pattern(size: (12pt, 12pt))[
    #circle(radius: 1.5pt, fill: rgb("#ffffff40"))
  ]

  let draft-watermark = if draft {
    align(center + horizon)[
      #rotate(-35deg)[
        #text(
          size: 140pt,
          fill: rgb("#4da6ff25"),
          weight: "bold",
          font: "STIX Two Text",
        )[DRAFT]
      ]
    ]
  } else { none }

  show: touying.themes.stargazer.stargazer-theme.with(
    touying.config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
    ),
    touying.config-colors(
      primary: palette.primary,
      primary-dark: palette.primary,
      secondary: palette.secondary,
      tertiary: palette.primary,
      neutral-darkest: palette.primary, // Removed the darker navy panel color
      neutral-lightest: rgb("#ffffff"),
    ),
    touying.config-page(
      background: draft-watermark,
      // Increased margins to completely clear both the banner and the new footer
      margin: (top: 5.5em, bottom: 4em, left: 2em, right: 2em),
    ),
    touying.config-store(
      navigation: none,
      progress-bar: false,
      header: self => {
        // Outer block for gradient
        block(
          width: 100%,
          height: 2.5em,
          fill: sky-gradient,
          outset: (x: 2em),
        )[
          // Inner block for the tiling pattern overlay
          #block(
            width: 100%,
            height: 100%,
            fill: dot-pattern,
            outset: (x: 2em),
          )[
            #box(width: 100%, height: 100%)[
              // Section name (level 1) on the left
              #align(left + horizon)[
                #text(
                  fill: white,
                  weight: "bold",
                  size: 1.1em,
                  touying.utils.display-current-heading(level: 1),
                )
              ]

              // Navigation dots on the right
              #place(right + horizon)[
                #touying.components.mini-slides(
                  self: self,
                  fill: white,
                  alpha: 80%,
                  display-section: false,
                  display-subsection: true,
                  linebreaks: false,
                  short-heading: true,
                )
              ]
            ]
          ]
        ]
      },
      // ADDED: Custom Footer to match the top panel styling
      footer: self => {
        block(
          width: 100%,
          height: 2.2em,
          fill: sky-gradient,
          outset: (x: 2em, bottom: 2em),
        )[
          #block(
            width: 100%,
            height: 100%,
            fill: dot-pattern,
            outset: (x: 2em, bottom: 2em),
          )[
            #box(width: 100%, height: 100%)[
              #align(horizon)[
                #grid(
                  columns: (1fr, auto, 1fr),
                  align(left)[
                    #text(
                      fill: white,
                      weight: "bold",
                      size: 0.9em,
                      self.info.author,
                    )
                  ],
                  align(center)[
                    #text(fill: white, size: 0.9em)[
                      #if self.info.date != none {
                        if type(self.info.date) == datetime {
                          self.info.date.display()
                        } else {
                          self.info.date
                        }
                      }
                    ]
                  ],
                  align(right)[
                    #text(fill: white, weight: "bold", size: 0.9em)[
                      #context counter(page).display()
                    ]
                  ],
                )
              ]
            ]
          ]
        ]
      },
    ),
  )

  // Move Subsections (level 2) out of the banner and into the body
  // Added top padding to prevent ANY interference with the top panel
  show heading.where(level: 2): it => {
    set text(fill: palette.primary, weight: "bold", size: 1.4em)
    pad(top: 0.5em, bottom: 0.5em, it.body)
  }

  set text(font: "STIX Two Text", size: 22pt, fill: palette.text-main)
  show math.equation: set text(font: "STIX Two Math")

  body
}
