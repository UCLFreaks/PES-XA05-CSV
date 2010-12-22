# To change this template, choose Tools | Templates
# and open the template in the editor.

class Weapon
  def initialize(owner)
    @shots = SpriteGroup.new
    @owner = owner
    @target = nil
    @status = :inactive
  end

  def shoot(target)
    @target = target
    @status = :active
    (min_number_of_shots + rand(max_number_of_shots-min_number_of_shots)).times do |i|
      @shots << spawn_shot
    end
  end

  def update(dt)
    @shots.update(dt)
    check_shots_state
    check_weapon_state
  end

  def draw(to_surface)
    @shots.draw(to_surface)
  end

  private

  def check_shots_state
    to_be_deleted = []
    @shots.each do |shot|
      to_be_deleted << shot if not shot.flying?
    end
    @shots.delete(to_be_deleted)
  end

  def check_weapon_state
    if(@shots.empty?)
      @status = :active
    else
      @status = :inactive
    end
  end

  def firing?
    return @status == :active
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

  def shot_source_position
    return [
      @owner.position[0]+@owner.weapon_hardpoint[0],
      @owner.position[1]+@owner.weapon_hardpoint[1],
    ]
  end

end
