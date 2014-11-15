require 'pry'
require 'sinatra'
require 'shotgun'

Dir[File.expand_path("lib/*.rb")].each { |f| require f }

include Universe

class BrowserGame
  attr_reader :universe, :times, :rows, :cols
  def initialize(rows = 10, cols = 20)
    @rows, @cols = rows, cols
    @life = Life.new(rows, cols)
    @times = 0
  end

  def next
    @universe = @life.run
    @times += 1
  end
end


get '/' do
  @browser_game = BrowserGame.new
  @browser_game.next
  # binding.pry
  erb :index
end
