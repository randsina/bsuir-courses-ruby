require 'minitest/autorun'
require 'cell'

class TestCell < MiniTest::Unit::TestCase
  def setup
    @el = Cell.new
  end

  def test_neighbours
    assert_equal(2, @el.neighbours([[0, 0, 0], [1, 1, 1], [0, 0, 0]], 1, 1))
    assert_equal(3, @el.neighbours([[0, 0, 0], [1, 1, 1], [0, 0, 0]], 0, 1))
    assert_equal(2, @el.neighbours([[0, 0, 0], [1, 1, 1], [0, 0, 0]], 2, 0))
    refute_equal(1, @el.neighbours([[0, 0, 0], [1, 1, 1], [0, 0, 0], [0, 0, 0]], 3, 2))
  end
end
