require 'nokogiri'
require 'yaml'
require 'byebug'
require 'open-uri'


url = "https://mhworld.kiranico.com/decoration"

doc = Nokogiri::HTML( open(url) )

tds = doc.css("table td:first-of-type")


decorations = []

tds.each do |td|
    name = td.css("div").text
    skill = td.css("a").text
    decorations << {name:name, skill:skill}
end

byebug

File.write("decorations.yaml", decorations.to_yaml)