// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Bootstrap <bootstrap>

// TODO: decide soon whether to include proofs IN the bootstrap!
// Definitely need to finsih those soon, if so
This section proves that there is a file, which we call `weklin.welkin`, that
contains enough information to _represent_ Welkin. We do not bootstrap proofs in
this thesis, but that could easily be a future extension.


== Self-Contained Standard

This section is self-contained and defines _everything_ necessary about Welkin.
The complete bootstrap is in appendix ?.


// TODO: emphasize that Welkin is
// homo-iconic, similar to lisp!
// Very powerful!
#let bootstrap-text = ```
#welkin,

radix {
  bit --> 0 | 1,
  digit --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 ,
  nibble --> decimal | A | B | C | D | E | F,
}

word {
  @radix,
    . --> binary | decimal | hex,
    binary --> bit | binary.bit,
    decimal --> digit | decimal.digit,
    hex --> nibble | hex.nibble,
    {
      {w, w', w''} --> binary,
      (w.w').w'' <--> w.(w'.w'')
    },
    {
      {w, w', w''} --> decimal,
      (w.w').w'' <--> w.(w'.w'')
    },
    {
      {w, w', w''} --> hex,
      (w.w').w'' <--> w.(w'.w'')
    }
}

US-ASCII {

}

grammar {
  @word,
}

```
