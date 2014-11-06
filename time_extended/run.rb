#!/usr/bin/env ruby

require 'date'
require 'time_extended'

p DateTime.now.ymd                            # => "14 11 06"
p DateTime.now.Bd                             # => "November 06"
p DateTime.now.M3N                            # => "51 963"
p DateTime.now.c                              # => "Thu Nov  6 00:49:50 2014"
d = DateTime.new(2007, 11, 19, 8, 37, 48, '-06:00')
p d.v                                         # => "19-Nov-2007"
