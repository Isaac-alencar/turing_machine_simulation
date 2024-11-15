defmodule TurinMachineTest do
  use ExUnit.Case
  doctest TurinMachine

  test "greets the world" do
    assert TurinMachine.hello() == :world
  end
end
