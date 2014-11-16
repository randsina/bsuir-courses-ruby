require 'pry'
require 'sinatra'
require 'shotgun'

Dir[File.expand_path("lib/*.rb")].each { |f| require f }
include Universe

use Rack::Session::Pool

ROWS = 10
COLS = 20

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
  erb :index
end

def next_step
  @browser_game = session[:browser_game]
  @browser_game.next
  erb :index
end
