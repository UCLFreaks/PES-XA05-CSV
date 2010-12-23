# To change this template, choose Tools | Templates
# and open the template in the editor.

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
  

  def sprite_size
    return [128,64]
  end

  def image_original_size
    return [128,64]
  end

  def relative_weapon_hardpoint
    return [120,32]
  end
end