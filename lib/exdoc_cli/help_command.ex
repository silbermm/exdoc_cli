defmodule ExdocCLI.HelpCommand do
  @moduledoc """
  exdoc Module.function

  Show help for the specified command
  """

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

  @doc false
  @impl true
  def process(%{help: true}) do
    IO.inspect("HELP")
  end

  def process(%{topic: topic}) do
    # TODO: take last segment with period if it is lowercase
    # TODO: find airity if passed in
    [module | others] = String.split(topic, ".")
    split_airity(module, others)
  end

  defp split_airity(module, []), do: IEx.Helpers.h(:"Elixir.#{module}")
end
