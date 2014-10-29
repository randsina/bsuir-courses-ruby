#!/usr/bin/env ruby
require 'mechanize'
require_relative 'lib/bash.rb'

count_pages = ARGV[0] ? ARGV[0].to_i : 1
site = 'http://bash.im/index/'
bash = Bash.new(site, count_pages)
bash.run
