defmodule ExdocCLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest ExdocCLI

  test "shows help message" do
    assert capture_io("", fn ->
             result = ExdocCLI.main(["--help"])
             assert result == 0
           end) =~ "exdoc <Module.function/airity>"
  end

  test "shows version" do
    assert capture_io("", fn ->
             result = ExdocCLI.main(["--version"])
             assert result == 0
           end) =~ "0.1.2"
  end

  test "shows Enum.map docs" do
    assert capture_io("", fn ->
             _ = ExdocCLI.main(["Enum.map/2"])
           end) =~ "Enum.map"
  end
end
