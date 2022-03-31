require 'nokogiri'
require 'yaml'
require 'byebug'
require 'open-uri'

url = "https://mhworld.kiranico.com/charm"

doc = Nokogiri::HTML( open(url) )

trs = doc.css("table tr")

charms = []

trs.each do |tr|
    tds = tr.css("td")
    name = tds[0].text
    skill = tds[1].css("a").text
    charms << {name: name, skill: skill}
end

byebug

File.write("charms.yaml", charms.to_yaml)