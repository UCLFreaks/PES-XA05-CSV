# To change this template, choose Tools | Templates
# and open the template in the editor.

class TankGun < Weapon
  def shoot(target)
    super(target)
    hit_target
  end

  private
  def spawn_shot
    return TankShot.new(self,shot_source_position,@target.position)
  end

  def min_number_of_shots
    return 1
  end

  def max_number_of_shots
    return 1
  end

  def time_between_shots
    return 1000
  end


end