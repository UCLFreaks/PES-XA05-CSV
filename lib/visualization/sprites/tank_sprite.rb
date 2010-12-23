# To change this template, choose Tools | Templates
# and open the template in the editor.

class TankSprite < UnitSprite

  def get_image_base_name(state)
    return "tank"
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