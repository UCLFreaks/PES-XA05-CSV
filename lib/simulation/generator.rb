require 'yaml'
require './simulation/unit_classes.rb'


def create_units(dir)

  unit_weights = {
    "Soldier" => 10,
    "Captain" => 0,
    "Elite" => 0,
    "Sniper" => 1,
    "Tank" => 2
  }

  units = []
  unit_weights.each do |key,val|
    val.times do
      pos = rand(10)*dir
			units << Object::const_get(key).new(pos)
    end

  end
  return units
end

units = create_units(1)
File.open('army1_user.yaml','w') do |f|
  f.puts units.to_yaml
end

units = create_units(-1)
File.open('army2_user.yaml','w') do |f|
  f.puts units.to_yaml
end
