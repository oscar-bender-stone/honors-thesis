// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Bootstrap Document: `welkin.welkin` <bootstrap-document>

```
@welkin,

epsilon,
bit := 0 | 1,
word := epsilon | {top --> bit, next --> word},

handle := {ID --> word},

unit := {
  . --> {},
  *{u, v, c} --> .,
  . --> {u, v} | {u - c -> v}
}

part := {
  u | v --> .unit,
  u --> {u, v},
  ~{{u, v} --> u},
  {u, ~v} --> u,
  ~{u --> {u, ~v}},
}

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

verify {
  query { context, goal },
  derivation,

  derivation - verify -> query,
}

draft,

encoding {


}

characters {



}


character_classes {


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
}

grammar {

}

information {

}


```
