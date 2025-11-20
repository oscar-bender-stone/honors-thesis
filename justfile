# SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
# SPDX-License-Identifier: MIT

compile:
    typst compile source/0_index.typ document/thesis.pdf

watch:
    typst watch source/0_index.typ document/thesis.pdf
