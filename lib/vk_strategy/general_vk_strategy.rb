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
require "./vk_strategy/generic_tactic.rb"
require "./vk_strategy/soldier_tactic.rb"
require "./vk_strategy/sniper_tactic.rb"
require "./vk_strategy/tank_tactic.rb"
module GeneralVK
  class Strategy
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
end

