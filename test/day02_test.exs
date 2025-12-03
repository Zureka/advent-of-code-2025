defmodule Day02Test do
  use ExUnit.Case

  @example_input """
  11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
  """

  test "solves example input for part 1" do
    assert Day02.Part1.solve(@example_input) == 1227775554
  end

  test "solves example input for part 2" do
    assert Day02.Part2.solve(@example_input) == 4174379265
  end

  test "part 2 small example" do
    input = """
    11-22
    """
    assert Day02.Part2.solve(input) == 33
  end
end
