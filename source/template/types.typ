// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


/// Creates one or more inference rules with guaranteed alignment.
///
/// This version uses a table with manual alignment overrides
/// to *guarantee* that the *vertical center* of labels
/// is aligned with the *vertical center* of the inference bar.
///
/// Args:
///   rules (array): An array of dictionaries, each defining a rule.
///     - premises (content, array): Premises for the rule.
///     - conclusion (content): Conclusion for the rule.
///     - lhs-label (content): Optional label for the *left* side (e..g, "T").
///     - label (content): Optional label for the *right* side (e.g., "Axiom").
///   premises (content, array): Premises for a single rule.
///   conclusion (content): Conclusion for a single rule.
///   lhs-label (content): Left-side label for a single rule.
///   label (content): Right-side label for a single rule.
///   caption (content): A caption for the figure.
///
#let judgement(
  rules: none,
  premises: none,
  conclusion: none,
  lhs-label: none, // For the left side (e.g., "T")
  label: none, // For the right side (e.g., "Decimal digits")
  caption: none,
) = {
  // --- Internal Helper to lay out a SINGLE rule ---
  let _layout-rule(r) = {
    let premises-arr = r.at("premises", default: none)
    let conclusion = r.at("conclusion", default: [error: no conclusion])
    let lhs = r.at("lhs-label", default: none)
    let rhs = r.at("label", default: none)
    let spacing = 0.5em

    // 1. Standardize premises
    if premises-arr == none {
      premises-arr = ()
    } else if type(premises-arr) != array {
      premises-arr = (premises-arr,)
    }

    // 2. Build the top (premises) and bottom (conclusion) content
    let top-content = if premises-arr.len() > 0 {
      stack(dir: ltr, spacing: 2em, ..premises-arr)
    } else {
      // Use an empty content box [ ]
      // This has a standard line height, just like a premise.
      [ ]
    }
    let bot-content = conclusion

    // 3. Find the width of the bar
    let top-width = measure(top-content).width
    let bot-width = measure(bot-content).width
    let bar-width = calc.max(top-width, bot-width)

    // 4. Create the three *centered* core components
    let top-part = box(width: bar-width, align(center, top-content))
    let bar-part = line(length: bar-width, stroke: 0.4pt)
    let bot-part = box(width: bar-width, align(center, bot-content))

    // 5. Stack the core tree
    let core-tree = stack(
      dir: ttb,
      spacing: spacing,
      top-part,
      bar-part,
      bot-part,
    )

    // --- THE GUARANTEED ALIGNMENT (CENTER) ---
    // We need to find the vertical *center* of the bar
    // relative to the top of the core-tree.
    let top-height = measure(top-part).height
    let bar-height = measure(bar-part).height
    // This is the distance from the top of the tree to the *center* of the bar
    let bar-v-center = top-height + spacing + (bar-height / 2)

    // 6. Place the core tree and labels in a table
    table(
      columns: (auto, auto, auto),
      rows: auto,
      gutter: 1em,
      // Align all cell tops as our starting reference
      align: top,
      stroke: none,
      // No borders

      // Col 1: Left Label
      if lhs != none {
        // Find the dy to align the label's center with the bar's center
        let lhs-height = measure(lhs).height
        let lhs-dy = bar-v-center - (lhs-height / 2)
        move(dy: lhs-dy, align(right, lhs))
      },

      // Col 2: The Proof Tree
      core-tree,

      // Col 3: Right Label
      if rhs != none {
        // Find the dy to align the label's center with the bar's center
        let rhs-height = measure(rhs).height
        let rhs-dy = bar-v-center - (rhs-height / 2)
        move(dy: rhs-dy, align(left, rhs))
      },
    )
  }
  // --- End of internal helper ---

  // Standardize input:
  if rules == none {
    rules = (
      (
        premises: premises,
        conclusion: conclusion,
        "lhs-label": lhs-label, // Pass LHS
        "label": label, // Pass RHS
      ),
    )
  }

  // --- Main Layout (WITH WRAPPING) ---
  // The wrapping logic is here, inside the layout() function.
  let content = layout(available => {
    // 1. Render all the individual rule trees
    let rule-trees = rules.map(r => _layout-rule(r))

    // 2. Wrapping logic
    let line-builder = stack.with(dir: ltr, spacing: 2em)
    let lines = ((),)
    let available-width = available.width

    for tree in rule-trees {
      let augmented-line = lines.last() + (tree,)
      // Add to line if it fits, or if the line is empty
      if (
        measure(line-builder(..augmented-line)).width <= available-width
          or lines.last().len() == 0
      ) {
        lines.last() = augmented-line
      } else {
        // Otherwise, start a new line
        lines.push((tree,))
      }
    }

    // 3. Build the final stack of lines
    stack(
      dir: ttb,
      spacing: 1em,
      ..lines
        .filter(line => line.len() > 0)
        .map(line => align(center, line-builder(..line))),
    )
  })

  // Add caption if provided
  if caption != none {
    content = figure(content, caption: caption)
  }

  content
}

