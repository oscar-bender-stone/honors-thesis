// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "@preview/touying:0.6.3": *

// --- RE-EXPORTS & CUSTOM COMPONENTS ---
#let pause = pause

// 1. Define custom standard slide wrapper
#let slide(
  title: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto { self.store.align = align }
  if title != auto { self.store.title = title }

  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting

    // Automatically render the slide title (from `== Subheader`)
    // at the top of the slide body, completely below the banner.
    if (
      "title" in self.store
        and self.store.title != none
        and self.store.title != auto
    ) {
      block(
        width: 100%,
        margin: (bottom: 1em),
        text(
          fill: self.colors.primary,
          weight: "bold",
          size: 1.4em,
          self.store.title,
        ),
      )
    }

    body
  }

  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

// 2. Define custom Title Slide
#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(self, config)
    let info = self.info + args.named()

    let body = {
      show: std.align.with(center + horizon)
      block(
        fill: gradient.linear(
          self.colors.primary,
          self.colors.secondary,
          dir: rtl,
        ),
        inset: 2.5em,
        radius: 0.5em,
        breakable: false,
        {
          text(
            size: 1.5em,
            fill: self.colors.neutral-lightest,
            weight: "bold",
            info.title,
          )
          if info.subtitle != none {
            parbreak()
            text(
              size: 1.1em,
              fill: self.colors.neutral-lightest,
              weight: "bold",
              info.subtitle,
            )
          }
        },
      )
      v(1em)
      text(
        size: 1.2em,
        fill: self.colors.text-main,
        weight: "bold",
        info.author,
      )
      if info.date != none {
        parbreak()
        text(
          size: 1.0em,
          fill: self.colors.text-main,
          utils.display-info-date(self),
        )
      }
    }
    touying-slide(self: self, body)
  },
)

// 3. Define custom Transition Slide (Highlights current section)
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: false,
  ..args,
  body,
) = touying-slide-wrapper(self => {
  let content = {
    std.align(center + horizon)[
      #block(
        align(left)[
          // The title of the transition slide
          #text(
            fill: self.colors.text-main,
            weight: "bold",
            size: 1.6em,
          )[Agenda]
          #v(1em)

          // Lists all sections, highlights current, dims the rest
          #text(fill: self.colors.text-main, weight: "bold", size: 1.3em)[
            #components.custom-progressive-outline(
              level: level,
              alpha: 30%, // Opacity of non-active sections
              depth: 1,
              numbered: (numbered,),
              vspace: (0.8em,),
            )
          ]
        ],
      )
    ]
  }
  touying-slide(self: self, config: config, content)
})

// 4. Define custom Focus Slide
#let focus-slide(
  config: (:),
  align: horizon + center,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: gradient.linear(
        self.colors.primary,
        self.colors.secondary,
        dir: rtl,
      ),
      margin: 2em,
      header: none,
      footer: none,
    ),
  )
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 1.5em)
  touying-slide(self: self, config: config, std.align(align, body))
})


// --- THEME DEFINITION ---
#let elegant-blue-theme(
  aspect-ratio: "16-9",
  align: horizon,
  title: none,
  subtitle: none,
  author: none,
  date: datetime.today(),
  draft: false,
  ..args,
  body,
) = {
  // 1. The Natural Sky Palette
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

  // Use Typst's modern `tiling` function for the dots
  let dot-pattern = tiling(size: (12pt, 12pt))[
    #circle(radius: 1.5pt, fill: rgb("#ffffff60"))
  ]

  let draft-watermark = if draft {
    std.align(center + horizon)[
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

  let header(self) = {
    block(
      width: 100%,
      height: 2.5em,
      fill: sky-gradient,
      outset: (x: 2em),
      grid(
        columns: (auto, 1fr, auto),
        rows: 100%,
        align: (left + horizon, center + horizon, right + horizon),

        // Displays current `= Section` heading
        box(inset: (right: 1.5em))[
          #text(fill: white, weight: "bold", size: 1.1em)[
            #utils.display-current-heading(level: 1)
          ]
        ],

        block(width: 100%, height: 100%, fill: dot-pattern),

        // Dot Progress Bar mapping the current section's slides
        box(inset: (left: 1.5em))[
          #components.mini-slides(
            self: self,
            fill: white,
            alpha: 80%,
            display-section: false,
          )
        ],
      ),
    )
  }

  let footer(self) = {
    block(
      width: 100%,
      height: 2.2em,
      fill: sky-gradient,
      outset: (x: 2em),
      grid(
        columns: (auto, 1fr, auto, 1fr, auto),
        rows: 100%,
        align: (
          left + horizon,
          center + horizon,
          center + horizon,
          center + horizon,
          right + horizon,
        ),

        // Generous padding applied to prevent edge cutoffs
        box(inset: (left: 1em, right: 1.5em))[
          #text(fill: white, weight: "bold", size: 0.9em, self.info.author)
        ],

        block(width: 100%, height: 100%, fill: dot-pattern),

        box(inset: (x: 1.5em))[
          #text(fill: white, size: 0.9em, utils.display-info-date(self))
        ],

        block(width: 100%, height: 100%, fill: dot-pattern),

        // Generous padding applied to prevent edge cutoffs
        box(inset: (left: 1.5em, right: 1em))[
          #text(fill: white, weight: "bold", size: 0.9em)[
            #context [
              #utils.slide-counter.display() / #utils.last-slide-number
            ]
          ]
        ],
      ),
    )
  }

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      // Mathematically calculated margins to make panels perfectly flush with the screen edges:
      // Margin Top (3.0em) = Header Height (2.5em) + Header Ascent (0.5em)
      // Margin Bottom (2.7em) = Footer Height (2.2em) + Footer Descent (0.5em)
      margin: (top: 3.0em, bottom: 2.7em, left: 2em, right: 2em),
      header: header,
      footer: footer,
      background: draft-watermark,
      header-ascent: 0.5em,
      footer-descent: 0.5em,
    ),
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide, // Registers the auto-outline transition slides
      slide-level: 2,
    ),
    config-colors(
      primary: palette.primary,
      primary-dark: palette.primary,
      secondary: palette.secondary,
      text-main: palette.text-main,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "STIX Two Text", size: 22pt, fill: self.colors.text-main)
        show math.equation: set text(font: "STIX Two Math")

        show heading.where(level: 1): it => {
          set text(fill: self.colors.text-main, weight: "bold", size: 1.6em)
          pad(top: 0.5em, bottom: 0.8em, it.body)
        }
        body
      },
    ),
    config-store(
      align: align,
      title: none,
    ),
    ..args,
  )

  body
}
