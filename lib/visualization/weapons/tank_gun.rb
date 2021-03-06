=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

TankGun weapon implementation.
=end
class TankGun < Weapon
  def shoot(target)
    super(target)

    @sounds['fire'].play
    hit_target
  end

  private
  def load_sounds
    @sounds['fire'] = AudioManager.get_sound("tank_fire1.wav")
  end

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