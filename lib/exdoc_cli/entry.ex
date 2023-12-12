defmodule ExdocCLI.Entry do
  @moduledoc """
    exdoc <Module.function/airity>

    Shows the builtin documentation for the specified Module

    Available options:
      --open        Opens the Module in your $ELIXIR_EDITOR

      --help, -h    show this help message
      --version, -v show the version
  """
  use Prompt.Router, otp_app: :exdoc_cli

  alias ExdocCLI.DefaultCommand

  command "", DefaultCommand do
    arg(:help, :boolean)
    arg(:open, :boolean, default: false)
  end
end
