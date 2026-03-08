// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

= Bootstrap Document <bootstrap-document>

```
#welkin,

bit <--> 0 | 1,
word <--> {} | {top --> bit, next --> word},

handle <--> {MID --> word, RID --> word, SYM --> word},

equals <--> {
  0 <--> 0,
  1 <--> 1,
  ~{0 <--> 1},

  w1 | w2 --> word,
  {w1 <--> w2} <-->
    | {w1 <--> {} <--> w2}
    | {w1.top <--> w2.top, w1.next <--> w2.next},

  h1 | h2 --> handle,
  {h1 <--> h2} <--> {
    h1.MID <--> h2.MID,
    h1.RID <--> h2.RID,
    h1.SYM <--> h2.SYM,
  }
}

unit {


}

in {


}


```
