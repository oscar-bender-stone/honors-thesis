// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

/// Displays *judgements*,
/// which consist of a grid cell
/// with an inference bar, premises
/// on top, and conclusion at the bottom.
/// Judgements can optionally have a label
/// on the side.
//
/// This function creates a judgement
/// for each element of rules,
/// an array of dictionary with:
/// - premises: content or none
/// - conclusion: content
/// - label: content or none (appears on the RHS)
///
/// Multiple rules are automatically wrapped
/// within the document's margin
/// and ensures that rules
/// on the *same* row
/// have perfectly aligned bars.
/// The figure is ALWAYS
/// within the margins
/// of the document's page.
#let judgement(
  rules: none,
  caption: none,
  stroke: 0.4pt,
  hspace: 4.3pt,
  label-padding: 6pt,
) = {
  if rules == none or rules.len() == 0 {
    return
  }

  let rule-cell(rule) = {
    grid(
      columns: (auto, auto),
      inset: hspace,
      stroke: (x, y) => if (x, y) == (0, 0) { (bottom: stroke) },
      align: center + horizon,
      pad(rule.at("premises", default: $$)),
      grid.cell(rowspan: 2, rule.at("label", default: none)),
      [#rule.at("conclusion", default: none)],
    )
  }

  let rules-grid() = {
    let rule = rules.at(0, default: none)

    for rule-sublist in rules.chunks(3) {
      stack(dir: ltr, ..rule-sublist.map(rule => rule-cell(rule)))
    }
  }

  figure(
    rules-grid(),
    caption: caption,
  )
}



