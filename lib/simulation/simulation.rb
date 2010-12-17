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

class SimulationStrategy
  def step(army1, army2)
		army1.units.select{|unit| unit.alive? }.each_with_index { |unit,key|

			enemies = army2.units.select { |unit| unit.alive? }
			unit.enemy = enemies[rand(enemies.length-1)]
			if(unit.enemy_distance > unit.range)
				puts unit.name + ' v ' + unit.class.to_s + ' se hýbe '
				unit.move
			else
				puts unit.name + ' střílí na '+ unit.enemy.name if unit.enemy != nil
				unit.fire
			end	
		}


		


#    s1 = army1.units.first
#    s2 = army2.units.first
#    s1.enemy = s2
#    if s1.enemy_distance >= s1.range
#      s1.move
#    else
#      s1.fire
#    end
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

def run
  while @day < 100 and @army1.lives > 0 and @army2.lives > 0
    make_step
  end
end



end


