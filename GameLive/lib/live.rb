# You must be alive
class Live
  def initialize(row, col)
    @row = row
    @col = col
    @universe = Array.new(row) { Array.new(col) }#[[1, 0, 1, 1, 0], [1, 0, 0, 0, 0], [0, 0, 0, 0, 0], [1, 0, 0, 1, 1], [0, 0, 1, 0, 0]] #

    fill_array
    @temp_universe = Array.new(row) { Array.new(col) }
    reinit
  end

  def fill_array
    @universe.each_index do |row|
      @universe[row].each_index do |col|
        @universe[row][col] = rand(0..1)
      end
      p @universe[row]
      # binding.pry
    end
  end

  def run
    print_universe
    one_step
    sleep 0.1
    reinit
    puts "\e[H\e[2J"
    #binding.pry
    run

  end

  def one_step
    @temp_universe.each_with_index do |vector, row|
      # p temp_universe[row]
      vector.each_with_index do |el, col|
        live = round(row, col)
        # p live
        # binding.pry
        if live == 3 && el == 0
          @universe[row][col] = 1
        end
        if !(2..3).include?(live) && el == 1
          @universe[row][col] = 0
        end
      end
    end
  end

  def reinit
    @universe.each_with_index { |vector, row| vector.each_with_index { |el, col| @temp_universe[row][col] = el } }
  end

  def round(i, j)
    temp = 0
    temp += @temp_universe[i - 1][j - 1] if i > 0 && j > 0
    temp += @temp_universe[i][j - 1] if j > 0
    temp += @temp_universe[i + 1][j - 1] if (i < @col - 1) && j > 0
    temp += @temp_universe[i - 1][j] if i > 0
    temp += @temp_universe[i + 1][j] if (i < @col - 1)
    temp += @temp_universe[i - 1][j + 1] if i > 0 && (j < @row - 1)
    temp += @temp_universe[i][j + 1] if (j < @row - 1)
    temp += @temp_universe[i + 1][j + 1] if (i < @col - 1) && (j < @row - 1)
    temp
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
