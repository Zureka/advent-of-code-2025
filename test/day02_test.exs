defmodule Day02Test do
  use ExUnit.Case

  @example_input """
  """

  @tag :skip
  test "solves example input for part 1" do
    assert Day02.Part1.solve(@example_input) == 8
  end

  @tag :skip
  test "solves example input for part 2" do
    assert Day02.Part2.solve(@example_input) == 2286
  end
end
