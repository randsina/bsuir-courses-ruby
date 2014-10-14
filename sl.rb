#!/usr/bin/env ruby

require 'matrix'
require 'terminfo'

class Pacman
  TIME = 0.1

  def initialize(file_pacman)
    @file_pacman = file_pacman
  end

  def start
    pacman_lines = File.readlines(@file_pacman)
    array = []
    pacman_lines.each { |line| array.push(line) }
    length = TermInfo.screen_size[1]
    length.times do
      system "clear"
      puts array
      array.map do |line|
        line.insert(0," ")
        line.chop! unless line.length < length
      end
      sleep(TIME)
    end
  end
end

pacman = Pacman.new("pacman.txt")
pacman.start
