#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'pry'

agent = Mechanize.new
quotes = []
reg = Regexp.new('0-9')
site = 'http://bash.im/index/'
next_page = ''

agent.get(site + next_page) do |page|
  #current_page = page.parser.css('[class="page"]').attr('value').text.to_i
  #pp current_page
  page.parser.css('div.quote').each do |quote|
    name = quote.search("[class='id']").children.text
    rating = quote.search("[class='rating-o']").children.text
    date = quote.search("[class='date']").children.text
    text = quote.search("[class='text']").children.text

    quotes << { :name => name, :rating => rating, :date => date, :text => text } unless name.empty?
  end
  #next_page = current_page - 1
  #pp next_page
end

builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
  xml.root {
    xml.Quotes {
      quotes.each do |quote|
        xml.Quote {
          xml.Name quote[:name]
          xml.Rating quote[:rating]
          xml.Date quote[:date]
          xml.Text quote[:text]
        }
      end
    }
  }
end

File.open("bash.xml", "w+") do |file|
  file.write(builder.to_xml)
end
