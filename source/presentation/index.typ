// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template.typ": elegant-blue-theme, title-slide

#show: elegant-blue-theme.with(
  draft: true,
  title: [Designing a Universal Information Language],
  author: [Oscar Bender-Stone],
  date: [March 26, 2026],
)

#title-slide()

= Introduction

== Background

== Existing Solutions

// TODO: incorporate compare list into code
#let compare-list(items, neutral-marker: []) = {
  // Define our markers
  let pro-marker = text(fill: green, weight: "bold")[✓]
  let con-marker = text(fill: red, weight: "bold")[✕]

  list(
    ..items.map(it => {
      // Ensure we are working with a string to check prefixes
      let content = it
      let current-marker = neutral-marker

      if type(it) == str {
        if it.starts-with("+") {
          current-marker = pro-marker
          content = it.slice(1).trim() // Remove the "+" and extra space
        } else if it.starts-with("-") {
          current-marker = con-marker
          content = it.slice(1).trim() // Remove the "-" and extra space
        }
      }

      list.item(marker: current-marker)[#content]
    }),
  )
}
- Resource Description Framework:
  - Part of: Web Ontology Language (OWL)
  - Widely used on internet
  - No built-in logical engine
- Labeled Property Graphs:
  - Stores *properties* (internal metadata) in nodes, edges
  - Efficient querying
- Cyc

= Foundations

= Syntax

= Metatheory

= Conclusion
