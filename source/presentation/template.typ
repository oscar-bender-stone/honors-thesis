// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "@preview/touying:0.6.3": *
#import themes.stargazer: *

// Define our reusable theme function
#let elegant-blue-theme(
  title: none,
  subtitle: none,
  author: none,
  date: datetime.today(),
  body,
) = {
  // 1. Pure Blue Gradient (Deep Navy to Royal Blue - No green/cyan)
  let pure-blue-gradient = gradient.linear(
    rgb("#06142e"), // Very deep navy
    rgb("#1b4282"), // Solid royal blue
    dir: rtl,
  )

  // 2. Dots tinted to a semi-transparent light blue to match
  let dot-pattern = tiling(size: (12pt, 12pt))[
    #place(dx: 6pt, dy: 6pt)[
      #circle(radius: 1.2pt, fill: rgb("#8ab4f840")) // Light blue with 25% opacity
    ]
  ]

  // 3. Initialize Stargazer with our overrides
  show: stargazer-theme.with(
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
    ),
    config-colors(
      primary: rgb("#1b4282"), // Matches the lighter end of the gradient
      secondary: rgb("#4a7bd1"), // Lighter accent blue for structural elements
      tertiary: rgb("#06142e"), // Matches the darkest end of the gradient
    ),
    config-store(
      header: self => {
        block(
          width: 100%,
          height: 100%,
          fill: pure-blue-gradient,
          outset: (x: 2em, top: 4em),
        )[
          #place(
            dx: -2em,
            dy: -4em,
            block(width: 100% + 4em, height: 100% + 4em, fill: dot-pattern),
          )
          #align(bottom + left)[
            #pad(bottom: 0.6em)[
              #text(
                fill: white,
                weight: "bold",
                size: 1.3em,
                utils.display-current-heading(level: 1),
              )
            ]
          ]
        ]
      },
    ),
  )

  // 4. STIX Two Typography
  // Text color is set to the deep navy (#06142e) for high contrast and color cohesion
  set text(font: "STIX Two Text", size: 22pt, fill: rgb("#06142e"))
  show math.equation: set text(font: "STIX Two Math")

  body
}
