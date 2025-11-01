// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

/*
 * Core proof tree layout logic adapted from 'curryst' (MIT License).
 * https://github.com/pauladam94/curryst
 */

/// Creates an inference rule. (Internal logic from curryst)
#let rule(
  label: none,
  name: none,
  conclusion,
  ..premises,
) = {
  assert.ne(
    type(conclusion),
    dictionary,
    message: "the conclusion of a rule must be some content (it cannot be another rule)",
  )
  assert.eq(
    premises.named().len(),
    0,
    message: "unexpected named arguments to `rule`",
  )
  (
    label: label,
    name: name,
    conclusion: conclusion,
    premises: premises.pos(),
  )
}

/// Lays out a proof tree. (Internal logic from curryst)
#let prooftree(
  rule,
  min-premise-spacing: 1.5em,
  title-inset: 0.2em,
  stroke: stroke(0.05em),
  vertical-spacing: 0pt,
  min-bar-height: 0.8em,
  dir: btt,
) = {
  // --- Internal layout functions (from curryst) ---

  let layout-content(content) = {
    let dimensions = measure(content)
    (
      content: box(..dimensions, content),
      left-blank: 0pt,
      right-blank: 0pt,
    )
  }

  let layout-premises(premises, min-spacing, optimal-inner-width) = {
    let arity = premises.len()
    if arity == 0 { return layout-content(none) }
    if arity == 1 { return premises.at(0) }

    let left-blank = premises.at(0).left-blank
    let right-blank = premises.at(-1).right-blank
    let initial-content = stack(
      dir: ltr,
      spacing: min-spacing,
      ..premises.map(p => p.content),
    )
    let initial-inner-width = (
      measure(initial-content).width - left-blank - right-blank
    )

    if initial-inner-width >= optimal-inner-width {
      return (
        content: box(initial-content),
        left-blank: left-blank,
        right-blank: right-blank,
      )
    }

    let remaining-space = optimal-inner-width - initial-inner-width
    let final-content = stack(
      dir: ltr,
      spacing: min-spacing + remaining-space / (arity + 1),
      ..premises.map(p => p.content),
    )
    (
      content: box(final-content),
      left-blank: left-blank,
      right-blank: right-blank,
    )
  }

  let layout-leaf-premises(premises, min-spacing, available-width) = {
    let line-builder = stack.with(dir: ltr, spacing: min-spacing)
    let lines = ((),)
    for premise in premises {
      let augmented-line = lines.last() + (premise,)
      if measure(line-builder(..augmented-line)).width <= available-width {
        lines.last() = augmented-line
      } else {
        lines.push((premise,))
      }
    }
    layout-content(align(center, stack(
      dir: ttb,
      spacing: 0.7em,
      ..lines.filter(line => line.len() != 0).map(line => line-builder(..line)),
    )))
  }

  let layout-bar(stroke, length, hang, label, name, margin, min-height) = {
    let bar = line(
      start: (0pt, 0pt),
      length: length + 2 * hang,
      stroke: stroke,
    )
    let (width: label-width, height: label-height) = measure(label)
    let (width: name-width, height: name-height) = measure(name)
    let content = {
      show: box.with(height: calc.max(label-height, name-height, min-height))
      set align(horizon)
      let bake(body) = if body == none {
        none
      } else {
        move(dy: -0.15em, box(body, ..measure(body)))
      }
      let parts = (bake(label), bar, bake(name)).filter(p => p != none)
      stack(dir: ltr, spacing: margin, ..parts)
    }
    (
      content: content,
      left-blank: if label == none { hang } else {
        hang + margin + label-width
      },
      right-blank: if name == none { hang } else { hang + margin + name-width },
    )
  }

  let layout-rule(
    premises,
    conclusion,
    bar-stroke,
    bar-hang,
    label,
    name,
    bar-margin,
    vertical-spacing,
    min-bar-height,
  ) = {
    conclusion = box(conclusion, ..measure(conclusion))
    let premises-inner-width = (
      measure(premises.content).width
        - premises.left-blank
        - premises.right-blank
    )
    let conclusion-width = measure(conclusion).width
    let bar-length = calc.max(premises-inner-width, conclusion-width)
    let bar = layout-bar(
      bar-stroke,
      bar-length,
      bar-hang,
      label,
      name,
      bar-margin,
      min-bar-height,
    )

    let left-start
    let right-start
    let premises-left-offset
    let conclusion-left-offset

    if premises-inner-width > conclusion-width {
      left-start = calc.max(premises.left-blank, bar.left-blank)
      right-start = calc.max(premises.right-blank, bar.right-blank)
      premises-left-offset = left-start - premises.left-blank
      conclusion-left-offset = (
        left-start + (premises-inner-width - conclusion-width) / 2
      )
    } else {
      let premises-left-hang = (
        premises.left-blank - (bar-length - premises-inner-width) / 2
      )
      let premises-right-hang = (
        premises.right-blank - (bar-length - premises-inner-width) / 2
      )
      left-start = calc.max(premises-left-hang, bar.left-blank)
      right-start = calc.max(premises-right-hang, bar.right-blank)
      premises-left-offset = (
        left-start
          + (bar-length - premises-inner-width) / 2
          - premises.left-blank
      )
      conclusion-left-offset = left-start
    }
    let bar-left-offset = left-start - bar.left-blank

    let content = {
      let stack-dir = dir.inv()
      let align-y = dir.start()
      set align(align-y + left)
      stack(
        dir: stack-dir,
        spacing: vertical-spacing,
        h(premises-left-offset) + premises.content,
        h(bar-left-offset) + bar.content,
        h(conclusion-left-offset) + conclusion,
      )
    }
    (
      content: box(content),
      left-blank: left-start + (bar-length - conclusion-width) / 2,
      right-blank: right-start + (bar-length - conclusion-width) / 2,
    )
  }

  let layout-tree(
    rule,
    available-width,
    min-premise-spacing,
    bar-stroke,
    bar-hang,
    bar-margin,
    vertical-spacing,
    min-bar-height,
  ) = {
    if type(rule) != dictionary {
      return layout-content(rule)
    }
    let layout-with-baked-premises(premises) = {
      layout-rule(
        premises,
        rule.conclusion,
        bar-stroke,
        bar-hang,
        rule.label,
        rule.name,
        bar-margin,
        vertical-spacing,
        min-bar-height,
      )
    }
    let side-to-side-premises = layout-premises(
      rule.premises.map(premise => layout-tree(
        premise,
        none,
        min-premise-spacing,
        bar-stroke,
        bar-hang,
        bar-margin,
        vertical-spacing,
        min-bar-height,
      )),
      min-premise-spacing,
      measure(rule.conclusion).width,
    )
    let result = layout-with-baked-premises(side-to-side-premises)
    let premises-are-all-leaves = rule.premises.all(p => type(p) != dictionary)
    if (
      available-width == none
        or measure(result.content).width <= available-width
        or not premises-are-all-leaves
    ) {
      return result
    }
    let used-width = bar-hang * 2
    if rule.name != none { used-width += bar-margin + measure(rule.name).width }
    if rule.label != none {
      used-width += bar-margin + measure(rule.label).width
    }
    let stacked-premises = layout-leaf-premises(
      rule.premises,
      min-premise-spacing,
      available-width - used-width,
    )
    layout-with-baked-premises(stacked-premises)
  }

  // --- Main prooftree layout ---
  layout(available => {
    let tree = layout-tree(
      rule,
      available.width,
      min-premise-spacing.to-absolute(),
      stroke,
      title-inset.to-absolute(),
      title-inset.to-absolute(),
      vertical-spacing.to-absolute(),
      min-bar-height.to-absolute(),
    ).content
    block(..measure(tree), breakable: false, tree)
  })
}

/// Creates one or more inference rules, centered and with wrapping.
///
/// Args:
///   rules (array): An array of dictionaries, each defining a rule.
///   premises (content, array): Premises for a single rule.
///   conclusion (content): Conclusion for a single rule.
///   label (content): Label (on right) for a single rule.
///   caption (content): A caption for the figure.
#let judgement(
  rules: none,
  premises: none,
  conclusion: none,
  label: none,
  caption: none,
) = {
  // Helper to convert to `curryst` rule format
  let make-internal-rule(r) = {
    let internal-premises = ()
    if r.premises != none {
      if type(r.premises) == array {
        internal-premises = r.premises
      } else {
        internal-premises = (r.premises,)
      }
    }
    rule(
      name: r.at("label", default: none),
      r.conclusion,
      ..internal-premises,
    )
  }

  let content

  if rules != none {
    // Multi-rule mode: Use `layout` to get available width and wrap rules
    content = layout(available => {
      let rule-trees = rules.map(r => {
        prooftree(make-internal-rule(r), stroke: 0.4pt)
      })

      let line-builder = stack.with(dir: ltr, spacing: 2em)
      let lines = ((),)
      let available-width = available.width

      for tree in rule-trees {
        let augmented-line = lines.last() + (tree,)
        // Add to line if it fits, or if the line is empty (to force at least one item)
        if (
          measure(line-builder(..augmented-line)).width <= available-width
            or lines.last().len() == 0
        ) {
          lines.last() = augmented-line
        } else {
          lines.push((tree,))
        }
      }

      // Build the final stack of centered lines
      stack(
        dir: ttb,
        spacing: 1em,
        ..lines
          .filter(line => line.len() > 0)
          .map(line => align(center, line-builder(..line))),
      )
    })
  } else if conclusion != none {
    // Single-rule mode: Create one tree
    let internal-rule = make-internal-rule((
      premises: premises,
      conclusion: conclusion,
      label: label,
    ))
    content = block(width: 100%, align(center, prooftree(
      internal-rule,
      stroke: 0.4pt,
    )))
  } else {
    content = box()
  }

  // Add caption if provided
  if caption != none {
    content = figure(
      content,
      caption: caption,
    )
  }

  // Final content is ready
  content
}

