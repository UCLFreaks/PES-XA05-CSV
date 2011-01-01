=begin
PES-XA05 Strategy
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010
Written in Ruby 1.9.2-p0 (Seems to work in Ruby 1.8 and JRuby 1.5)

This is a strategy that Vratislav Kalenda submitted as his homework.

General rules:
1) Try to kill but do not overkill

Soldier, Captain, Elite rules:
1) Attack everything in range
2) Move forward if nothing is in range
3) Leave enemy tanks to friendly snipers and tanks if possible

Tank rules:
1) Attack high priority targets (tanks, snipers) if they are in range
2) Decide whether to attack other targets or move in range to the high priority
 targets.
3) When out of ammo, go forward and act as a meat shield.

Sniper rules:
1) Check the spwan point. If it is too close to the center of the battlefield, retrat.
2) Prepare the weapon.
3) Shoot at the tagets according to priority and proximity from the sniper.
4) Crawl forward, if there is no enemey in range

=end

class GenericTactic
  def make_move(unit,strategy)
    raise "Abstract method make_move is not implemented for Class #{self.class}"
  end
  private
  def target_priority_by_type(enemy_unit)
    return 1
  end


end

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

class VKJStrategy
     SOLDIER_TACTIC = SoldierTactic.new
     SNIPER_TACTIC = SniperTactic.new
     TANK_TACTIC = TankTactic.new

    def step(friendly_army, enemy_army)
      @friendly = filter_out_dead_units(friendly_army.units)
      @enemy = filter_out_dead_units(enemy_army.units)

      friendly_army_lives = friendly_army.lives

      @friendly.each do |unit|
        if(enemy_army.lives > 0 and friendly_army_lives > 0)
          case unit
          when Soldier,Elite,Captain
            SOLDIER_TACTIC.make_move(unit, self)
          when Tank
            TANK_TACTIC.make_move(unit, self)
          when Sniper
            SNIPER_TACTIC.make_move(unit, self)
          end
        end
      end

    end

    def targets_in_range(unit)
      targets_in_range = []
      go_through_each_unit(@enemy)do |enemy_unit|
        distance = (unit.position - enemy_unit.position).abs
        if(distance < unit.range)
          targets_in_range << {"unit"=>enemy_unit,"distance"=>distance}
        end
      end
      targets_in_range.sort_by { |u_a_d| u_a_d['distance']  }
      return targets_in_range
    end



    def threats_for_unit(unit)
      threats = []
      go_through_each_unit(@enemy) do |enemy_unit|
        distance = (unit.position - enemy_unit.position).abs
        if(distance < enemy_unit.range)
          threats << {"unit"=>enemy_unit,"distance"=>distance}
        end
      end
      return threats
    end

    def enemy_units_by_type
      enemy = {
        Soldier => [],
        Captain => [],
        Elite => [],
        Sniper => [],
        Tank => []
      }
      go_through_each_unit(@enemy) do |enemy_unit|
        enemy[enemy_unit.class] << enemy_unit
      end
      return enemy
    end

    def first_enemy(unit)
      @enemy.each do |unit|
        return unit if unit.alive?
      end
    end

    private
    def go_through_each_unit(units)
      dead_units = []
      units.each do |unit|
          if(unit.alive?)
            yield(unit)
          else
            dead_units << unit
          end
      end
      dead_units.each do |dead_unit|
        units.delete(dead_unit)
      end
    end


    def filter_out_dead_units(units)
      return units.select{|unit| unit.alive?}
    end
end


