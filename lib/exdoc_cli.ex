defmodule ExdocCLI do
  @moduledoc """
  Documentation for `Exdoc`.
  """

  use Prompt, otp_app: :exdoc_cli

  @help_txt """

    exdoc <Module.function/airity>  

    Shows the builtin documentation for the specified Module

    Available options:
      --help, -h    show this help message
      --version, -v show the version
  """

  @doc false
  def main(argv), do: process(argv, [], fallback: ExdocCLI.HelpCommand)

  @doc false
  def help do
    display(@help_txt)
  end

  def help(:empty) do
    display("""

    An argument is required. Make sure to pass in the name of a module.

    Examples:

      exdoc Enum
      exdoc Enum.map
      exdoc Enum.map/2
    """)
  end
end
