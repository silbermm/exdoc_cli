defmodule ExdocCLI.DefaultCommand do
  @moduledoc """

  exdoc <Module.function/airity>

  Shows the builtin documentation for the specified Module

  Available options:
    --open        Opens the Module in your $ELIXIR_EDITOR

    --help, -h    show this help message
    --version, -v show the version
  """
  use Prompt.Command
  require IEx.Helpers

  def init(args) do
    # a leftover arg is required here for the module/function name    
    topic = List.first(args.leftover, nil)
    Map.put(args, :topic, topic)
  end

  @impl true
  def process(%{help: true}), do: help()
  
  def process(%{topic: nil}) do
    display("Required argument was not provided.", color: :red)
    help()
  end

  def process(%{topic: <<":" <> erlang_module>>, open: open}) do
    IEx.configure(colors: [enabled: true])

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
    IEx.configure(colors: [enabled: true])
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
