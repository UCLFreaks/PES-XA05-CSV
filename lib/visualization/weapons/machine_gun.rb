# To change this template, choose Tools | Templates
# and open the template in the editor.

class MachineGun < Weapon
  def initialize(owner)
    super(owner)
    @hit_delivered = false
  end

  def spawn_shot
    y_offset = @target.position[1] + rand(64) - 32
    @sounds['fire'].play
    return RifleShot.new(self,
      shot_source_position,
      [@target.position[0],y_offset],
      @target)
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

  private

  def load_sounds
    @sounds['fire'] = AudioManager.get_sound("soldier_fire2.wav")
  end

end