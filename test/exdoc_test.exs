defmodule ExdocTest do
  use ExUnit.Case
  doctest Exdoc

  test "greets the world" do
    assert Exdoc.hello() == :world
  end
end
