#!/usr/bin/env ruby
require 'matrix'
require_relative 'lib/live'
require 'pry'

live = Live.new(50, 50)
live.run
