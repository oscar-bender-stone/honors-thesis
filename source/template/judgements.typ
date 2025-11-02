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
  bar-padding: 4pt,
  label-padding: 6pt,
) = {
  let rule-grid(premises: content, conclusion: content) = {
    return grid(
      columns: 1,
      rows: 2,
      row-gutter: bar-padding,
      grid.cell(stroke: (bottom: stroke + black), pad(
        premises,
        bottom: bar-padding + 1pt,
      )),
      conclusion,
    )
  }


  let rule-figure(premises: content, conclusion: content, label: none) = {
    return grid(
      columns: (auto, auto),
      rule-grid(premises: premises, conclusion: conclusion),
    )
  }

  if rules.len() == 1 {
    rule-grid()
  } else {
    rule-figure(
      premises: rules.at(0).at("premises", default: none),
      conclusion: rules.at(0).at("conclusion", default: none),
    )
  }
}



