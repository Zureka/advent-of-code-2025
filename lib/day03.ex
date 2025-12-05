defmodule Day03.Part1 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn bank ->
      batteries = String.split(bank, "", trim: true)

      for i <- 0..(length(batteries) - 2),
          j <- (i + 1)..(length(batteries) - 1) do
        String.to_integer(Enum.at(batteries, i) <> Enum.at(batteries, j))
      end
      |> Enum.max()
    end)
    |> Enum.sum()
  end
end

defmodule Day03.Part2 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&process_bank_v2(&1, 0, 12))
    |> Enum.map(fn val -> val |> Integer.parse() |> elem(0) end)
    |> Enum.sum()
  end

  defp process_bank_v2(bank, index, 1) do
    bank
    |> String.slice(index..-1//1)
    |> String.graphemes()
    |> Enum.max()
  end

  defp process_bank_v2(bank, index, num_chars_left) do
    bank_length = String.length(bank)
    batteries = String.graphemes(bank)

    {max_val, max_index} =
      Enum.slice(batteries, index..(bank_length - 1))
      |> Enum.with_index(index)
      |> Enum.filter(fn {_, i} -> i + num_chars_left <= bank_length end)
      |> Enum.max_by(fn {val, _} -> val end, fn -> {"0", index} end)

    max_val <> process_bank_v2(bank, max_index + 1, num_chars_left - 1)
  end
end

defmodule Mix.Tasks.Day03 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day03-input.txt")

    IO.puts("--- Part 1 ---")
    IO.puts(Day03.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day03.Part2.solve(input))
  end
end
