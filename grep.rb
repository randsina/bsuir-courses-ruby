#!/usr/bin/env ruby

require 'pry'

class Grep

  def initialize(arguments)
    if arguments.length == 2
      @file = arguments.pop
      @pattern = arguments
      @options
    else
      @file = arguments.pop
      @pattern = arguments.pop
      @options = arguments
    end
    @pattern = @pattern.join if @pattern.is_a?(Array)
    puts "options #{@options}"
    puts "pattern #{@pattern}"
    puts "file #{@file}"
  end

  def run
    File.open(@file, "r+") do |file|
      lines = IO.readlines(file)
      lines.map do |line|
        # binding.pry
        if line.include? @pattern
           puts "#{line}"
        end
      end
    end
  end


end

grep = Grep.new(ARGV)
grep.run
