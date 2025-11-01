// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


#import calc.max // We need this for max

// --- Core Rule Function ---
// This new function builds the rule but does NOT wrap it in a figure,
// so it can be composed with other elements.
// (This function is unchanged)
#let judgement-rule(premises, conclusion, name: none) = {
  // We must use a `context` block to be able to `measure` elements.
  // The block will evaluate its contents and return the result,
  // which we store in `rule-body`.
  let rule-body = context {
    // 1. Measure content and define the core rule
    let premises-content = box(premises)
    let conclusion-content = box(conclusion)

    let premises-width = measure(premises-content).width
    let conclusion-width = measure(conclusion-content).width
    // We use the max width, plus a little padding for aesthetics
    let rule-width = max(premises-width, conclusion-width) + 2pt

    // We use a vertical `stack`. The cross-axis alignment
    // is controlled by wrapping children in `align()`.
    stack(
      spacing: 0.4em,

      // Premises above the line, centered
      align(center, premises-content),

      // The horizontal line, with its length
      // explicitly set to the max width.
      line(length: rule-width, stroke: 0.5pt),

      // Conclusion below the line, centered
      align(center, conclusion-content),
    )
  } // `rule-body` is now defined

  // 2. Create the final content, adding the name if it exists.
  let final-content = if name == none {
    // If no name, just use the rule body.
    rule-body
  } else {
    // If a name exists, use a 2-column grid.
    grid(
      columns: (auto, auto),
      column-gutter: 0.6em,
      // `align: bottom` is valid for grid and aligns
      // cells vertically to the bottom.
      align: bottom,

      rule-body, $ (#name) $,
      // Display the name in math mode
    )
  }

  // 3. Return the final, unwrapped content
  final-content
}


#let judgement(
  premises: none,
  conclusion: none,
  rules: none, // This is the new argument
  name: none, // Used only for single-rule mode
  caption: none,
) = {
  // 1. Determine the content: single rule or list of rules?
  let final-content = if rules != none {
    // --- Multiple Rule Mode ---
    // We have an array of rules. Stack them vertically.
    // We use `.at()` for safe dictionary access.
    stack(
      dir: ttb,
      spacing: 1.2em,
      ..rules.map(rule => judgement-rule(
        rule.at("premises", default: ()),
        rule.at("conclusion", default: ()),
        name: rule.at("name", default: none),
      )),
    )
  } else {
    // --- Single Rule Mode ---
    // Just call the core rule function with the provided args.
    judgement-rule(premises, conclusion, name: name)
  }

  // 2. Wrap the final content in a figure
  figure(
    align(center, final-content),
    caption: caption,
  )
}
