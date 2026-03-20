# SPDX-FileCopyrightText: Oscar Bender-Stone <oscar-bender-stone@protonmail.com>
# SPDX-License-Identifier: MIT

default := "thesis"

compile document=default:
    typst compile 'source/{{document}}/index.typ' 'document/{{document}}.pdf' --font-path ./source/fonts

watch document=default:
    typst watch 'source/{{document}}/index.typ' 'document/{{document}}.pdf' --font-path ./source/fonts

reuse-lint:
    reuse lint
