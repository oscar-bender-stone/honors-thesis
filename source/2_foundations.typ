// SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
// SPDX-License-Identifier: MIT

#import "template/ams-article.typ": definition, example, remark
#import "template/ams-article.typ": lang-def-vertical
#import "template/ams-article.typ": equation_block, lemma, proof, theorem

= Foundations <foundations>

This section develops two major components for this thesis:

- The base metatheory, which defines binary strings (as binary trees) and proofs
  for computability. We justify why this theory is reliable, based on work from
  Artemov @artemov_serial_consistency.

- The definition of a verifier, which is a computable function on binary
  strings.

== Computability

// TODO: How do we *connect* a Turing complete language *and* a language for logic
// that is Sigma^0_1 sound?
// TODO: should we bring back the idea of a formal problem and a solution?
// Might make sense.

- From intro: we formally represent something by _how we check it_.

  - Initial idea: use computable functions. _Can_ associate
  a checker to any RE set, even if we restrict these checkers, e.g., to specific
  linear time functions.

  - BUT, we want to include RE sets

    - Need UTMs! Provides a general appartus to explore _any_ RE set

    - Clear Completeness Problem: Halting Problem (decide if x in RE set)

      - Logic in Meta theory: we need _proofs_ of this. This is our verifier!
        Maybe still restrict the verifier suitably for _effective_ verification.

  - Introduce set of all RE sets and define UTMs simply. Maybe use lambda terms
    or meta-theory encoding to simplify this?

  - Problem: too many UTMs!

    - Trivial permutations: relabeling, small changes, etc.

    - How to go from one UTM to another? Lots of "bloat" is possible

  - Key inquiry: _how to effectively reuse answers to Halting_?

    - Want to separate _queries_ (straightforward) from _search_ (hard)!

    - Main solution: represent this as _information_. Show that better systems
      have _better information compression_. This IS our solution to
      organization.

  - Go back to verifier idea: we'll abstractly assume linear time, BUT for
    Welkin 64, we can impose specific bounds on _steps_. (Or, provide a demo
    verifier that can then be improved).

    - Want to use the whole input as well: represents that the _whole_ input
      matters for the query. This limits the inputs themselves: we want a
      definition of a trace that goes from initial state TO accept. In other
      words, for THAT specific trace, _each_ step is *needed*. For reject, we
      _want_ to do so early if needed.

    - Need to encode this into the meta-theory! Maybe have a further subset to
      make this easier? Can think of this as an _initial_ representation.

== Verifiers

Given a partial computable function $phi$, let $L(phi)$ be the language
recognized by $phi$.

#definition[
  An *effective verifier* is a Turing machine that runs in linear time and it
  accepts an input _must_ have read the entire input.
]

In a refined form of Kleene representability, we show that every RE set
corresponds to an effective verifier in an important way.

#lemma[
  For every RE set $S$ with recognizer $phi$, there is an effective verifier
  $V_phi$ such that $x in S$ iff there is some trace $t$ that starts with $x$
  and $t in L(V_phi)$.
]

For the rest of this thesis, all verifiers mentioned will be effective.

== Serial Soundness

- Need to established for next section!

  - _How_ do we "trust" the output of another TM? Pretty key!

  - Need to base off of meta-theory that has reliable computing base: HA

    - Stick to constructive proofs so we have an _actual_ witness; closely
      corresponds to completeness theorem

- Transition: what is information?

  - Goal: traces = SUP information needed. We can prove this, but just refer.

    - _May_ be implied by other information, but we want EXACTLY the trace
      itself.

    - NOTE: think about multiple traces. May be a SUP in a different sense
    (or we don't distingush traces for a _specific problem_ if they show x in S,
    BUT it may aid in others)

    - Want to build from this idea, that we want to _enhance_ our perception
    of information, NOT just as traces.


// TODO: connect back with computability!
// == Metatheory

// To formally define computatbility, we require a metatheory $cal(T)$ such that:

// + $cal(T)$ is equivalent to an established theory.
// + $cal(T)$ is reflective: it can prove properties about itself.
// + $cal(T)$ is straightforward to define.
// + $cal(T)$ proves only true properties about computable functions.
// + $cal(T)$ has has efficient proof checking.

// The last condition is not strictly necessary, but it does aid in verifying the
// bootstrap in @bootstrap.

// #let ZF = math.bold("ZF")
// #let PA = math.bold("PA")
// #let PA = math.bold("HA")

// We could use *Zermelo Frankel Set Theory ($ZF$)* or *Peano Arithmetic ($PA$)*
// directly, as well established first-order theories, but they have two problems.
// First, defining first-order logic is tedious, specifically free and bound
// variables. Second, recursively enumerable functions are _encoded_ into the
// theory, rather than being first class citizens. Computable functions are more
// naturally expressed in type theories, but partial functions are secondary and
// are awkward to define. By interpreting proofs as programs, under the
// Curry-Howard correspondence, non-terminating functions translate into proofs of
// inconsistency. Moreover, in more expressive type theories, like those with
// dependent types, proof checking has an extreme time complexity.

// Our solution to these issues is to build on Feferman's framework on explicit
// mathematics @feferman_logic. His work builds on two key ideas. First, separating
// partial functions from proofs is useful. Second, presenting a theory of
// computable functions is simpler with combinatory logic, which was specifically
// developed to remove involved calculations with variables. This is easier still
// using illative combinatory logic, which has useful logical constants (see
// @czajka_illative_cl).

// We will build on Feferman's framework and present _both_ levels entirely with
// combinators. The main component of this section is proving that this theory is
// equivalent to *Heyting Arithmetic (HA)*. Additionally, we build on Artemov's
// Logic of Proofs @artemov_lp for quantification, augmenting equality on terms
// with proof certificates. This enables us to discuss programs _and_ their proofs
// in the same logic, while being simpler than dependent types. Finally, we present
// our system with Hilbert proof system, which favors many axims and few rules of
// inference presents the logic with many axioms and few rules of inference. This
// enables the system to avoid contexts, which pose similar challenges as
// variables.

// #let step = math.attach(math.arrow.r, br: $1$)

// #let ICA = math.bold("ICA")
// #let Imp(x, y) = $"Imp" thin #x thin #y$
// #let pair(x, y) = $"pair" thin #x thin #y$
// #let ext = $attach(->, br: A)$

// #let vdash = math.tack

// #definition[
//   We define *Illative Combinatory Arithmetic ($ICA$)* as follows.

//   - The *language* $cal(L)_ICA$ consists of:
//     - *Constants*: $bot | 0 | "nat"$
//     - *Consequence Relation*: $vdash$
//     - *Equality*: $=$
//     - *Base Combinators*: $"K" | "S"$
//     - *Auxilary Combinators*: $"I" | "id" | "B" | "C" | "swap" | "bop"$
//     - *Pairing*: $"pair" | "fst" | "snd"$
//     - *Connectives*:
//       $"if" | "join" | "meet" | "Imp" | "A"$
//   - *Terms* are defined recursively:
//   - We add useful notation, where $X, Y, F, G$ are terms:
//     // TODO: determine best way to organize these axioms!
//     // Maybe refer to appendix for *full* list and proofs?
//     // TODO: determine if period should be outside or inside equation
//     - $"id" equiv I equiv S K K$
//     - $"swap" equiv C equiv S B B S$.
//     - $F (G X) = B F G X$, where $B equiv S (K S) K$.
//     - *Phoenix*: $"bop" equiv B(B S)B$
//     - $X -> Y equiv Imp(X, Y)$.
//     - $X ext Y equiv S (B (X -> Y))$.
//     - $(X, Y) equiv pair(X, Y)$.
//     - $(X) equiv X$.
//   - Two sets of axioms called *computational* and *logical*.
//     - *Propositional Logic*:
//       - $vdash X -> (Y -> Z)$
//       - $vdash (X -> (Y -> Z)) -> ((X -> Y) -> (Y -> Z))$
//     - *Base Combinators:*
//       - $vdash K X Y = X$
//       - $vdash S X Y Z = X Z(Y Z)$
//     - *Equality:*
//       - *Symmetry:* $vdash X = Y -> Y = X$
//       - *Transitivity:* $vdash X = Y -> ((Y = Z) -> X = Z)$
//       - *Congruence:* $vdash X = Y -> Z X = Z Y$
//       - *Application:* $vdash X = Y -> X Z = Y Z$
//     - *Quantifiers:*
//       - $vdash A(K(A X)) ext X$
//       - $vdash X -> A(K X)$
//   - One rule of inference called *Modus Ponens*: $vdash X$ and $vdash X -> Y$
//     implies $vdash Y$.
// ]

