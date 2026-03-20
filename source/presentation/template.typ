// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "@preview/touying:0.6.3"

// --- RE-EXPORTS ---
// This ensures your main file stays perfectly clean.
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
  // 1. The Pure Blue Palette (Zero Black, Zero Green)
  let palette = (
    primary: rgb("#005bac"), // Main true-blue (Title box, right footer)
    secondary: rgb("#3388ff"), // Brighter true-blue (Gradient fade)
    footer-left: rgb("#002855"), // Very dark navy (Replaces black in the footer & author text!)
    text-main: rgb("#001a33"), // Deepest navy for highly readable prose
  )

  let pure-blue-gradient = gradient.linear(
    palette.primary,
    palette.secondary,
    dir: rtl,
  )

  let draft-watermark = if draft {
    align(center + horizon)[
      #rotate(-35deg)[
        #text(
          size: 140pt,
          fill: rgb("#001a3315"),
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
      primary-dark: palette.primary, // Ensures tblocks don't use Stargazer's default dark
      secondary: palette.secondary,
      tertiary: palette.primary,
      neutral-darkest: palette.footer-left, // ABSOLUTELY NO BLACK: Overrides footer/title-slide text
      neutral-lightest: rgb("#ffffff"),
    ),
    touying.config-page(
      background: draft-watermark,
      margin: (top: 3.5em, bottom: 2em, left: 2em, right: 2em),
    ),
    touying.config-store(
      // Disable Stargazer's default continuous bar since we are using dots
      progress-bar: false,
      header: self => {
        block(
          width: 100%,
          height: 100%,
          fill: pure-blue-gradient,
          outset: (x: 2em, top: 3.5em),
          inset: (x: 0em, bottom: 0.5em),
        )[
          // 2. The Dewdrop-style Navigation Dots
          // Placed elegantly at the top right of the banner
          #place(top + right)[
            #pad(top: -2.8em)[
              #touying.components.mini-slides(
                self: self,
                fill: white, // White dots against the blue banner
                alpha: 35%, // Faded dots for upcoming slides
                display-section: false,
                display-subsection: true,
                linebreaks: true,
                short-heading: true,
              )
            ]
          ]

          // Slide Title using == (level: 2)
          #align(bottom + left)[
            #text(
              fill: white,
              weight: "bold",
              size: 1.2em,
              touying.utils.display-current-heading(level: 2),
            )
          ]
        ]
      },
    ),
  )

  // STIX Two Typography matched to the deep navy
  set text(font: "STIX Two Text", size: 22pt, fill: palette.text-main)
  show math.equation: set text(font: "STIX Two Math")

  body
}
