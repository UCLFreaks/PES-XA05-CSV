require './simulation/simulation.rb'
require './visualization.rb'


units1 = [Soldier.new(10)]
units2 = [Soldier.new(-10)]
army1 = Army.new(units1, SimulationStrategy.new)
army2 = Army.new(units2, SimulationStrategy.new)
battle = BattleProgram.new(army1,army2)
battle.info


vis = Visualization.new(battle)
vis.run

  