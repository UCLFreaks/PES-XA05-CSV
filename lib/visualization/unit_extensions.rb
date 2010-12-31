=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Necessary non intrusive extensions to the original unit methods and unit classes.
=end
module UnitReportMethods
  attr_reader :last_action,:fired_at

  def move
    @last_action = :move
    super()
  end

  def retrat
    @last_action = :retrat
    super()
  end

  def clear_last_action
    @last_action = nil
    @fired_at = nil
  end

  def fire_in_range
    if enemy and enemy_distance < @range and lives > 0
      @enemy.recieve_damage(@damage)
      @last_action = :fire_hit
    else
      @last_action = :fire_miss
    end
    @fired_at = enemy
  end  
end

class Soldier
  include UnitReportMethods
end

class Captain
  include UnitReportMethods
end

class Elite
  include UnitReportMethods
end

class Sniper
  attr_reader :max_focus_time
  include UnitReportMethods
  def crawl
    @last_action = :crawl
    @position += attack_direction
  end

  def prepare_weapon
    @last_action = :prepare_weapon
    @focus_time -= 1
  end

end

class Tank
  include UnitReportMethods
end

