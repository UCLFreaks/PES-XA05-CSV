require './simulation/simulation.rb'
require './simulation_extension.rb'
require './visualization.rb'


units1 = [Soldier.new(10),Soldier.new(12),Soldier.new(30),Tank.new(8)]
units2 = [Soldier.new(-20),Soldier.new(-10),Soldier.new(-12),Sniper.new(-25),Tank.new(-17)]
army1 = Army.new(units1, SimulationStrategy.new)
army2 = Army.new(units2, SimulationStrategy.new)
battle = BattleProgram.new(army1,army2)



vis = Visualization::Visualization.new(battle)
vis.run

  