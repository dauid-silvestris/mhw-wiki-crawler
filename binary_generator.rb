require 'yaml'
require 'byebug'
# File.open( "test.dat", "wb") do |file|
#     file.write( [-1].pack("C") )
# end

data = YAML::load(File.read("new_data.yaml"))

skills = data.map {|entry|
    entry["Skills"].map{ |e| e["Skill"]}
}.flatten.uniq

skill_map = []

File.open("skills.h", "w+") do |file|
    
    skills.each_with_index do |skill, index|
        file.puts( skill.upcase.gsub(" ", "_").gsub("/", "_").gsub("'","")+ "," )
        skill_map << skill
    end
end

data = data[53], data[54]

class File
    # def write_int byte
    #     write([byte.to_i].pack("C"))
    # end
    
    def write_int int
        write([int.to_i].pack("L"))
    end
end

types = {
    "Helm" => 0,
    "Chest" => 1,
    "Gloves" => 2,
    "Waist" => 3,
    "Legs" => 4
}

File.open("test.dat", "wb") do |file|
    file.write_int(data.length)
    data.each do |entry|
        file.write_int(entry["ID"])
        file.write_int(types[entry["Type"]])
        file.write_int(entry["Rarity"])
        file.write_int(entry["Defense"])
        file.write_int(entry["Fire"])
        file.write_int(entry["Ice"])
        file.write_int(entry["Thunder"])
        file.write_int(entry["Water"])
        file.write_int(entry["Dragon"])
        file.write_int(entry["Skills"].length)
        entry["Skills"].each do |skill|
            file.write_int(skill_map.index(skill["Skill"]))
            file.write_int(skill["Value"])
        end
    end
end



# - Set: King Beetle Alpha Set
# Type: Waist
# Name: King Beetle Elytra Alpha
# Defense: 42 ～ 0
# Rarity: '5'
# Slots: 
# - 1
# Fire: "-1"
# Water: "-1"
# Thunder: "+2"
# Ice: '0'
# Dragon: "+2"
# Skills:
# - Skill: Honey Hunter
#   Value: "+1"
# - Skill: Quick Sheath
#   Value: "+1"
# ID: 53
