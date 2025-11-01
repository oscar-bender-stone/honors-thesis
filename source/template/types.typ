// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// This implementation is adapted from the `prooftree` function in
// the `curryst` library (https://github.com/pauladam94/curryst),
// which is available under the MIT License.

// A helper function to draw a single inference rule.
// Used by the *single rule* case.
#let draw-rule(
  premises: none,
  conclusion: [],
  label: none,
  stroke: 0.4pt,
  spacing: 0.65em,
  gutter: 0.5em,
) = {
  layout(available => {
    let min-bar-height = measure(box(height: 0.8em)).height
    let dy-adjust = measure(box(height: -0.15em)).height
    let premises-content = if premises != none { premises } else { [] }
    let conclusion-content = conclusion

    let (premises-width, conclusion-width) = (
      measure(premises-content).width,
      measure(conclusion-content).width,
    )

    let bar-length = calc.max(premises-width, conclusion-width)

    // Use `box` with `align(center)` for robust centering.
    let premises-box = box(
      width: bar-length,
      align(center, premises-content),
    )
    let conclusion-box = box(
      width: bar-length,
      align(center, conclusion-content),
    )

    let baked-label = if label != none {
      move(dy: dy-adjust, label)
    } else {
      none
    }
    let (label-width, label-height) = if baked-label != none {
      (measure(baked-label).width, measure(baked-label).height)
    } else {
      (0pt, 0pt)
    }
    let bar-row = {
      box(
        height: calc.max(label-height, min-bar-height),
        {
          set align(horizon)
          let bar-line = line(length: bar-length, stroke: stroke)
          let parts = (bar-line, baked-label).filter(p => p != none)
          stack(dir: ltr, spacing: gutter, ..parts)
        },
      )
    }

    // Assemble the final stack
    stack(
      dir: ttb,
      spacing: spacing, // Applies the standard space
      premises-box,
      bar-row,
      conclusion-box,
    )
  })
}

// A helper function to draw the BAR and CONCLUSION
#let draw-rule-base(
  conclusion: [],
  label: none,
  bar-length: 0pt, // Must be pre-calculated
  stroke: 0.4pt,
  spacing: 0.65em, // Standard spacing
  gutter: 0.5em,
) = {
  layout(available => {
    let min-bar-height = measure(box(height: 0.8em)).height
    let dy-adjust = measure(box(height: -0.15em)).height

    let baked-label = if label != none {
      move(dy: dy-adjust, label)
    } else {
      none
    }
    let (label-width, label-height) = if baked-label != none {
      (measure(baked-label).width, measure(baked-label).height)
    } else {
      (0pt, 0pt)
    }

    // Create the bar row
    let bar-row = {
      box(
        height: calc.max(label-height, min-bar-height),
        {
          set align(horizon)
          let bar-line = line(length: bar-length, stroke: stroke)
          let parts = (bar-line, baked-label).filter(p => p != none)
          stack(dir: ltr, spacing: gutter, ..parts)
        },
      )
    }

    // Center the conclusion
    let conclusion-box = box(
      width: bar-length,
      align(center, conclusion),
    )

    // Stack bar and conclusion with standard spacing
    stack(
      dir: ttb,
      spacing: spacing,
      bar-row,
      conclusion-box,
    )
  })
}


// Displays one or more judgement rules.
//
#let judgement(
  // For multiple rules
  rules: none,
  caption: none,
  columns: 3,
  column-gutter: 1.5em,
  // For single rule
  premises: none,
  conclusion: [],
  label: none,
  // Styling
  stroke: 0.4pt,
  spacing: 0.65em, // Standard vertical space
  gutter: 0.5em,
) = {
  // --- SINGLE RULE CASE ---
  if rules == none {
    draw-rule(
      premises: premises,
      conclusion: conclusion,
      label: label,
      stroke: stroke,
      spacing: spacing,
      gutter: gutter,
    )
  } // --- MULTIPLE RULE CASE ---
  else {
    figure(
      layout(available => {
        // 1. Pre-process all rules.
        let processed-rules = rules.map(rule => {
          let p = rule.at("premises", default: none)
          let c = rule.at("conclusion", default: [])
          let p-content = if p != none { p } else { [] }

          let p-width = measure(p-content).width
          let c-width = measure(c).width
          let bar-length = calc.max(p-width, c-width)

          // Measure the height of the premise box
          let p-height = measure(
            box(width: bar-length, align(center, p-content)),
          ).height

          (
            premises: p-content,
            conclusion: c,
            label: rule.at("label", default: none),
            bar-length: bar-length,
            premises-height: p-height,
          )
        })

        // --- THIS IS THE FIX ---
        // Get all heights
        let premise-heights = processed-rules.map(
          r => r.premises-height,
        )
        // Use `calc.max` with spread operator and a default
        // value of 0pt to prevent errors on empty arrays.
        let max-premise-height = calc.max(0pt, ..premise-heights)

        // 2. Create the final vertical stack
        stack(
          dir: ttb,
          // Standard spacing between premises and bars
          spacing: spacing,

          // --- ROW 1: PREMISES ---
          stack(
            dir: ltr,
            spacing: column-gutter,
            ..processed-rules.map(rule => {
              // This box enforces alignment:
              // 1. All boxes have same height (max-premise-height)
              // 2. All align their content at the bottom
              // 3. All have the correct bar-length width
              // 4. All center their content horizontally
              box(
                width: rule.bar-length,
                height: max-premise-height,
                align(bottom + center, rule.premises),
              )
            }),
          ),

          // --- ROW 2: BARS + CONCLUSIONS ---
          stack(
            dir: ltr,
            spacing: column-gutter,
            ..processed-rules.map(rule => {
              // This content is naturally top-aligned
              draw-rule-base(
                conclusion: rule.conclusion,
                label: rule.label,
                bar-length: rule.bar-length,
                stroke: stroke,
                spacing: spacing, // Standard spacing
                gutter: gutter,
              )
            }),
          ),
        )
      }),
      caption: caption,
    )
  }
}

