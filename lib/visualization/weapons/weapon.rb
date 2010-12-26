# To change this template, choose Tools | Templates
# and open the template in the editor.

class Weapon
  def initialize(owner)
    @current_shots = SpriteGroup.new
    @all_shots = SpriteGroup.new
    @owner = owner
    @target = nil
    @status = :inactive
    @actual_number_of_shots = nil
  end

  def shoot(target)
    @current_shots.clear
    @target = target
    @owner.make_busy("Shooting at #{@target.unit.object_id}")
    @status = :active
    @actual_number_of_shots = min_number_of_shots + rand(max_number_of_shots-min_number_of_shots).floor
    #puts "Number of shots is #{@actual_number_of_shots}"
    @time_since_last_shot = time_between_shots
  end

  def update(dt)
    @time_since_last_shot += dt
    if(@current_shots.size < @actual_number_of_shots)
      if(@time_since_last_shot >= time_between_shots)
        #puts "#{self.object_id} Spawning shot"
        shot = spawn_shot
        @current_shots << shot
        @all_shots << shot
        @time_since_last_shot -= time_between_shots
      end
    end
    @all_shots.update(dt)
    check_shots_state
    check_weapon_state
  end

  def draw(to_surface)
    #puts "Drawing shots"
    @all_shots.draw(to_surface)
  end

  def firing?
    return @status == :active
  end

  def hit_target
    @target.hit
    @owner.make_idle
  end

  private

  def check_shots_state
    to_be_deleted = []
    @all_shots.each do |shot|
      if not (shot.flying?)
        to_be_deleted << shot
      end
    end
    @current_shots.delete(to_be_deleted)
    @all_shots.delete(to_be_deleted)
  end

  def check_weapon_state
    if not(@current_shots.empty?)
      @status = :active
    else
      @status = :inactive
    end
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
