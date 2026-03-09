// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Bootstrap Document: `welkin.welkin` <bootstrap-document>

```
#welkin,

bit <--> 0 | 1,
word <--> {} | {top --> bit, next --> word},

handle <--> {ID --> word},

equals <--> {
  0 <--> 0,
  1 <--> 1,
  ~{0 <--> 1},

  w1 | w2 --> word,
  {w1 <--> w2} <-->
    | {w1 <--> {} <--> w2}
    | {w1.top <--> w2.top, w1.next <--> w2.next},

  h1 | h2 --> handle,
  {h1 <--> h2} <--> {h1.ID <--> h2.ID},
}

unit {
  {} --> .,
  u | v | c --> .,
  @u --> .,
  {u, v} --> .,

  import_block <-->
    | {}
    | @u
    | {import_block, ~v}
    | {~v, import_block},
  import_block --> .,

  {u - c -> v} --> .,
}

part {
  u | v --> .unit,
  u --> {@u, v},
  ~{{@u, v} --> u},
  {@u, ~v} --> u,
  ~{u --> {@u, ~v}},
}

verify {
  query { context | goal --> ..unit },
  derivation --> .unit,

  derivation - verify -> query,
}

encoding {


}


codec <--> {
  parse --> unit,
  print --> unit,

  {s --> input, u --> unit, ~{s - parse -> {}}} -->
  {
    {s - parse -> u}
    <-->
    {u - print -> s}
  }
},

characters {


}

grammar {

}

information {

}


compress {


}

```
