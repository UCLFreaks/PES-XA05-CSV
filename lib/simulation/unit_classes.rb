module UnitMethods
  attr_accessor :enemy, :name
  attr_reader :range, :damage, :position, :lives
  
  def enemy_distance
    if enemy
      return (@position - @enemy.position).abs
    else
      return 0
    end
  end

  def move
    @position += @speed*attack_direction
  end

  def retrat
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


  private 

  def fire_in_range
    if enemy and enemy_distance < @range and lives > 0
      @enemy.recieve_damage(@damage)
    end
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
  attr_reader :focus_time
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
    @position += attack_direction
  end

  def move
    @position += @speed*attack_direction
    @focus_time = @max_focus_time
  end

  def prepare_weapon
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
