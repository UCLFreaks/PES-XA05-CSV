=begin
PES-XA05 Combat simulation
Original author: Tomas Holas (Unicorn College)
Modifications by: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Generator that generates the armies units and stores them into YAML file.

Modifications:
- Maximum distance from the center was lowered from 95 to 20.  Greater distance makes the visualization
confusing. Use constant MAXIMUM_DISTANCE to change it.

- Minimum distance was lowered from 5 to 1 to compensate for the lower maximum distance.
Use constant MINIMUM_DISTANCE to change it.

- Unit count has been halved to better fit into the smaller battlefield.
You can change the number of battling units by changing the unit_weights.


=end
require 'yaml'

MAXIMUM_DISTANCE = 20
MINIMUM_DISTANCE = 1

def create_units(dir)
  unit_weights = {
    "Soldier" => 10,
    "Captain" => 4,
    "Elite" => 2,
    "Sniper" => 1,
    "Tank" => 1
  }

  units = []
  unit_weights.each do |key,val|
    val.times do
      pos = [rand(MAXIMUM_DISTANCE)*dir+(MINIMUM_DISTANCE*dir),MAXIMUM_DISTANCE].min
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
