# SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
# SPDX-License-Identifier: MIT

compile:
    typst compile source/thesis/index.typ document/thesis.pdf --font-path ./source/fonts

watch:
    typst watch source/thesis/index.typ document/thesis.pdf --font-path ./source/fonts

reuse-lint:
    reuse lint
