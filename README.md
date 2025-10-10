# Honors Thesis 2025 (Work in Progress)

**Warning**: This repository is still under development. Except breaking changes!
This will be replaced with an official message once the thesis is completed.

## Description

**Title:** Creating a Universal Formalized Information Language

**School:** University of Colorado at Boulder

**Department:** Mathematics

**Advisor:** [Keith Kearnes](kearnes@colorado.edu)

**Honors Representative:** [Nathaniel Thiem](nathaniel.thiem@colorado.edu)

Licensed under the [CC-BY-SA-4.0 license](./LICENSES/CC-BY-SA-4.0.txt).

## Available Scripts

You will need:

- [`uv`](https://github.com/astral-sh/uv): manages python tools.

- [`typst`](https://github.com/typst/typst): typsetting program for the thesis.

  - You will need the **latest version** (`0.14.0-rc.1`).
  For now, you will need [`cargo`](https://doc.rust-lang.org/cargo/getting-started/installation.html)
  and will need to run:

  `cargo install --locked typst-cli --version 0.14.0-rc.1`

### Generating Documents

- `uv run compile`: compile the thesis. Available outputs:

  - (Default): `pdf`

  - (Pandoc-based) `html`

### Compliance

- `uv run reuse lint`: confirm [REUSE](https://reuse.software/faq/) compliance.
