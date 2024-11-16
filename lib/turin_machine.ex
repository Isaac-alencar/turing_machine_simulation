defmodule TurinMachine do
  def add_one(tape) do
    if is_valid_input(tape) do
      {new_tape, _state} = read_tape(tape, length(tape) - 1, :q0)

      {:q_accept, Enum.reverse(new_tape) |> Enum.join("")}
    else
      {:q_halt}
    end
  end

  # Tape validations
  defp is_valid_input(tape), do: Enum.all?(tape, fn digit -> is_valid_digit(digit) end)
  defp is_valid_digit(digit) when digit in [0, 1], do: true
  defp is_valid_digit(_digit), do: false

  # Recursive function for tape processing
  defp read_tape(tape, -1, :q0), do: {[1 | tape], :q_accept}
  defp read_tape(tape, -1, :q1), do: {[1 | tape], :q_accept}

  defp read_tape(tape, q0, :q0) when q0 >= 0 do
    case Enum.at(tape, q0) do
      1 ->
        new_tape = List.replace_at(tape, q0, 0)
        read_tape(new_tape, q0 - 1, :q1)

      0 ->
        new_tape = List.replace_at(tape, q0, 1)
        {new_tape, :q_accept}

      _ ->
        {:q_halt, tape}
    end
  end

  # When carry reaches end of tape, add 1 bit to the left
  defp read_tape(tape, q0, :q1) when q0 >= 0 do
    case Enum.at(tape, q0) do
      1 ->
        new_tape = List.replace_at(tape, q0, 0)
        read_tape(new_tape, q0 - 1, :q1)

      0 ->
        new_tape = List.replace_at(tape, q0, 1)
        {new_tape, :q_accept}

      _ ->
        {:q_halt, tape}
    end
  end
end
