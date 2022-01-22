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
           end) =~ "0.1.4-pre"
  end

  test "shows Enum.map/2 docs" do
    assert capture_io("", fn ->
             _ = ExdocCLI.main(["Enum.map/2"])
           end) =~ "Enum.map"
  end

  test "shows Enum.map docs" do
    assert capture_io("", fn ->
             _ = ExdocCLI.main(["Enum.map"])
           end) =~ "Enum.map"
  end

  test "shows erlang module docs" do
    assert capture_io("", fn ->
             _ = ExdocCLI.main([":ets"])
           end) =~ ":ets"
  end

  test "shows erlang module function docs" do
    assert capture_io("", fn ->
             _ = ExdocCLI.main([":ets.new"])
           end) =~ "new(name, options)"
  end

  test "shows erlang module function airity docs" do
    assert capture_io("", fn ->
             _ = ExdocCLI.main([":ets.new/2"])
           end) =~ "new(name, options)"
  end
end
