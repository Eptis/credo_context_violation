defmodule ContextViolationTest do
  use ExUnit.Case
  doctest ContextViolation

  test "greets the world" do
    assert ContextViolation.hello() == :world
  end
end
