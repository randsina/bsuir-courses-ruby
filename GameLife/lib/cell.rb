module Universe
  # Cell for Conway's Game of Life
  class Cell
    attr_accessor :value

    def initialize(value = rand(0..1))
      @value = value if (0..1).include?(value)
    end

    def self.neighbours(universe, i, j)
      temp = 0
      temp += universe[i - 1][j - 1].value if i > 0 && j > 0
      temp += universe[i][j - 1].value if j > 0
      temp += universe[i + 1][j - 1].value if (i < universe.size - 1) && j > 0
      temp += universe[i - 1][j].value if i > 0
      temp += universe[i + 1][j].value if i < universe.size - 1
      temp += universe[i - 1][j + 1].value if i > 0 && (j < universe[0].size - 1)
      temp += universe[i][j + 1].value if j < universe[0].size - 1
      temp += universe[i + 1][j + 1].value if (i < universe.size - 1) && (j < universe[0].size - 1)
      temp
    end

    private

    def to_s
      @value == 1 ? 'O' : ' '
    end
  end
end
