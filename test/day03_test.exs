defmodule Day03Test do
  use ExUnit.Case

  @example_input """
  987654321111111
  811111111111119
  234234234234278
  818181911112111
  """

  test "solves example input for part 1" do
    assert Day03.Part1.solve("987654321111111") == 98
    assert Day03.Part1.solve("811111111111119") == 89
    assert Day03.Part1.solve("234234234234278") == 78
    assert Day03.Part1.solve("818181911112111") == 92

    assert Day03.Part1.solve(@example_input) == 357
  end

  test "solves example input for part 2" do
    assert Day03.Part2.solve("987654321111111") == 987_654_321_111
    assert Day03.Part2.solve("811111111111119") == 811_111_111_119
    assert Day03.Part2.solve("234234234234278") == 434_234_234_278
    assert Day03.Part2.solve("818181911112111") == 888_911_112_111

    assert Day03.Part2.solve(@example_input) == 3_121_910_778_619
  end
end
