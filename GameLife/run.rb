#!/usr/bin/env ruby
require_relative 'lib/life'
require_relative 'lib/cell'

include Universe

life = Life.new(30, 60)
life.run
