// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block
#import "template/ams-article.typ": corollary, lemma, proof, theorem
#import "template/ams-article.typ": todo

= Foundations <foundations>

To introduce our foundations, we need to ensure the language is _expressive_
enough. As an information language, the core design is to mechanize the storage
and retrieval of information, so we generally say that this must be processed as
a computable function, which is a well estalished notion. Thus, at the very
least, we must express all computable function; this is shown in
@universality-theorem.

#todo[Prove the claim for partial computable functions and IO!]
However, we need more than computable functions: we seek _clarity_ in concepts.
We need to include meaning into the symbols, so we at least need
representations. This encompasses partial computable functions as well by
modelling non-termination as a unit, as well as Input/Output mechanisms.

Given these two components, managing information with computable functions and
including representations, we argue that Welkin precisely captures anything
_representable by a computable representation_. Practically, we impose defining
things based on the _least_ restrictions. Having a _self-contained_ definition
of "anything", or a definition with _no_ restrictions, is problematic, as shown
in the introduction. But the least _practical_ restriction is precisely having
representations accepted by a computable function. This provides a best of both
worlds: the flexibility for any (reasonable) concept, and guarantees
mechanically feasible operations on representations.

Now, given that computable representations are sufficiently expressive for a
mechanical information base, a cruical inquiry is to study _how to represent
representations themselves_. At the very least, a _sign_ represents a
_referant_. #footnote[Part of our terminology and concepts originate from
  Peirce's philosophical theory of semiotics. Note that this thesis focuses on
  representing representations, though it does make some of Peirce's ideas more
  precise.
] However, this is not sufficient to express any computable function, because we
lack conditional checks. A key insight in this thesis is showing that having
these conditions is equivalent to having a general namespace mechanism.

Now, a key component of this argument, as well as our truth management system,
is proving _true_ things about computable functions. We develop the machinery
through Welkin's meta-theory. == Arithmetic

== Expressivity

