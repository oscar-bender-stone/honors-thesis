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

    // Explicitly fetch the active level 2 heading (e.g. `== Background`)
    // to guarantee it renders reliably below the banner every time.
    let display-title = if title != auto { title } else {
      utils.display-current-heading(level: 2)
    }

    if display-title != none and display-title != [] {
      // Fixed: `block` does not take `margin`. Use `pad` to create spacing.
      pad(bottom: 1em)[
        #block(
          width: 100%,
          text(
            fill: self.colors.primary,
            weight: "bold",
            size: 1.4em,
            display-title,
          ),
        )
      ]
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
    // Strips the banner/footer and equalizes margins so content is perfectly centered
    self = utils.merge-dicts(
      self,
      config-page(header: none, footer: none, margin: 2em),
      config,
    )
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

// 3. Define custom Outline Slide (Shows ALL sections, no dimming)
#let outline-slide(
  config: (:),
  title: "Agenda",
  level: 1,
  numbered: false,
  ..args,
) = touying-slide-wrapper(self => {
  let content = {
    std.align(center + horizon)[
      #block(
        std.align(left)[
          #text(
            fill: self.colors.text-main,
            weight: "bold",
            size: 1.6em,
          )[#title]
          #v(1em)

          // Removed adaptive-columns to force a strict, clear vertical list
          #text(fill: self.colors.text-main, weight: "bold", size: 1.3em)[
            #components.custom-progressive-outline(
              level: level,
              alpha: 100%,
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

// 4. Define custom Transition Slide (Highlights current section)
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
        std.align(left)[
          #text(
            fill: self.colors.text-main,
            weight: "bold",
            size: 1.6em,
          )[Agenda]
          #v(1em)

          // Removed adaptive-columns to force a strict, clear vertical list
          #text(fill: self.colors.text-main, weight: "bold", size: 1.3em)[
            #components.custom-progressive-outline(
              level: level,
              alpha: 30%,
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

// 5. Define custom Focus Slide
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
  let palette = (
    primary: rgb("#4da6ff"),
    secondary: rgb("#80ccff"),
    text-main: rgb("#165a9e"),
  )

  let sky-gradient = gradient.linear(
    palette.primary,
    palette.secondary,
    dir: rtl,
  )

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
      fill: sky-gradient,
      outset: (x: 2em),
      block(
        width: 100%,
        fill: dot-pattern,
        // Fixed: Explicitly bypass the local `align` parameter by calling `std.align`
        // to prevent "expected function, found alignment" compiler errors.
        pad(y: 0.8em, std.align(center + horizon)[
          #components.mini-slides(
            self: self,
            fill: white,
            alpha: 50%,
            display-section: true,
          )
        ]),
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

        box(inset: (left: 1em, right: 1.5em))[
          #text(fill: white, weight: "bold", size: 0.9em, self.info.author)
        ],

        block(width: 100%, height: 100%, fill: dot-pattern),

        box(inset: (x: 1.5em))[
          #text(fill: white, size: 0.9em, utils.display-info-date(self))
        ],

        block(width: 100%, height: 100%, fill: dot-pattern),

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
      margin: (top: 4.5em, bottom: 2.7em, left: 2em, right: 2em),
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
      new-section-slide-fn: new-section-slide,
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

        // Suppress native printing of level 1/2 headings so Touying handles them
        show heading.where(level: 1): none
        show heading.where(level: 2): none
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
