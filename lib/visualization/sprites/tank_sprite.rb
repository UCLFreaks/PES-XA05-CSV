=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Tank sprite
=end
class TankSprite < UnitSprite

  def get_image_base_name()
    return "tank"
  end

  def setup_animation
    @number_of_frames = 1
    add_animation(:dead, 750,false,1)
    add_animation(:idle, 1000,false,1)
    add_animation(:run, 500)
    set_animation(:idle)
  end
  
  def load_sounds
    @sounds['die2'] = AudioManager.get_sound('tank_die.wav')
    @sounds['die3'] = @sounds['die2']
  end

  def sprite_size
    return [128,64]
  end

  def image_original_size
    return [128,64]
  end

  def relative_weapon_hardpoint
    return [120,32]
  end

  def default_weapon
    return TankGun.new(self)
  end

end