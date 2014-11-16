module Universe
  # You must be alive
  class Life
    attr_accessor :universe

    def initialize(row, col)
      srand 42
      @universe = Array.new(row) { Array.new(col) { Cell.new } }
      @temp_universe = @universe.clone
    end

    def run
      one_step
      @temp_universe = @universe.clone
    end

    private

    def one_step
      @temp_universe.each_with_index do |vector, row|
        vector.each_with_index do |el, col|
          live = Cell.neighbours(@temp_universe, row, col)
          live == 3 && el.value == 0 && @universe[row][col].value = 1
          !(2..3).include?(live) && el.value == 1 && @universe[row][col].value = 0
        end
      end
    end
  end
end
