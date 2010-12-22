# To change this template, choose Tools | Templates
# and open the template in the editor.

class TankGun < Weapon
  private
  def spawn_shot
    return TankShot.new(shot_source_position@target.position)
  end

  def min_number_of_shots
    return 1
  end

  def max_number_of_shots
    return 1
  end


end