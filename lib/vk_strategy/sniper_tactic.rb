module GeneralVK
class SniperTactic < GenericTactic
  DANGER_ZONE = 5
  def make_move(sniper,strategy)
    first_enemy = strategy.first_enemy(sniper)
    sniper.enemy = first_enemy
    if not prepared?(sniper)
      if sniper.position.abs < DANGER_ZONE
        sniper.retrat
      else
        sniper.prepare_weapon
      end
    else
      targets = strategy.targets_in_range(sniper)
      if(targets.empty?)
        sniper.crawl
      else
        threats = strategy.threats_for_unit(sniper)
        if not(threats.empty?)
          threats.sort_by { |threat| target_priority_by_type(threat['unit'])}
          sniper.enemy = threats.last['unit']
          sniper.fire
        else
          targets.sort_by { |target| target_priority_by_type(target['unit'])}
          sniper.enemy = targets.last['unit']
          sniper.fire
        end
      end
    end
  end
  private
  def prepared?(sniper)
    return sniper.focus_time == 0 ? true : false
  end

  def preparing?(sniper)
    return sniper.focus_time == sniper.max_focus_time ? false : true
  end

  def target_priority_by_type(enemy_unit)
    case enemy_unit
    when Sniper
      return 5
    when Tank
      return 4
    when Elite
      return 3
    when Captain
      return 2
    when Soldier
      return 1
    end
  end
end
end