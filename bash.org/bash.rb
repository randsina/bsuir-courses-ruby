#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'

agent = Mechanize.new

quotes = []
agent.get('http://bash.im') do |page|
  page.links_with(:text => /#/).each do |link|
    #link.click

    name = link.text
    rating = agent.get(link.click).search("[@class='rating-o']").children.text
    date = agent.get(link).search("[@class='date']").children.text
    text = agent.get(link).search("[@class='text']").children.text
    p name
    quote = { :name => name, :rating => rating, :date => date, :text => text }
    quotes << quote
    #p quotes
  end
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
puts builder.to_xml

File.open("bash.xml", "w+") do |file|
  file.write(builder.to_xml)
end
