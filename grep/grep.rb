#!/usr/bin/env ruby

require 'pry'
require 'optparse'
require 'zlib'

class Grep

  def initialize
    @options = {}
    @files = []

    optparse = OptionParser.new do |opts|
      opts.banner = "Usage: ./grep.rb [OPTION]... PATTERN [FILE]..."

      @options[:context] = 0
      opts.on("-A", "--context=NUM", "Print NUM lines of output context") do |option_after_context|
        @options[:context] = option_after_context
      end

      @options[:regexp] = nil
      opts.on("-e", "--regexp", "Use PATTERN for matching") do |option_regexp|
        @options[:regexp] = option_regexp
      end

      @options[:recursive] = nil
      opts.on("-R", "--recursive", "Recursively search PATTERN in all files in a directory") do |option_recursive|
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

    ARGV.map { |line| @files.push(line) if File.exist?(line) }
    @files.each { |file| ARGV.delete(file) }

    @pattern = ARGV.join
  end

  def run
    @files.each do |item|
      if File.directory?(item) && @options[:recursive]
        Dir.foreach(item) { |file| open_file("#{item}/#{file}") }
      else
        open_file(item)
      end
    end

  end

  def open_file(item)
    if File.file?(item)
      File.open(item, "r+") do |file|
        if @options[:gzipped]
          gz = Zlib::GzipReader.new(file)
          lines = gz.readlines
        else
          lines = IO.readlines(file)
        end
        lines.each_with_index do |line, index|
          # TODO: rework all using REGEX
          if @options[:regexp]
            reg = Regexp.new(@pattern)
            line.match(reg) { print_lines(lines, index) }
          elsif line.include?(@pattern)
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
