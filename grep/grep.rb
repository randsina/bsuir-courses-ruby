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

      opts.on("-A", "--context=NUM", "Print NUM lines of output context") do |option_after_context|
        @options[:context] = option_after_context
      end

      opts.on("-e", "--regexp=PATTERN", "Use PATTERN for matching") do |option_regexp|
        @options[:regexp] = option_regexp
      end

      opts.on("-r", "--recursive", "Recursively search PATTERN in all files in a directory") do |option_recursive|
        @options[:recursive] = option_recursive
      end

      opts.on("-z", "--gzipped", "Search PATTERN in compressed file") do |option_compressed|
        @options[:gzipped] = option_compressed
      end

      opts.on("-h", "--help", "Display this screen") do
        puts opts
        exit
      end
    end

    optparse.parse!

    if @options[:recursive]
      ARGV.map { |line| @directories.push(line) if File.directory?(line) }
      @directories.each { |dir| ARGV.delete(dir) }
    else
      ARGV.map { |line| @files.push(line) if File.file?(line) }
      @files.each { |file| ARGV.delete(file) }
    end

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
        lines.map { |line| puts "#{line}" if line.include?(@pattern.join) }
      end
    end

  end


end

grep = Grep.new
grep.run
