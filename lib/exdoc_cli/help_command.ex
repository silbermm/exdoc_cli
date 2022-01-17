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
      strict: [help: :boolean, open: :boolean],
      aliases: [h: :help, o: :open]
    )
    |> parse()
  end

  defp parse({[help: true], _, _}), do: %{help: true}

  defp parse({opts, [topic | _], _}) do
    open = Keyword.get(opts, :open, false)
    %{help: false, topic: topic, open: open}
  end

  @doc false
  @impl true
  def help() do
    help = """
    Shows the builtin help for the specified Module.

    exdoc <Module> or <Module.function> or <Module.function/airity>

      --open, -o  Opens the Module in your $ELIXIR_EDITOR
      --help, -h  Shows this help message

    """

    display(help)
  end

  @doc false
  @impl true
  def process(%{help: true}), do: help()

  def process(%{topic: <<":" <> erlang_module>>, open: open}) do
    {last, first_part} =
      erlang_module
      |> String.split(".")
      |> List.pop_at(-1)

    if first_part == [] do
      if open do
        IEx.Helpers.open(:"#{erlang_module}")
      else
        IEx.Helpers.h(:"#{erlang_module}")
      end
    else
      help_with_airity(last, "#{Enum.join(first_part, ".")}", open)
    end
  end

  def process(%{topic: topic, open: open}) do
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
      help_with_airity(last, "Elixir.#{Enum.join(first_part, ".")}", open)
    else
      if open do
        IEx.Helpers.open(:"Elixir.#{topic}")
      else
        IEx.Helpers.h(:"Elixir.#{topic}")
      end
    end
  end

  defp help_with_airity(last_word_of_argument, first_part_of_argument, open) do
    case String.split(last_word_of_argument, "/") do
      [function_name, airity] ->
        if open do
          IEx.Helpers.open(
            {:"#{first_part_of_argument}", String.to_atom(function_name),
             String.to_integer(airity)}
          )
        else
          IEx.Helpers.h(
            {:"#{first_part_of_argument}", String.to_atom(function_name),
             String.to_integer(airity)}
          )
        end

      [function_name] ->
        if open do
          IEx.Helpers.open({:"#{first_part_of_argument}", String.to_atom(function_name)})
        else
          IEx.Helpers.h({:"#{first_part_of_argument}", String.to_atom(function_name)})
        end

      _ ->
        display("error", error: true)
    end
  end
end
