require_relative 'cell'

# You must be alive
class Life
  def initialize(row, col)
    @row = row
    @col = col
    @universe = Array.new(row) { Array.new(col) { Cell.new }}
    @temp_universe = @universe.clone
    print_universe
  end

  def run
    loop do
      one_step
      @temp_universe = @universe.clone
      puts "\e[H\e[2J" # system "clear"
      print_universe
      sleep 0.2
    end
  end

  private

  def one_step
    @temp_universe.each_with_index do |vector, row|
      vector.each_with_index do |el, col|
        live = el.neighbours(@temp_universe, row, col)
        live == 3 && el.to_i == 0 && @universe[row][col].value = 1
        !(2..3).include?(live) && el.to_i == 1 && @universe[row][col].value = 0
      end
    end
  end

  def print_universe
    @universe.each do |vector|
      vector.each do |el|
        print el
      end
      print "\n"
    end
  end
end
