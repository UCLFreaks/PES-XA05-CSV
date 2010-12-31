class DefaultStrategy
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
          unit.move
        else
         unit.fire
        end
      end
		}
  end
end