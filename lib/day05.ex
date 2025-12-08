defmodule Day05.Part1 do
  def solve(input) do
    [ranges, ids] = String.split(input, "\n\n", trim: true)

    id_ranges =
      ranges
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [start_str, end_str] = String.split(line, "-", trim: true)
        {String.to_integer(start_str), String.to_integer(end_str)}
      end)

    ids
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn id_str, acc ->
      id = String.to_integer(id_str)

      cond do
        Enum.any?(id_ranges, fn {id_start, id_end} ->
          id >= id_start and id <= id_end
        end) ->
          acc + 1

        true ->
          acc
      end
    end)
  end
end

defmodule Day05.Part2 do
  def solve(input) do
    [ranges, ids] = String.split(input, "\n\n", trim: true)

    id_ranges =
      ranges
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [start_str, end_str] = String.split(line, "-", trim: true)
        {String.to_integer(start_str), String.to_integer(end_str)}
      end)
      |> Enum.sort()

    merged_ranges = merge_ranges(id_ranges)

    merged_ranges
    |> Enum.map(fn {id_start, id_end} -> id_end - id_start + 1 end)
    |> Enum.sum()
  end

  defp merge_ranges([]), do: []

  defp merge_ranges([first | rest]) do
    merge_ranges(rest, [first])
  end

  defp merge_ranges([], acc), do: Enum.reverse(acc)

  defp merge_ranges([{start, end_pos} | rest], [{acc_start, acc_end} | acc_tail]) do
    cond do
      start <= acc_end ->
        merge_ranges(rest, [{acc_start, max(end_pos, acc_end)} | acc_tail])

      true ->
        merge_ranges(rest, [{start, end_pos}, {acc_start, acc_end} | acc_tail])
    end
  end
end

defmodule Mix.Tasks.Day05 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day05-input.txt")

    IO.puts("--- Part 1 ---")
    IO.puts(Day05.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day05.Part2.solve(input))
  end
end
