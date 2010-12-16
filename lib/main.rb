require './simulation/simulation.rb'
require './visualization/simulation_extension.rb'
require './visualization/unit_extensions.rb'
require './visualization/visualization.rb'


units1 = [Tank.new(15),Soldier.new(10),Soldier.new(12),Tank.new(8)]
units2 = [Soldier.new(-8),Soldier.new(-3),Soldier.new(-1),Sniper.new(-14),Tank.new(-9)]
army1 = Army.new(units1, SimulationStrategy.new)
army2 = Army.new(units2, SimulationStrategy.new)
battle = BattleProgram.new(army1,army2)



vis = Visualization::Visualization.new(battle)
vis.run

  