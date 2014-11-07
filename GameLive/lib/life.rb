# You must be alive
class Life
  def initialize(row, col)
    @row = row
    @col = col
    @universe = Array.new(row) { Array.new(col) { rand(0..1) }}
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
        live = round(row, col)
        live == 3 && el == 0 && @universe[row][col] = 1
        !(2..3).include?(live) && el == 1 && @universe[row][col] = 0
      end
    end
  end

  def round(i, j)
    temp = 0
    temp += @temp_universe[i - 1][j - 1] if i > 0 && j > 0
    temp += @temp_universe[i][j - 1] if j > 0
    temp += @temp_universe[i + 1][j - 1] if (i < @temp_universe.size - 1) && j > 0
    temp += @temp_universe[i - 1][j] if i > 0
    temp += @temp_universe[i + 1][j] if i < @temp_universe.size - 1
    temp += @temp_universe[i - 1][j + 1] if i > 0 && (j < @temp_universe[0].size - 1)
    temp += @temp_universe[i][j + 1] if j < @temp_universe[0].size - 1
    temp += @temp_universe[i + 1][j + 1] if (i < @temp_universe.size - 1) && (j < @temp_universe[0].size - 1)
  end

  def print_universe
    @universe.each do |vector|
      vector.each do |el|
        print '*' if el == 1
        print ' ' if el == 0
      end
      print "\n"
    end
  end
end
