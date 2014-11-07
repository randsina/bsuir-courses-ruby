#!/usr/bin/env ruby
require_relative 'lib/life'
require_relative 'lib/cell'

life = Life.new(20, 40)
life.run
