require './simulation/simulation.rb'
require './visualization/simulation_extension.rb'
require './visualization/unit_extensions.rb'
require './visualization/visualization.rb'
require 'yaml'

  
units1 = YAML.load_file('army1_user.yaml');
units2 = YAML.load_file('army2_user.yaml');

p units1

#units1 = [Tank.new(50),Soldier.new(55),Soldier.new(58),Soldier.new(60),Tank.new(80)]
#units2 = [Soldier.new(-8),Soldier.new(-3),Soldier.new(-1),Sniper.new(-14),Tank.new(-9)]

army1 = Army.new(units1, SimulationStrategy.new)
army2 = Army.new(units2, SimulationStrategy.new)
battle = BattleProgram.new(army1,army2)

vis = Visualization::Visualization.new(battle)
vis.run
