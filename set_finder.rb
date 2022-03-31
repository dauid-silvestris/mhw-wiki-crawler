require 'yaml'
require 'byebug'

data = YAML::load( File.read( 'data.yaml'))

by_type ={
    heads: data.select{ |piece| piece["Type"] == "Helm"},
    chests: data.select{ |piece| piece["Type"] == "Chest"},
    hands: data.select{ |piece| piece["Type"] == "Gloves"},
    waists: data.select{ |piece| piece["Type"] == "Waist"},
    legs: data.select{ |piece| piece["Type"] == "Legs"}
}

skills = data.map {|entry|
    entry["Skills"].map{ |e| e["Skill"]}
}.flatten.uniq

sorted_skills = skills.sort
indices = {}
skills.each_with_index{ |skill, index| indices[skill] = index}

sorted_skills.each do |skill|
    puts "[#{indices[skill]}] #{skill}"
end

target_skills = []
input = "Monster Hunter World"
while input != ""
    print "Choose Skill(0 -> #{skills.length-1} / done): "
    input = gets.chomp
    if input.to_i.to_s == input && input.to_i >= 0 && input.to_i < skills.length
        print "Enter Level: "
        value = gets.to_i
        target_skills << {skill:skills[input.to_i], value: value}
        puts "Chosen Skills: "
        target_skills.each {|skill| puts skill}
    end
end




armors = []

def intersect? a1, a2
    (a1.map{|s| s[:skill] } & 
    a2["Skills"].map{|s| s["Skill"]}).any? 
end

def calc_total pieces
    state = {}
    pieces.each do |piece|
        piece["Skills"].each do |skill|
            state[skill["Skill"]] = 0 unless state[skill["Skill"]]
            state[skill["Skill"]] += skill["Value"].to_i
        end
    end
    state
end

def verify set_skills, target_skills
    target_skills.each do |skill|
        
        return false unless set_skills[skill[:skill]]
        return false if set_skills[skill[:skill]] != skill[:value]
    end
    true
end







by_type[:heads].each do |head|
    if intersect?(target_skills, head)
        by_type[:chests].each do |chest|
            if intersect?(target_skills, chest)
                by_type[:hands].each do |hand|
                    if intersect?(target_skills, hand)
                        by_type[:waists].each do |waist|
                            if intersect?(target_skills, waist)
                                by_type[:legs].each do |leg|
                                    if intersect?(target_skills, leg)
                                        state = calc_total([head,chest,hand,waist,leg])
                                        armors << {set: [head,chest,hand,waist,leg], state: state} if verify(state, target_skills)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

def print_armor_set data
    puts ".......Set Pieces......."
    data[:set].each do |armor|
        puts armor["Name"]        
    end
    puts ".......Skills......."
    data[:state].each_pair do |key, value|
        print key.to_s + " : "
        puts value
    end
    puts "--------------"
end

puts "#{armors.length} sets found.. press enter to continue"
gets

armors.each do |armor|
    print_armor_set armor
end

puts "Possible Extra Skills"
puts "------------------"
temp = target_skills.map{|s| s[:skill]}
values = {}
armors.each do |armor|
    armor[:state].each do |key, value|
        # extra_skills << key.to_s unless temp.include? key.to_s
        values[key] = value unless values[key] && values[key] > value

    end
end
values.each_pair do |key, value|
    unless temp.include? key.to_s
        print key.to_s
        puts ": " + value.to_s
    end
end
puts values