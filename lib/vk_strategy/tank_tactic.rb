module GeneralVK
  class TankTactic < GenericTactic
    def make_move(tank,strategy)
      tank.enemy = strategy.first_enemy(tank)
      if(tank.shells > 0)
        targets = strategy.targets_in_range(tank)
        if(targets.empty?)
          tank.move
        else
          targets.sort_by { |target| target_priority_by_type(target['unit'])}
          tank.enemy = targets.last['unit']
          #Dont waste shells on not important targets
          ec = strategy.enemy_units_by_type
          interesting_count = ec[Tank].count + ec[Elite].count + ec[Sniper].count
          if(interesting_count > 0 and target_priority_by_type(tank.enemy) < 0)
            tank.enemy = get_priority_movement_target(ec)
            tank.move
          else
            tank.fire
          end
        end
      else
        #Act as a meat shield
        tank.move
      end
    end
    private
    def target_priority_by_type(enemy_unit)
      case enemy_unit
      when Tank
        return 5
      when Elite
        return 4
      when Sniper
        return 3
      when Captain
        return -1
      when Soldier
        return -2
      end
    end

    def get_priority_movement_target(ec)
      return ec[Tank].first if not ec[Tank].empty?
      return ec[Elite].first if not ec[Elite].empty?
      return ec[Sniper].first if not ec[Sniper].empty?
    end

  end
end
