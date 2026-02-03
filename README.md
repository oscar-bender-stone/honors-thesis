# Honors Thesis 2025 (Work in Progress)

**Warning**: This repository is still under development. Except breaking changes!
This will be replaced with an official message once the thesis is completed.

## Description

**Title:** Creating a Universal Formalized Information Language

**School:** University of Colorado at Boulder

**Department:** Mathematics

**Advisor:** [Keith Kearnes](kearnes@colorado.edu)

**Honors Representative:** [Nathaniel Thiem](nathaniel.thiem@colorado.edu)

**Outside Reader:** [Gowtham Kaki][gowtham.kaki@colorado.edu]

Licensed under the [CC-BY-SA-4.0 license](./LICENSES/CC-BY-SA-4.0.txt).

## Available Scripts

You will need:

- A Python package manager. (Recommended: [`uv`](https://docs.astral.sh/uv/getting-started/installation/)).

- [`typst` (0.14.2)](https://typst.app/open-source/#download): typsetting program for the thesis.


### Generating Documents

- Compile the thesis: `just compile`. Available outputs:

  - (Default): `pdf`

  - (Pandoc-based): `html`

### Compliance

- `just reuse-lint`: confirm [REUSE](https://reuse.software/faq/) compliance.
