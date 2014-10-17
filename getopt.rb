#!/usr/bin/ruby
require "optparse"

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: grep [OPTION]... PATTERN [FILE]..."

  opts.on("-h", "--help", "Display this screen") do #|option_help|
    #options[:help] = option_help
    puts opts
    exit
  end
  
  opts.on("-A", "--after-context=NUM", "Print NUM lines of trailing context") do |option_after_context|
    options[:after_context] = option_after_context
  end

end

optparse.parse!

#puts "Help options: #{options[:help]}" if options[:help]
#puts "After context options: #{options[:after_context]}" if options[:after_context]
puts "#{options}"
