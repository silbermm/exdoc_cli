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
  defp parse(), do: %{}

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
      case String.split(last, "/") do
        [function_name, airity] ->
          IEx.Helpers.h(
            {:"Elixir.#{Enum.join(first_part, ".")}", String.to_atom(function_name),
             String.to_integer(airity)}
          )

        [function_name] ->
          IEx.Helpers.h({:"Elixir.#{Enum.join(first_part, ".")}", String.to_atom(function_name)})

        _ ->
          display("error", error: true)
      end
    else
      # not a function name 
      IEx.Helpers.h(:"Elixir.#{topic}")
    end
  end
end
