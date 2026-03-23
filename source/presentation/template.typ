// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "@preview/touying:0.6.3": *
// 1. Alias the original pause and meanwhile to avoid recursion
#import "@preview/touying:0.6.3": meanwhile as ty-meanwhile, pause as ty-pause

// --- FOOTNOTE & PAUSE FIX ---
// We track which 'pause chunk' we are currently in
#let pause-tracker = counter("touying-pause-tracker")

// Export the overridden pause and meanwhile globally
#let pause = pause-tracker.step() + ty-pause
#let meanwhile = pause-tracker.update(0) + ty-meanwhile

// Intercept footnote so it only renders when the subslide has reached its chunk
#let old-footnote = footnote
#let footnote(..args) = context {
  let current-pause = pause-tracker.get().first() + 1
  touying-fn-wrapper(self => {
    if self.subslide >= current-pause {
      old-footnote(..args)
    }
  })
}
// ----------------------------

// 2. Fixed title block slide wrapper
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
    let display-title = if title != auto { title } else {
      utils.display-current-heading(level: 2)
    }

    block(
      width: 100%,
      height: 4.5em,
      inset: (top: 2.2em, bottom: 0.1em),
      if display-title != none and display-title != [] {
        text(
          fill: black, // Changed from primary blue to black
          weight: "bold",
          size: 1.4em,
          display-title,
        )
      },
    )

    show: setting

    // Reset the pause tracker at the beginning of every new slide body
    pause-tracker.update(0)

    std.align(self.store.align, body)
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

// 3. Title Slide
#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(
      self,
      config-page(header: none, footer: none, margin: 2em, fill: white),
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
        inset: 1.2em,
        radius: 0.5em,
        breakable: false,
        {
          text(
            size: 1.3em,
            fill: black, // Changed to black
            weight: "bold",
            info.title,
          )
          if info.subtitle != none {
            parbreak()
            text(
              size: 1.1em,
              fill: black, // Changed to black
              weight: "bold",
              info.subtitle,
            )
          }
        },
      )
      v(1em)
      text(
        size: 1.2em,
        fill: black, // Changed to black
        weight: "bold",
        info.author,
      )
      if info.date != none {
        parbreak()
        text(
          size: 1.0em,
          fill: black, // Changed to black
          utils.display-info-date(self),
        )
      }
    }
    touying-slide(self: self, body)
  },
)

// 4. Outline Slide
#let outline-slide(
  config: (:),
  title: "Agenda",
  level: 1,
  numbered: false,
  ..args,
) = touying-slide-wrapper(self => {
  let content = {
    std.align(center + horizon)[
      #block(width: 100%, align(left)[
        #text(fill: black, weight: "bold", size: 1.6em)[#title]
        #v(1em)
        #block(width: 100%)[
          #text(fill: black, weight: "bold", size: 0.95em)[
            #components.custom-progressive-outline(
              level: level,
              alpha: 100%,
              depth: 1,
              numbered: (numbered,),
              vspace: (0.4em,),
            )
          ]
        ]
      ])
    ]
  }
  touying-slide(self: self, config: config, content)
})

// 5. Transition Slide
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: false,
  ..args,
  body,
) = touying-slide-wrapper(self => {
  let content = {
    std.align(center + horizon)[
      #block(width: 100%, align(left)[
        #text(fill: black, weight: "bold", size: 1.6em)[Agenda]
        #v(1em)
        #block(width: 100%)[
          #text(fill: black, weight: "bold", size: 0.95em)[
            #components.custom-progressive-outline(
              level: level,
              alpha: 30%,
              depth: 1,
              numbered: (numbered,),
              vspace: (0.4em,),
            )
          ]
        ]
      ])
    ]
  }
  touying-slide(self: self, config: config, content)
})

// 6. Focus Slide
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
  set text(fill: black, weight: "bold", size: 1.5em) // Changed to black
  touying-slide(self: self, config: config, std.align(align, body))
})


// --- THEME DEFINITION ---
#let elegant-blue-theme(
  aspect-ratio: "16-9",
  align: top + left,
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
    text-main: black, // Changed to black
  )

  let sky-gradient = gradient.linear(
    palette.primary,
    palette.secondary,
    dir: rtl,
  )
  let dot-pattern = tiling(size: (12pt, 12pt))[#circle(
    radius: 1.5pt,
    fill: rgb("#00000020"), // Made dots dark/subtle
  )]

  let draft-watermark = if draft {
    std.align(center + horizon)[
      #rotate(-35deg)[
        #text(
          size: 140pt,
          fill: rgb("#00000010"),
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
      grid(
        columns: (10%, auto, 10%),
        rows: auto,
        align: (left + horizon, center + horizon, right + horizon),
        block(width: 100%, height: 100%, fill: dot-pattern),
        block(width: 100%, inset: (x: 1em), pad(y: 0.8em)[
          #set par(leading: 0.8em)
          #components.mini-slides(
            self: self,
            fill: black, // Changed from white to black
            alpha: 60%,
            display-section: true,
            linebreaks: false,
          )
        ]),
        block(width: 100%, height: 100%, fill: dot-pattern),
      ),
    )
  }

  let footer(self) = {
    let footer-fontsize = 0.7em
    block(
      fill: sky-gradient,
      grid(
        columns: (auto, auto, auto, auto, auto),
        rows: 100%,
        align: (
          left + horizon,
          center + horizon,
          center + horizon,
          center + horizon,
          right + horizon,
        ),
        box(inset: (left: 1em, right: 1.5em))[#text(
          fill: black, // Changed from white to black
          weight: "bold",
          size: footer-fontsize,
          self.info.author,
        )],
        block(width: 100%, height: 100%, fill: dot-pattern),
        box(inset: (x: 1.5em))[#text(
          fill: black, // Changed from white to black
          size: footer-fontsize,
          utils.display-info-date(self),
        )],
        block(width: 100%, height: 100%, fill: dot-pattern),
        box(inset: (left: 1.5em, right: 1em))[
          #text(fill: black, weight: "bold", size: footer-fontsize)[
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
      fill: white,
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (top: 3.4em, bottom: 2.0em, left: 2em, right: 2em),
      header: header,
      footer: footer,
      background: draft-watermark,
      header-ascent: 0.5em,
      footer-descent: 0.5em,
    ),
    config-info(title: title, subtitle: subtitle, author: author, date: date),
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
      neutral-lightest: rgb("#000000"), // Set to black
      neutral-darkest: rgb("#000000"),
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "STIX Two Text", size: 18pt, fill: black)
        show math.equation: set text(font: "STIX Two Math")
        show heading.where(level: 1): none
        show heading.where(level: 2): none
        body
      },
    ),
    config-store(align: align, title: none),
    ..args,
  )

  body
}

#let end-slide(
  config: (:),
  title: "Thank you!",
  subtitle: "Questions?",
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(header: none, footer: none, fill: white, margin: 2em),
    config,
  )
  let body = {
    show: std.align.with(center + horizon)
    text(size: 2.5em, fill: black, weight: "bold", title) // Changed to black
    v(0.5em)
    text(size: 1.8em, fill: black, weight: "bold", subtitle) // Changed to black
  }
  touying-slide(self: self, body)
})

