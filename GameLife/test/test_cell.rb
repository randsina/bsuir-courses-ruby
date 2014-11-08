require 'minitest/autorun'
require 'cell'

include Universe

class TestCell < MiniTest::Test
  def setup
    @universe =
      [
        [ Cell.new(0), Cell.new(0), Cell.new(0) ],
        [ Cell.new(1), Cell.new(1), Cell.new(1) ],
        [ Cell.new(0), Cell.new(0), Cell.new(0) ],
        [ Cell.new(0), Cell.new(0), Cell.new(0) ]
      ]
  end

  def test_neighbours
    assert_equal(2, Cell.neighbours(@universe, 1, 1))
    assert_equal(3, Cell.neighbours(@universe, 0, 1))
    assert_equal(2, Cell.neighbours(@universe, 2, 0))
    refute_equal(1, Cell.neighbours(@universe, 3, 2))
  end
end
