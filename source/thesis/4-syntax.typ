// SPDX-FileCopyrightText: 2026 Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": corollary, lemma, theorem
#import "template/ams-article.typ": proof
#import "us-ascii.typ": printable-ascii-table

#show sym.emptyset: math.diameter

= Syntax <syntax>

This section examines the grammar for Welkin and provides validation rules. For
specific sections, consult @syntax:overview.

#figure(
  table(
    columns: (20%, 25%, 55%),
    align: left,
    table.header([*Section Number*], [*Title*], [*Description*]),
    [*@syntax:encoding*], [*Encoding*], [Introduces the encoding for Welkin.],

    [*@syntax:invertible-descriptions*],
    [*Invertible #linebreak(justify: true) Syntax #linebreak(justify: true)
    Descriptions*],
    [Defines invertible syntax descriptions, the fundamental building blocks for
      the grammar.],

    [*@syntax:strings-and-ids*],
    [*Strings and IDs*],
    [Defines the syntax for strings and IDs.],

    [*@syntax:welkin-grammar*],
    [*The Welkin #linebreak() Grammar*],
    [Presents the Welkin grammar, defining which strings are syntactically
      allowed.],

    [*@syntax:proof-unambiguous*],
    [*Proof of #linebreak() Unambiguity*],
    [Proves that the Welkin grammar is unambiguous.],

    [*@syntax:validation-and-transforms*],
    [*Validation and Transforms*],
    [Defines which strings are *valid*, as well as transforms on certain
      constructs.],
  ),
  caption: [Overview of @syntax.],
)<syntax:overview>

To make specific characters clearer, we write syntactic features in
`type-writer font`.

== Encoding <syntax:encoding>

Welkin uses ASCII as its base encoding. The term ASCII is slightly ambiguous, as
there are subtly distinct variants. To address this problem, we formally define
US-ASCII as a standard version. We define the encoding through *bytes*, which
are words with of eight bits. We provide the codes for each character in decimal
and hexadecimal. Note that the conversion into binary words, as directly used in
Welkin, is straightforward. Each code is assigned to a unique symbol called a
*glyph*.

#figure(
  printable-ascii-table(),
  caption: [Printable US-ASCII codes and glyphs.],
)<syntax:printable-ascii-codes>

#definition[
  Welkin's encoding consists of *Printable US-ASCII*, listed in
  @syntax:printable-ascii-codes, as well as character `EOF`, with code 127. An
  *ASCII string* is the concatenation of bytes, each of which correspond to a
  character in the encoding.#footnote[Note that this table _itself_ is a
    representation, which represents glyphs with binary words.] The last byte
  must end with the code for `EOF`.
]<syntax:encoding-strings>

Moreover, we will need to define *character classes*, or important sets of
characters. These are presented in @syntax:character-classes, with each
character separated by |. Note that strings _may_ contain quotes prefixed with a
slash `\`, refer to @syntax:string.

#figure(
  table(
    columns: (auto, auto),
    align: center,
    table.header([*Set Name*], [*Characters*]),
    [`PRINTABLE`], [Listed in @syntax:printable-ascii-codes],

    [`WHITESPACE`], [`\t` | `\r` | Space ],
    [`DELIMITER`], [`{` | `}` | `'` | `"` | `.` | `,`],
    [`RESERVED`], [`DELIMITER` | `*` | `@`],
    [`SQ_CHAR`], [Any `PRINTABLE` character except `'` and `\`],
    [`DQ_CHAR`], [Any `PRINTABLE` character except `"` and `\`],
    [`ID_CHAR`], [Any `PRINTABLE` character not in `RESERVED` or `WHITESPACE`],
  ),
  caption: [Definitions of key character classes. Each class is denoted in
    `UPPERCASE`.],
)<syntax:character-classes>

== Invertible Syntax Descriptions <syntax:invertible-descriptions>

To more easily describe the language, we provide basic building blocks. Our
approach is based on _parser combinators_, which are functions that take other
parsers as input. We augment these combinators using *invertible syntax
descriptions*, first introduced in @invertible-syntax-descriptions. Here, an
*invertible syntax description* is a pair of functions:
- A *Parser*, converts strings into an intermediate data structure.#footnote[For
    computer scientists: this is an AST. Because this thesis aims to have a
    broader audience, we leave details to @invertible-syntax-descriptions.
  ] We say the parser _consumes_ a string.
- A *Printer*, the reverse of Parser.

Invertible syntax descriptions are used to enable easier formatting. This helps
users more seamlessly switch between a string and the underlying unit. Specific
details are provided in @invertible-syntax-descriptions.

For our use case, we will need four invertible syntax descriptions. These are
based on functions from `parsec`, a Haskell combinator parser library. Here, `A`
and `B` denote meta-variables over syntax descriptions. Parsing `A` means
applying the parser in `A`, and likewise, printing `A` means printing the
corresponding rule. Additionally, `WS` is short-hand for `WHITESPACE`
(@syntax:character-classes).

- `A - seq -> B`:
  - *Parser:* Consumes a string based on `A`. immediately followed by the rule
    `B`. Notice that _no_ `WS` characters are allowed.
  - *Printer:* prints the string `AB`.
- `A - lexeme -> B`:
  - *Parser:* Consumes a string based on `A`. then accepts any number of
    `WHITESPACE` characters, and finally consumes the input based on `B`.
  - *Printer:* first prints `A`, then zero or more `WS` characters, then `B`.
    whitespaces.
- `A - seq_many_till -> B`:
  - *Parser:* Consumes a string based on `A` zero more times, _until_ the input
    is accepted by the rule `B`. Note that the end marker `B` supports
    unambiguous parsing.
  - *Printer:* prints `A*B`, where `A*` is zero or more instances of `A`.
- `A - lex_many_till -> B`:
  - *Parser:* Consumes a string based on `A` _and_ optional whitespace zero more
    times, _until_ the input is accepted by the rule `B`. Note that the end
    marker `B` supports unambiguous parsing.
  - *Printer:* prints zero or more instances of `A` _with_ optional whitespace,
    followed by `B`.

Additionally, the parsers above are allowed to have sets of characters called
*tokens*. We assume these follow the "maximal munch" principle: the entire token
must be consumed _before_ processing other rules. This helps to simplify the
grammar.

== Strings and IDs <syntax:strings-and-ids>

Strings are defined in @syntax:string, and they allow escaped single or double
quotes. Note that, semantically, single and double quoted strings are
equivalent, consult @syntax:validation-and-transforms.

#figure(
  ```
  STRING := SQ_STRING | DQ_STRING,
  SQ_STRING := "'" - seq -> *{SQ_CHAR, "\'"} - seq_many_till -> "'",
  DQ_STRING := '"' - seq -> *{DQ_CHAR, '\"'} - seq_many_till -> '"',
  ```,
  caption: "Strings.",
)<syntax:string>

IDs are defined in @syntax:id. These are special strings do not require quotes
but forbid whitespace and certain characters. This comparison is reinforced in
@syntax:validation-and-transforms.

#figure(
  ```
  ID := ID_CHAR - seq_many_till -> *{RESERVED, WHITESPACE}
  ```,
  caption: "Syntactic definition of an ID.",
)<syntax:id>

== The Welkin Grammar <syntax:welkin-grammar>

Welkin's grammar is displayed in @syntax:figure-welkin-grammar, inspired by
several languages.

- The binding operator `:=` is inspired by functional languages, emphasizing how
  Welkin is immutable. Moreover, choices can be written via `|`, which
  _themselves_ can include definitions.

- The import system is inspired by Python. Additionally, `*u` is a concept
  borrowed from Python, which gets the contents of a tuple.#footnote[The grammar
    rule `trailer` is also inspired by Python. The Python grammar is available
    at:
    #link("https://docs.python.org/3/reference/grammar.html")]

#let grammar = ```
start := units - lexeme -> EOF,

units := "" | {unit - lexeme -> *{"", "," - lexeme -> units}},

unit := node - lexeme -> *{
  ":=" - lexeme -> choices,
  *{"", arc - lexeme -> chain}
},
choices := *{"", "|"} - lexeme -> choices_list,
choices_list := *{"",
  chain - lexeme -> *{"", "|" - lexeme -> choice_list}
},
chain := *{"", "*"} - seq -> path - lexeme -> *{"", arc - lexeme -> chain},

arc := right_arc | other_arc,
right_arc := "-" - seq -> node - seq -> "->",
other_arc := "<-" - seq -> node - seq -> *{"-", "->"},

node := *{"", "*"} - seq -> path,
path := *{"", modifiers} - seq -> trailer - seq -> *{"", graph},
modifiers := *{
  "@",
  "~" - seq -> *{"", "@"}
},
trailer := HANDLE - seq -> *{"", "." - seq -> trailer},
graph :=  "{" - lexeme -> units - lexeme -> "}",

HANDLE := ID | STRING,

STRING := SQ_STRING | DQ_STRING,
SQ_STRING := "'" - seq -> *{SQ_CHAR, "\'"} - seq_many_till -> "'",
DQ_STRING := '"' - seq -> *{DQ_CHAR, '\"'} - seq_many_till -> '"',

ID := ID_CHAR - seq_many_till -> *{RESERVED, WHITESPACE}
```
#figure(
  grammar,
  caption: [The complete grammar for Welkin. This includes the rules `STRING`
    and `ID`, which are also provided in @syntax:string and @syntax:id,
    respectively.],
)<syntax:figure-welkin-grammar>

== Validation and Transformations <syntax:validation-and-transforms>

Due to time constraints, this section of the thesis is given at a higher level
than intended. These details may change in the final revision of the language.

We say a string is *valid* if it is accepted by the grammar
(@syntax:figure-welkin-grammar), and the following hold:

- The number of dots (relative import) used must not exceed the number of levels
  available.

- There must be at least one path that starts with `@h`, where `h` is some
  handle. This is used to name the module.

- For all paths that start with `@h1` and `@h2`, respectively, `h1` must be
  equal to `h2`.

- Every definition of a unit must only be stated once. This means
  `u := v, u:= w` is not allowed.

- Accessing a unit $v$ from $u$ requires that $u$ has a closed definition
  containing $v$. This means `u := {v, w}, u.x` is not valid, and neither is
  `u.x` alone.

We leave error handling for future work, described in @conclusion.

Additionally, we define transformation rules after parsing:

- Some node that starts with `@` is found. This marks the module name. Denote
  this name as $m$.

- If `\'` appears in a single quoted string, then this will be replaced by `'`
  in the final contents. For example, given a string `"John\'s dog"`, the
  contents would be `John's dog`.

- A similar rule applies for `"` but with `\"`.

- Double slashes `\\` are converted into one slash `\`.

- Single and double quoted strings are represent each other. For example,
  `'hello' <--> "hello"`. In fact, IDs are special cases of strings, so
  `hello <--> 'hello'`. Practically, the only difference is that units forbid
  `WHITESPACE` or `RESERVED` characters, but they can be written without quotes.

- Paths are resolved, determined where the unit originated. For example, in
  `a, c := {.a, b}`, the `.a` inside `c` would be expanded as `a`.

- Each `*u` for a handle or graph `u` expands to all the members in the enclosed
  unit. If `u` contains a at most one item or is a representation, then `*u` is
  expanded as `u`. Multiple `*`, such as `**u`, recursively expands the contents
  in a unit.

- Each definition `x := a1 | ... | an` expands to
  `x <--> {x - x -> a1, ..., b - x -> an}`. For each graph `a1`, the generated
  graph will contain `v - x -> v`, where `v` is a handle or representation in
  `a1`.

- Each `~x` expands to `x - g -> {}`, where `g` is the name where `~x` is
  placed. At the highest level, this would be the module name, $m$.

== Proof of Unambiguity <syntax:proof-unambiguous>

We show that, by construction, the combinators we used form an $"LL"(1)$
grammar. These grammars have two desirable properties:
- If a string is accepted, it is parsed unambiguously.
- Efficient parsers can be easily and efficiently implemented
  @compilers-dragon-book[Sect. 4.4.3].

Our approach is to based converting the combinators in
@invertible-syntax-descriptions to an algebraic from, based on a paper by
Edelmann, Hamza, and Kunčak @edelmann-ll1-parsing. These authors define create
an algebra on parsing combinators, used to define a combinator form of
$"LL"(1)$. In this algebra, two natural operations are disjunction $A or B$,
which behaves exactly like $A | B$ in our notation, and $A dot B$, which
represents concatenation. Additionally, the algebra includes rules with _exit
variables_, or rules of the form #box[$x mapsto (A dot x) dot B$]. Using
recursion in $x$, these track when a parser still consumes an $A$, _or_
encounters a $B$. For example, we can define a parser that takes in zero or more
whitespaces: #box[$"WS*" equiv w mapsto ("WS" dot w) or epsilon$]. We heavily
use exit variables in the conversions, provided in @syntax:original-to-edelmann.
For more details on the algebraic rules, refer to @edelmann-ll1-parsing[Sect.
  3].

#figure(
  table(
    columns: (auto, auto),
    table.header([*Original*], [*Algebraic Form*]),
    [$A - "seq" -> B$], [$A dot B$],
    [$A - "lexeme" -> B$], [$A dot ("WS""*" dot B)$],
    [$A - "seq_many_till" -> B$], [$x mapsto (A dot x) or B$],
    [$A - "lex_many_till" -> B$], [$x mapsto ((A dot "WS*") dot x) or B$],
    [$C := A | B$], [$C equiv A or B$],
    [$"*"{A, B}$], [$A or B$],
    [$"*"{epsilon, B}$], [$epsilon or B$],
  ),
  caption: [Conversions of parser combinators into the algebra defined by
    @edelmann-ll1-parsing.],
)<syntax:original-to-edelmann>

Next, we need to define properties of combinators, provided below. Note that
$emptyset$ denotes the empty set, $f in F$ denotes that $f$ is an element of
$F$, and $F union E$ denotes the union of sets $F$ and $E$.
#let NULLABLE = math.text("NULLABLE")
#let FIRST = math.text("FIRST")
#let FOLLOW = math.text("FOLLOW")
#let SNFOLLOW = math.text("SN-FOLLOW")

#definition[
  (@edelmann-ll1-parsing). Let $A, B$ be meta-variables for parser combinators .
  Moreover, let $t$ be a meta-variable for a simple combinator, one which
  consumes a single token. The following properties on parsing combinators are
  defined recursively:

  - $NULLABLE$: returns a boolean, checking whether a combinator matches
    $epsilon$. We say a combinator is *nullable* if this check returns true.
    - $NULLABLE(epsilon) = "True"$.
    - $NULLABLE(t) = "False"$.
    - $NULLABLE(A | B) = NULLABLE(A) "or" NULLABLE(B)$.
    - $NULLABLE(A B) = NULLABLE(A) "and" NULLABLE(B)$.
  - $FIRST$: gathers the first character in a combinator.
    - $FIRST(epsilon) = emptyset$.
    - $FIRST(t) = {t}$.
    - $FIRST(A | B) = FIRST(A) union FIRST(B)$.
    - $FIRST(A dot B) = FIRST(A) union FIRST(B) "if" NULLABLE(A) "else" FIRST(A)$.
  - $SNFOLLOW$: this set stands for "should not follow". It is used to locally
    detect ambiguities.
    #footnote[A note for computer scientists: this is a _new_ $"LL"(1)$ related
      set, replacing the usual $"FOLLOW"$ set. This change is needed because
      parsing combinators are built bottom-up; they do not access a global
      parsing context. For details, consult @edelmann-ll1-parsing.
    ]
    - $SNFOLLOW(epsilon) = emptyset$
    - $SNFOLLOW(t) = emptyset$
    - $SNFOLLOW(A | B) = SNFOLLOW(A) union SNFOLLOW(B) "if" NULLABLE(A) "else" emptyset$.
    - $SNFOLLOW(A dot B) = SNFOLLOW(B) union (SNFOLLOW(A) union FIRST(B) "if" NULLABLE(B) "else" emptyset)$
]

Using these properties, we are now ready to define $"LL"(1)$ grammars. Without
loss of generality, we assume the set of parser combinators contains rules
strictly of the form $A | B$, $A dot B$, or $x mapsto (A dot x) or B$. We will
implicitly use this form when examining the proof for the Welkin grammar.
#definition[(@edelmann-ll1-parsing[Sect. 4.5]). A set $P$ of parsing combinators
  is $"LL"(1)$ if and only if, for all $A$ and $B$:
  - For any rule $A | B in P$, at most $A$ or $B$ are nullable, and $FIRST(A)$
    and $FIRST(B)$ are disjoint.
  - For any rule $A dot B in P$, $SNFOLLOW(A) inter FIRST(B) = emptyset$. In
    other words, the set of characters that locally follow $A$ must be disjoint
    with the characters starting in $B$.
  - In any recursive expression $x mapsto (A dot x) or B$, $A$ is not nullable.
]<syntax:LL1>

Finally, we conclude this section with the proof the Welkin grammar is
$"LL"(1)$.

#theorem[
  The Welkin grammar (provided in @syntax:figure-welkin-grammar) is $"LL"(1)$,
  and is therefore unambiguous.
]<syntax:LL1-proof>
#proof[
  We proceed by checking the necessary conditions. First, we need to confirm
  that in any rule of the form $A | B$, $"*"{A, B}$, at least $A$ or $B$ are not
  nullable. This is clear upon inspection.

  Second, we check that, in all recursive rules of the form
  $x mapsto (A dot x) or B$, $A$ is not nullable. This, too, evidently holds:
  every rule in @syntax:welkin-grammar based on $"seq_many_till"$ and
  $"lex_many_till"$ starts with at least one character. Thus, these rules have
  an $A$ that is not nullable.

  Third, we must confirm that certain pairs of sets are disjoint, based on
  @syntax:LL1 and @syntax:original-to-edelmann. More precisely:
  - For each rule $A | B$ or $"*"{A, B}$, we need to confirm $FIRST(A)$ and
    $FIRST(B)$ are disjoint.
  - For each rule $A - "seq" -> B$ or $A - "lexeme" -> B$, we need to confirm
    $SNFOLLOW(A)$ and $FIRST(B)$ are disjoint.

  We demonstrate these conditions hold in @syntax:LL1-calculations. To conserve
  space, each subrule is assigned an $"ID"$, and may be used in other subrules.
  We exclude easy cases, including `HANDLE`, or which start with a unique
  character. Moreover, any rule of the form `*{"", A}` clearly has disjoint
  $FIRST$ sets, so we exclude most of these in @syntax:LL1-calculations.

  With each of these properties satisfied, this proves that
  @syntax:figure-welkin-grammar is $"LL"(1)$. Thus, as all $"LL"(1)$ grammars
  are unambiguous by construction, so is the Welkin grammar.

  #figure(
    [
      #show table.cell: set text(size: 0.85em)
      #table(
        columns: (auto, auto, auto),
        table.header([*ID*], [*Rule*], [*Subrule* ($A$ op $B$)]),
        [[1]], [`units`], [ `unit` $dot$ `*{"", "," - lexeme -> units}` ],
        [[2]],
        [`unit`],
        [ `node` $dot$ `*{ ":=" - lexeme -> choices, *{...} }` ],

        [[3]],
        [`unit`],
        [ `":=" - lexeme -> choices` $|$ `*{"", arc - lexeme -> chain}` ],

        [[4]], [`choices`], [ `*{"", "|"}` $dot$ `choice_list` ],
        [[5]],
        [`choice_list`],
        [ `chain` $dot$ `*{"", "|" - lexeme -> choice_list}` ],

        [[6]], [`chain`], [ `node` $dot$ `*{"", arc - lexeme -> chain}` ],
        [[7]], [`arc`], [ `right_arc` $|$ `other_arc` ],
        [[8]], [`right_arc`], [ `"-" - seq -> node` $dot$ `"->"` ],
        [[9]], [`other_arc`], [ `"<-" - seq -> node` $dot$ `*{"-", "->"}` ],
        [[10]], [`node`], [ `*{"", "*"}` $dot$ `path` ],
        [[11]], [`path`], [ `*{"", modifiers}` $dot$ `trailer` ],
        [[12]], [`path`], [ `trailer` $dot$ `*{"", graph}` ],
        [[13]], [`trailer`], [ `HANDLE` $dot$ `*{"", "." - seq -> trailer}` ],
        [[14]], [`modifiers`], [ `"@"` $|$ `"~"` $dot$ `*{"", "@"}` ],
      )],
    caption: [IDs provided for each key subrule in the Welkin grammar
      (@syntax:figure-welkin-grammar). Each subrule either has the form
      $A dot B$ or $A | B$.],
  )<syntax:LL1-subrule-IDs>

  // 1. Define the two-line expressions to save space
  #let sf-fb = [$"SNFOLLOW"(A)$ \ $inter "FIRST"(B)$]
  #let fa-fb = [$"FIRST"(A)$ \ $inter "FIRST"(B)$]

  // 2. Automate the set formatting (handles raw backticks and commas automatically)
  #let fmt-set(items) = {
    if items.len() == 0 {
      [$emptyset$] // If empty array, return the empty set symbol
    } else {
      // Join items with a comma and space, allowing Typst to naturally line-break here
      [\{ ] + items.map(it => raw(it)).join([, ]) + [ \}]
    }
  }

  // 3. Define the raw data for the table
  // Format: (ID, Expression, Left-hand side, Array of A tokens, Array of B tokens)
  #let data = (
    (
      1,
      sf-fb,
      [$"SNFOLLOW"("unit") =$],
      (".", "{", "-", "<-", "|", "*", "@", "~", "ID", "STRING", ":="),
      (",",),
    ),
    (2, sf-fb, [$"SNFOLLOW"("node") =$], (".", "{"), (":=", "-", "<-")),
    (3, fa-fb, [$"FIRST"(A) =$], (":=",), ("-", "<-")),
    (4, sf-fb, [$"SNFOLLOW"(A) =$], (), ("*", "@", "~", "ID", "STRING")),
    (5, sf-fb, [$"SNFOLLOW"("chain") =$], (".", "{", "-", "<-"), ("|",)),
    (6, sf-fb, [$"SNFOLLOW"("node") =$], (".", "{"), ("-", "<-")),
    (7, fa-fb, [$"FIRST"(A) =$], ("-",), ("<-",)),
    (8, sf-fb, [$"SNFOLLOW"("node") =$], (".", "{"), ("->",)),
    (9, sf-fb, [$"SNFOLLOW"("node") =$], (".", "{"), ("-", "->")),
    (10, sf-fb, [$"SNFOLLOW"(A) =$], (), ("@", "~", "ID", "STRING")),
    (11, sf-fb, [$"SNFOLLOW"(A) =$], ("@",), ("ID", "STRING")),
    (12, sf-fb, [$"SNFOLLOW"("trailer") =$], (".",), ("{",)),
    (13, sf-fb, [$"SNFOLLOW"("HANDLE") =$], (), (".",)),
    (14, fa-fb, [$"FIRST"(A) =$], ("@",), ("~",)),
  )

  // 4. Generate the table dynamically
  #let calculations-table = [
    #show table.cell: set text(size: 0.85em)
    #table(
      columns: (auto, auto, 2fr, 1.5fr, auto),
      align: left,
      [*ID*],
      [*Expression*],
      [*Set for* $A$],
      [*Set for* $B$],
      [*Intersection*],

      // Loop through the data and flatten it into table cells
      ..data
        .map(row => (
          [\[#row.at(0)\]],
          row.at(1),
          // Use #box to prevent the left-hand side from ever breaking onto two lines,
          // but append a space so the set itself can wrap to the next line safely!
          box(row.at(2)) + [ ] + fmt-set(row.at(3)),
          fmt-set(row.at(4)),
          [$emptyset$],
        ))
        .flatten(),
    )
  ]


  #figure(
    calculations-table,
    caption: [Calculations used to detect the presence of potential conflicts.
      Subrules are given by their IDs, provided in @syntax:LL1-subrule-IDs.],
  )<syntax:LL1-calculations>
]



