=begin
PES-XA05-CSV Combat simulation visualization
Version: 0.9.2
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010
Written in Ruby 1.9.2-p0 (Seems to work in Ruby 1.8 and JRuby 1.5)

If Visualization does not work. Run this file. It runs the simulation in text mode.
=end
require './simulation/simulation.rb'
require './visualization/simulation_extension.rb'
require './visualization/unit_extensions.rb'
require './visualization/unit_loader.rb'
require './default_strategy.rb'
require './vk_strategy/general_vk_strategy.rb'

#Loading units from YAML file. Modify generator.rb and run it if you want
#to simulate different battles.
units1 = UnitLoader.units_from_yaml('army1_user.yaml');
units2 = UnitLoader.units_from_yaml('army2_user.yaml');

army1 = Army.new(units1, GeneralVK::Strategy.new)
army2 = Army.new(units2, DefaultStrategy.new)

battle = BattleProgram.new(army1,army2)
battle.info
battle.run