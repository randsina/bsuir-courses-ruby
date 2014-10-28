#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'optparse'
require_relative 'lib/bash.rb'

count_pages = ARGV[0].to_i
count_pages ||= 1
site = 'http://bash.im/index/'
bash = Bash.new(site, count_pages)
bash.run
