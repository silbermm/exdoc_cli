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

  use Prompt, otp_app: :exdoc_cli

  @help_txt """

    exdoc <Module.function/airity>

    Shows the builtin documentation for the specified Module

    Available options:
      --open        Opens the Module in your $ELIXIR_EDITOR

      --help, -h    show this help message
      --version, -v show the version
  """

  @doc false
  def main(argv) do
    # enables the colors in output
    IEx.configure(colors: [enabled: true])
    process(argv, [], fallback: ExdocCLI.HelpCommand)
  end

  @doc false
  def help do
    display(@help_txt)
  end

  def help(:empty) do
    display("""

    An argument is required. Make sure to pass in the name of a module.

    Examples:

      exdoc Enum
      exdoc Enum.map/2
      exdoc :ets --open
    """)
  end
end
