#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'pry'
require_relative 'lib/bash.rb'

count_pages = 10
site = 'http://bash.im/index/'
bash = Bash.new(site, count_pages)
bash.run
