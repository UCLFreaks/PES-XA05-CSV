=begin
PES-XA05 Combat simulation
Original author: Tomas Holas (Unicorn College)
Modifications by: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Army class and BattleProgram class are defined here.

Modifications:
- BattleProgram is extended by simulation_extension.rb in order to employ stepping of the simulation.
=end
require './simulation/unit_classes.rb'

class Army
  attr_reader :strategy, :units
  def initialize(units, strategy)
    @units = units
    @strategy = strategy
  end

  def status
    @units.each do |unit|
      puts "Class:#{unit.class}, Position:#{unit.position}," +
        " Lives: #{unit.lives}"
    end
  end

  def lives
    sum = 0
    @units.each do |unit|
      sum += unit.lives
    end
    return sum
  end

  def attack(enemy)
    @strategy.step(self,enemy)
  end
end

class BattleProgram
def initialize(army1, army2)
  @army1 = army1
  @army2 = army2
  @day = 0
end

def info
  puts "*** BATTLE INFO ***"
  puts "Army 1:"
  @army1.status
  puts "Army 2:"
  @army2.status
end

#Note: this function is never used in the visualization.
#Sequencing is implemented by the make_step function in the simulation_extension.rb
def run
  while @day < 100 and @army1.lives > 0 and @army2.lives > 0
    make_step
  end
end



end


