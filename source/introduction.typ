// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT


= Introduction

Humanity produces a colossal amount of data each year. According to the International Data Corporation, there is currently 163 zettabytes of digital data in the world. Given that the average human can read, on average, 200 words per minute, and approximating a word as 8 bytes, this would require _billions_ of years ($7.8675 * 10^9$ minutes). Even in restricted areas, such as academa, the amount of data available cannot be consumed individually. On JSTOR alone, there are over 2800 journals, translating to around 12 _million_ articles. Taking the average size of an article to be 5000 words, this amounts to _hundreds_ of years ($3 * 10^8$ minutes) for a _single_ jounral provider. The sheer scale of this data coincides with the trends in increased complexity, with little further predictions rapidly increasing this total.

In an attempt to tame these large data sets, a key concept called _information_ emerged. Within modern databases, this is pronounced in the way data is organized and the relations between them. In modern formalizations, this is best represented by Knowledge Graphs, particulrly OWL and John Sowa's Conceptual Graphs. More recently, AI systems are being more deeply integrated with databases, providing an easier way for users to query accross a large amount of websites or resources at a time. However, this does not address the missing _semantic_ loss of information. Formalizations miss on the _underlying structure_ behind the data, providing a "shadow" through a model instead of the "thing itself". Additionally, research done in AI aims to provide a good "average"; the amount of fake data produced is a concern, as noted in @Romano2025SyntheticGD.

Analyzing this problem from a theoretical lens, the natural question arises: _why_ is there so much information present? Could it be _compressed_ into a smaller form? The leading two theories on the matter provide hard limitations on compression, each with their own notion of "information":

- Shannon entropy: Claude Shannon founded information theory and defined informatoin as the "reduction of uncertainty", measured in a probablistic setting.

- Kolmogorov complexity: Kolomogorov founded Algorithmic Information Theory, independently connecting Shannon's work to computability.


However, these theories lack a suitable _semantics_. These were expanded upon in Scott domains, which have been succesful in projects like Prolog. Nevertheless, there is _still_

This thesis proposes to rexamine a topic in the literature: the notion of _information_. Using the etymology in Latin, "to form", this thesis develops a formalized programming language to organize information.This provides the missing link to the _semantics_ of information, more so than labels within Knowledge Graphs or ones commonly used in AI.

Past studies have looked into using data . More recently, AI is gaining a prominent role in managing large swarthes of data.


These statistics point to an overwhelming problem: the difficulty to _organize_ this data. The state of academia provides a clear case study: *each* journal has their own formatting guidelines, often with their a custom citation style. Seeking data through manual reading is ineffec


- In mathematics,

- In the sciences, there is an estimated

The behemoth of data gives way for the need


== Goals

The aim of this thesis is to create a formalized programing language, called Welkin, derived from an archaic German word meaning "sky, heavens".
