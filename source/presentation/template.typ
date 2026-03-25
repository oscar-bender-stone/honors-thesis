// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "@preview/touying:0.6.3": *
#import "@preview/touying:0.6.3": meanwhile as ty-meanwhile, pause as ty-pause

#let pause = ty-pause
#let meanwhile = ty-meanwhile

#let t-fn-counter = counter("t-fn-counter")
#let t-footnote-state = state("t-footnote-state", ())

#let t-footnote(body) = box({
  t-fn-counter.step()
  context {
    let idx = t-fn-counter.get().first()
    let trigger = counter("touying-pause").get().first()
    t-footnote-state.update(arr => (
      arr + ((step: trigger, idx: idx, body: body),)
    ))
    text(fill: black)[#super(str(idx))]
  }
})

// 1. Fixed title block slide wrapper
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
    // Reset footnote state per slide
    t-footnote-state.update(())
    t-fn-counter.update(0)

    let display-title = if title != auto { title } else {
      utils.display-current-heading(level: 2)
    }

    if display-title != none and display-title != [] {
      block(
        width: 100%,
        inset: (top: 0.5em, bottom: 0.5em),
        text(
          fill: black,
          weight: "bold",
          size: 1.4em,
          display-title,
        ),
      )
    }

    show: setting

    // Render the main content
    std.align(self.store.align, body)

    // Safely render accumulated custom footnotes at absolute bottom
    context {
      let current-frame = counter("touying-step").get().first()
      let all-fns = t-footnote-state.get()

      // Filter so only footnotes attached to visible pauses are rendered at the bottom
      let visible-fns = all-fns.filter(fn => fn.step <= current-frame)

      if visible-fns.len() > 0 {
        place(bottom + left, block(width: 100%, {
          line(length: 100%, stroke: 1pt + black)
          v(0.2em, weak: true)

          set text(fill: black, font: "STIX Two Text", size: 0.6em)

          for (i, fn) in visible-fns.enumerate() {
            if i != 0 { [\ ] }
            [#super(str(fn.idx)) #fn.body]
          }
        }))
      }
    }
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

// 2. Updated Title Slide with Committee Support and Honors Badge
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

      // Honors Thesis Badge/Indicator
      if "honors" in info and info.honors == true {
        block(
          fill: gradient.linear(
            self.colors.primary,
            self.colors.secondary,
            dir: rtl,
          ),
          inset: (x: 1em, y: 0.5em),
          radius: 0.3em,
          text(size: 1.3em, weight: "bold", fill: black, [Honors Thesis:]),
        )
      }
      v(-1pt, weak: true)

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
            fill: black,
            weight: "bold",
            info.title,
          )
          if info.subtitle != none {
            parbreak()
            text(
              size: 1.1em,
              fill: black,
              weight: "bold",
              info.subtitle,
            )
          }
        },
      )
      v(1em)
      text(
        size: 1.2em,
        fill: black,
        weight: "bold",
        info.author,
      )
      if info.date != none {
        parbreak()
        text(
          size: 1.0em,
          fill: black,
          utils.display-info-date(self),
        )
      }

      // --- COMMITTEE SECTION ---
      if "committee" in info and info.committee != none {
        v(2em)
        text(size: 1.0em, weight: "bold", fill: black)[Committee Members]
        v(0.6em)
        block(width: 95%, {
          set text(size: 0.75em)
          let count = info.committee.len()
          grid(
            columns: (1fr,) * count,
            column-gutter: 1em,
            row-gutter: 1.2em,
            align: center,
            // Each member occupies one column with stacked info
            ..info.committee.map(member => [
              *#member.name* \
              #member.dept \
              #member.role
            ])
          )
        })
      }

      if extra != none {
        v(1em)
        extra
      }
    }
    touying-slide(self: self, body)
  },
)

// 3. Outline Slide
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
        #v(0.5em)
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
  touying-slide(
    self: self,
    config: config,
    content,
  )
})

// 4. Transition Slide
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
        #v(0.5em)
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
  touying-slide(
    self: self,
    config: config,
    content,
  )
})

// 5. Focus Slide
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
  set text(fill: black, weight: "bold", size: 1.5em)
  touying-slide(
    self: self,
    config: config,
    std.align(align, body),
  )
})


// --- THEME DEFINITION ---
#let elegant-blue-theme(
  aspect-ratio: "16-9",
  align: top + left,
  title: none,
  subtitle: none,
  author: none,
  date: datetime.today(),
  committee: none,
  honors: false,
  draft: false,
  ..args,
  body,
) = {
  let palette = (
    primary: rgb("#4da6ff"),
    secondary: rgb("#80ccff"),
    text-main: black,
  )

  let sky-gradient = gradient.linear(
    palette.primary,
    palette.secondary,
    dir: rtl,
  )
  let dot-pattern = tiling(size: (12pt, 12pt))[#circle(
    radius: 1.5pt,
    fill: rgb("#00000020"),
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
        block(width: 100%, inset: (x: 1em), pad(y: 0.5em)[
          #set par(leading: 0.8em)
          #components.mini-slides(
            self: self,
            fill: black,
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
          fill: black,
          weight: "bold",
          size: footer-fontsize,
          self.info.author,
        )],
        block(width: 100%, height: 100%, fill: dot-pattern),
        box(inset: (x: 1.5em))[#text(
          fill: black,
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
      margin: (top: 2.8em, bottom: 2.0em, left: 2em, right: 2em),
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
      committee: committee,
      honors: honors,
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
      neutral-lightest: rgb("#000000"),
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
    text(size: 2.5em, fill: black, weight: "bold", title)
    v(0.5em)
    text(size: 1.8em, fill: black, weight: "bold", subtitle)
  }
  touying-slide(self: self, body)
})
