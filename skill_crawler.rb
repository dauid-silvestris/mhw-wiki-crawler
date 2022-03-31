require 'nokogiri'
require 'open-uri'

url = "https://mhworld.kiranico.com/skill"
doc = Nokogiri::HTML( open(url) )

as = doc.css('.table tr td[rowspan="8"] a, .table tr td[rowspan="5"] a, .table tr td[rowspan="4"] a,  .table tr td[rowspan="6"] a, .table tr td[rowspan="2"] a')

as.each do |a|
    puts a.content
end