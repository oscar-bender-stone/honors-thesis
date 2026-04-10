# Honors Thesis 2025-2026

## Description

**Title:** Creating a Universal Formalized Information Language

**School:** University of Colorado at Boulder

**Department:** Mathematics

**Advisor:** [Keith Kearnes](kearnes@colorado.edu)

**Honors Representative:** [Nathaniel Thiem](nathaniel.thiem@colorado.edu)

**Outside Reader:** [Gowtham Kaki](gowtham.kaki@colorado.edu)

The thesis **and** presentation are licensed under the
[CC-BY-SA-4.0 license](./LICENSES/CC-BY-SA-4.0.txt).

## Available Scripts

You will need:

- [`typst` (0.14.2)](https://typst.app/open-source/#download): typsetting
  program for the thesis.

- [`just`](https://search.brave.com/search?q=rust+just+tool) for running
  commands.

### Generating Documents

Note that only PDF is supported.

- Thesis:
  - Compile: `just compile`
  - Compile while editing: `just watch`

- Presentation
  - Compile: `just compile presentation`
  - Compile while editing: `just watch presentation`

### Compliance

- Confirm [REUSE](https://reuse.software) compilance: `just reuse-lint`.
