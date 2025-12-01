defmodule Day04Test do
  use ExUnit.Case

  @example_input """
  """

  @tag :skip
  test "solves example input for part 1" do
    assert Day04.Part1.solve(@example_input) == 13
  end

  @tag :skip
  test "solves example input for part 2" do
    assert Day04.Part2.solve(@example_input) == 30
  end
end
