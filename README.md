# Exdoc CLI


![](https://github.com/silbermm/exdoc_cli/workflows/Build%20and%20Test/badge.svg)
[![Hex.pm](https://img.shields.io/hexpm/v/exdoc_cli?style=flat-square)](https://hexdocs.pm/exdoc_cli/ExdocCLI.html#content)

A CLI equivilent to the IEx h/1 helper.

![Example Commands](https://raw.githubusercontent.com/silbermm/exdoc_cli/main/exdoc_usage.gif)

## Installation

Install with `mix escript.install hex exdoc_cli`

Once installed, run `exdoc <Module>`

## Examples
  * exdoc Enum
  * exdoc Enum.flat_map
  * exdoc Enum.reduce/2

## View source code

To view the source code of the module, pass the `--open` flag.

```bash
exdoc Enum.reduce/2 --open
```

This uses the $ELIXIR_EDITOR environment variable and falls back to $EDITOR if the former is not available. See [IEx.Helpers.open/1](https://github.com/elixir-lang/elixir/blob/main/lib/iex/lib/iex/helpers.ex#L251-L294) or just run `exdoc IEx.Helpers.open/1` for more info on setting up your editor.

On my system, I use [Alacritty](https://alacritty.org/) as my terminal and Vim as my editor. I've setup a tiny little executable script called `vimsh` that opens a terminal and starts vim with the specified file that looks like this:
```bash
#!/bin/bash

/usr/bin/alacritty -e vim $@
```

and my $ELIXIR_EDITOR variable is set as:
```
vimsh +__LINE__ __FILE__
```

## License
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

Copyright (C) 2022 Matt Silbernagel

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
