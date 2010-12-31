=begin
PES-XA05-CSV Combat simulation visualization
Version: 0.9.0
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010
Written in Ruby 1.9.2-p0 (Seems to work in JRuby 1.5)

This file contains entry point for the simulation. Run this file.
=end
require './simulation/simulation.rb'
require './visualization/simulation_extension.rb'
require './visualization/unit_extensions.rb'
require './visualization/visualization.rb'
require 'yaml'

#Loading units from YAML file. Change the _example suffix to _user suffix in order
#to load units from the generator.
units1 = YAML.load_file('army1_example.yaml');
units2 = YAML.load_file('army2_example.yaml');


#Creating armies from arrays. Uncomment and use for debugging your strategy.
#units1 = [Soldier.new(8),Soldier.new(1),Captain.new(1),Elite.new(1)]
#units2 = [Soldier.new(-8),Soldier.new(-2),Captain.new(-3),Elite.new(-1)]

army1 = Army.new(units1, SimulationStrategy.new)
army2 = Army.new(units2, SimulationStrategy.new)
battle = BattleProgram.new(army1,army2)

vis = Visualization::Visualization.new(battle)
vis.run
