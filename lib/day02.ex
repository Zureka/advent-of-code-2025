defmodule Day02.Part1 do
  def solve(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.flat_map(fn range ->
      [start_str, final_str] = String.split(range, "-")
      {start, _} = Integer.parse(start_str)
      {final, _} = Integer.parse(final_str)

      Enum.filter(start..final, fn val ->
        str = Integer.to_string(val)
        {first, second} = String.split_at(str, div(String.length(str), 2))
        first == second
      end)
    end)
    |> Enum.sum()
  end
end

defmodule Day02.Part2 do
  def solve(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.flat_map(fn range ->
      [start_str, final_str] = String.split(range, "-")
      {start, _} = Integer.parse(start_str)
      {final, _} = Integer.parse(final_str)

      Enum.filter(start..final, fn val ->
        str = Integer.to_string(val)
        half_len = div(String.length(str), 2)

        0..half_len
        |> Enum.any?(fn index ->
          sub_str = String.slice(str, 0, index)
          sub_str != "" and String.split(str, sub_str, trim: true) == []
        end)
      end)
    end)
    |> Enum.sum()
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
