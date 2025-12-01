defmodule Day06Test do
  use ExUnit.Case

  @example_input """
  """

  @tag :skip
  test "solves example input for part 1" do
    assert Day06.Part1.solve(@example_input) == 288
  end

  @tag :skip
  test "solves example input for part 2" do
    assert Day06.Part2.solve(@example_input) == 71503
  end
end
