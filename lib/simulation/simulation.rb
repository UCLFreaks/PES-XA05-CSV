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

		enemies = army2.units.select { |unite| unite.alive? }

			nearest = enemies[0]
			enemies.each{|enemy|
				if(enemy.position.abs < nearest.position.abs)
					nearest = enemy
				end
			}

		army1.units.select{|unit| unit.alive? }.each { |unit|
      unit.enemy = nearest
      if(unit.class == Sniper)
        if(unit.focus_time != 0)
          unit.prepare_weapon
        else
          unit.fire
          #unit.retrat
        end
      else
        
        if(unit.enemy_distance > unit.range)
          puts unit.name + ' v ' + unit.class.to_s + ' se hejbe '
          unit.move
        else
          puts unit.name + " (#{unit.object_id}) shoots at  #{unit.enemy.name} (#{unit.enemy.object_id}) " if unit.enemy != nil
          unit.fire
        end
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


