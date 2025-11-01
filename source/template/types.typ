// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

// This implementation is adapted from the `prooftree` function in
// the `curryst` library (https://github.com/pauladam94/curryst),
// which is available under the MIT License.


// A helper function to draw a single inference rule.
#let draw-rule(
  premises: none,
  conclusion: [],
  label: none,
  stroke: 0.4pt,
  spacing: 0.65em,
  gutter: 0.5em,
) = {
  // We MUST wrap the entire logic in `layout` so that
  // the `measure` function has access to the context.
  layout(available => {
    // 1. Resolve `em` units to absolute `pt` lengths
    //    by measuring them in the current context.
    let min-bar-height = measure(box(height: 0.8em)).height
    let dy-adjust = measure(box(height: -0.15em)).height

    // 2. Prepare content
    let premises-content = if premises != none { premises } else { [] }
    let conclusion-content = conclusion

    // 3. Measure content
    let (premises-width, conclusion-width) = (
      measure(premises-content).width,
      measure(conclusion-content).width,
    )

    // 4. Determine bar length and offsets
    let bar-length = calc.max(premises-width, conclusion-width)
    let premises-offset = (bar-length - premises-width) / 2
    let conclusion-offset = (bar-length - conclusion-width) / 2

    // 5. Create baked label and measure it
    let baked-label = if label != none {
      // Move text up by an absolute amount for precise centering
      move(dy: dy-adjust, label)
    } else {
      none
    }

    let (label-width, label-height) = if baked-label != none {
      (measure(baked-label).width, measure(baked-label).height)
    } else {
      (0pt, 0pt)
    }

    // 6. Create the bar row (using the `curryst` technique)
    let bar-row = {
      box(
        // Now `calc.max` compares two absolute lengths (pt vs pt)
        height: calc.max(label-height, min-bar-height),
        {
          set align(horizon)
          let bar-line = line(length: bar-length, stroke: stroke)

          let parts = (bar-line, baked-label).filter(p => p != none)
          stack(dir: ltr, spacing: gutter, ..parts)
        },
      )
    }

    // 7. Assemble the final stack
    //    `align: left` was removed, as it's not a valid stack argument.
    //    The `h()` functions handle the alignment.
    let final-stack = stack(
      dir: ttb,
      spacing: spacing,

      // 1. Premises (with horizontal padding)
      h(premises-offset) + premises-content,

      // 2. Bar Row
      bar-row,

      // 3. Conclusion (with horizontal padding)
      h(conclusion-offset) + conclusion-content,
    )

    // 8. Return the stack directly.
    //    The `layout` function provides the block context.
    //    Wrapping in *another* `block` was redundant and
    //    likely caused the overlapping issue.
    final-stack
  })
}


// Displays one or more judgement rules.
//
// - For a single rule:
//   #judgement(premises: ..., conclusion: ..., label: ...)
//
// - For multiple rules in a grid:
//   #judgement(rules: ( (premises: ...), ... ), caption: ...)
//
#let judgement(
  // For multiple rules
  rules: none,
  caption: none,
  columns: 3,
  // For single rule
  premises: none,
  conclusion: [],
  label: none,
  // Styling
  stroke: 0.4pt,
  spacing: 0.65em, // Vertical space
  gutter: 0.5em, // Space between line and label
) = {
  // Case 1: Multiple rules provided in an array
  if rules != none {
    figure(
      grid(
        columns: columns,
        row-gutter: 2em,
        column-gutter: 1.5em,
        align: top,

        // Map each rule dictionary to the `draw-rule` helper
        ..rules.map(rule => draw-rule(
          premises: rule.at("premises", default: none),
          conclusion: rule.at("conclusion", default: []),
          label: rule.at("label", default: none),
          stroke: stroke,
          spacing: spacing,
          gutter: gutter,
        ))
      ),
      caption: caption,
    )
  } else {
    // Case 2: Single rule arguments provided directly
    draw-rule(
      premises: premises,
      conclusion: conclusion,
      label: label,
      stroke: stroke,
      spacing: spacing,
      gutter: gutter,
    )
  }
}

