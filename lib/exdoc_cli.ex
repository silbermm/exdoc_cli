# Exdoc CLI - Commandline tool for showing Elixir Docs
# Copyright (C) 2022 Matt Silbernagel
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
defmodule ExdocCLI do
  @moduledoc """
  A CLI equivilent to the IEx h/1 helper.

  ## Installation

  Install with `mix escript.install hex exdoc_cli`

  > #### ASDF {: .info}
  >
  > If you installed Elixir with asdf, be sure to run 
  > `asdf reshim elixir`


  Once installed, run
  ```
  exdoc <Module>
  ```

  ## Examples

  ```bash
  $ exdoc Enum
  $ exdoc Enum.flat_map
  $ exdoc Enum.reduce/2
  $ exdoc :ets.new/2 --open
  ``` 
  """
end
