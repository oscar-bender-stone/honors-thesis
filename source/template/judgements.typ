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
  vspace: 4pt,
  hspace: 2pt,
  label-padding: 6pt,
) = {
  let rule-grid(premises: content, conclusion: content) = {
    return grid(
      columns: 1,
      rows: 2,
      row-gutter: vspace,
      grid.cell(stroke: (bottom: stroke + black), pad(
        premises,
        bottom: vspace + 1pt,
      )),
      pad(conclusion, left: hspace, right: hspace),
    )
  }

  let rule-figure(
    premises: content,
    conclusion: content,
    label: none,
  ) = {
    let label-cell

    if label == none {
      label-cell = []
    } else {
      label-cell = pad(label, left: label-padding)
    }

    return figure(
      grid(
        columns: (auto, auto),
        rule-grid(premises: premises, conclusion: conclusion), label-cell,
      ),
      caption: caption,
    )
  }

  if rules.len() == 1 {
    let rule = rules.at(0)

    rule-figure(
      premises: rule.at("premises", default: none),
      conclusion: rule.at("conclusion", default: none),
      label: rule("label", default: none),
    )
  } else {
    rule-figure(
      premises: rules.at(0).at("premises", default: none),
      conclusion: rules.at(0).at("conclusion", default: none),
      label: rules.at(0).at("label", default: none),
    )
  }
}



