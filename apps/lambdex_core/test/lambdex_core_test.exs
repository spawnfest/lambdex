defmodule LambdexCoreTest do
  use ExUnit.Case
  doctest LambdexCore

  test "greets the world" do
    assert LambdexCore.hello() == :world
  end
end
