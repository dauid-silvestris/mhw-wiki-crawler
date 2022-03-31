require 'sqlite3'
require 'yaml'

types = {
    "Helm" => 0,
    "Chest" => 1,
    "Gloves" => 2,
    "Waist" => 3,
    "Legs" => 4
}

db = SQLite3::Database.new('db/mhw.db')
data = YAML::load( File.read( 'data.yaml'))

db.results_as_hash = true
skills = db.execute("SELECT * FROM skills")

data.each do |armor|

    query = "INSERT INTO armors('name', 'set', 'type', 'defense', 'fire_res', 'water_res', 'ice_res', 'thunder_res', 'dragon_res', 'rarity', 'slot1', 'slot2', 'slot3') VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)"
    slots1 = armor["Slots"].select{ |slot| slot == 1}.count
    slots2 = armor["Slots"].select{ |slot| slot == 2}.count
    slots3 = armor["Slots"].select{ |slot| slot == 3}.count
    data = [armor["Name"], armor["Set"], types[armor["Type"]], armor["Defense"].to_i, armor["Fire"].to_i, armor["Water"].to_i, armor["Ice"].to_i, armor["Thunder"].to_i, armor["Dragon"].to_i, armor["Rarity"], slots1, slots2, slots3 ]

    db.execute(query, data)
    armor_id = db.execute("SELECT id FROM armors WHERE name=?", armor["Name"]).first["id"].to_i
    sleep 0.1
    armor["Skills"].each do |skill|
        skill_id = skills.detect{ |s| s["name"] == skill["Skill"]}

        if skill_id.nil?
            p skill
            print "Enter ID: "
            skill_id = gets.to_i
            skills << ["id" => skill_id, "name" => skill["Skill"]]
        else
            skill_id = skill_id["id"].to_i
        end


        db.execute("INSERT INTO armor_skill_rel('armor_id', 'skill_id', 'value') VALUES(?,?,?)", [armor_id, skill_id, skill["Value"].to_i])

    end

end