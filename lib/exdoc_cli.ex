defmodule ExdocCLI do
  @moduledoc """
  Documentation for `Exdoc`.
  """

  use Prompt, otp_app: :exdoc_cli

  @doc false
  def main(argv), do: process(argv, [], fallback: ExdocCLI.HelpCommand)

  @doc false
  def help do
    display("help")
  end
end
