# To change this template, choose Tools | Templates
# and open the template in the editor.

class MachineGun < Weapon
  def initialize(owner)
    super(owner)
    @hit_delivered = false
  end

  def spawn_shot
    return RifleShot.new(self,shot_source_position,@target.position,@target)
  end

  def min_number_of_shots
    return 1
  end

  def max_number_of_shots
    return 4
  end

  def time_between_shots
    return 300
  end

  def shoot(target)
    super(target)
  end

  def hit_target
    super
    @hit_delivered = true
  end

  def shooting_finished
    puts "Shooting finished"
    hit_target if not @hit_delivered
    @hit_delivered = false
  end


end