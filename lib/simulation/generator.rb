require 'yaml'
require './simulation/unit_classes.rb'


def create_units(dir)
	ranking = ['vojin','desatnik','rotny','rotmistr','porucik','kapitan','major','general']
	names = ['Vomacka','Vochcalpadlo','Voprckozu','Skocdopole','Teply','Lopata','Hnidopich']


  unit_weights = {
    "Soldier" => 2,
    "Captain" => 0,
    "Elite" => 0,
    "Sniper" => 0,
    "Tank" => 0
  }

  units = []
  unit_weights.each do |key,val|
    val.times do
      pos = rand(10)*dir
			units << Object::const_get(key).new(pos,ranking[0] + ' '+ names[0])
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
