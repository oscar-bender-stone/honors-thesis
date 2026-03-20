# Honors Thesis 2025 (Work in Progress)

**Warning**: This repository is still under development. Except breaking
changes! This will be replaced with an official message once the thesis is
completed.

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

Note that only PDF is supported, but HTML export will eventually be added.

- Compile the thesis: `just compile`.

- Compile while editing: `just watch`.

### Compliance

- `just reuse-lint`: confirm [REUSE](https://reuse.software/faq/) compliance.
