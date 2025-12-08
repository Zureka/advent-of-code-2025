defmodule Day05Test do
  use ExUnit.Case

  @example_input """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  test "solves example input for part 1" do
    assert Day05.Part1.solve(@example_input) == 3
  end

  test "solves example input for part 2" do
    assert Day05.Part2.solve(@example_input) == 14
  end
end
