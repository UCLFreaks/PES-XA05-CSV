require 'yaml'

def create_units(dir)
  unit_weights = {
    "Soldier" => 20,
    "Captain" => 8,
    "Elite" => 4,
    "Sniper" => 2,
    "Tank" => 2
  }

  units = []
  unit_weights.each do |key,val|
    val.times do
      pos = rand(95)*dir+5
      units << [key, pos]
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
