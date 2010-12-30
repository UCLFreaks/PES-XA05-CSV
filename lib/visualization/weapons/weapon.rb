# To change this template, choose Tools | Templates
# and open the template in the editor.

class Weapon
  attr_reader :target
  def initialize(owner)
    @current_shots = []
    @all_shots = []
    @owner = owner
    @target = nil
    @status = :inactive
    @actual_number_of_shots = nil
    @shots_fired = 0
    @sounds = {}
    load_sounds
  end


  def shoot(target)
    @current_shots.clear
    @shots_fired = 0
    @target = target
    @owner.make_busy("Shooting at #{@target.unit.object_id}")
    @status = :active
    @actual_number_of_shots = min_number_of_shots + rand(max_number_of_shots-min_number_of_shots+1).floor
    #puts "Number of shots is #{@actual_number_of_shots}"
    @time_since_last_shot = time_between_shots
  end

  def update(dt)
    @time_since_last_shot += dt
    if(@shots_fired < @actual_number_of_shots)
      if(@time_since_last_shot >= time_between_shots)
        #puts "#{self.object_id} Spawning shot"
        shot = spawn_shot
        @current_shots << shot
        @all_shots << shot
        @shots_fired += 1
        @time_since_last_shot -= time_between_shots
      end
    end
    @all_shots.each do |shot|
      shot.update(dt)
    end
    check_shots_state
    check_weapon_state
  end

  def draw(to_surface)
    #puts "Drawing shots"
    @all_shots.each do |shot|
      shot.draw(to_surface)
    end
  end

  def firing?
    return @status == :active
  end

  def hit_target
    @target.hit
    @owner.make_idle
    puts "#{@owner.object_id} Hitting target"
  end

  private

  def check_shots_state
    @all_shots.each do |shot|
      if not (shot.flying?)
        @current_shots.delete(shot)
        @all_shots.delete(shot)
        #puts "Deleting shot #{shot.object_id}"
      end
    end
  end

  def check_weapon_state
    if not(@current_shots.empty?)
      @status = :active
    else
      shooting_finished
      puts "Weapon incactive"
      @status = :inactive
    end
  end

  def shooting_finished
    
  end

  def load_sounds
    
  end

  def spawn_shot
    raise "must be implemented for #{self.class}"
  end

  def min_number_of_shots
    raise "must be implemented for #{self.class}"
  end

  def max_number_of_shots
    raise "must be implemented for #{self.class}"
  end

  def time_between_shots
    raise "must be implemented for #{self.class}"
  end

  def shot_source_position
    lcp = @owner.left_corner_position
    return [
      lcp[0]+@owner.weapon_hardpoint[0],
      lcp[1]+@owner.weapon_hardpoint[1],
    ]
  end

end
