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
  if rules == none or rules.len() == 0 {
    return
  }

  let rule-cell(premises: content, conclusion: content) = {
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

  let rule-grid(
    premises: content,
    conclusion: content,
    label: none,
  ) = {
    let label-vspace
    if premises == none {
      label-vspace = vspace + 2pt
    } else {
      label-vspace = 0pt
    }

    let label-cell = pad(label, bottom: label-vspace, left: label-padding)

    grid(
      columns: (auto, auto),
      align: center + horizon,
      rule-cell(premises: premises, conclusion: conclusion), label-cell,
    )
  }

  figure(
    for rule in rules {
      rule-grid(
        premises: rule.at("premises", default: none),
        conclusion: rule.at("conclusion", default: none),
        label: rule.at("label", default: none),
      )
    },
    caption: caption,
  )
}



