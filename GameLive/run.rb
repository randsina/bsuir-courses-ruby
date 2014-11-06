#!/usr/bin/env ruby
require_relative 'lib/live'
require 'pry'

live = Live.new(40, 80)
loop do
  live.run
end
