=begin
PES-XA05 Strategy
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010
Written in Ruby 1.9.2-p0 (Seems to work in Ruby 1.8 and JRuby 1.5)

Tactic shared by Soldiers, Captains and Elites. The distinguishing between them are
done when other units are deciding on what to shoot.
=end
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