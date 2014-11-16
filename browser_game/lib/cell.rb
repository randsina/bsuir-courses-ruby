module Universe
  # Cell for Conway's Game of Life
  class Cell
    NEIGHBOURS = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]

    attr_accessor :value
    def initialize(value = rand(0..1))
      @value = value if (0..1).include?(value)
    end

    def self.neighbours(universe, i, j)
      NEIGHBOURS.inject(0) do |sum, pos|
        sum + universe[(i + pos[0]) % universe.size][(j + pos[1]) % universe[0].size].value
      end
    end

    private

    def to_s
      @value == 1 ? 'o' : ' '
    end
  end
end
