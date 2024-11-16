defmodule TuringMachineTest do
  use ExUnit.Case
  doctest TuringMachine

  test "accept and return 1 when input list is empty" do
    assert TuringMachine.add_one([]) == {:q_accept, "1"}
  end

  test "halts rejecting when input is a string" do
    assert TuringMachine.add_one([1, 1, 1, "1"]) == {:q_halt}
  end

  test "halts rejecting when it is not a valid binary digit" do
    assert TuringMachine.add_one([1, 1, 1, 3]) == {:q_halt}
  end

  test "add one to a binary number" do
    assert TuringMachine.add_one([1, 1, 1, 0]) == {:q_accept, "1111"}
    assert TuringMachine.add_one([1, 0, 1, 0]) == {:q_accept, "1101"}
    assert TuringMachine.add_one([1, 1, 1, 1]) == {:q_accept, "00001"}
  end
end
