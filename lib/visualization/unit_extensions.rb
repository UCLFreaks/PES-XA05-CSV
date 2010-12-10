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

class Captian
  include UnitReportMethods
end

class Elite
  include UnitReportMethods
end

class Sniper
  include UnitReportMethods
  def crawl
    @last_action = :crawl
    super()
  end

  def prepare_weapon
    @last_action = :prepare_weapon
    super()
  end

end

class Tank
  include UnitReportMethods
end
