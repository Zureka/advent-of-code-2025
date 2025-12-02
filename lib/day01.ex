defmodule Day01.Part1 do
  def solve(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parseRow/1)
    |> adjustDial(50)
  end

  defp parseRow("R" <> tail) do
    {res, _} = Integer.parse(tail)
    res
  end

  defp parseRow("L" <> tail) do
    {res, _} = Integer.parse(tail)
    res * -1
  end

  defp adjustDial(adjustments, start) do
    [num_zeros, _] =
      Enum.reduce(adjustments, [0, start], fn adj, [num_zeros, pos] ->
        pos_adj = pos + rem(adj, 100)

        cond do
          pos_adj < 0 -> [num_zeros, 100 + pos_adj]
          pos_adj > 100 -> [num_zeros, pos_adj - 100]
          pos_adj == 0 or pos_adj == 100 -> [num_zeros + 1, 0]
          true -> [num_zeros, pos_adj]
        end
      end)

    num_zeros
  end
end

defmodule Day01.Part2 do
  def solve(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parseRow/1)
    |> adjustDial(50)
  end

  defp parseRow("R" <> tail) do
    {res, _} = Integer.parse(tail)
    res
  end

  defp parseRow("L" <> tail) do
    {res, _} = Integer.parse(tail)
    res * -1
  end

  defp adjustDial(adjustments, start) do
    [count, _] =
      Enum.reduce(adjustments, [0, start], fn adj, [count, pos] ->
        remainder = rem(adj, 100)
        full_rotations = abs(div(adj, 100))

        new_pos = normalize_position(pos + remainder)

        zero_crossings =
          cond do
            new_pos == 0 && pos != 0 -> 1
            pos == 0 or new_pos == 0 -> 0
            adj > 0 && new_pos < pos -> 1
            adj < 0 && new_pos > pos -> 1
            true -> 0
          end

        [count + full_rotations + zero_crossings, new_pos]
      end)

    count
  end

  defp normalize_position(pos) do
    cond do
      pos < 0 -> 100 + pos
      pos > 100 -> pos - 100
      pos == 100 -> 0
      true -> pos
    end
  end
end

defmodule Mix.Tasks.Day01 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day01-input.txt")

    IO.puts("--- Part 1 ---")
    IO.puts(Day01.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day01.Part2.solve(input))
  end
end
