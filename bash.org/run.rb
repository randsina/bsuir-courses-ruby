#!/usr/bin/env ruby
require 'mechanize'
require_relative 'lib/bash'

count_pages = ARGV.empty? ?  1 : ARGV[0].to_i
site = 'http://bash.im/index/'
bash = Bash.new(site, count_pages)
bash.run
