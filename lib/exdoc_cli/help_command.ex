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
defmodule ExdocCLI.HelpCommand do
  @moduledoc false

  use Prompt.Command
  require IEx.Helpers

  @impl true
  @doc false
  def init(argv) do
    argv
    |> OptionParser.parse(
      strict: [help: :boolean],
      aliases: [h: :help]
    )
    |> parse()
  end

  defp parse({[help: true], _, _}), do: %{help: true}
  defp parse({_opts, [topic | _], _}), do: %{help: false, topic: topic}
  defp parse(), do: %{help: true}

  @doc false
  @impl true
  def help() do
    help = """
    exdoc <Module.function/airity>

    Shows the builtin help for the specified Module
    """

    display(help)
  end

  @doc false
  @impl true
  def process(%{help: true}), do: help()

  def process(%{topic: <<":" <> erlang_module>>}) do
    {last, first_part} =
      erlang_module
      |> String.split(".")
      |> List.pop_at(-1)

    if first_part == [] do
      IEx.Helpers.h(:"#{erlang_module}")
    else
      help_with_airity(last, "#{Enum.join(first_part, ".")}")
    end
  end

  def process(%{topic: topic}) do
    {last, first_part} =
      topic
      |> String.split(".")
      |> List.pop_at(-1)

    # is the last part a function name ?
    first_letter = String.first(last)

    if first_letter == String.downcase(first_letter) do
      # yes it is
      # is the airity passed in?
      # "Elixir.#{Enum.join(first_part, ".")}"
      help_with_airity(last, "Elixir.#{Enum.join(first_part, ".")}")
    else
      # not a function name 
      IEx.Helpers.h(:"Elixir.#{topic}")
    end
  end

  defp help_with_airity(last_word_of_argument, first_part_of_argument) do
    case String.split(last_word_of_argument, "/") do
      [function_name, airity] ->
        IEx.Helpers.h(
          {:"#{first_part_of_argument}", String.to_atom(function_name), String.to_integer(airity)}
        )

      [function_name] ->
        IEx.Helpers.h({:"#{first_part_of_argument}", String.to_atom(function_name)})

      _ ->
        display("error", error: true)
    end
  end
end
