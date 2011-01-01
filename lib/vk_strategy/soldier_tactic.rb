module GeneralVK
  class SoldierTactic < GenericTactic
    def make_move(unit,strategy)
      targets = strategy.targets_in_range(unit)
      if(targets.empty?)
        unit.enemy = strategy.first_enemy(unit)
        unit.move
      else
        targets = targets.sort_by{|target| target_priority_by_type(target['unit'])}
        unit.enemy = targets.last['unit']
        unit.fire
        #TODO implement rule nr. 3
      end
    end
  private
    def target_priority_by_type(enemy_unit)
      case enemy_unit
      when Sniper
        return 5
      when Soldier
        return 4
      when Captain
        return 3
      when Elite
        return 2
      when Tank
        return -1
      end
    end

  end

end