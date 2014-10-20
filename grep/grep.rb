#!/usr/bin/env ruby

require 'pry'
require "optparse"

class Grep

  def initialize
    @options = {}
    @files = []
    @directories = []

    optparse = OptionParser.new do |opts|
      opts.banner = "Usage: ./grep.rb [OPTION]... PATTERN [FILE]..."

      @options[:context] = 0
      opts.on("-A", "--context=NUM", "Print NUM lines of output context") do |option_after_context|
        @options[:context] = option_after_context
      end

      @options[:regexp] = nil
      opts.on("-e", "--regexp=PATTERN", "Use PATTERN for matching") do |option_regexp|
        @options[:regexp] = option_regexp
      end

      @options[:recursive] = nil
      opts.on("-r", "--recursive", "Recursively search PATTERN in all files in a directory") do |option_recursive|
        @options[:recursive] = option_recursive
      end

      @options[:gzipped] = nil
      opts.on("-z", "--gzipped", "Search PATTERN in compressed file") do |option_compressed|
        @options[:gzipped] = option_compressed
      end

      opts.on("-h", "--help", "Display this screen") do
        puts opts
        exit
      end
    end

    optparse.parse!

    # TODO: May save all in files directories
    # and then check flag ":recursive"
    # File.exists? or File.exist?
    if @options[:recursive]
      ARGV.map { |line| @directories.push(line) if File.directory?(line) }
      @directories.each { |dir| ARGV.delete(dir) }
    else
      ARGV.map { |line| @files.push(line) if File.file?(line) }
      @files.each { |file| ARGV.delete(file) }
    end
    # TODO: May use options[:regexp] without PATTERN
    # then @pattern = ARGV
    if @options[:regexp]
      @pattern = @options[:regexp]
    else
      @pattern = ARGV
    end
  end

  def run

    @files.each do |item|
      File.open(item, "r+") do |file|
        lines = IO.readlines(file)
        lines.each_with_index do |line, index|
          if @options[:regexp]
            reg = Regexp.new(@options[:regexp])
            line.match(reg) { |match| print_lines(lines, index) }
          elsif line.include?(@pattern.join)
            print_lines(lines, index)
          end
        end
      end
    end

  end

  def print_lines(lines, index)
    context = @options[:context].to_i
    min = index > context ? index - context : 0
    max = (lines.length - index) > context ? index + context : lines.length - 1
    (min..max).to_a.each { |pos| puts "#{lines[pos]}" }
  end

end

grep = Grep.new
grep.run
