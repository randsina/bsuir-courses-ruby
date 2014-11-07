# Cell for Conway's Game of Life
class Cell
  attr_accessor :value
  def initialize
    @value = rand(0..1)
  end

  def neighbours(universe, i, j)
    temp = 0
    temp += universe[i - 1][j - 1].to_i if i > 0 && j > 0
    temp += universe[i][j - 1].to_i if j > 0
    temp += universe[i + 1][j - 1].to_i if (i < universe.size - 1) && j > 0
    temp += universe[i - 1][j].to_i if i > 0
    temp += universe[i + 1][j].to_i if i < universe.size - 1
    temp += universe[i - 1][j + 1].to_i if i > 0 && (j < universe[0].size - 1)
    temp += universe[i][j + 1].to_i if j < universe[0].size - 1
    temp += universe[i + 1][j + 1].to_i if (i < universe.size - 1) && (j < universe[0].size - 1)
    temp
  end

  def to_s
    @value == 1 ? '*' : ' '
  end

  def to_i
    @value
  end
end
