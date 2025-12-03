defmodule Day02.Part1 do
  def solve(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(fn range ->
      [start_str, final_str] = String.split(range, "-")
      {start, _} = Integer.parse(start_str)
      {final, _} = Integer.parse(final_str)
      start..final
    end)
    |> Enum.reduce([], fn range, invalid_ids ->
      invalid_in_range =
        Enum.reduce(range, [], fn val, acc ->
          str = Integer.to_string(val)
          {first, second} = String.split_at(str, div(String.length(str), 2))

          cond do
            first == second -> [val | acc]
            true -> acc
          end
        end)

      [invalid_in_range | invalid_ids]
    end)
    |> Enum.flat_map(fn x -> x end)
    |> Enum.sum()
  end
end

defmodule Day02.Part2 do
  def solve(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(fn range ->
      [start_str, final_str] = String.split(range, "-")
      {start, _} = Integer.parse(start_str)
      {final, _} = Integer.parse(final_str)
      start..final
    end)
    |> Enum.reduce(0, fn range, total ->
      total_for_range =
        Enum.reduce(range, 0, fn val, acc ->
          str = Integer.to_string(val)

          invalid_id_sum =
            0..div(String.length(str), 2)
            |> Enum.reduce([], fn index, ids ->
              sub_str = String.slice(str, 0, index)

              cond do
                Enum.all?(String.split(str, sub_str), fn x -> x == "" end) -> [val | ids]
                true -> ids
              end
            end)
            |> Enum.uniq()
            |> Enum.sum()

          acc + invalid_id_sum
        end)

      total + total_for_range
    end)
  end
end

defmodule Mix.Tasks.Day02 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day02-input.txt")

    IO.puts("--- Part 1 ---")
    IO.puts(Day02.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day02.Part2.solve(input))
  end
end
