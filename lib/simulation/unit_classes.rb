=begin
PES-XA05 Combat simulation
Original author: Tomas Holas (Unicorn College)
Modifications by:
Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010,
Jakub Kohout

Units definitions.

Modifications:
- Tank range was lowered from 20 to 10 in order to compensate for the smaller battlefield and also
to balance thigns a little bit.

- Units classes are extended by unit_extensions.rb. UnitReportMethods module that is defined there provides
non-intrusive reporting about the unit's last action.
=end
module UnitMethods
  attr_accessor :enemy, :name
  attr_reader :range, :damage, :position, :lives
  attr_reader :last_action,:fired_at
  
  def enemy_distance
    if enemy
      return (@position - @enemy.position).abs
    else
      return 0
    end
  end

  def move
    @last_action = :move
    @position += @speed*attack_direction
  end

  def retreat
    @last_action = :retreat
    @position -= @speed*attack_direction
  end

  def recieve_damage(damage)
    @lives -= damage
    @lives = 0 if lives < 0
  end

  def fire
    fire_in_range
  end

	def alive?
		return (@lives > 0)
	end
  
  #Do not use! This function is for visualization purpose
  def clear_last_action
    @last_action = nil
    @fired_at = nil
  end


  private 

  def fire_in_range
    if enemy and enemy_distance < @range and lives > 0
      @enemy.recieve_damage(@damage)
      @last_action = :fire_hit
    else
      @last_action = :fire_miss
    end
    @fired_at = enemy
  end  

  
  def attack_direction
    if position > @enemy.position
      return -1
    else
      return 1
    end
  end
end

class Soldier
  include UnitMethods
  def initialize(position)
    @lives = 10
    @range = 5
    @damage = 2
    @speed = 3
    @position = position
  end
end

class Captain
  include UnitMethods
  def initialize(position)
    @lives = 15
    @range = 6
    @damage = 3
    @speed = 3
    @position = position
  end
end

class Elite
  include UnitMethods
  def initialize(position)
    @lives = 20
    @range = 7
    @damage = 4
    @speed = 4
    @position = position
  end
end

class Sniper
  include UnitMethods
  attr_reader :focus_time, :max_focus_time
  def initialize(position)
    @lives = 12
    @range = 15
    @damage = 20
    @speed = 3
    @max_focus_time = 10
    @focus_time = @max_focus_time
    @position = position
  end

  def crawl
    @last_action = :crawl
    @position += attack_direction
  end

  def move
    @last_action = :move
    @position += @speed*attack_direction
    @focus_time = @max_focus_time
  end

  def prepare_weapon
    @last_action = :prepare_weapon
    @focus_time -= 1
  end

  def fire
    if @focus_time < 1
      fire_in_range
    else
      puts "Sniper needs to focus: #{@focus_time} rounds"
    end
  end
end

class Tank
  attr_reader :shells
  include UnitMethods
  def initialize(position)
    @lives = 50
    @range = 10
    @damage = 30
    @speed = 6
    @shells = 10
    @position = position
  end

  def fire
    if @shells > 0
      fire_in_range
      @shells -= 1
    else
      puts "Out of amunition"
    end
  end
end
