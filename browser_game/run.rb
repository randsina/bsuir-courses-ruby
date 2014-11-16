require 'pry'
require 'sinatra'
require 'shotgun'

Dir[File.expand_path("lib/*.rb")].each { |f| require f }

use Rack::Session::Pool

include Universe
ROWS = 10
COLS = 20

class BrowserGame
  attr_reader :life, :times, :rows, :cols
  def initialize(rows = ROWS, cols = COLS)
    @rows, @cols = rows.to_i, cols.to_i
    @life = Life.new(@rows, @cols)
    @times = 0
  end

  def next
    @times += 1
    @life.universe = @life.run
  end
end

get '/' do
  erb :index
end

post '/' do
  return start if params[:start] || params[:reset]
  return next_step if params[:next_step] && session[:browser_game]
  erb :index
end

def start
  session.clear
  @browser_game = BrowserGame.new(params[:rows], params[:columns])
  session[:browser_game] = @browser_game
  erb :start
end

def next_step
  @browser_game = session[:browser_game]
  @browser_game.next
  erb :start
end
