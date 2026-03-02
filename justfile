# SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
# SPDX-License-Identifier: MIT

compile:
    typst compile source/index.typ document/thesis.pdf --root . --font-path ./source/fonts

watch:
    typst watch source/index.typ document/thesis.pdf --root . --font-path ./source/fonts

reuse-lint:
    reuse lint
