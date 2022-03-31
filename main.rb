require 'nokogiri'
require 'open-uri'
require 'yaml'

armor_pieces = []
HELM=0
CHEST=1
GLOVES=2
WAIST=3
LEGS=4

piece_types = {
    HELM => "Helm",
    CHEST => "Chest",
    GLOVES => "Gloves",
    WAIST => "Waist",
    LEGS => "Legs"
}


base_url = "https://mhworld.kiranico.com/armor"
doc = Nokogiri::HTML( open(base_url) )
cards = doc.css("#rank-2 .card")
# card = cards[-13]
cards.each do |card|
    set_name = card.css("h5").first.content
    links = card.css(".col-sm-7 tr a")

    links.each_with_index do |link, index| 
        piece = {"Set" => set_name, "Type" => piece_types[index]}


        piece_doc = Nokogiri::HTML( open(link["href"]) )
        piece_name = piece_doc.css(".col-lg-9 > .card:first-of-type h1").first.content

        piece["Name"] = piece_name
        def_info = piece_doc.css(".col-lg-9 > .card:first-of-type .lead")[0]

        defense = def_info.content

        piece["Defense"] = defense

        slot_info = piece_doc.css(".col-lg-9 > .card:first-of-type .lead")[1]
        slots = []
        slot_info.css("i").each do |i|
            klass = i["class"]
            next if klass.include?("zmdi-minus")
            slots << 1 if klass.include?("zmdi-n-1-square")
            slots << 2 if klass.include?("zmdi-n-2-square")
            slots << 3 if klass.include?("zmdi-n-3-square")
        end

        rarity_info = piece_doc.css(".col-lg-9 > .card:first-of-type .lead")[4]
        rarity = rarity_info.content

        piece["Rarity"] = rarity

        piece["Slots"] = slots

        divs = piece_doc.css(".col-lg-9 >.no-gutters > div")
        res_info = divs[0]

        res_info.css("tr").each do |tr|
            tds = tr.css("td")
            res = tds[0].content.to_s.gsub("Vs. ", "")
            value = tds[1].content
            piece[res] = value
        end
        skill_info = divs[1]

        piece["Skills"] = []
        skill_info.css("tr"). each do |tr|
            tds = tr.css("td")
            skill = tds[0].content
            value = tds[1].content

            piece["Skills"] << {"Skill" => skill, "Value" => value}
        end

        piece["Slots"] = slots
        
        armor_pieces << piece

    end

end

File.write("data.yaml", armor_pieces.to_yaml)
