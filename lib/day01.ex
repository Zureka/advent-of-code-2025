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
        pos_adj = pos + rem(adj, 100)
        num_passes = abs(div(adj, 100))

        new_pos =
          cond do
            pos_adj < 0 -> 100 + pos_adj
            pos_adj > 100 -> pos_adj - 100
            pos_adj == 100 -> 0
            true -> pos_adj
          end

        crossed_zero =
          cond do
            pos == 0 or new_pos == 0 -> false
            adj > 0 && new_pos < pos -> true
            adj < 0 && new_pos > pos -> true
            true -> false
          end

        new_count =
          cond do
            new_pos == 0 && pos != 0 -> count + num_passes + 1
            crossed_zero -> count + num_passes + 1
            true -> count + num_passes
          end

        [new_count, new_pos]
      end)

    count
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
