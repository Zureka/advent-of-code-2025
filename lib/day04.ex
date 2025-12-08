defmodule Day04.Part1 do
  def solve(input) do
    grid = input |> String.split("\n", trim: true) |> Enum.map(&String.graphemes/1)

    grid
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_idx} ->
      row
      |> Enum.with_index()
      |> Enum.filter(fn {cell, _col_idx} -> cell == "@" end)
      |> Enum.map(fn {_cell, col_idx} ->
        count_at_neighbors(grid, row_idx, col_idx)
      end)
    end)
    |> Enum.count(fn count -> count < 4 end)
  end

  defp count_at_neighbors(grid, row, col) do
    directions = [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1}
    ]

    Enum.count(directions, fn {dr, dc} ->
      neighbor_row = row + dr
      neighbor_col = col + dc

      if neighbor_row >= 0 and neighbor_row < length(grid) and
           neighbor_col >= 0 and neighbor_col < length(Enum.at(grid, 0, [])) do
        Enum.at(grid, neighbor_row) |> Enum.at(neighbor_col) == "@"
      else
        false
      end
    end)
  end
end

defmodule Day04.Part2 do
  def solve(input) do
    grid = input |> String.split("\n", trim: true) |> Enum.map(&String.graphemes/1)
    remove_until_stable(grid, 0)
  end

  defp remove_until_stable(grid, total_removed) do
    # Find all @ cells with fewer than 4 @ neighbors
    to_remove = find_cells_to_remove(grid)

    if Enum.empty?(to_remove) do
      total_removed
    else
      # Remove all cells in this wave and recheck
      new_grid = remove_cells(grid, to_remove)
      remove_until_stable(new_grid, total_removed + length(to_remove))
    end
  end

  defp find_cells_to_remove(grid) do
    grid
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_idx} ->
      row
      |> Enum.with_index()
      |> Enum.filter(fn {cell, col_idx} ->
        cell == "@" and count_at_neighbors(grid, row_idx, col_idx) < 4
      end)
      |> Enum.map(fn {_cell, col_idx} -> {row_idx, col_idx} end)
    end)
  end

  defp remove_cells(grid, cells_to_remove) do
    cells_set = MapSet.new(cells_to_remove)

    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, row_idx} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, col_idx} ->
        if MapSet.member?(cells_set, {row_idx, col_idx}) do
          "."
        else
          cell
        end
      end)
    end)
  end

  defp count_at_neighbors(grid, row, col) do
    directions = [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1}
    ]

    Enum.count(directions, fn {dr, dc} ->
      neighbor_row = row + dr
      neighbor_col = col + dc

      if neighbor_row >= 0 and neighbor_row < length(grid) and
           neighbor_col >= 0 and neighbor_col < length(Enum.at(grid, 0, [])) do
        Enum.at(grid, neighbor_row) |> Enum.at(neighbor_col) == "@"
      else
        false
      end
    end)
  end
end

defmodule Mix.Tasks.Day04 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day04-input.txt")

    IO.puts("--- Part 1 ---")
    IO.puts(Day04.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day04.Part2.solve(input))
  end
end
