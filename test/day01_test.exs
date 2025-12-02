defmodule Day01Test do
  use ExUnit.Case

  @example_input """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

  test "solves example input for part 1" do
    assert Day01.Part1.solve(@example_input) == 3
  end

  test "solves example input for part 2" do
    assert Day01.Part2.solve(@example_input) == 6
  end

  test "solves many right rotations around the dial" do
    input = """
    R1000
    """

    assert Day01.Part2.solve(input) == 10
  end

  test "solves many left rotations around the dial" do
    input = """
    L1000
    """

    assert Day01.Part2.solve(input) == 10
  end

  test "handles small left adjustments" do
    input = """
    L48
    L3
    """

    assert Day01.Part2.solve(input) == 1
  end

  test "handles small right adjustments" do
    input = """
    R48
    R3
    """

    assert Day01.Part2.solve(input) == 1
  end
end
