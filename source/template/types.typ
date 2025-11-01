// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import calc.max // We need this for max

// --- Core Rule Function ---
// This builds the rule (premises, line, conclusion)
// and attaches the name if it exists.
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

  // 3. Create final content, attaching name if it exists
  if name == none {
    rule-body // Just return the stack
  } else {
    // `attach` is a method on content, so we call it on `rule-body`.
    // We use `right + bottom` for the position.
    rule-body.attach(
      right + bottom,
      // Add a bit of horizontal space before the name
      // We create a content block `[]` to hold the space
      // and the math-formatted name.
      [#h(0.6em)
        $ (#name) $],
    )
  }
}


// --- Main Figure Function ---
// This function is now "smarter". It can handle
// either a single rule (using positional args)
// or multiple rules (using the new `rules` named arg).
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
    // Use a grid to automatically arrange rules in rows
    // and wrap as needed.
    grid(
      // Set a gutter between columns and rows
      column-gutter: 2.5em, // Horizontal space between rules
      row-gutter: 1.5em, // Vertical space between rules
      // Align all rules in a row to their bottom edge
      // This makes the conclusions and names line up.
      align: bottom,

      // Map each rule dictionary to a rule element
      ..rules.map(rule => judgement-rule(
        rule.at("premises", default: ()),
        rule.at("conclusion", default: ()),
        name: rule.at("name", default: none), // <-- Fixed: Added 'name:'
      ))
    )
  } else {
    // --- Single Rule Mode ---
    // Just call the core rule function with the provided args.
    judgement-rule(premises, conclusion, name: name)
  }

  // 2. Wrap the final content in a figure
  figure(
    // Center the whole block (either the single rule or the grid of rules)
    align(center, final-content),
    caption: caption,
  )
}
