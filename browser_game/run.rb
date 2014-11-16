require 'pry'
require 'sinatra'
require 'shotgun'
require 'haml'
require 'slim'

Dir[File.expand_path("lib/*.rb")].each { |f| require f }
include Universe

use Rack::Session::Pool
set :haml, :format => :html5

ROWS = 10
COLS = 20

# TODO: use options from command line as template (erb, haml, slim)

get '/' do
  haml 'haml/index'.to_sym
end

post '/' do
  return start if params[:start] || params[:reset]
  return next_step if params[:next_step] && session[:browser_game]
  haml 'haml/index'.to_sym
end

def start
  session.clear
  @browser_game = BrowserGame.new(params[:rows], params[:columns])
  session[:browser_game] = @browser_game
  haml 'haml/index'.to_sym
end

def next_step
  @browser_game = session[:browser_game]
  @browser_game.next
  haml 'haml/index'.to_sym
end
