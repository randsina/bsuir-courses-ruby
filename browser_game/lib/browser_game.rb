class BrowserGame
  attr_reader :life, :times, :rows, :cols
  def initialize(rows, cols)
    @rows, @cols = rows.to_i, cols.to_i
    @life = Life.new(@rows, @cols)
    @times = 0
  end

  def next
    @times += 1
    @life.universe = @life.run
  end
end
